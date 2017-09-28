<?php
if (!defined('puyuetian'))
	exit('403');

$array = array();
//php版本
$array['php_version'] = phpversion();

$array['php_version'] = explode('.', $array['php_version']);
$array['php_version'] = $array['php_version'][0] . '.' . $array['php_version'][1];

//读取文件检测
file_get_contents($mp . 'install/mysqldata/hadsky.sql') !== FALSE ? $array['readfile'] = TRUE : $array['readfile'] = FALSE;

//创建文件检测
file_put_contents($mp . 'install/test.txt', 'www.hadsky.com') !== FALSE ? $array['createfile'] = TRUE : $array['createfile'] = FALSE;

//写入文件检测
file_put_contents($mp . 'puyuetian/mysql/config.php', 'www.hadsky.com') !== FALSE ? $array['writefile'] = TRUE : $array['writefile'] = FALSE;

$json = json_encode($array);

$HTMLCODE .= template("{$tpath}environment.html", TRUE);
