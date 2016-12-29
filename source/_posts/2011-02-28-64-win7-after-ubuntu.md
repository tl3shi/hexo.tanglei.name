---
id: 331
title: 先Ubuntu，再64位 Win 7,恢复ubuntu启动项
date: 2011-02-28T16:17:29+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=331
duoshuo_thread_id:
  - 1351844048792453400
categories:
  - 经验技巧
tags:
  - Linux
  - Ubuntu
  - Windows
---
前面谈到，为了让自己的电脑4g充分利用。也试试用用WINDOWS7，好久没用过WINDOWS7了，记得上一次用还是WIndows7出测试版的时候，通过虚拟光驱装了一个玩玩呢，不稳定，后来就一直没用过。据说现在很稳定了，也装来玩玩。不过64位的系统还不是很大众化。

刚开始也想到了通过虚拟光驱加载window7镜像文件安装。结果加载虚拟光驱后，点击SETUP.EXE，出现了………………啥不是32位的有效应用程序……之类的。想了下，64位的系统，估计这样安装不行。刻盘吧，自己的笔记本的光驱好像就被之前刻盘搞得不怎么好用了。CD啊DVD啊啥的放进去能识别出来要看心情，拼人品。于是后来又网上查了下，用win pe安装。结果好像很复杂的样子。说什么WIN PE 安装64位也不是很容易。再后来想到了，之前安装ubuntu10.10的时候就是通过U盘安装的。我的WIN7旗舰版能不能也通过U盘安装呢。…………借助这个工具就可以实现了。UltraISO.

将win7的镜像文件7600.16385.090713-1255\_x64fre\_client\_zh-cn\_Retail\_Ultimate-GRMCULXFRER\_CN_DVD.iso。后面会将种子上传。。用UltralISO打开，如图：

[<img class="aligncenter size-full wp-image-332" title="ISO2Upan" src="/wp-content/uploads/2011/02/ISO2Upan.jpg" alt=""  />](/wp-content/uploads/2011/02/ISO2Upan.jpg)

找个大一点的U盘，在丹姐那要的U盘刚好是4G的，就用它了。很简单。就像刻盘一样，将数据写入U盘。就可以通过U盘启动了。再然后，就安装……安装过程就很简单了………………………………………

安装完毕后，windows 7能识别以前的WIndows XP，但Ubuntu的启动项就没了。。。。请教了我们班linux高手，阿财，说可以用grub修复。网上又是一大堆教程。想到了，以前用过EASYBCD来恢复引导项的，不知道能不能恢复ubuntu的。一查，果然网上有人恢复过。于是我也试试，实在不行再通过grub恢复引导。结果事实证明是可行的。

[<img class="aligncenter size-full wp-image-333" title="recovery-ubuntu-start" src="/wp-content/uploads/2011/02/recovery-ubuntu-start.jpg" alt=""  />](/wp-content/uploads/2011/02/recovery-ubuntu-start.jpg)

刚开始以为还要手动指定UBUNTU在哪个分区。结果居然可以自动识别。UBUNTU10.10 是grub2.add 之后，重庆，有了启动菜单，选中之后，闪过一段words，出现了以前熟悉的ubuntu启动画面。

[<img class="aligncenter size-large wp-image-335" title="2011-02-28_12-52-20_953" src="/wp-content/uploads/2011/02/2011-02-28_12-52-20_953.jpg" alt=""  />](/wp-content/uploads/2011/02/2011-02-28_12-52-20_953.jpg)

于是，本机现在三个系统都OK啦。。。

附上64位win7 种子：[win7](/wp-content/uploads/2011/02/win7.zip)
