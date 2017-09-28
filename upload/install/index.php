<?php
/*
 * HadSky - 安装程序
 * 作者：蒲乐天
 * QQ：632827168
 */
error_reporting(0);
date_default_timezone_set("PRC");
if (file_exists(dirname(__FILE__) . '/install.locked')) {
	exit("install locked!");
}

define('puyuetian', 'hadsky.com');

//定义全局编码，防止个别exit输出乱码
header('Content-Type: text/html; charset=utf-8');

//基础框架加载
$mp = dirname(__FILE__) . '/../';
require "{$mp}puyuetian/vars.php";
require "{$mp}puyuetian/function.php";
if (version_compare(PHP_VERSION, '7.0.0') > -1) {
	//php7兼容处理
	require "{$mp}puyuetian/mysql/withphp7.php";
}
//模板路径所在
$tpath = dirname(__FILE__) . '/template/';

$step = Cnum($_GET['step'], 1);

switch ($step) {
	case 1 :
		$HTMLCODE .= template("{$tpath}useragreement.html", TRUE);
		break;
	case 2 :
		require dirname(__FILE__) . '/phpscript/environment.php';
		break;
	case 3 :
		require dirname(__FILE__) . '/phpscript/install.php';
		break;
	default :
		$error = "无效的参数！";
		template("{$tpath}htmltip.html");
		exit();
		break;
}

template("{$tpath}frame.html");
