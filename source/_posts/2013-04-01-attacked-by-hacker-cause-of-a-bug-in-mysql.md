---
id: 2121
title: 电脑因mysql漏洞被人攻击
date: 2013-04-01T23:54:19+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2121
duoshuo_thread_id:
  - 1351844048792453194
categories:
  - 经验技巧
tags:
  - 网络安全
  - Windows
  - 清华大学
---
今天早上来实验室突然就上不网，换ip能上网，实验室网管告诉我之前的IP有问题，已经被校网络中心给被封调。其实昨晚就被封了，难怪昨晚在寝室连不上我实验室电脑的。

[<img title="clip_image002" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image002" src="/wp-content/uploads/2013/04/clip_image002_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image002.jpg)

查看Windows日志，看有没有异常情况，结果发现这个mysql貌似比较可疑。如下图示：

[<img title="clip_image004" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image004" src="/wp-content/uploads/2013/04/clip_image004_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image004.jpg)

查了下这个IP贵州省遵义市等莫名其妙的地方，还有其他的一些IP也是莫名其妙的其他地方。然后google了下mysql有啥漏洞

[<img title="clip_image006" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image006" src="/wp-content/uploads/2013/04/clip_image006_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image006.jpg)

猜测，是由于mysql的bug引起的。上图有一个bug描述如下：

Security vulnerability in MySQL/MariaDB 在知道用户名的情况下（如root），直接反复重试（平均大约256次）即可登入。

受影响的版本：

All MariaDB and MySQL versions up to 5.1.61, 5.2.11, 5.3.5, 5.5.22 are vulnerable.

MariaDB versions from 5.1.62, 5.2.12, 5.3.6, 5.5.23 are not.

MySQL versions from 5.1.63, 5.5.24, 5.6.6 are not.

详情请点击[这里](http://seclists.org/oss-sec/2012/q2/493)

之前本来都是关掉mysql远程登陆的，只允许本地登陆。看来还是有风险啊。果断关闭远程登陆了。还有再一次发现windows的不安全。得转移到linux下.

确认下是mysql的问题，从网上的一篇文章得以确定。文章说**由MySql漏洞导致电脑被入侵，特征为新增加名为piress的帐户，打开控制面板，果然有一个piress的帐号，果断先删除再说。**

然后查看下注册表有没有被自动启动的异常程序，发现一个。

[<img title="clip_image008" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image008" src="/wp-content/uploads/2013/04/clip_image008_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image008.jpg)

暂且用用QQ的杀毒功能全盘扫描下，发现一些风险，管不了那么多了删了再说。

[<img title="clip_image010" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image010" src="/wp-content/uploads/2013/04/clip_image010_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image010.jpg)

[<img title="clip_image012" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image012" src="/wp-content/uploads/2013/04/clip_image012_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image012.jpg)

后来网管告诉我这个IP出口流量过大，很大很异常，才被学校网络中心工作人员给封了。上面的日志看到貌似尝试从我的PC去扫描同网段的其他电脑。

然后查看了下我的上网记录，对比下平时的出流量和这两天的。

[<img title="clip_image014" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image014" src="/wp-content/uploads/2013/04/clip_image014_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image014.jpg)

[<img title="clip_image016" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image016" src="/wp-content/uploads/2013/04/clip_image016_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image016.jpg)

[<img title="clip_image018" style="border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px; display: inline" border="0" alt="clip_image018" src="/wp-content/uploads/2013/04/clip_image018_thumb.jpg"  />](/wp-content/uploads/2013/04/clip_image018.jpg)

攻击者我机器作为跳板在扫描校内各个网段。发了大量数据包，校网络中心的工作人员前来查看问题。也无非就是说说中毒了，让勤杀病毒。

网上仔细看了下这个mysql漏洞以及如何被占领，还被建了一个管理帐户。原因是在windows上安装了mysql，如安装套件XAMPP，且mysql默认密码没有更改，且允许网络其他host连接此mysql server(因为诸如phpmyadmin等产品默认需要通过网络访问)。此问题引起的明显特征表现在除了piress帐户外，还有其他木马蠕虫等，例如上面扫描到的cna12.dll，开机自动运行的lib32waqv.exe等。

攻击者通过扫描到mysql弱口令等取得mysql的root后，可以运行mysql client的任何command，进而就可以读取mysql server所在电脑的文件，然后上传木马病毒等然后运行开始干坏事，比如建一个名叫piress的账号且给了admin的权限啊等。再比如利用此电脑再去扫描其他同网段IP的电脑啊等。

首先攻击者能access the mysql server, 然后因为若口令被暴力破解了，再因为拥有了对mysql server的plugin文件夹和bin文件夹具有write权限进而被写进了病毒，就这样中招了……这篇文章还详细分析了[cna12.dll文件解析](http://malwaremusings.com/2012/11/30/increase-in-mysql-attacks-analysing-the-binary-files/)的过程，有兴趣可以了解下，有时间还可以研究研究能够把这个攻击者的一些信息找出来。可惜之前的mysql log等没开。这个攻击者应该很菜很菜，拿一些扫描工具瞎玩玩罢，因为攻击下来，留了这么多痕迹，高手应该不留痕迹的，且不会把动作搞得这么明显(比如扫描的时候别太快啊)，连校网络中心都发现不正常了。

以防后患，除了删除piress帐号，禁止/删除开机自启的可疑程序外，我还将mysql切换到了换到linux下并只允许本机能连mysql，并删除默认的一些帐户给了较强的密码，且linux、windows系统的远程连接也仅仅只允许指定IP可连。

参考资料：

[1]由MySql漏洞导致电脑被入侵(特征为新增加名为piress的帐户)所想到的<http://blog.csdn.net/whuslei/article/details/7893754>

[2] MySQL 严重 Bug &#8211; 用户登陆漏洞 <http://www.oschina.net/news/29899/mysql-root-bug>

[3] What is cna12.dll and the piress user? <http://malwaremusings.com/2013/01/31/what-is-cna12-dll-and-the-piress-user/>
