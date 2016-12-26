---
id: 1316
title: windows下运行linux命令工具
date: 2011-12-21T20:23:27+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1316
duoshuo_thread_id:
  - 1351844048792453262
categories:
  - 'Linux'
  - Windows
  - 经验技巧
tags:
  - Linux
  - 经验技巧
---
之前在[外刊评论](http://www.aqee.net/)上看到滴这个工具的介绍，感觉还不错。转过来了。有时候用用linux的命令感觉挺方便的。例如在整个目录下搜索某个关键字啊之类的。

<p align="left">
  　<a href="https://github.com/bmatzelle/gow/">Gow</a>是一个轻量级的<a href="http://zh.wikipedia.org/wiki/Cygwin">Cygwin</a>替代软件，它能做的事情是给Liunx软件提供一个Windows系统上的运行环境。Gow是Gnu On Windows的缩写，它跟传统的具有相同功能的Cygwin软件比起来的特点是体积小，Cygwin动辄能达到上百兆，而它的体积不到10MB，但里面却集成了Liunx环境下<a href="https://github.com/bmatzelle/gow/wiki/executables_list" target="_blank">130多种</a>实用工具软件，其中包括：
</p>

  * **Shell** **环境：****bash, zsh**
  * 压缩工具： gzip, zip, bzip2, compress
  * SSH软件： putty, psftp, pscp, pageant, plink
  * 上传/下载软件：cURL, wget
  * FTP工具： NcFTP
  * **文本编辑器：** **vim**
  * **文字搜索****/****查看工具****:****：****grep, agrep, less, cat, tail, head**
  * **文件系统操作命令：** **mv, cp, du, ls, pwd, rmdir, whereis**
  * 开发工具：make, diff, diff3, sleep, cvs, dos2unix, unix2dos

<p align="left">
  　　这个软件跟Cygwin比起来还有个特点，安装了它后，当你点击文件夹右键时，会看到右键菜单里多了一个快捷键，点击这个快捷键，你就会在当前文件路径下打开一个命令行窗口，注意：是Windows的命令行窗口，不是Linux的shell窗口，当然这个功能用其他方式比如改注册表之类也可以实现（<a href="/blog/introduce-my-right-click-menu.html">这篇文章展示下我的右键菜单</a>，比较方便），不是用它的主要目的，在这个窗口里，你既可以使用DOS命令，也可以使用Liunx命令，比如：你既可以输入“dir”命令来查看目录结构，也可以输入“ls” 命令查看，效果是一样的。(遗憾的是，命令好像是不能正常的显示中文)。
</p>

<p align="left">
  <img class="alignnone" title="windows下运行linux命令" src="http://i1123.photobucket.com/albums/l549/tl3shi/gow.jpg" alt=""  />
</p>

<p align="left">
   这样一来，你就解决在Windows上一些以前不可能完成的任务，比如要查看500MB的日志文件，如果你用文本编辑器打开来看，那系统会崩溃。这时你在命令行里输入：tail -n 100 my.log 这样很轻松的就能查看这个巨大的日志的最后100行日志信息。
</p>

<p align="left">
  这个软件你可以在这里<a href="https://github.com/bmatzelle/gow" target="_blank">下载</a>。
</p>
