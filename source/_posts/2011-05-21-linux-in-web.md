---
id: 683
title: 牛-Web下运行linux
date: 2011-05-21T15:54:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=683
duoshuo_thread_id:
  - 1351844048792453292
categories:
  - 开开眼界
tags:
  - Linux
---
转自：http://coolshell.cn/articles/4722.html 只能说，太牛了……膜拜！如果你是用的chrome11或者firefox，那你就可以直接在下面敲linux命令执行了。看看我执行的效果图。[![web-linux](/wp-content/uploads/2011/05/web-linux.png "web-linux")](/wp-content/uploads/2011/05/web-linux.png)

一个叫Fabrice Bellard的程序员写了一段Javascript在Web浏览器中启动Linux（<a onclick="pageTracker._trackPageview('/outgoing/bellard.org/jslinux/?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://bellard.org/jslinux/" target="_blank">原网页</a>，我把这个网页iframe在了下面），目前，你**只能使用Firefox 4和Chrome
  
11**运行这个Linux。这不是什么假的模仿Linux的东西，这是实实在在的运行一个Linux。这一举动还引起了很多很牛人的关注，包括Javascript的创建者<a onclick="pageTracker._trackPageview('/outgoing/twitter.com/_/BrendanEich/status/70393502328045568?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://twitter.com/#!/BrendanEich/status/70393502328045568" target="_blank">Brendan Eich</a>。

<P align=center></p> 

随后，Fabrice Bellard发布了相关的技术说明：<a onclick="pageTracker._trackPageview('/outgoing/bellard.org/jslinux/tech.html?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://bellard.org/jslinux/tech.html" target="_blank">http://bellard.org/jslinux/tech.html</a>，从这份文档中我们可以看到：

  * 这个模似器完全由Javascript写成
  * CPU仿真器使用的是<a onclick="pageTracker._trackPageview('/outgoing/qemu.org/?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://qemu.org/">QEMU</a>（接近于原古的486），为了装上Linux，其做了一些改动。
  * Javascript的终端本来可以使用<a onclick="pageTracker._trackPageview('/outgoing/www.masswerk.at/termlib/?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://www.masswerk.at/termlib/">termlib</a>，但他还是自己写了一个，因为OS的按键和Web浏览器不一样（<a onclick="pageTracker._trackPageview('/outgoing/unixpapa.com/js/key.html?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://unixpapa.com/js/key.html">here</a>）
  * Linux  使用了2.6.20内核，编译配置在<a onclick="pageTracker._trackPageview('/outgoing/bellard.org/jslinux/config_linux-2.6.20?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://bellard.org/jslinux/config_linux-2.6.20" target="_blank">这里</a>，并做了一些<a onclick="pageTracker._trackPageview('/outgoing/bellard.org/jslinux/patch_linux-2.6.20?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://bellard.org/jslinux/patch_linux-2.6.20" target="_blank">小改动</a>。
  * 磁盘用的是Ram Disk，在启动的时候装载。其文件系统由<a onclick="pageTracker._trackPageview('/outgoing/buildroot.uclibc.org/?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://buildroot.uclibc.org/">Buildroot</a> 和<a onclick="pageTracker._trackPageview('/outgoing/www.busybox.net/?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://www.busybox.net/">BusyBox</a>产生。
  * 在Home目录下有一个hello.c的程序，你可以使用<a onclick="pageTracker._trackPageview('/outgoing/bellard.org/tcc?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://bellard.org/tcc">TinyCC</a>编译（tcc，参看酷壳的<a title="用TCC可以干些什么？" href="http://coolshell.cn/articles/786.html" target="_blank">这篇文章</a>）

从这个事我有这些感触，

  1. 在Web上运行一个Linux的操作系统不是问题。那么在Web上还有什么不能做的吗？
  2. Linux真是性能很高，在Javascript下运行感觉也不慢啊。
  3. 真是Techno-Geek。
