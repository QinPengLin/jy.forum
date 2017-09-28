/*
 * 名称：puyuetianUI前端框架 js驱动
 * 更新：2017-08-25
 * 作者：蒲乐天
 * 官网：http://www.hadsky.com
 */

//puyuetianJS 创建驱动框架
//puyuetianJS 创建驱动div
$(function() {
	$('body').append('<div id="pk-dd" class="pk-display-none"></div><iframe id="pk-di" name="pk-di" class="pk-display-none"></iframe>');
	//防止CSRF攻击
	var $forms = $('form');
	if($forms.length && typeof($_USER) != "undefined") {
		for(var i = 0; i < $forms.length; i++) {
			var $formaction = $($forms[i]).attr('action');
			if($formaction) {
				$formaction.indexOf('?') == -1 ? $formaction += '?' : $formaction += '&';
				$($forms[i]).attr('action', $formaction + 'chkcsrfval=' + $_USER['CHKCSRFVAL']).prepend('<input type="hidden" name="chkcsrfval" value="' + $_USER['CHKCSRFVAL'] + '">');
			}
		}
	}
	//加载图片
	ImageLaterLoading('img', '懒加载过来的图片^o^', 'this.src="template/default/img/imageloaderror.png";this.title="此图已被汪星人给吃了~汪呜汪呜~~~";this.onclick=""');
	ImageOnerrorClear('img');
});

//该函数原创，类似于jq的$().ready
function pk(func) {
	if(document.getElementsByTagName('body')[0]) {
		func();
	} else {
		setTimeout(function() {
			pk(func);
		}, 10);
	}
}

//javascript去掉空格函数
function trim($str) {
	return $str.replace(/(^\s*)|(\s*$)/g, "");
}

//添加收藏函数
function addfavor($title, $url) {
	if(!$title) $title = document.title;
	if(!$url) $url = document.URL;
	try {
		window.external.addFavorite($url, $title);
	} catch(e) {
		alert('添加收藏失败,请使用Ctrl+D进行添加');
	}
}

//按name全选或全不选
function choosecheckbox($name, $checked) {
	var $c = document.getElementsByTagName('input');
	for(i = 0; i < $c.length; i++) {
		if($c[i].name == $name) {
			$c[i].checked = $checked;
		}
	}
}

function showdivframe($id) {
	var $d = document.getElementById($id);
	var $w = window.screen.availWidth;
	var $h = window.screen.availHeight;
	var $t = parseInt(($h / 2) - (($d.offsetHeight) / 2));
	var $l = parseInt(($w / 2) - (($d.offsetWidth) / 2));
	//alert($t);
	$d.style.top = $t + 'px';
	$d.style.left = $l + 'px';
	$d.style.visibility = 'visible';
	//$d.style.display = '';
}

function hiddendivframe($id) {
	document.getElementById($id).style.visibility = 'hidden';
	//document.getElementById($id).style.display = 'none';
}

//获取get参数
function $_GET($paramname, $url) {
	var $a, $i;
	var $param = new Array();
	if(!$url) {
		$url = document.URL;
	}
	var $spos = $url.indexOf('?');
	if($spos != -1 && ($spos + 1) != $url.length) {
		var $params = $url.substring($spos + 1, $url.length).split('&');
		for($i = 0; $i < $params.length; $i++) {
			$a = $params[$i].split('=');
			if($a.length == 2) {
				$param[$a[0]] = $a[1];
			}
		}
		if($paramname) {
			return $param[$paramname];
		} else {
			return $param;
		}
	} else {
		return false;
	}
}

//文字闪闪闪
function TextSSS($id, $hm) {
	$id = document.getElementById($id) || $($id)[0];
	if(!$hm) $hm = 800;
	if($id) setInterval(function() {
		$id.style.opacity == 0 ? $id.style.opacity = 1 : $id.style.opacity = 0;
	}, $hm);
}

function pkalert($content, $title, $jscode, $noautoclose) {
	if($content === false) {
		if(!$title) {
			$('.pk-alert,.pk-alert-bg').remove();
		} else {
			$('#pab-' + $title + ',#pa-' + $title).remove();
		}
	} else {
		var alertid = (Date.parse(new Date()) / 1000) + parseInt(Math.random() * 1000);
		if($content !== null) {
			if(!$noautoclose) {
				$autoclose = ';pkalert(false,' + alertid + ');';
			} else {
				$autoclose = '';
			}
			$('body').append('<div id="pab-' + alertid + '" class="pk-alert-bg"></div><div id="pa-' + alertid + '" class="pk-alert"><div class="pk-alert-box"><div class="pk-alert-head">提示</div><div class="pk-alert-body"></div><div class="pk-alert-foot"><a class="pk-btn pk-btn-primary pk-radius-2" onclick="pkalert(false,' + alertid + ')">确定</a><a class="pk-btn pk-btn-danger pk-radius-2" style="margin-left:15px;display:none;" onclick="pkalert(false,' + alertid + ')">取消</a></div></div></div>');
			$('#pa-' + alertid + ' .pk-alert-body').html($content);
			if($title) {
				if($title.substr(0, 3) == 'js:') {
					$('#pa-' + alertid + ' .pk-alert-foot a:eq(0)').attr('onclick', $title.substr(3) + $autoclose);
				} else {
					$('#pa-' + alertid + ' .pk-alert-head').html($title);
				}
			}
			if($jscode) {
				$('#pa-' + alertid + ' .pk-alert-foot a:eq(0)').attr('onclick', '');
				if(typeof $jscode == "function") {
					$('#pa-' + alertid + ' .pk-alert-foot a:eq(0)').bind('click', $jscode);
					if(!$noautoclose) {
						$('#pa-' + alertid + ' .pk-alert-foot a:eq(0)').bind('click', function() {
							pkalert(false, alertid);
						});
					}
				} else {
					$('#pa-' + alertid + ' .pk-alert-foot a:eq(0)').attr('onclick', $jscode + $autoclose);
				}
				$('#pa-' + alertid + ' .pk-alert-foot a:eq(1)').css('display', '');
			}
		}
		return alertid;
	}
}

function TextboxAndCheckbox($textbox, $checkbox) {
	var $regqxs = $($textbox).val();
	var $regarray = new Array();
	$regarray = $regqxs.split(",");
	for(var $i = 0; $i < $regarray.length; $i++) {
		$($checkbox + "[value='" + $regarray[$i] + "']").attr('checked', 'true');
	}
	$($checkbox).click(function() {
		var $regqxs = $($textbox).val();
		var $regarray = new Array();
		$regarray = $regqxs.split(",");
		if(this.checked) {
			//写进注册权限值
			if($regqxs.length > 0) {
				$regqxs += ',' + this.value;
			} else {
				$regqxs = this.value;
			}
			$($textbox).val($regqxs);
		} else {
			//移除注册权限值
			if($regqxs.length > 1) {
				$regqxs = '[hadsky.com]'; //临时填充字符
				for(var $i = 0; $i < $regarray.length; $i++) {
					if($regarray[$i] != this.value) {
						$regqxs += (',' + $regarray[$i]);
					}
				}
				//去掉临时填充的字符
				$regqxs = $regqxs.replace('[hadsky.com],', '');
				$regqxs = $regqxs.replace('[hadsky.com]', '');
			} else {
				$regqxs = $regqxs.replace(this.value, '');
			}
			$($textbox).val($regqxs);
		}
	});
}

//图片延迟加载
function ImageLaterLoading($id, $title, $error) {
	var imageloadings = $($id);
	for(var $i = 0; $i < imageloadings.length; $i++) {
		if($(imageloadings[$i]).data('status') != 'complete' && $(imageloadings[$i]).data('src') && $(imageloadings[$i]).data('src') != imageloadings[$i].src) {
			$(imageloadings[$i]).attr('src', $(imageloadings[$i]).data('src'));
			$(imageloadings[$i]).attr('data-status', 'complete');
			if(!imageloadings[$i].title && $title) {
				$(imageloadings[$i]).attr('title', $title);
			}
			if(!imageloadings[$i].onerror && $error) {
				$(imageloadings[$i]).attr('onerror', $error);
			}
		}
	}
}

function ImageOnerrorClear($id, $js) {
	var images = $($id);
	if(!$js) {
		$js = ";this.onerror=''";
	} else {
		$js = ";" + $js;
	}
	for(var $i = 0; $i < images.length; $i++) {
		if(!$(images[$i]).attr('onerror')) $(images[$i]).attr('onerror', '');
		$(images[$i]).attr('onerror', $(images[$i]).attr('onerror') + $js);
	}
}

function getLocalTime(nS, format) {
	if(nS) {
		var $date = new Date(parseInt(nS) * 1000);
	} else {
		var $date = new Date();
	}
	var $y = $date.getFullYear();
	var $m = $date.getMonth() + 1;
	if($m < 10) {
		$m = '0' + $m;
	}
	var $d = $date.getDate();
	if($d < 10) {
		$d = '0' + $d;
	}
	var $h = $date.getHours();
	if($h < 10) {
		$h = '0' + $h;
	}
	var $i = $date.getMinutes();
	if($i < 10) {
		$i = '0' + $i;
	}
	var $s = $date.getSeconds();
	if($s < 10) {
		$s = '0' + $s;
	}
	if(format) {
		var format2 = '';
		format2 = format.replace('y', $y);
		format2 = format2.replace('m', $m);
		format2 = format2.replace('d', $d);
		format2 = format2.replace('h', $h);
		format2 = format2.replace('i', $i);
		format2 = format2.replace('s', $s);
		return format2;
	} else {
		return $y + '-' + $m + '-' + $d + ' ' + $h + ':' + $i + ':' + $s;
	}
}

function strip_tags($str) {
	return str.replace(/<[^>]+>/g, "");
}

function ImageToBase64(url, w, h) {
	var img, base64data, tw, th, ow, oh;
	tw = 0;
	th = 0;
	var $div = 'pk-div-rnd-' + parseInt(Math.random() * 10000);
	$('body').append('<div class="pk-hide" id="' + $div + '"></div>');
	$('#' + $div).html('<canvas id="pk-canvas-object"></canvas>');
	var canvas = $('#' + $div + ' #pk-canvas-object')[0];
	var ctx = canvas.getContext('2d');
	img = url;
	ow = $(img).width();
	oh = $(img).height();
	$(img).width('');
	$(img).height('');
	if(w) {
		if(w.substr(0, 4) == 'max:') {
			tw = w.substr(4);
			if(tw > img.width) {
				tw = img.width;
			}
		} else if(w.substr(0, 4) == 'min:') {
			tw = w.substr(4);
			if(tw < img.width) {
				tw = img.width;
			}
		} else {
			tw = w;
		}
	}
	if(h) {
		if(h.substr(0, 4) == 'max:') {
			th = h.substr(4);
			if(th > img.height) {
				th = img.height;
			}
		} else if(h.substr(0, 4) == 'min:') {
			th = h.substr(4);
			if(th < img.height) {
				th = img.height;
			}
		} else {
			th = h;
		}
	}
	if(tw || th) {
		if(!tw) {
			tw = (th / img.height) * img.width;
		}
		if(!th) {
			th = (tw / img.width) * img.height;
		}
		canvas.width = tw;
		canvas.height = th;
		ctx.drawImage(img, 0, 0, tw, th);
	} else {
		canvas.width = img.width;
		canvas.height = img.height;
		ctx.drawImage(img, 0, 0);
	}
	base64data = canvas.toDataURL('image/png');
	$('#' + $div).remove();
	$(img).width(ow);
	$(img).height(oh);
	return base64data;
}

function getLocalFileUrl(sourceId) {
	var url, obj;
	if(typeof sourceId == 'object') {
		obj = sourceId;
	} else {
		obj = $(sourceId)[0];
	}
	url = window.URL.createObjectURL(obj.files[0]);
	return url;
}

function LookImage($obj) {
	var $url;
	if(typeof $obj == 'object') {
		$url = $obj.src;
		if($obj.alt == 'emotion') {
			return false;
		}
	} else {
		$url = $obj;
	}
	var $lh = $(window).height();
	$('body').append('<div class="pk-alert-bg"></div><div class="pk-alert pk-padding-15 pk-text-center" style="line-height:' + $lh + 'px;overflow:auto" onclick="pkalert(false)"><img id="pk-lookimage" src="' + $url + '" style="width:auto;height:auto"></div>');
}

function isJson(obj) {
	var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;
	return isjson;
}

function FormDataPackaging($selector) {
	var forminputs = $($selector + ' :input');
	var formstring = '_webos=HadSky';
	for(var i = 0; i < forminputs.length; i++) {
		if($(forminputs[i]).attr('name')) {
			if($(forminputs[i]).attr('type') == 'checkbox' && !$(forminputs[i]).prop('checked')) {
				formstring += '&' + $(forminputs[i]).attr('name') + '=';
			} else {
				formstring += '&' + $(forminputs[i]).attr('name') + '=' + encodeURIComponent(($(forminputs[i]).val() || ''));
			}
		}
	}
	return formstring;
}

//默认模板公用函数
function postmessagediv($uid) {
	if($uid == $_USER['ID']) {
		pkalert('不能自己给自己发消息');
	} else if(!$uid) {
		pkalert('请登录后再操作');
	} else {
		var $html = '<form name="form_message" target="pk-di" method="post" action="index.php?c=postmessage&uid=' + $uid + '"><div class="pk-row pk-margin-top-10"><div class="pk-w-sm-12 pk-padding-0"><textarea name="content" class="pk-textarea pk-textbox-noshadow pk-radius-4 pk-width-all" maxlength="255" rows="7"></textarea></div></div></form>';
		pkalert($html, '发消息', function() {
			if(trim(form_message.content.value)) {
				var strings = FormDataPackaging('form[name="form_message"]:eq(0)');
				$.post('index.php?c=postmessage&uid=' + $uid, strings, function(data) {
					if(data['state'] == 'ok') {
						pkalert(false);
						pkalert('发送成功');
					} else {
						pkalert(data['msg'] || '未知错误');
					}
				}, 'json');
			} else {
				form_message.content.focus()
			}
		}, true);
		form_message.content.focus();
	}
}

function addfriend($uid) {
	if($_USER['ID'] > 0 && $_USER['ID'] != $uid) {
		window.open('index.php?c=friends&uid=' + $uid + '&type=add', 'pk-di');
		pkalert('添加好友成功！');
	} else {
		if(!($_USER['ID'] > 0)) {
			pkalert('请登录后再操作');
		} else {
			pkalert('不能自己添加自己');
		}
	}
}

function delfriend($uid) {
	pkalert('您确定删除该好友么？', '提示', 'window.open("index.php?c=friends&uid=' + $uid + '&type=del","pk-di");if($_GET("c")=="friends"){$("#message-uid-' + $uid + '").remove();lookmessage(0);}else{pkalert("删除成功！");}');
}