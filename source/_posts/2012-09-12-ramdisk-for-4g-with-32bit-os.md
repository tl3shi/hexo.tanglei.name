---
id: 1945
title: 32位系统有效利用4g内存-虚拟硬盘
date: 2012-09-12T21:11:24+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1945
duoshuo_thread_id:
  - 1351844048792453331
categories:
  - 经验技巧
tags:
  - 经验技巧
  - Windows
  - 工具
---
> 今天清理了下电脑，把以前安装的oracle9i，weblogic等卸载了，因为得安装VS，突然发现自己电脑4g内存，现在32的系统没有效利用起来，以前就用过ramdisk将内存虚拟成硬盘一方面有效利用内存，另一方面做某些事情时可以快点儿。

然后发现以前用的ramdisk4g、SuperSpeedRamDiskPlus等软件不可用，好不容易找到破解版，结果新建虚拟硬盘时，没有讲系统未识别的内存利用起来。如图，本来系统可用数2.5G多，新建一个1G的虚拟硬盘后，可用数随之减少了1G，因此这个软件貌似没解决问题，网上有的人说可以，总之我这台电脑不可以。(ATTENTION，得首先开启使用“未经管理”的内存这个功能，默认是没有开启的).

[<img title="image" src="/wp-content/uploads/2012/09/image_thumb.png" alt="image"  />](/wp-content/uploads/2012/09/image.png) 几经折腾，终于找到一个适合我这个电脑的软件了，那就是<a href="http://www.cncrk.com/downinfo/33892.html" target="_blank">PrimoRamdiskUltimateEdition</a>，如下图所示,首先也得开启识别系统未识别内存的功能(点击图中标注2处),创建1g虚拟硬盘后，如图注3，可用数没有明显减少1g(有减少是因为我开了QQ、浏览器等应用)，说明确实是系统未识别的那些内存发挥作用了。

[<img title="虚拟硬盘" src="/wp-content/uploads/2012/09/image_thumb1.png" alt="虚拟硬盘"  />](/wp-content/uploads/2012/09/image1.png)

接下来就修改以下环境变量，例如IE的临时文件(因为在内存中关机后自动消失)，系统临时文件目录改为C:\temp(如解压缩文件的时候)，不过注意安装有些大软件或者解压某些大文件时还得修改回来，不然会安装/解压失败。

以上记下来备份下。
