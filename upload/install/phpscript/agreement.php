<?php
//定义全局编码，防止个别exit输出乱码
header('Content-Type: text/html; charset=utf-8');

if (file_exists(dirname(__FILE__) . '/../install.locked')) {
	exit("install locked!");
}

echo file_get_contents('http://www.hadsky.com/read-281-1.html');
