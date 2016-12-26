---
id: 2293
title: Android 4.2 自动定时切换飞行模式
date: 2014-01-23T00:05:31+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2293
duoshuo_thread_id:
  - 1351844048792453497
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
  - coding小工具
tags:
  - Android
  - 没有权限
  - 飞行模式
---
<span style="color: #ff0000;">2015-01-18 (AutoSwitcher1.0)之后的<a href="/blog/android-airplanemode-auto-switcher-v2.html">更新说明文档<span style="color: #ff0000;">在这里</span></a>。<a href="/blog/android-airplanemode-auto-switcher-v2.html"><span style="color: #000000;">/blog/android-airplanemode-auto-switcher-v2.html</span></a><span style="color: #333300;">//2015-01-18 update</span></span>

**UPDATE:** 代码托管在[GitHub](https://github.com/tl3shi/AirPlanModeSwitcher)上了, 欢迎有兴趣的童鞋加入一起完善。
  
之前写过一个[Android手机根据时间设定自动切换飞行模式的代码](/blog/android-switch-airplanemode-3.html)，这次换了个屌丝红米手机之后安装后发现用不了。于是决定重新写一个。

整个功能要实现的话思路很清晰，只要改变一下系统配置(System.AIRPLANE\_MODE\_ON)，发送一个通知即可。但发现Android的权限设置没有以前那么开放了。从**Android 4.2**开始([SDK API 17](http://developer.android.com/about/versions/android-4.2.html))，设备的这些属性是只读的，官网上说：

> Some device settings defined by Settings.System are now read-only. If your app attempts to write changes to settings defined in Settings.System that have moved to Settings.Global, the write operation will silently fail when running on Android 4.2 and higher.

所以对于Android4.2及其以上版本的手机来说就悲剧了～

刚开始在代码里面试图去修改System.AIRPLANE\_MODE\_ON 的属性，UI上貌似没有什么反映，log看到说缺少**android.permission.WRITE\_SECURE\_SETTINGS** 权限，在manifest里面声明，eclipse 又编译不过提示 **Permission is only System Apps**，说是必须得是系统应用才行。网上也有讨论各种解决方案，有说要写成系统应用，需要一个跟固件一起打包编译或者跟固件有相同的签名才行。同样也有人说通过反射可以实现。第一种方式应该很麻烦，得下某源码包编啊之类的，第二种方案有人说可以尝试下，但具体我也没试～不知道是否靠谱。

后来的后来，还是从网上找到了解决方案，不过device必须得root，不然**没办法**搞定。原文来自<a href="http://zipta.ru/2012/11/borba-s-android-4-2/" target="_blank">这里</a>，虽然不知道是哪国语言～但代码还是认识。

```
//开启飞行模式
settings put global airplane_mode_on 1
am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true
//关闭飞行模式
settings put global airplane_mode_on 0
am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false
```

通过adb shell，输入以上两句命令，可以将切换飞行模式。核心问题解决了～剩下的就是需要通过Java代码去调用shell命令，这个不难～不过得注意需要通过root去调用，另外得防止程序卡死～

再后来在<a href="http://stackoverflow.com/questions/15861046/how-to-toggle-airplane-mode-on-android-4-2-using-root" target="_blank">stackoverflow</a>上也有人提到了这个解决方案，并且还给了另外一个解决方案，即通过sqlite去**直接**改变Android的系统配置。数据库位置在/data/data/com.android.providers.settings/databases/settings.db

```
sqlite3 /data/data/com.android.providers.settings/databases/settings.db
insert into global values(null, 'airplane_mode_on', 1); //相应的插入0值，即是取消飞行模式
```

当然上面的数据库修改之后要生效，还是必须得发上面的那个broadcast才能生效。

下面是我写的小程序的界面：

[<img class="size-large wp-image-2294" title="Android 自动定时切换飞行模式-android-airplanemode-auto-switcher" src="/wp-content/uploads/2014/01/android-airplanemode-auto-switcher.png" alt="android自动切换飞行模式"  />](/wp-content/uploads/2014/01/android-airplanemode-auto-switcher.png)

使用方法如下：

  1. 分别设定好需要开启、关闭飞行模式的时间，默认情况下为凌晨12点30分开启飞行模式，早上7点关闭飞行模式。然后打开当前状态的按钮即可，打开后会提示下次切换飞行模式的时间。
  2. 设定的时间到之后，App会自动尝试去启用飞行模式状态，如上图第二副图所示，当然得允许了(最好添加到信任程序列表，不然每次弹框)。另外，设定的时间到之后，有可能你还正在使用手机而不想马上切换飞行模式，App会给你5s的时间考虑，5秒之后你没有操作，app就会自动启用飞行模式了。当然你取消之后，这次就不会切换了，不过当你通过按手机返回键(Home键不会)或者杀掉这个进程再重新启动这个App的时候，会根据时间设定满足规则则自动切换。
  3. 切换&#8221;关闭&#8221;状态即取消设定功能，若当前手机正处于飞行模式状态，也会切换为正常状态。

注意：针对Android4.2及其以上的版本，手机需要ROOT才OK，且建议添加到信任程序列表。4.2之前的版本是木有问题的。

欢迎有兴趣的同学<del datetime="2014-01-27T08:22:26+00:00">下载1</del> [下载2](/wp-content/uploads/2014/01/airplanemode_auto_switcher.apk_v0.2.zip)试用，有建议/意见欢迎留言反馈～

TODO：

  1. Android 各个版本UI风格的统一
  2. 增加多个时间段的设置，支持晚上睡觉和中午睡觉都转飞行模式，既省电又防打扰
  3. 自己写着瞎玩，应该有不少Bug
