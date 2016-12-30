---
id: 972
title: SmsManager.sendTextMessage()总是报空指针NullPointerException
date: 2011-07-12T13:45:54+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=972
duoshuo_thread_id:
  - 1351844048792453192
categories:
  - 除臭虫
tags:
  - Android
  - coding小工具
  - Java
---
昨晚继续写我的短信群发小工具，但遇到manager.sendTextMessage(info.getTelephone(), null, info.getSmsContent(), sentPi, null);总是报空指针。

android.telephony.SmsManager.sendTextMessage(SmsManager.java:87)

Caused by: java.lang.NullPointerException

但是呢。事实上.info不为空, info.getTelephone(),info.getSmsContent()都不为空.sentPi也不为空.按理说，发送消息的方法中第一个参数和第3个参数不是空就OK啊。就算如此。但我都logcat打印出来hashcode了.前面manager也不为空.后来才网上查了下说发现原来这个是android的一个bug,当发送短信的内容过长时,就会报空指针异常.果然我把长度减少，再运行，就没空指针了。

难怪要先用manager 的divideMessage方法divide一下.不过我之前测试,不用这个方法,在没报空指针时,消息的内容长了也会被自动拆成几个消息.因为注册的BroadcastReceiver都多次Receive到intent了.

避免不必要的麻烦,还是自己手动的divide下吧.

&nbsp;
