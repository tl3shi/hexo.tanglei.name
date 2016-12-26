---
id: 1721
title: 揪出这个android手机下乱弹广告的坏蛋
date: 2012-04-19T18:50:37+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1721
duoshuo_thread_id:
  - 1351844048792453156
categories:
  - Android
  - 玩玩手机
tags:
  - Android
---
前几天，我的android手机升级了几个软件，这两天手机突然莫名其妙的弹广告，并且根本不知道是哪个应用程序弹出来的。一般地弹广告也是运行某个app，就算是后台弹出，也有地方标志着是这个app弹的广告。而这次这个app也太狠了，自己想赚钱也就算了，还不让用户知道是谁。就想到一定得把它揪出来。 (之前以为是appchina应用汇，就卸载了，结果还弹……然后就是怀疑之前更新的豌豆荚，水果忍者……，不能老用排除法试了) 我能想到的解决方案就是看android运行的系统log日志了。

一种方法是连接电脑，用adb调试工具查看log，另一种方法是直接在android手机看log日志记录：[alogcat](http://code.google.com/p/alogcat/)，还是上次在腾讯实习时反映一个[QQ手机管家的bug](/blog/qq-mobile-secure-manager-feedback.html)，知道这个软件的。

等手机再弹出广告时，打开alogcat，为了方便查找，清除下刚刚产生的log，然后去通知栏那里点点那个广告，再返回alogcat先暂停记录log，然后慢慢看。TMD，是一个叫com.halfbriakin.utils..之类的activity再放广告，然后关键字\*fruitninjaseasons\*，居然是水果忍者。

再想水果忍者的开发者应该不会无耻到这个地步吧？用这样的方式弹广告。就想弄个究竟。查了下，我这个水果忍者是从豌豆荚下的，说的开发商是**halfbriakin**，而切水果这样的火，他应该不敢这么做吧，查了下，切水果的官网是**halfbrick.com**。得看看halfbrick跟**halfbriakin**的关系。是否**halfbriakin**山寨了了**halfbrick****，**在其之上包装了一层**。**看样子好像是的,**纯属个人猜测**。

继续探个究竟。看源代码，希望试图从中找出其与广告相关的代码跟**halfbriakin**的关系。从官网下载的com.halfbrick.fruitninjafree进行对比。

android的apk文件反编译用到的工具：

  * android代码反编译工具：<a href="http://code.google.com/p/dex2jar/" target="_blank">dex2jar</a>;
  * java源代码查看工具：[jd-gui](http://java.decompiler.free.fr/jd-gui/downloads/jd-gui-0.3.3.windows.zip);
  * android资源文件查看工具，(那些xml文件，打包成apk时被编码过一次，直接看有乱码看不清楚) <a href="http://code.google.com/p/android-apktool/" target="_blank">apktool</a>或者<a href="http://ishare.iask.sina.com.cn/f/19218022.html" target="_blank">AXMLPrinter2</a>.

下面看看过程：

  1. 反编译得到源代码，直接将apk文件后缀改成rar,用winrar解压即可得到classes.dex，然后通过dex2jar工具就能得到java的源代码。[<img title="apk反编译dex2jar" src="/wp-content/uploads/2012/04/dex2jar_thumb.jpg" alt="apk反编译dex2jar"  />](/wp-content/uploads/2012/04/dex2jar.jpg)
  2. 然后用jd-gui查看编译后的源代码。看样子好像确实是山寨的，不过可能因为二者版本不一致导致的？我想可能不大。下图左边为网上能下载到的开发商是**halfbriakin**发布的软件，在什么豌豆荚啊应用汇啊等等能下到，其介绍敢说哦什么Android官方无广告版本正式发布，只能说在放P了。下图右是我到google play下的，官网的免费版本。能看出来开发商是**halfbriakin**这个版本多了个上面那个包。[<img title="fruitninjafree广告" src="/wp-content/uploads/2012/04/fruitninjafree_thumb.jpg" alt="fruitninjafree广告"  data-pinit="registered" />](/wp-content/uploads/2012/04/fruitninjafree.jpg)
  3. 怀疑类似一些请求广告的url写在资源xml文件中，因此得解码资源文件。android的xml资源文件解码有两种方法

  * 用<a href="http://ishare.iask.sina.com.cn/f/19218022.html" target="_blank">AXMLPrinter2</a>.如下图命令后,打开t.xml文件可以看到AdnroidManifest的内容。<img title="android反编译资源xml文件" src="/wp-content/uploads/2012/04/androidxml_thumb.jpg" alt="android反编译资源xml文件"  />
  * 用apktool,如图。直接打开各个目录下的xml文件即可看到

[<img title="android资源文件反编译apktool" src="/wp-content/uploads/2012/04/androidapktool_thumb.jpg" alt="android资源文件反编译apktool"  data-pinit="registered" />](/wp-content/uploads/2012/04/androidapktool.jpg)

结果找了下，好像什么请求广告的url之类没写在string.xml等文件里面。还是看源代码吧。

查了下，’山寨’版本(暂且这么叫吧)的切水果，除了官方版本的广告外(google ads,意大利的游戏广告企业<a href="http://www.beintoo.com" target="_blank">beintoo</a>，移动广告服务商<a href="www.admob.com/A" target="_blank">admob</a>和<a href="www.mobclix.com" target="_blank">moblix</a>)，还有多余的那个包<a href="www.domob.cn/" target="_blank">domob</a>(国内的手机广告服务商多盟)，找了下没有找到相关的绑定的ID(也不深究了)。感到奇怪的是，水果忍者发布出来的源码里面出现了好多这种废弃的代码，不知道是程序员懒还是怎么着。自我感觉发布的时候还是把废弃代码给删掉吧，能减轻体重呢。<span style="color: #ff0000;">【更新：感谢网友的指出，之前根本没想到这些代码有可能是反编译失败/出错产生的，让大家见笑了】</span>

[<img title="切水果程序员废弃代码" src="/wp-content/uploads/2012/04/thumb.jpg" alt="切水果程序员废弃代码"  data-pinit="registered" />](/wp-content/uploads/2012/04/4acb83313de3.jpg)另外看“山寨”的源码也有这种废弃的代码：

[<img title="水果忍着恶心代码恶心广告" src="/wp-content/uploads/2012/04/image_thumb1.png" alt="水果忍着恶心代码恶心广告"  data-pinit="registered" />](/wp-content/uploads/2012/04/image1.png)现在就不知道是到底是出自原来的程序员之手呢还是说山寨的过程中，copy了这些代码。

不管怎么说，如果这个开发商**halfbriakin**是来自官网也好，不是也罢，你这个广告也弹得太恶心了。  看了这么久也没什么确切的结论，反正我是卸载了这个app。
