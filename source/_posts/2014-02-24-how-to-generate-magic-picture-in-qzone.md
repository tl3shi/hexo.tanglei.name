---
id: 2314
title: '所谓QQ空间神奇的日志、图片~原来是酱紫&#8230;'
date: 2014-02-24T22:30:24+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2314
duoshuo_thread_id:
  - 1351844048792453498
categories:
  - 经验技巧
tags:
  - PHP
---
在浏览自己的QQ空间的时候，时不时会看到有这样的图片，图片里面的内容包含自己的QQ号码，昵称和头像信息，然后就是&#8221;恭喜发财&#8221;啊,&#8221;转发送祝福&#8221;啊之类的(以此来推广产品啊获取流量等)。

[<img title="qq transfer" src="/wp-content/uploads/2014/02/qq-transfer_thumb.png" alt="qq transfer"  />](/wp-content/uploads/2014/02/qq-transfer.png)

今天就探了个究竟。其实大概也能想到，这张图片是动态生成的，关键就是怎么获取自己的帐号信息。
  
首先想到的是Cookie，但感觉不对~ 人家网站的cookie，是没办法轻松获得滴吧~
  
然后~嗯，应该是http的请求头~
  
当浏览自己的QQ空间时，那张动态的图片指向了另外一台服务器A.服务器A可以获得请求的来源，正是自己QQ空间的url~~ 从中获取url得到QQ号，再通过QQ号 去获取 头像，昵称信息~ 得到这些信息后在服务器A的后台，在已有的图片基础上加拼接上头像和文字信息~恰好之前实习时候有用到[php中给图片加文字/图片水印](/blog/add-chinese-text-mark-to-picture-in-php.html)，所以很快就搞定了~
  
对，就是这样~

效果可以到这里看：进[这个日志](http://user.qzone.qq.com/410454274/blog/1393078235)，然后分享，再自己的个人中心查看自己分享的状态~类似下面这样

[<img title="image" src="/wp-content/uploads/2014/02/image_thumb.png" alt="image"  />](/wp-content/uploads/2014/02/image.png)

之所以点击进去后没有了，是因为你点击进去后，我就获取不到当前浏览者(你)的QQ号码了~ 在你的个人中心能看到，是因为能从这个请求的refere得到你的QQ号~
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-
  
貌似TX会对(应该有一定条件)日志中的图片进行缓存~ 如果这张动态的图片被缓存了~ 就没辙了。。。
