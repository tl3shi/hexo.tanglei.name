---
id: 2263
title: 迁移QT 程序可能会出现的问题
date: 2013-12-24T22:10:12+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2263
duoshuo_thread_id:
  - 1351844048792453495
categories:
  - c++
  - Windows
  - 敲敲代码
tags:
  - c++
  - Windows
---
Untitled Blog Post NameUntitled Blog Post NameUntitled Blog Post Name

QT程序在发布或者迁移的过程中可能会出现以下的问题：

1. Visual studio里面正常运行，copy到其他目录出现问题。

拷贝如下dll文件  Qt5Core.dll   Qt5Gui.dll   Qt5Widgets.dll  Qt5OpenGL.dll  Qt5PrintSupport.dll

以上dll缺失还好解决，毕竟双击exe文件运行，报错会弹框提示**缺少xxx.dll**找不到。

2. 运行exe失败，提示This application failed to start because **it could not find or load the Qt platform plugin &#8220;windows&#8221;** Reinstalling the application may fix this problem.

生成的exe文件所在目录下新建一个文件夹 platforms , 将 **qwindows.dll** (在类似于这样的目录下D:\Qt\Qt5.2.0\5.2.0\Src\qtbase\plugins\platforms) 以上是自己编译的qt。若用直接下载编译好的qt，可能还会报其他的错。此时可以考虑拷贝libGLESv2.dll  icudt51.dll  icuin51.dll  icuuc51.dll  libEGL.dll文件。

3 . 本机运行正常，拷贝到其他电脑图片显示不了。

这个问题比较坑，因为运行不报错，程序逻辑功能等正常。但是就是QT里面涉及的所有**背景图片没有显示**，什么信息都加载不到（此时往往是copy到其他电脑会出现的症状）.解决方案是，在exe文件所在目录新建文件夹**imageformats**, 然后去QT的安装/编译好的plugins下imageformats文件夹下(类似D:\Qt\Qt5.2.0\5.2.0\Src\qtbase\plugins\imageformats这样的目录)拷贝相应的图片编码的dll和lib。例如在程序中用到的图片是jpg格式的，就copy qjpeg.dll 和qjpeg.lib，类似的还有其他gif之类的,若嫌麻烦直接将整个目录copy过来即可（只是臃肿了点而已）。

**UPDATE：**若按照第3步走了，仍然显示不了图片，请考虑你的exe路径是不是包含了中文。

Reference :

[1]http://stackoverflow.com/questions/16198649/how-to-run-qt-5-applications-on-other-computers-windows-7

[2] http://falsinsoft.blogspot.com/2013/09/qt-5-and-failed-to-load-platform-plugin.html (墙)

[3] http://bbs.qter.org/forum.php?mod=viewthread&tid=705
