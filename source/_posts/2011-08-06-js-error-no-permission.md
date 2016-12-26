---
id: 1105
title: JS 报错-没有权限
date: 2011-08-06T19:39:58+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1105
duoshuo_thread_id:
  - 1351844048792453278
categories:
  - PHP
tags:
  - 没有权限
---
在写后台管理的时候一直用过得firefox做开发调试，写得挺顺利的，后来Leaner准备将测试的数据删除，添加点像样的数据时，一点删除就报错了。然后就…… 

我赶紧查看，是JS报错，提示说没有权限。具体情况是这样子的,当前页面有一个表单，另外还包含一个iframe，当点击一个按钮时，submit，但设置target是这个iframe，然后呢，在firefox下，没有任何问题，服务器能成功响应，但IE下就报错，说没有权限。后来网上查，说这个是因为不能跨域访问。服务器返回JS里面加一句话就可以了<span style="font-size:10pt">document.domain=xx,例如我遇到的这个问题就采用下面的方法解决了<br /> </span>

![](/wp-content/uploads/2011/08/080611_1139_JS1.png)
