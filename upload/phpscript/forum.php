<?php
if (!defined('puyuetian'))
	exit('Not Found puyuetian!Please contact QQ632827168');

$id = Cnum($_G['GET']['ID'], 0, TRUE, 0);

$template = template('forum-2', TRUE, FALSE, FALSE);
$forumdatas = $_G['TABLE']['READSORT'] -> getDatas(0, 0, "where `pid`={$id} and `show`=1 order by `rank`");
if ($forumdatas) {
	foreach ($forumdatas as $forumdata) {
		$forumhtml .= template('forum-2', TRUE, $template);
	}
}

if ($id) {
	$pdata = $_G['TABLE']['READSORT'] -> getData($id);
	$_G['SET']['WEBTITLE'] = '版块列表 - ' . $pdata['title'];
	if ($pdata['content']) {
		$_G['SET']['WEBDESCRIPTION'] = strip_tags($pdata['content']);
	}
} else {
	$_G['SET']['WEBTITLE'] = '版块列表 - ' . $_G['SET']['WEBTITLE'];
}

$_G['HTMLCODE']['OUTPUT'] .= template('forum-1', TRUE) . $forumhtml . template('forum-3', TRUE);
