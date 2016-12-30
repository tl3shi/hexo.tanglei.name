---
id: 875
title: Android系统环境变量
date: 2011-06-20T20:51:57+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=875
duoshuo_thread_id:
  - 1351844048792453311
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Android
  - 玩玩手机
---
今天收拾桌面，看到这个文档，以前搞开发时用的。maybe大家用的着。下面环境变量是我的水货机子defy，买了之后的，android 2.1update1系统的环境变量。由如下代码产生

```java
Properties p = System.getProperties();
Iterator k = p.keySet().iterator();
while(k.hasNext()){
  	String ki = (String) k.next();
  	Log.e("tl3shi",ki+":\t"+p.getProperty(ki));
}
```
  
 下面是从logcat中输出的：
  
```java
01-21 12:31:09.872: ERROR/tl3shi(4479): java.vm.version:    1.1.0
01-21 12:31:09.901: ERROR/tl3shi(4479): java.vendor.url:    http://www.android.com/
01-21 12:31:09.912: ERROR/tl3shi(4479): java.vm.vendor.url:    http://www.android.com/
01-21 12:31:09.922: ERROR/tl3shi(4479): user.dir:    /
01-21 12:31:09.922: ERROR/tl3shi(4479): java.vm.name:    Dalvik
01-21 12:31:09.922: ERROR/tl3shi(4479): <strong>java.home:    /system</strong>
01-21 12:31:09.942: ERROR/tl3shi(4479): user.region:    CN
01-21 12:31:09.942: ERROR/tl3shi(4479): javax.net.ssl.trustStore:    /system/etc/security/cacerts.bks
01-21 12:31:09.942: ERROR/tl3shi(4479): java.runtime.name:    Android Runtime
01-21 12:31:09.942: ERROR/tl3shi(4479): user.home:    
01-21 12:31:09.942: <strong>ERROR/tl3shi(4479): java.io.tmpdir:    /sdcard</strong>
01-21 12:31:09.942: ERROR/tl3shi(4479): http.agent:    Dalvik/1.1.0 (Linux; U; Android 2.1; sdk Build/ERD79)
01-21 12:31:09.942: ERROR/tl3shi(4479): java.net.preferIPv6Addresses:    true
01-21 12:31:09.942: ERROR/tl3shi(4479): java.version:    0
01-21 12:31:09.942: ERROR/tl3shi(4479): java.boot.class.path:    /system/framework/core.jar:/system/framework/ext.jar:/system/framework/framework.jar:/system/framework/android.policy.jar:/system/framework/services.jar
01-21 12:31:09.953: ERROR/tl3shi(4479): java.library.path:    /system/lib
01-21 12:31:09.953: ERROR/tl3shi(4479): <strong>file.separator:    /</strong>
01-21 12:31:09.953: ERROR/tl3shi(4479): java.specification.vendor:    The Android Project
01-21 12:31:09.953: ERROR/tl3shi(4479):<strong> file.encoding:    UTF-8</strong>
01-21 12:31:09.953: ERROR/tl3shi(4479): line.separator:    
01-21 12:31:09.953: ERROR/tl3shi(4479): java.vm.specification.version:    0.9
01-21 12:31:09.953: ERROR/tl3shi(4479): java.vm.specification.vendor:    The Android Project
01-21 12:31:09.953: ERROR/tl3shi(4479): os.name:    Linux
01-21 12:31:09.962: ERROR/tl3shi(4479): java.vm.vendor:    The Android Project
01-21 12:31:09.962: ERROR/tl3shi(4479): path.separator:    :
01-21 12:31:09.962: ERROR/tl3shi(4479): android.vm.dexfile:    true
01-21 12:31:09.962: ERROR/tl3shi(4479): java.ext.dirs:    
01-21 12:31:09.972: ERROR/tl3shi(4479): java.class.path:    .
01-21 12:31:09.972: ERROR/tl3shi(4479): os.version:    2.6.29-00255-g7ca5167
01-21 12:31:09.972: ERROR/tl3shi(4479): java.specification.name:    Dalvik Core Library
01-21 12:31:09.972: ERROR/tl3shi(4479): java.compiler:    
01-21 12:31:09.972: ERROR/tl3shi(4479): user.language:    zh
01-21 12:31:09.972: ERROR/tl3shi(4479): user.name:    
01-21 12:31:09.972: ERROR/tl3shi(4479): os.arch:    armv5tejl
01-21 12:31:09.982: ERROR/tl3shi(4479): java.runtime.version:    0.9
01-21 12:31:09.992: ERROR/tl3shi(4479): java.class.version:    46.0
01-21 12:31:10.012: ERROR/tl3shi(4479): java.vendor:    The Android Project
01-21 12:31:10.012: ERROR/tl3shi(4479): java.vm.specification.name:    Dalvik Virtual Machine Specification
01-21 12:31:10.012: ERROR/tl3shi(4479): java.specification.version:    0.9
```
