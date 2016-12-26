---
id: 364
title: 我的博客搬家了,换空间、域名
date: 2011-03-29T05:41:17+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=364
duoshuo_thread_id:
  - 1351844048792453327
categories:
  - MyLife
tags:
---
由于换空间了。反正都要啥备份数据库啊，重新上传Wordpress到新ftp啊。之类的。结果还挺快的。新空间是laoxuehost的，里面看了下myslq不怎么方便设置啊。在空间后台管理添加了外部主机访问权限%，自己用mysqlfront等mysql客户端还是连不上去。也就只好用phpmyadmin导入sql语句了。导入之前别忘了做一件事情，把以前的sql文件当中原有的域名http://blog.i3zhai.com全部替换到http://www.tanglei.name新域名。然后导入即可。修改wp-config.php。数据库，用户。说只需要改主机为localhost。推断出来的ftp地址就是mysql服务器地址。但是还是登陆不上去，估计端口啥的不是还是怎么回事。有空还得咨询下。。mysqlfront或者navicat用着方便啊。
  
结果全部上传完毕后，访问tanglei.name报错：
  
Warning: Cannot modify header information &#8211; headers already sent by (output started at ……………………
  
啥啥啥。有的说插件。。结果也就是个编码的问题。
  
将刚上传的wp-config打开，另存为ANSI编码再上传覆盖即可访问了。
  
搬家了，搬家了。
