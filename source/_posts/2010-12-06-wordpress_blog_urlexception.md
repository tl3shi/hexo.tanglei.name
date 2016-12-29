---
id: 14
title: Wordpress更改二级域名异常
date: 2010-12-06T15:23:12+00:00
author: tanglei
excerpt: |
  将以前的<a href="http://www.i3zhai.com">www.i3zhai.com</a>换成了二级域名了blog.i3zhai.com
  
  期间出了点问题。是因为在没换之前。在Wordpress后台没有该url。后Wordpress前台的链接除了首页访问。。且首页的CSS等都没有出来。只出现了文字。登陆的后天提交的action还是www开头的。所以想象前台的链接是通过DB生成的。而到后天数据库中查看。wp_users表中user_url中的url也改成了blog.i3zhai.com了。但前台生成的submit的action还是www的。所以想想肯定后台数据库中还有的地方保存了url信息了。最后发现wp_options表中的siteurl中还是<a href="http://www.i3zhai.com">www.i3zhai.com</a>。将其改为blog.i3zhai.com成功。
  
  不过 后来当这篇文章发布出去后 才发现这个也访问不了。
  
  原来发布的每篇文章的url都写死了的。写在了数据库里面了
layout: post
guid: http://www.tanglei.name/?p=14
duoshuo_thread_id:
  - 1351844048792453208
categories:
  - 经验技巧
tags:
  - Wordpress
  - 我做站长
---
将以前的[www.i3zhai.com](http://www.i3zhai.com)换成了二级域名了blog.i3zhai.com

期间出了点问题。是因为在没换之前。在Wordpress后台没有该url。后Wordpress前台的链接除了首页访问。。且首页的CSS等都没有出来。只出现了文字。登陆的后天提交的action还是www开头的。所以想象前台的链接是通过DB生成的。而到后天数据库中查看。wp\_users表中user\_url中的url也改成了blog.i3zhai.com了。但前台生成的submit的action还是www的。所以想想肯定后台数据库中还有的地方保存了url信息了。最后发现wp_options表中的siteurl中还是[www.i3zhai.com](http://www.i3zhai.com)。将其改为blog.i3zhai.com成功。

不过 后来当这篇文章发布出去后 才发现这个也访问不了。

原来发布的每篇文章的url都写死了的。写在了数据库里面了

wp_post里面全死了滴

如图<a rel="attachment wp-att-18" href="/blog/Wordpress_blog_urlexception.htmltemp/"><img class="alignleft size-medium wp-image-18" title="temp" src="/wp-content/uploads/2010/12/temp.png" alt=""  /></a>

再写个update语句replace就可以了。
