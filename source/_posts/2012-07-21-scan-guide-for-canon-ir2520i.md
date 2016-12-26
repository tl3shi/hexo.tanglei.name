---
id: 1874
title: 办公室打印机IR 2520i扫描功能教程
date: 2012-07-21T12:43:35+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1874
duoshuo_thread_id:
  - 1351844048792453408
categories:
  - 经验技巧
tags:
---
1、安装驱动，运行scangear tool 工具，设置IP，找到打印机/扫描仪。如果下图中没有找到，请检查下驱动程序是否安装正确。驱动程序在\\10.18.103.226\share\常用资源\Software\Drivers\大打印机驱动\……中，扫描仪驱动是ColorNetworkScanGear_* 类似。

<img class="aligncenter" src="/wp-content/uploads/2012/07/072112_0442_IR2520i1.png" alt="" data-pinit="registered" />

2、此外，还得安装一个兼容 TWAIN （TWAIN 是用于连接电脑与扫描仪和数码相机等图像输入设备的技术标准）的软件，我下了一个比较小型的[Scanitto.rar](/wp-content/uploads/2012/07/Scanitto.rar)在附件中。运行后如下图所示：（第一次运行左下角有提示注册激活的信息，ignore掉，点击continue，随附件有个注册码，不注册也OK，扫描时有个弹框而已）。

<img class="aligncenter" src="/wp-content/uploads/2012/07/072112_0442_IR2520i2.png" alt="" data-pinit="registered" />

&nbsp;

3、去打印机那里把要扫描的纸放到最上面那个输送器里，再到电脑端点击上面那个软件中的scan按钮，即可完成扫描。打印机要开启网络扫描功能设置在线。Scanitto比较轻，这个软件只能从输送器上，适合扫描的东西较少。

补充p.s.后来发现共享里有个ACDsee软件，\\10.18.103.226\share\常用资源\Software\Drivers\大打印机驱动\32位\扫描仪驱动\ acdsee11_zh-MyCrack.rar

<img class="aligncenter" src="/wp-content/uploads/2012/07/072112_0442_IR2520i3.png" alt="" data-pinit="registered" />

下一步下一步。

这个可以把原稿放在稿台上，设置纸张等等。

<img class="aligncenter" src="/wp-content/uploads/2012/07/072112_0442_IR2520i4.png" alt="" data-pinit="registered" />

另外，没搞懂那个打印机的发送功能，按理说应该扫描后可以直接输入邮件地址发送到指定邮箱的。期待有人补充哈。

<div>
  扫描然后发送到指定邮箱。貌似是这样的：<br /> 1、把要扫描的东西放到稿台。<br /> 2、点打印机上的发送按钮。<br /> 3、指定发送到的邮箱。（从地址簿添加）<br /> 3、完成后启动按钮会变绿，点击启动。<br /> 提示发送OK了。我看邮箱貌似没收到。<br /> 还不知道解决方法。
</div>
