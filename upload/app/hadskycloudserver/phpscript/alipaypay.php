<?php
if (!defined('puyuetian'))
	exit('403');

$sitekey2 = md5(md5($_G['SYSTEM']['DOMAIN']) . md5($_G['SET']['APP_HADSKYCLOUDSERVER_SITEKEY']) . md5($_GET['createtime']) . md5($_GET['timeout']));
if (Cnum($_GET['createtime']) + Cnum($_GET['timeout']) > time() && $_GET['sitekey2'] == $sitekey2) {
	$data = json_decode($_GET['data'], TRUE);
	//防止二次重复充值
	if ($_G['TABLE']['APP_HADSKYCLOUDSERVER_CLOUDPAY_RECORD'] -> getData(array('hs_id' => $data['hs_id']))) {
		exit('ok');
	}
	$array = array();
	$array['hs_id'] = $data['hs_id'];
	$array['createtime'] = Cnum($data['createtime']);
	$array['uid'] = Cnum($data['uid']);
	$array['rmb'] = Cnum($data['rmb']);
	$array['finishtime'] = time();
	$array['tiandou'] = Cnum($_G['SET']['APP_HADSKYCLOUDSERVER_TIANDOUDUIHUANSHU']) * $array['rmb'];
	$_G['TABLE']['APP_HADSKYCLOUDSERVER_CLOUDPAY_RECORD'] -> newData($array);
	//充值到账
	UserDataChange(array('tiandou' => $array['tiandou']), $array['uid']);
	exit('ok');
} else {
	exit('no');
}
