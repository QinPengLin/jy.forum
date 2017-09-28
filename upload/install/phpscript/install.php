<?php
if (!defined('puyuetian'))
	exit('403');

$mysql_location = $_POST['mysql_location'];
$mysql_username = $_POST['mysql_username'];
$mysql_password = $_POST['mysql_password'];
$mysql_database = $_POST['mysql_database'];
$mysql_prefix = $_POST['mysql_prefix'];
$mysql_charset = $_POST['mysql_charset'];
$adminusername = Cstr($_POST['adminusername']);
$adminpassword = Cstr($_POST['adminpassword'], FALSE, FALSE, 5, 16);
$adminemail = filter_var($_POST['adminemail'], FILTER_VALIDATE_EMAIL);

if (!$mysql_location || !$mysql_username || !$mysql_database || !$mysql_prefix || !$mysql_charset) {
	$error = "请填写完整MySQL数据库信息！";
	template("{$tpath}htmltip.html");
	exit();
}
if (!$adminusername || !$adminpassword || !$adminemail) {
	$error = "请填写正确的创世人信息！";
	template("{$tpath}htmltip.html");
	exit();
}

//mysql/config.php配置文件写入
$mysql_config = "<?php
	\$_G['MYSQL']['LOCATION'] = '{$mysql_location}';
	\$_G['MYSQL']['USERNAME'] = '{$mysql_username}';
	\$_G['MYSQL']['PASSWORD'] = '{$mysql_password}';
	\$_G['MYSQL']['DATABASE'] = '{$mysql_database}';
	\$_G['MYSQL']['CHARSET'] = '{$mysql_charset}';
	\$_G['MYSQL']['PREFIX'] = '{$mysql_prefix}';
	";
file_put_contents($mp . 'puyuetian/mysql/config.php', $mysql_config);
//连接mysql数据库
$MYSQL_CONNECT = mysql_connect($mysql_location, $mysql_username, $mysql_password);
if (!$MYSQL_CONNECT) {
	//连接失败
	$error = "MySQL数据库连接失败！请返回检查";
	template("{$tpath}htmltip.html");
	exit();
}
//选择数据库
$MYSQL_SELECT_DB_R = mysql_select_db($mysql_database, $MYSQL_CONNECT);
if (!$MYSQL_SELECT_DB_R) {
	$error = "不存在的数据库！请创建后再安装";
	template("{$tpath}htmltip.html");
	exit();
}
//数据库编码设置
mysql_query($mysql_charset);
//导入MySQL数据
$string = file_get_contents($mp . 'install/mysqldata/hadsky.sql');
//去除bom
if (ord(substr($string, 0, 1)) == 239 && ord(substr($string, 1, 1)) == 187 && ord(substr($string, 2, 1)) == 191) {
	$string = substr($string, 3);
}
//数据表前缀替换
//require "{$mp}install/mysqldata/data.php";
$string = str_replace('`pk_', "`{$mysql_prefix}", $string);
$querys = explode(";\r\n", $string);
if (count($querys) == 1) {
	$querys = explode(";\n", $string);
}
$err = 1;
$rs = '';
foreach ($querys as $query) {
	$err++;
	if (trim($query, "\x00..\x1F")) {
		$r = mysql_query($query);
		if (!$r) {
			$rs .= "出错行{$err}：" . mysql_error() . "，出错语句：" . htmlspecialchars($query) . "<br>";
		}
	}
}
if ($rs) {
	$tiptext = "安装发生部分错误！Err：{$err}<br>错误信息：<br>{$rs}<br>若无法正常运行请<a target='_blank' href='http://www.hadsky.com/read-426-1.html'>手动安装</a>或加群368240741咨询";
} else {
	$tiptext = "恭喜您，HadSky已成功安装完成";
}
//创始人信息更新
mysql_query("update `{$mysql_prefix}user` set `username`='{$adminusername}',`password`='" . md5($adminpassword) . "',`email`='{$adminemail}' where `id`=1");
//安装成功，锁定安装程序
file_put_contents($mp . 'install/install.locked', 'install locked!');
$HTMLCODE .= template("{$tpath}complete.html", TRUE);
