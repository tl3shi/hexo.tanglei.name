---
id: 1499
title: android手机获取系统短信sqlite数据库并查看内容
date: 2012-03-05T14:02:34+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1499
duoshuo_thread_id:
  - 1351844048792453295
categories:
  - 玩玩手机
  - 经验技巧
tags:
  - Android
  - sqlite
---
一个朋友过来，准备玩玩Ta的android手机，给我之前还要拿回去看看，结果是ta把短信加密了(第三方短信)，怕我知道ta的啥见不得人的秘密。o(∩_∩)o 哈哈。TA威胁我说加密了，看我怎么看。结果我说要是我能看呢。ta威胁我说不行，我就非得试试。直接的思路是，他的手机已经root过，我应该能直接拿到sqlite数据库。（其他方法比如下对应软件的破解解密爆破等没试过）。

准备的工具是adb调试工具、sqlite工具。（之前搞过android开发，所以OK）

手机连接电脑后，对应驱动安装好之后，直接进shell，adb shell。然后cd进系统短信数据库的目录。结果总提示没有permission. 然后觉得是否是这样没有root权限,再看看adb 帮助提示,说命令adb root是可以以root身份进入的.结果又提示说这个调试工具不能用于真实的手机产品.adbd cannot run as root in production builds .最后尝试什么sudo su啊之类的也不行.(当时一直关注于电脑上的commond端，没注意手机)，其实只要执行命令su 之后，手机有提示，点击一下允许root权限即可。命令行得到root之后就方便了。

首先查看存放短信的sqlite数据库是不是在下面这个目录

/data/data/com.android.providers.telephony/databases/mmssms.db

[<img title="clip_image002" src="/wp-content/uploads/2012/03/clip_image002_thumb.jpg" alt="clip_image002"  hspace="12" />](/wp-content/uploads/2012/03/clip_image002.jpg)

OK，在滴。然后就是想的直接用命令cp或者copy命令复制到sdcard上，取回到电脑里。结果悲催的是居然木有cp命令。然后网上查询得到下面这个方法。可以用[dd命令](http://baike.baidu.com/view/3568252.htm)(链接百科详解)。(说是cat命令重定向输出也可以).

现在已经将系统目录下的数据库copy到sdcard了。

[<img title="clip_image004" src="/wp-content/uploads/2012/03/clip_image004_thumb.jpg" alt="clip_image004"  hspace="12" data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image004.jpg)

然后退出adb调试器。(我不知道怎么在adb调试器里面直接将文件导出到数据库)用adb pull命令导出(之前只用过这种adb push 和adb pull 等)。

[<img title="clip_image006" src="/wp-content/uploads/2012/03/clip_image006_thumb.jpg" alt="clip_image006"  />](/wp-content/uploads/2012/03/clip_image006.jpg)

OK，已经将数据库拿到电脑上了。

打开sqlite命令，查看数据库。

[<img title="clip_image008" src="/wp-content/uploads/2012/03/clip_image008_thumb.jpg" alt="clip_image008"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image008.jpg)

看该数据库下的表。很明显sms是保存短信的，直接select就能知道短信内容。(涉及到电话号码，就给划掉了)

[<img title="clip_image010" src="/wp-content/uploads/2012/03/clip_image010_thumb.jpg" alt="clip_image010"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image010.jpg)

乱码，不着急。将查询结果导出到文件。

.output是改变输出。返回标准输出。.output stdout

[<img title="clip_image012" src="/wp-content/uploads/2012/03/clip_image012_thumb.jpg" alt="clip_image012"  />](/wp-content/uploads/2012/03/clip_image012.jpg)

再select一遍。已经在当前目录下生生成查询结果的文件。

[<img title="clip_image014" src="/wp-content/uploads/2012/03/clip_image014_thumb.jpg" alt="clip_image014"  hspace="12" />](/wp-content/uploads/2012/03/clip_image014.jpg)

直接打开，即可。

[<img title="clip_image015" src="/wp-content/uploads/2012/03/clip_image015_thumb.jpg" alt="clip_image015"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image015.jpg)

参考资料：

1. 已经root，命令行获取不到root权限问题参考（adb root错误信息adbd cannot run as root in production builds问题解决）：<http://blog.csdn.net/littletigerat/article/details/6549021>

2. 命令行没有cp copy命令 参考：<http://blog.allenm.me/2010/04/android-shell-%E6%B2%A1%E6%9C%89-cp-%E5%91%BD%E4%BB%A4%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95/>

3. android系统短信数据库位置参考：(sms表字段信息)：<http://blog.csdn.net/reachkate/article/details/6784082>

4. sqlite命令参考：<http://wenku.baidu.com/view/17f8c720192e45361066f5e7.html>
