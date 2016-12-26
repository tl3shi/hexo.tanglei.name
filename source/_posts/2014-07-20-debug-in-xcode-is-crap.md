---
id: 2504
title: 吐槽下xcode debug功能
date: 2014-07-20T11:15:45+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2504
duoshuo_thread_id:
  - 1351844048792453509
categories:
  - c++
  - 经验技巧
tags:
  - mac
---
不得不吐槽下Xcode的debug功能实在是弱爆了～ 网上也不止我一个人吐槽～废话不多说，看图

<div>
  <a href="/wp-content/uploads/2014/07/xcode-debug.jpg"><img class="size-full wp-image-2505 aligncenter" title="xcode-debug" src="/wp-content/uploads/2014/07/xcode-debug.jpg" alt=""  /></a>
</div>

看上图的一段调试代码～我不吐槽xcode从用户交互等易用性，TA的可用性都简直。。。

函数传参，传递一个string, 传的值就无法查看值内容(网上一大堆“**无法查看xcode debug变量值**”类似的问题)，用类似gdb命令查看同样无法获得([这里有一个gdb和xcode里的lldb命令对照表](http://lldb.llvm.org/lldb-gdb.html))，参数变量用p/po/fr v (frame variable) 等命令也不行～

再看看局部变量，两层的vector, bool的话，第二层就没有了(上图size为0)，而string第二次就有。这也太～～

示例用的xcode版本是Version 6.0 (6A215l)，虽然是beta版，但也不至于。更何况之前用xcode5偶尔也有类似的问题，你说这样如何能debug?   准备换eclipse环境试试～

不知道你用xcode有没有遇到类似的问题～还望指教啊。
