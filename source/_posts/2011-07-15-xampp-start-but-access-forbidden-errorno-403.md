---
id: 997
title: XAMPP安装后出现拒绝访问-Access forbidden-Error 403
date: 2011-07-15T00:35:15+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=997
duoshuo_thread_id:
  - 1351844048792453123
categories:
  - PHP
tags:
  - APACHE
  - PHP
---
前面说到XAMPP安装后配环境时出现了问题就是这个，说也奇怪，刚开始安装完毕后，就能正常访问到XAMPP的首页，让选择语言。当我在eclipse里面新建一个工作空间到htdocs后就不行了，访问就一直拒绝。这奇怪啊，我eclipse搞个工作空间到htdocs里面有啥影响啊。这个问题出现的原因未解。有时候出现的一些莫名其妙的问题是无法解释的。

反正后来是这样解决的。

##### Access forbidden!

You don’t have permission to access the requested directory. There is either no index document or the directory is read-protected.

If you think this is a server error, please contact the webmaster.

##### Error 403

解决方法就是在xampp\apache\conf\httpd.conf中将下面的

<Directory />
  
Options FollowSymLinks
  
AllowOverride None
  
Order deny,allow
  
Deny from all
  
</Directory>

修改 Deny from all 为 Deny from allow。

此后得重启apache才行。一次不行，两次。两次不行，重启电脑啊之类的。
