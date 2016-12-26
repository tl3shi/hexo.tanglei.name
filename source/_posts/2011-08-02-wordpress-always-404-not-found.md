---
id: 1070
title: WordPress总是报404-Not Found
date: 2011-08-02T21:48:13+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1070
duoshuo_thread_id:
  - 1351844048792453215
categories:
  - Wordpress
  - 我做站长
tags:
  - Wordpress
---
之前因为想把[www.i3zhai.com和blog.i3zhai.com](http://www.i3zhai.com和blog.i3zhai.com)的请求全部转发到[www.tanglei.name/index.php上。结果在cpanel](/blog/index.php上。结果在cpanel)上配置总是不行。都会将相应的请求参数和路径也附加到[www.tanglei.name上。知道.htaccess](http:.html/www.tanglei.name上。知道.htaccess)文件可以实现。就按照自己的理解，匹配正则表达式嘛，瞎搞了一番。最后没实现功能，反倒让Wordpress总是各种报404.以为把最开始备份的.htaccess还原成原来的状态就可以了。但还是404Notfound。但后台管理能访问，于是新写了一个测试，结果还是404.如图： 


![](/wp-content/uploads/2011/08/080211_1347_Wordpress401.jpg) 

后来才发现，网上也有人遇到类似的问，这篇文章说了如何解决。[WordPress &#8220;Not Found&#8221; Error Fix](http://www.squidoo.com/Wordpress-not-found-error-fix)。现在我用中文说一下解决方案。呵呵。 

这篇文章说的是很可能就是因为改动了Wordpress固定链接的结构，(但我可没改，不过我遇到这个问题也应该是我改.htacess的原因。)原文说可能是因为选择了其他非短链接(?p=XX)之类的。然后说Wordpress后台还会报错，.htaccess不可写啊之类。让改权限。改成666之类的。然后再进Wordpress后台，设置-<span style="font-family:Wingdings">à</span>固定链接，点保存更改，即可。 


![](/wp-content/uploads/2011/08/080211_1347_Wordpress402.jpg) 

我就按照这个方法，幸亏我使用的ftp工具FlashFXP支持这样写命令了。我我来得直接一点。直接chmod 777。最后再进后台，点下保存。然后就能成功访问了。 


![](/wp-content/uploads/2011/08/080211_1347_Wordpress403.jpg) 

 
