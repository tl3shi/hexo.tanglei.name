---
title: 给手机主题插件Wptouch绑定单独的域名
date: 2015-06-26
layout: post
categories: 
    - 经验技巧 
tags: 
    - 经验技巧 
    - 我做站长 
    - Wordpress 
published: True
---

目标是使得在Wordpress站点中，绑定域名[m.tanglei.name](m.tanglei.name),通过此域名访问Wordpress站点时都以wptouch主题访问。 

最终解决方案： 

手动设置UA，让wptouch后台添加设置的UA能够match后切换。相关联系太多，不能直接设置``is_mobile_device``为``true``或者直接``$this->is_supported_device()``返回``true``。

vim core/class-wptouch-pro.php 中的is_supported_device()方法中：

```php
$domain = $_SERVER['HTTP_HOST'];
if ($domain == 'm.tanglei.name')
     $_SERVER['HTTP_USER_AGENT']='tanglei'; //跟wptouch admin后台设置的一样即可
```

首页解决了～ 还得改首页上的链接～ 这些链接都是www打头的～ 
vim wp-config.php 添加如下设置，成功后 WP后台设置-常规中Wordpress地址和站点地址不可编辑。
//``{.php .numberLines} Attention 这个jekyll不支持

```php 
//multiple domain set tanglei begin
$tangleihome = 'http://'.$_SERVER['HTTP_HOST'];
$tangleisiteurl = $tangleihome;
define('WP_HOME', $tangleihome);
define('WP_SITEURL', $tangleisiteurl);
//multiple domain set tanglei end
```
对SEO不太好～管他呢～

效果如下

![](https://www.tanglei.name/resources/binding-domain-to-plugin-of-mobile-theme/m.tanglei.name.preview.png)
