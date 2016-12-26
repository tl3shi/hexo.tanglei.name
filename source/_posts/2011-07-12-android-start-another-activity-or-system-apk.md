---
id: 978
title: android启动系统应用activity-另一个APK
date: 2011-07-12T17:17:03+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=978
duoshuo_thread_id:
  - 1351844048792453320
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
  - coding小工具
tags:
  - Android
---
写短信群发小工具，当发送成功后，想跳动到系统自带的已发送或者发件箱，网上搜了下。开始关键字没输好，搜不到，结果用一个apk启动另一个apk就搜到了。

方法如下，

```java
Intent mIntent = new Intent( ); 
　　ComponentName comp = new ComponentName("包名", "类名");     
　　mIntent.setComponent(comp); 
　　mIntent.setAction("android.intent.action.VIEW"); 
　　startActivity(mIntent);
```

怎么找到要启动的activity呢，手机连接logcat，启动下那个想要通过代码启动的那个应用程序，就能看到了。例如本例，启动信息的那个apk时，logcat打印出

```java
07-13 09:22:15.104: INFO/ActivityManager(59): Starting activity: Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=com.android.mms/.ui.ConversationList }
07-13 09:22:17.675: INFO/ActivityManager(59): Displayed activity com.android.mms/.ui.ConversationList: 2478 ms (total 2478 ms)
```

然后带入上面的就是 

```java
ComponentName comp = new ComponentName("com.android.mms", "com.android.mms.ui.ConversationList");     
mIntent.setComponent(comp); 
mIntent.setAction("android.intent.action.VIEW"); 
startActivity(mIntent)
```

logcat输出的信息com.android.mms/.ui.ConversationList中，/前面的是包名，我试着把/后面的类名带入也不行，提示activityNotfound。最后/后面的类名也把包名加完整即可，及上面所示com.android.mms.ui.ConversationList。
