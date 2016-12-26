---
id: 1457
title: 人人网密码是明文传输的
date: 2012-02-22T21:59:12+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1457
duoshuo_thread_id:
  - 1351844048792453143
categories:
  - 经验技巧
tags:
  - 网络安全
  - 腾讯
---
今天看到月光博客里说道[UC浏览器被指明文传输用户密码](http://www.williamlong.info/archives/3006.html)，里面谈到关于网站明文传输滴，我才想起N久以前看人人网的密码也是明文传输的，不知道改了没有。今天再看了下，果然还是明文传输的。不过现在的很多网站肯定也是明文传输密码的。QQ当然不可能是明文传输。

随便用google的开发人员工具抓包就能看到，当然你也可以用httpwatch，firedebug，fiddler等等抓包看看。

<img class="alignnone" title="人人网V.S腾讯密码传输" src="http://i1123.photobucket.com/albums/l549/tl3shi/renren_tencent1.jpg" alt=""  data-pinit="registered" />

可以看到，人人网登陆虽然用POST传输，也能看到提交的form表单，用户名和密码。图中下半部分是我抓webQQ的登陆时提交的表单。其实，腾讯所有的产品，其登陆都由统一的部门管理。其他产品例如朋友网，腾讯微博根本就不知道用户输入的密码是什么，其判断是否登陆成功只能通过cookie来判断，你也可以试试，禁用浏览器的coockie，再去登陆类似朋友网，腾讯微博之类的，看是否能登陆成功。

还有，一些网站用户的帐号被盗，其一有可能就是网站本身安全性没有考虑好，就如人人网，直接明文传输，电脑稍微有个小脚本就能监测到其输入的用户名和密码。如果其加密了，就如腾讯，就算知道传输时的用户名和密文密码，也无法破译。其二，就是由于用户本身的安全意识导致其主动将自己的帐号密码告诉给其他人，例如一些钓鱼网站啊等等。

&nbsp;
