---
id: 573
title: 将腾讯微博加到Wordpress
date: 2011-04-30T08:54:28+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=573
duoshuo_thread_id:
  - 1351844048792453422
categories:
  - 经验技巧
tags:
  - Wordpress
  - 我做站长
---
将腾讯的微博加到Wordpress，想想也就是一句代码的问题。进了腾讯的官方微博看看。有个[腾讯微博秀](http://open.t.qq.com/websites/show/)。“使用微博秀，将生成的代码放置到你的博客、网站或是其它支持html代码的位置，就能向网页访问者展示你在腾讯微博的最新广播和听众。”可以生成代码。
  
<iframe frameborder=&#8221;0&#8243; scrolling=&#8221;no&#8221; src=&#8221;http://v.t.qq.com/show/show.php?n=tl3shi&w=217&h=552&fl=1&l=2&o=31&c=0&si=980ad9b2208025f72a4669cde4de601cb2891294&#8243; width=&#8221;217&#8243; height=&#8221;552&#8243;></iframe>

剩下的就是调整生成的微博窗口的位置了。进入Wordpress后台。外观—编辑-主题有个sidebar.php类似的东西，不同的主题估计有细微差别，我的就是sidebar-right.php,sidebar-left.php。将你自己的对应的微博代码copy到side-bar里面。不断调整，达到你自己想要的结果就可以了。
