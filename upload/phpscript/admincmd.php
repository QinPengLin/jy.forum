<?php
if (!defined('puyuetian'))
	exit('403');

$table = $_G['GET']['TABLE'];
$field = $_G['GET']['FIELD'];
$value = $_GET['value'];

if (($table != 'read' && $table != 'reply') || ($field != 'top' && $field != 'high') || !$_G['GET']['ID'])
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

if ($_G['USER']['ID'] == 1 || InArray(getUserQX(), 'superman') || ($table == 'reply' && $field == 'top' && ($_G['USER']['ID'] == $data['uid'] || InArray(getUserQX(), 'admin')))) {
	$_G['TABLE'][strtoupper($table)] -> newData(array('id' => $_G['GET']['ID'], $field => $value));
	exit('ok');
} else {
	exit('Unauthorized operation');
}
