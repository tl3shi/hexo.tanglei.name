---
id: 980
title: 共享上网-无法启动Internet连接共享.一个已经用IP地址配置的LAN连接需要自动IP地址
date: 2011-07-13T23:22:09+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=980
duoshuo_thread_id:
  - 1351844048792453160
categories:
  - Windows
tags:
  - 共享上网
---
来到了腾讯安排的富邦国际酒店，房间里只有一根网线，不过俩笔记本共享上网应该比较容易实现的。我开始用XP，按照以前的方法设置两台笔记本共享上网，但每次我点击共享时，就报错：无法启动Internet连接共享.一个已经用IP地址配置的LAN连接需要自动IP地址。刚开始以为我的笔记本好久没有关过机器了，然后就重启，但试试，还是报同样的错误。以为室友MACbook不兼容啊啥的，但不可能啊。没涉及到硬件啊啥的。自动获取IP也不行，手动填个IP还是不行。建的临时的计算机-计算机的wifi网络，他的MAC能连上我，但我这边显示的还是等待连接。结果网上搜索了下，有篇文章讲了这样的：

在Windows XP中设置Internet连接共享时出现“无法启动Internet连接共享.一个已经用IP地址配置的LAN连接需要自动IP地址”问题的解决：

1、需要设置共享的网卡（以下简称网卡A）在设置共享时**不要使用**<span style="color: #ff0000;">192.168.0.1-254</span>这个网段。

2、另一块网卡（以下简称网卡B）设置为自动获取，系统默认自动获取的地址192.168.0.1-254这个网段。

3、如此即可解决在Windows XP中设置Internet连接共享时出现“无法启动Internet连接共享.一个已经用IP地址配置的LAN连接需要自动IP地址”的问题。

4、可以更改网卡B地址为你需要的地址。

5、可以更改网卡A的IP为<span style="color: #e06666;">192.168</span>.<span style="color: #ff0000;">1</span>.<span style="color: #ea9999;">1-254</span>这个网段的地址。

然后我IPConfig了一下，恰恰酒店提供的IP就是192.168.0.*这个网段的，悲剧了，这个不能改啊，改了，我的都不能上网了。试试WIN7嘛，重启进了WIN7系统。结果能成功共享了，但他的MAC 还是不能连上我新建的临时计算机-计算机的网络。什么手动IP,自动IP啊，设置密码啊，防火墙啊，杀毒软件啊等等都考虑过了。还是不成功。最后想到过宏杰之前介绍过一个软件connectify，下载安装，就可以了。我的defy也能连上。呵呵[<img class="aligncenter size-full wp-image-981" title="connectify-me" src="/wp-content/uploads/2011/07/connectify-me.jpg" alt="无法启动Internet连接共享"  />](/wp-content/uploads/2011/07/connectify-me.jpg)
