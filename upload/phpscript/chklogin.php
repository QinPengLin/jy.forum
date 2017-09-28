<?php
if (!defined('puyuetian'))
	exit('403');

//提取用户名
if (Cnum($_POST['username'])) {
	$__ud = $_G['TABLE']['USER'] -> getData($_POST['username']);
	$username = $__ud['username'];
} elseif (strpos($_POST['username'], '@')) {
	$__ud = $_G['TABLE']['USER'] -> getData(array('email' => $_POST['username']));
	$username = $__ud['username'];
} else {
	preg_match('/^[\x{4e00}-\x{9fa5}A-Za-z0-9_]+$/u', $_POST['username']) ? $username = $_POST['username'] : $username = FALSE;
	if (strlen($username) > 24 || strlen($username) < 3) {
		$username = FALSE;
	}
}
unset($__ud);
$password = Cstr($_POST['password'], FALSE, FALSE, 5, 16);
$verifycode = Cstr($_POST['verifycode'], FALSE, TRUE, 1, 255);
$ip = getClientInfos('ip');

$chkr = FALSE;
for ($rf = 0; $rf < 1; $rf++) {
	if (!$username || !$password) {
		$chkr = '请填入正确的登录信息';
		break;
	}

	if (!chkVerifycode($verifycode, 'login')) {
		$chkr = '验证码错误';
		break;
	}

	//=========================清除验证码信息和检测用户登录=============================
	$_SESSION['APP_VERIFYCODE_LOGIN'] = '';

	$trylogindata = $_G['TABLE']['USER'] -> getData(array('username' => $username));
	if (!$trylogindata) {
		$chkr = '用户名或密码错误';
		break;
	}
	//登录次数判断
	$array = array();
	$array['id'] = $trylogindata['id'];
	if (JsonData($trylogindata['data'], 'logindate') == date('Ymd', time())) {
		$loginfaildata = json_decode(JsonData($trylogindata['data'], 'trylogindata'), TRUE);
		if (Cnum($loginfaildata[$ip]) >= Cnum($_G['SET']['TRYLOGINCOUNT'], 10)) {
			$chkr = '该ip今日尝试登录次数已用尽，请明日再来';
			break;
		}
	} else {
		$trylogindata['data'] = JsonData($trylogindata['data'], 'trylogindata', '');
	}

	$userdata = UserLogin(array('username' => $username, 'password' => md5($password)));
	if (!$userdata) {
		//记录此次登录失败
		$chkr = $_G['USERLOGINFAILEDINFO'];
		$loginfaildata = json_decode(JsonData($trylogindata['data'], 'trylogindata'), TRUE);
		if ($loginfaildata[$ip]) {
			$loginfaildata[$ip]++;
		} else {
			$loginfaildata[$ip] = 1;
		}
		$array['data'] = JsonData($trylogindata['data'], 'logindate', date('Ymd', time()));
		$array['data'] = JsonData($array['data'], 'trylogindata', array(json_encode($loginfaildata)));
		$_G['TABLE']['USER'] -> newData($array);
		break;
	}
	//登录成功，记录当日登录记录
	$userdata['data'] = $trylogindata['data'];
	$array['data'] = JsonData($userdata['data'], 'logindate', date('Ymd', time()));
	$loginfaildata = json_decode(JsonData($userdata['data'], 'trylogindata'), TRUE);
	if (!$loginfaildata[$ip]) {
		$loginfaildata[$ip] = 0;
	}
	$loginfaildata = json_encode($loginfaildata);
	$array['data'] = JsonData($array['data'], 'trylogindata', array($loginfaildata));
	$_G['TABLE']['USER'] -> newData($array);
	//是否设置了自动登录
	if ($_POST['autologin']) {
		setcookie('UIA', key_endecode($userdata['id'] . '|' . md5($userdata['password'] . $userdata['session_token']) . md5($userdata['session_token'])), time() + Cnum($_G['SET']['USERCOOKIESLIFE'], 86400, TRUE, 1800));
	}
	if ($_GET['referer']) {
		//防止无法添加端口号和跳转到其他网站
		if (substr($_GET['referer'], 0, 7) == 'http://' || substr($_GET['referer'], 0, 8) == 'https://') {
			$referer = end(explode('/', $_GET['referer']));
			$_GET['referer'] = $referer ? $referer : 'index.php';
		}
	} else {
		$_GET['referer'] = 'index.php?c=user';
	}
	if ($_G['GET']['RETURN'] == 'json') {
		echo json_encode(array('state' => 'ok', 'msg' => '登录成功', 'referer' => $_GET['referer']));

	} else {
		header('Location:' . $_GET['referer']);
	}
	exit();
}
if ($_G['GET']['RETURN'] == 'json') {
	exit(json_encode(array('state' => 'no', 'msg' => $chkr, 'referer' => $_GET['referer'])));
} else {
	$_G['HTMLCODE']['TIP'] = $chkr;
	$_G['HTMLCODE']['OUTPUT'] .= template('tip', TRUE);
}
