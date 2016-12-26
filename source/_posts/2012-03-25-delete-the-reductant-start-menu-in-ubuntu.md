---
id: 1629
title: 删除ubuntu下多余的启动项
date: 2012-03-25T00:36:02+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1629
duoshuo_thread_id:
  - 1351844048792453294
categories:
  - 'Linux'
  - 经验技巧
tags:
  - Linux
  - Ubuntu
  - 启动菜单
---
上次<a href="/blog/my-ubuntu10-10.html" target="_blank">装了ubuntu</a>(3个系统,windows xp,64-位win7,ubuntu)后好久没用了。今天突然跟google一样抽风进去看看，才发现，原来我的ubuntu下有那么多启动项。（又查了下图中的[PAE](http://baike.baidu.com/view/493711.htm)//Physical Address Extension，效果是使32位系统用4g内存）

<img src="/wp-content/uploads/2011/02/2011-02-28_12-52-20_953.jpg" alt=""  data-pinit="registered" />

后来查了下,是因为使用Ubuntu一段时间后，如果进行了升级，系统里安装了很多内核，然后就有了这个长的启动列表，不仅占用了空间，也影响美观。于是得删除。

首先用如下命令列出已经安装的内核：

<div id="codeSnippetWrapper">
  <div id="codeSnippet" class="csharpcode">
    <pre class="alteven">dpkg --<span class="kwrd">get</span>-selections|grep linux</pre>
    
    <p>
      其中dpkg &#8211;get-selections 是取当前包状态，详细命令用法可以参考<a href="http://baike.baidu.com/view/1314054.htm" target="_blank">这里</a>。这命令就会列出一些类似linux-headers-2.xx-xx 和linux-image-2.xx之类的，其中前者应该是内核的头文件，后面者应该表示的是内核镜像文件。接下来就用下面的命令卸载。
    </p>
  </div>
</div>

<div id="codeSnippetWrapper" class="csharpcode-wrapper">
  <pre id="codeSnippet" class="csharpcode">apt-<span class="kwrd">get</span> remove linux-image-2.xx.xx</pre>
  
  <pre id="codeSnippet" class="csharpcode">apt-<span class="kwrd">get</span> remove linux-headers-2.xx.xx</pre>
</div>

在以root身份执行这两行命令前，最好先 uname –a 查看一下自己当前是用的哪个内核了来，免得remove错了。删除这些东东还是能腾空出好多的空间呢。

[<img title="ubuntu" src="/wp-content/uploads/2012/03/ubuntu_thumb.jpg" alt="ubuntu"  data-pinit="registered" />](/wp-content/uploads/2012/03/ubuntu.jpg)

这样就删除了旧的内核，释放空间了。并且启动项也减少了。我系统版本是ubuntu10.10，网上有的说还得修改启动菜单/boot/grub/menu.lst这个文件，不过我系统里的启动菜单文件好像不是这个吧，反正没找到，而在/boot/grub/grub.cfg这个文件里面。这个文件就是配置了那些启动菜单吧，用上面的命令卸载后，这个文件也就自动更新了。

另外还有一种方法就是用可视化的，用系统－系统管理－新立得软件包管理器 采取windows下的卸载文件的方式。
