---
id: 970
title: 'android错误Error generating final archive: Debug certificate expired on xx-x-x 上午11:42!'
date: 2011-07-11T12:15:16+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=970
duoshuo_thread_id:
  - 1351844048792453432
categories:
  - 除臭虫
tags:
  - Bug
  - Android
---
今天网上down了一个android源码，导入eclipse，build总是出错，提示：Error generating final archive: Debug certificate expired on 11-7-7 上午11:42!

网上查了下。原因如下：

android要求所有的程序必须有签名，否则就不会安装该程序。在我们开发过程中，adt使用debug keystore，在 preference->android->buid中设置。debug的keystore默认有效期为一年，如果你是从一年前开始的android程序，那么在一年后导入这个app的时候很可能出现debug keystore过期，导致你无法生成 apk文件。此时你只要删除debug keystore就行，系统又会为你生成有效期为一年的私钥。

解决方法：

进入C:\Documents and Settings\Administrator[或者你的用户名]\.android 删除[改名也行]路径下的debug.keystore及 ddms.cfg。

（不同环境下的目录可能略有不同，可在eclipse中查找此路径：Window->Preferences->Android->Build下 Default debug keystore）

然后再build一下即可。
