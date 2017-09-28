<?php
if (!defined('puyuetian'))
	exit('403');

$table = $_G['GET']['TABLE'];

if (($table != 'read' && $table != 'reply') || !$_G['GET']['ID'])
	exit('illegal parameter');

$data = $_G['TABLE'][strtoupper($table)] -> getData($_G['GET']['ID']);

if (!$data)
	exit('Does not exist ID');

if ($table == 'reply') {
	$sortid = $_G['TABLE']['READ'] -> getData($data['rid']);
} else {
	$sortid = $_G['TABLE']['READ'] -> getData($_G['GET']['ID']);
}
$sortid = $sortid['sortid'];
$bkdata = $_G['TABLE']['READSORT'] -> getData($sortid);
(InArray($bkdata['adminuids'], $_G['USER']['ID']) && $_G['USER']['ID']) ? $bkadmin = TRUE : $bkadmin = FALSE;

if ($_G['USER']['ID'] == 1 || (InArray(getUserQX(), 'del' . $table) && (InArray(getUserQX(), 'admin,superadmin') || $bkadmin || $data['uid'] == $_G['USER']['ID']))) {
	UserDataChange(array("jifen" => Cnum($_G['SET']['POST' . strtoupper($table) . 'JIFEN']), "tiandou" => Cnum($_G['SET']['POST' . strtoupper($table) . 'TIANDOU'])), $data['uid'], '-');
	$_G['TABLE'][strtoupper($table)] -> newData(array('id' => $_G['GET']['ID'], 'del' => 1));
	exit('ok');
} else {
	exit('Unauthorized operation');
}
