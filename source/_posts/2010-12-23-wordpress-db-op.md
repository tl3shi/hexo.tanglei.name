---
id: 154
title: Wordpress数据库优化
date: 2010-12-23T03:48:20+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=154
duoshuo_thread_id:
  - 1351844048792453251
categories:
  - 经验技巧
tags:
  - Wordpress
  - 我做站长
---
今天是准备来给<a title="我的博客" href="http://www.tanglei.name" target="_self">blog.i3zhai.com</a>上的数据库备份的。就用navicat连接了数据库服务器，看了下里面的数据。发现了好多冗余数据。特别是posts张表，数据冗余很大，因为向在后台写文章的时候，有自动保存啊，什么修订版啊之类的。好像之前还听说有什么优化数据库的插件。我想，作为一个搞开发的人来说，这点东西还要去搞啥插件就太……。。所以就手动优化了下。

看看里面的冗余数据，太吓人了。

[<img class="alignleft size-full wp-image-155" title="Wordpress-bak" src="/wp-content/uploads/2010/12/Wordpress-bak.png" alt=""  />](/wp-content/uploads/2010/12/Wordpress-bak.png)

 一篇文章，里面有N多冗余数据，我觉得这点Wordpress开可以优化下，比如最开始是把一些数据自动保存在数据库里面，当有更新版本的自动保存的数据时，应该去执行一条delete数据，把以前的数据删掉。

观察这些冗余数据发现了，有一个共同的特点就是，字段post_type的值是&#8217;revision&#8217;，于是只需要执行一条sql语句DELETE FROM **posts** WHERE post_type = &#8216;revision&#8217;;//注意posts是表面，可能你的数据库的表面跟我 不一样。在安装的时候要求输入前缀，默认是wp,也就是说默认的from后面应该跟**wp_posts** 。执行后，就能看到效果了，总数据量record少了很多，再自习看，还有冗余，就是有的title是名字是“自动草稿”。这些数据也是冗余的，再执行一下delete from wp\_posts[你自己的表名] where post\_title=&#8217;自动草稿&#8217;。就又会删掉部分冗余数据。

主要的冗余也就是那张表上的咯。后来网上看了下，还有其他表。postmeta也有冗余。同样的2条delete语句解决问题：
  
[SQL] DELETE FROM  postmeta WHERE meta\_key = &#8216;\_edit_lock&#8217;;
  
影响的数据栏: 26
  
时间: 0.265ms
  
[SQL]
  
DELETE FROM postmeta WHERE meta\_key = &#8216;\_edit_last&#8217;;
  
影响的数据栏: 26
  
时间: 0.265ms

 呃， 要是有时间的话，看下php的语法，自己优化下Wordpress。按照提到过的思路，就不会产生冗余啦。

o(∩_∩)o 哈哈
