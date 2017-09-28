<?php
if (!defined('puyuetian'))
	exit('403');

$_G['TEMPLATE']['BODY'] = 'home';

if ($_G['SET']['DEFAULTPAGE'] != 'home') {
	$_G['SET']['WEBTITLE'] = '首页 - ' . $_G['SET']['WEBTITLE'];
}

//$_G['HTMLCODE']['OUTPUT'] .= template('home', TRUE);
