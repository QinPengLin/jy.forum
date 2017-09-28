DROP TABLE IF EXISTS `pk_download_record`;
CREATE TABLE `pk_download_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `downloadid` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  `tiandou` int(11) NOT NULL DEFAULT '0',
  `datetime` bigint(20) NOT NULL DEFAULT '20000101000000',
  `leixing` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `pk_read`;
CREATE TABLE `pk_read` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章的id',
  `sortid` int(11) NOT NULL DEFAULT '0' COMMENT '文章所属版块id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发布人uid',
  `title` text NOT NULL COMMENT '文章标题',
  `content` longtext NOT NULL COMMENT '文章内容',
  `looknum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `zannum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被赞次数',
  `posttime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `readlevel` int(11) NOT NULL DEFAULT '0' COMMENT '文章阅读权限',
  `replyuid` int(11) unsigned NOT NULL DEFAULT '2' COMMENT '最后回复人uid',
  `replycontent` text COMMENT '最新回复内容',
  `replytime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后回复时间',
  `replyip` varchar(255) DEFAULT NULL COMMENT '最后回复人的ip',
  `postip` varchar(255) DEFAULT NULL COMMENT '发布人的ip',
  `top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文章置顶',
  `high` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文章精华',
  `replyafterlook` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '回复后可见',
  `data` longtext COMMENT '文章其他数据',
  `del` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1为删除，0为正常',
  `activetime` int(11) NOT NULL DEFAULT '0' COMMENT '最后活动时间',
  `replyid` int(11) NOT NULL DEFAULT '0' COMMENT '回复的id',
  `fs` int(11) NOT NULL DEFAULT '1' COMMENT '回复的楼层数',
  `label` text COMMENT '标签',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文章表';
INSERT INTO `pk_read` VALUES (1,1,1,'欢迎您使用HadSky轻论坛！','您好，我是乐天，HadSky轻论坛的创始人及开发者，很高兴您选择HadSky轻论坛，HadSky 4.x将专注于移动端的发展，成就一款国产、原创、开源、免费的掌上轻论坛系统，HadSky基于puyuetianPHP和puyuetianUI开发，整套软件版权都归作者蒲乐天所有，整套原创，您可以放心使用。<p><br></p><p>使用HadSky轻论坛您必须遵守HadSky用户协议<a target=\"_blank\" href=\"http://www.hadsky.com/index.php?c=read&amp;id=281&amp;page=1\">http://www.hadsky.com/index.php?c=read&amp;id=281&amp;page=1</a>，请您仔细阅读用户协议，并遵守协议，我们才能更好的为您服务。</p><p><br></p><p>HadSky现处于公测阶段，若您在试用过程中遇到了bug或问题，请及时向我们反馈：</p><p>QQ群：368240741</p><p>作者QQ：632827168</p><p></p><p><br></p><p>感谢您选择HadSky，让我们一起努力让HadSky更好、更美、更强大！</p><p><br></p><p style=\"text-align: right;\">By puyuetian</p><p style=\"text-align: right;\">2016年07月21日</p>',3,0,1469069740,0,2,NULL,0,NULL,'::1',1,1,0,NULL,0,1469069740,0,1,'原创,爆料'),(2,1,1,'开启免签约使用QQ、百度及微博登录，免签约使用支付宝在线支付！','HadSky4.6开启了云登录与云支付功能，只要您配置好与HadSky的sitekey即可实现免签约在线支付宝支付和免签约登录第三方账号！<p><br></p><p>详情地址：<a target=\"_blank\" href=\"http://www.hadsky.com/app-puyuetian_documents-index.html#rid1833\">http://www.hadsky.com/app-puyuetian_documents-index.html#rid1833</a></p><p><br></p><p>HadSky发展离不开大家的支持，欢迎大家提出建议和反馈问题！</p>',1,0,1500722725,0,2,NULL,0,NULL,'::1',0,0,0,NULL,0,1500722725,0,1,'原创');
DROP TABLE IF EXISTS `pk_readsort`;
CREATE TABLE `pk_readsort` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '版块的id',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属父版块的id',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '版块排序，从小到大',
  `title` text NOT NULL COMMENT '版块名称',
  `content` text COMMENT '版块说明',
  `url` text COMMENT '点击分类跳转的url',
  `logourl` text COMMENT '版块logo图片地址',
  `postlevel` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户发帖需要的阅读权限',
  `replylevel` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户回复需要的阅读权限',
  `adminuids` text COMMENT '管理员uid',
  `looklevel` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户看帖需要的阅读权限',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1:显示 0:隐藏',
  `label` text COMMENT '标签',
  `banpostread` int(11) NOT NULL DEFAULT '0' COMMENT '该板块是否允许发帖',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='版块分类表';
INSERT INTO `pk_readsort` VALUES (1,0,0,'新版块','','','',0,0,'',0,1,'原创,爆料',0);
DROP TABLE IF EXISTS `pk_reply`;
CREATE TABLE `pk_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '回复的id',
  `rid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复的文章id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复人uid',
  `content` text NOT NULL COMMENT '回复内容',
  `posttime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回复时间',
  `postip` varchar(255) DEFAULT NULL COMMENT '发布人的ip',
  `zannum` int(11) NOT NULL DEFAULT '0' COMMENT '赞数',
  `top` tinyint(3) NOT NULL DEFAULT '0' COMMENT '置顶',
  `del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1删除，0正常',
  `fnum` int(11) NOT NULL DEFAULT '0' COMMENT '当前回复的楼层数',
  `data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='回复表';
DROP TABLE IF EXISTS `pk_set`;
CREATE TABLE `pk_set` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '基本设置id',
  `setname` char(255) NOT NULL COMMENT '变量名称',
  `setvalue` text COMMENT '变量值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `setname` (`setname`)
) ENGINE=MyISAM AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统设置表';
INSERT INTO `pk_set` VALUES (2,'bbcodemarks','<b><i><u><strong><font><pre><code><p><span><table><thead><tbody><tfoot><tr><td><th><a><em><h1><h2><h3><h4><h5><h6><img><label><ul><ol><li><br><audio><embed><video>'),(3,'footerhtmlcode','<a target=\"_blank\" href=\"http://www.hadsky.com\">HadSky官方站</a>\r\n<a target=\"_blank\" href=\"http://wpa.qq.com/msgrd?v=3&uin=632827168&site=qq&menu=yes\">联系站长</a>\r\n\t\t\t'),(4,'headerhtmlcode','<a target=\"_blank\" href=\"http://www.hadsky.com\">官方论坛</a>'),(5,'quotes','支持原创软件，抵制盗版，共创美好明天！'),(6,'templatename','puyuetian_newstyle4'),(7,'webdescription','HadSky轻论坛 - 轻、快、简的原创论坛系统！这是一款对非营利性个人用户免费开放的论坛系统，基于原创的puyuetianPHP快速开发框架设计，新的论坛，新的世界！'),(8,'webkeywords','hadsky,有天,轻论坛,puyuetian,蒲乐天'),(9,'weblogo','template/default/img/logo.png'),(10,'webname','有天轻论坛'),(11,'reg','1'),(12,'reguserquanxian','bbcode,login,lookuser,postreply,uploadfile,uploadhead,search,postread,lookread,download'),(13,'readlistnum','10'),(14,'replylistnum','10'),(15,'logotext','HadSky'),(16,'qiandaojifen','10'),(17,'qiandaotiandou','10'),(18,'readsort',''),(19,'navhtmlcode','<li><a href=\"index.php?c=home\">首页</a></li>\r\n<li><a href=\"index.php?c=list\">动态</a></li>\r\n<li><a href=\"index.php?c=forum\">版块</a></li>\r\n<li><a target=\"_blank\" href=\"http://www.hadsky.com/app-puyuetian_documents-index.html\">使用文档</a></li>\r\n<li><a target=\"_blank\" href=\"http://www.hadsky.com/appstore.html\">应用市场</a></li>\r\n<li><a target=\"_blank\" href=\"http://www.hadsky.com/htmlpage-purchase.html\">购买产品</a></li>\r\n<li><a target=\"_blank\" href=\"http://www.hadsky.com/read-281-1.html\">用户协议</a></li>'),(20,'uploadfiletypes','jpg|jpeg|gif|bmp|png|zip|rar|txt|doc'),(21,'uploadfilesize','2000'),(22,'postreadjifen','5'),(23,'postreadtiandou','5'),(24,'postreplyjifen','2'),(25,'postreplytiandou','2'),(27,'defaultpage','list'),(29,'rewriteurl','0'),(30,'downloadfilernd','258'),(31,'openverifycode','0'),(32,'phonetemplatename','default'),(33,'regmessage','恭喜您注册成功！'),(44,'jifenname','经验'),(45,'tiandouname','金钱'),(46,'regjifen','0'),(47,'regtiandou','0'),(48,'friendlinks','<a target=\"_blank\" href=\"http://www.hadsky.com\">HadSky官方站</a>'),(49,'postingtimeinterval','0'),(50,'postaudit','0'),(51,'newuserpostwaittime','0'),(52,'beianhao','&nbsp;免备案'),(53,'bbcodeattrs','class,style,href,target,src,width,height,title,alt,border,align,valign,color,size,controls,autoplay,loop,type,face,id'),(54,'readtitlemin','1'),(55,'readtitlemax','1250'),(56,'readcontentmin','1'),(57,'readcontentmax','999999'),(58,'replycontentmin','1'),(59,'replycontentmax','999999'),(60,'replyorder','1'),(61,'readtopnum','3'),(62,'webtitle','HadSky'),(63,'template_default_headhtml',''),(64,'template_default_banner','<div class=\"pk-padding-top-30 pk-padding-bottom-30\"><a title=\"HadSky轻论坛\" href=\"/\"><img src=\"template/default/img/logo.png\" alt=\"HadSky\"></a></div>'),(65,'template_default_searchrighthtml','<div class=\"pk-text-right pk-text-xs pk-text-default\">支持原创软件，共创美好明天！</div>'),(66,'template_default_tjwzids',''),(67,'template_default_jhnum','0'),(68,'template_default_rtnum','0'),(69,'defaulttemplates','default'),(70,'runerrordisplay','1'),(71,'openreg','1'),(85,'app_superadmin_load','1'),(88,'app_puyuetianeditor_load','embed'),(89,'template_default_ad1htmlcode',''),(90,'template_default_ad2htmlcode',''),(91,'template_default_ad3htmlcode',''),(92,'guestdata','{\"username\":\"guest\",\"nickname\":\"游客\",\"quanxian\":\"bbcode,lookuser,postreply,search,lookread,download,nopostingtimeinterval\",\"readlevel\":\"0\",\"data\":\"{\\\"htmlcodemarks\\\":\\\"\\\",\\\"htmlcodeattrs\\\":\\\"\\\",\\\"uploadsize\\\":\\\"\\\"}\"}'),(93,'template_default_randheadcount','24'),(95,'novicetraineetime','0'),(96,'postreadcheck','0'),(97,'postreplycheck','0'),(107,'app_puyuetian_search_load','1'),(108,'app_puyuetian_search_showcount','50'),(109,'readlistorder','posttime'),(110,'showmessagecount','50'),(111,'closeregtip','本站暂未开启注册功能！'),(112,'uploadheadsize','500'),(113,'trylogincount','10'),(114,'changeuserinfoverify','0'),(115,'app_puyuetianeditor_pceditconfig','var PytConfig = \'Html,Bold,Italic,Underline,Strikethrough,Fontname,Fontsize,Forecolor,Backcolor,Justifyleft,Justifycenter,Justifyright,Link,Unlink,Emotion,Image,File,Video,Music,Myfiles,Code,Replylook,Undo,Redo\';'),(116,'app_puyuetianeditor_pcreadconfig','var PytConfig = \'Html,Bold,Italic,Underline,Emotion,Image,Code\';'),(117,'app_puyuetianeditor_phoneeditconfig','var PytConfig = \'Emotion,Image,File,Link,Code,Replylook\';'),(118,'app_puyuetianeditor_phonereadconfig','var PytConfig = \'Emotion,Image,Code\';'),(119,'yunserver','1'),(120,'phonedomains','m'),(121,'ifpccomephonego','1'),(122,'phonedefaulttemplates','default'),(123,'readlistshowbks',''),(124,'readlisthiddenbks',''),(125,'usernameeverychars','1'),(126,'regway','normal'),(127,'regreadlevel','10'),(128,'reguserdata',''),(129,'app_puyuetianeditor_quickpost','1'),(130,'app_puyuetianeditor_quickeditconfig','var PytConfig = \'Html,Bold,Italic,Underline,Strikethrough,Justifyleft,Justifycenter,Justifyright,Link,Unlink,Emotion,Image,Code,Replylook,Undo,Redo\';'),(131,'chkcsrfval','c5599274558f02e97470a14c9b27fa1f'),(132,'uploadfilecount','5'),(133,'dayuploadfilesize','10000'),(134,'downloadedrecord','1'),(135,'template_puyuetian_newstyle4_slidecount','5'),(136,'template_puyuetian_newstyle4_newactiveids',''),(137,'template_puyuetian_newstyle4_navadv',''),(138,'template_puyuetian_newstyle4_kjtdhtml','<div class=\"pk-padding-top-10\">\r\n<a target=\"_blank\" class=\"pk-background-color-secondary\" href=\"http://www.hadsky.com\" title=\"示例格式\"><span class=\"fa fa-search\"></span></a>\r\n</div>'),(139,'template_puyuetian_newstyle4_twrddays','9999999'),(140,'template_puyuetian_newstyle4_homeadv1','<div class=\"pk-padding-top-10 pk-padding-bottom-10\">\r\n<img class=\"pk-width-all pk-radius-2\" src=\"http://www.hadsky.com/uploadfiles/images/1/20170118/135410_ABgNso.gif\" style=\"height: 90px;border: solid 1px #ddd;\" title=\"这是广告位，在后台-模板-NewStyle4处设置\">\r\n</div>'),(141,'template_puyuetian_newstyle4_bks',''),(142,'template_puyuetian_newstyle4_activeshow','0'),(143,'template_puyuetian_newstyle4_homeadv2',''),(144,'template_puyuetian_newstyle4_tjwz',''),(145,'template_puyuetian_newstyle4_listadv1',''),(146,'template_puyuetian_newstyle4_listadv2',''),(147,'key',''),(148,'chkcsrf','0'),(149,'chkcsrfpages',''),(150,'sitestatus','0'),(151,'siteclosedtip','维护中...'),(152,'usercookieslife','31536000'),(153,'userloginemailtip','0'),(154,'regusergroupid','1'),(155,'app_verifycode_load','0'),(156,'app_verifycode_page','login,postread,reg,postreply'),(157,'app_verifycode_chars','1234567890'),(158,'app_verifycode_length',''),(159,'app_verifycode_width',''),(160,'app_verifycode_height',''),(161,'app_verifycode_fontsize',''),(162,'app_puyuetianeditor_watermark_text',''),(163,'app_puyuetianeditor_watermark_textcolor_r','255'),(164,'app_puyuetianeditor_watermark_textcolor_g','255'),(165,'app_puyuetianeditor_watermark_textcolor_b','255'),(166,'app_puyuetianeditor_watermark_pp','0'),(167,'app_puyuetianeditor_watermark_px','5'),(168,'app_puyuetianeditor_watermark_py','24'),(169,'app_puyuetianeditor_watermark_fontsize','14'),(170,'defaultlabel','原创,爆料'),(171,'app_hadskycloudserver_load','embed'),(172,'app_hadskycloudserver_sitekey',''),(173,'app_hadskycloudserver_qqlogin_openreg','0'),(174,'app_hadskycloudserver_weibologin_openreg','0'),(175,'app_hadskycloudserver_baidulogin_openreg','0'),(176,'app_hadskycloudserver_tiandouduihuanshu','10'),(177,'phonedefaultpage','list');
DROP TABLE IF EXISTS `pk_upload`;
CREATE TABLE `pk_upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传用户',
  `rid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所在的帖子id',
  `name` text COMMENT '上传的文件名',
  `suffix` text COMMENT '文件后缀',
  `uploadtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `datetime` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传时间YYYYMMDDHHIISS',
  `rand` varchar(255) NOT NULL DEFAULT '' COMMENT '产生的随机数',
  `idcode` varchar(255) NOT NULL DEFAULT '' COMMENT '识别码',
  `jifen` int(11) NOT NULL DEFAULT '0' COMMENT '消耗积分',
  `tiandou` int(11) NOT NULL DEFAULT '0' COMMENT '消耗的天豆',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT '所存在的文件夹',
  `downloadcount` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  `downloadeduids` longtext COMMENT '已下载用户的uid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='论坛附件上传记录';
DROP TABLE IF EXISTS `pk_user`;
CREATE TABLE `pk_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户的uid',
  `username` char(255) NOT NULL DEFAULT '' COMMENT '用户名，仅允许字母和数字和下划线',
  `password` text NOT NULL COMMENT '加密后的密码',
  `nickname` text COMMENT '用户昵称',
  `quanxian` text COMMENT '用户具有的权限',
  `tiandou` int(11) NOT NULL DEFAULT '0' COMMENT '天豆数',
  `jifen` int(11) NOT NULL DEFAULT '0' COMMENT '积分数',
  `logininfo` text COMMENT '最后一次登录信息',
  `reginfo` text COMMENT '用户注册信息',
  `sex` text COMMENT '性别',
  `birthday` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `email` varchar(255) DEFAULT NULL COMMENT 'email地址',
  `qq` text COMMENT 'QQ',
  `phone` text COMMENT '手机号',
  `adress` text COMMENT '联系地址',
  `sign` text COMMENT '用户个性签名',
  `friends` text COMMENT '用户好友',
  `readlevel` int(11) NOT NULL DEFAULT '0' COMMENT '用户阅读权限',
  `qqopenid` varchar(255) DEFAULT NULL COMMENT 'qq登录openid',
  `data` longtext COMMENT '用户数据',
  `logintime` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `regtime` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `session_token` varchar(255) DEFAULT NULL COMMENT '登录时产生的识别码',
  `groupid` int(11) NOT NULL DEFAULT '0' COMMENT '用户组id',
  `wxopenid` varchar(255) DEFAULT NULL COMMENT '微信登录openid',
  `weibo_uid` varchar(255) DEFAULT NULL,
  `baidu_userid` varchar(255) DEFAULT NULL,
  `regip` varchar(255) DEFAULT NULL,
  `loginip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
INSERT INTO `pk_user` VALUES (1,'admin','27da85f99b6e1207a71b6c4dd6404ddb','创始人','bbcode,login,lookuser,postreply,uploadfile,delread,editread,nopostreadcheck,noverifycode,admin,htmlcode,superman,nopostingtimeinterval,nopostreplycheck,editreply,delreply,uploadhead,search,postread,lookread,download',10,10,NULL,NULL,'s',0,'puyuetian@qq.com','','',NULL,'HadSky轻论坛 - 您的掌上轻论坛！',NULL,0,NULL,'{\"trylogindata\":\"{\\\"::1\\\":0}\",\"logindate\":\"20170704\",\"lasttimereadposttime\":\"1500722725\"}',1499131982,0,'oiSbMERd6yuFT35H',0,NULL,NULL,NULL,NULL,NULL);
DROP TABLE IF EXISTS `pk_user_message`;
CREATE TABLE `pk_user_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息的id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '消息用户的uid',
  `fid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '来自哪个用户的uid',
  `content` text COMMENT '消息内容',
  `islook` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '此消息是否被查看',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '消息添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';
DROP TABLE IF EXISTS `pk_usergroup`;
CREATE TABLE `pk_usergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usergroupname` varchar(255) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `quanxian` text COMMENT '用户组权限',
  `readlevel` int(11) NOT NULL DEFAULT '0' COMMENT '阅读权限',
  `data` longtext COMMENT '其他数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `pk_usergroup` VALUES (1,'普通会员','bbcode,login,lookuser,postreply,uploadfile,uploadhead,search,postread,lookread,download',10,'{\"htmlcodemarks\":\"\",\"htmlcodeattrs\":\"\",\"signcodemarks\":\"\",\"signcodeattrs\":\"\",\"uploadsize\":\"\",\"dayuploadfilesize\":\"\"}');
