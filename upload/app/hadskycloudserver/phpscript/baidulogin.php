<?php
if (!defined('puyuetian'))
	exit('403');

$sitekey2 = md5(md5($_G['SYSTEM']['DOMAIN']) . md5($_G['SET']['APP_HADSKYCLOUDSERVER_SITEKEY']) . md5($_GET['createtime']) . md5($_GET['timeout']));
if (Cnum($_GET['createtime']) + Cnum($_GET['timeout']) > time() && $_GET['sitekey2'] == $sitekey2) {
	$data = json_decode($_GET['data'], TRUE);
	if (!$_G['USER']['ID']) {
		//用户登录或注册
		$userdata = UserLogin(array('baidu_userid' => $data['userid']), FALSE);
		if ($userdata) {
			//存入登录信息
			header('Location:../../index.php');
			exit();
		} else {
			//用户注册
			$_SESSION['APP_HADSKYCLOUDSERVER_BAIDULOGIN_USERID'] = $data['userid'];
			header('Location:../../index.php?c=reg&regway=quick');
			exit();
		}
	} else {
		//用户绑定
		$array['id'] = $_G['USER']['ID'];
		$array['baidu_userid'] = $data['userid'];
		$_G['TABLE']['USER'] -> newData($array);
		if ($_G['USER']['BAIDU_USERID']) {
			$ht = '恭喜，更换百度账号绑定成功！';
		} else {
			$ht = '恭喜，绑定百度账号成功！';
		}
		$_G['HTMLCODE']['TIPJS'] = 'location.href="index.php"';
		$_G['HTMLCODE']['TIP'] = $ht;
		$_G['HTMLCODE']['OUTPUT'] .= template('tip', TRUE);
	}
} else {
	$_G['HTMLCODE']['TIPJS'] = 'location.href="index.php?c=login"';
	$_G['HTMLCODE']['TIP'] = '登录校验码超时或错误';
	$_G['HTMLCODE']['OUTPUT'] .= template('tip', TRUE);
}
