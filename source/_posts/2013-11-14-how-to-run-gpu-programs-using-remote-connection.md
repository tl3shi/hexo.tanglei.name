---
id: 2230
title: 如何远程连接运行OpenGL/Cuda 等GPU程序
date: 2013-11-14T15:04:07+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2230
duoshuo_thread_id:
  - 1351844048792453492
categories:
  - 经验技巧
tags:
  - OpenGL
  - Windows
  - 敲敲代码
  - 计算机图形学
---
有时候往往需要通过远程桌面连接进行coding工作，像一般的比如web之类的可能不需要GPU等支持的coding工作直接用windows远程桌面连接编码然后debug即可，而一些需要依靠显卡支持的工作如渲染、cuda等GPU操作时，往往远程桌面连接debug会失败。因为当用远程桌面连接电脑B时，比如本来电脑B是具有牛X显卡，驱动啥之类都没有问题，但此时用另外一台电脑A远程连接过去，在B上跑需要GPU支持的程序，如需要用到Opengl3.X的功能或者cuda，而此时B检测到是远程连接过来的，就不会给予相应的支持或者说没有相应的驱动能够使得远程连接过来的也能支持。啊。。晕了。意思就是说可能此时只能驱动OpenGL1.X,程序就会crash掉。下面用个实例来说吧。

比如我在电脑B上有<a href="https://gist.github.com/tl3shi/7462450" target="_blank">一段代码时检测GPU 对CUDA的支持</a>。

此时我直接通过电脑A通过windows自带的远程桌面连接工具练过去，运行。

[<img class="alignnone" style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="/wp-content/uploads/2013/11/image_thumb.png" alt="image"  />](/wp-content/uploads/2013/11/image.png)

得到这样的结果，就是没有cuda相应的支持，而实际上，我直接通过本地执行时能够正常运行的。现在的问题是采取怎样的方式能够正常跑电脑B上的程序，就像自己本人在电脑B所在地本地操控电脑B一样。

开始设想通过QQ的远程控制能否解决？因为感觉QQ远程控制貌似就是传输图片，然后将在电脑A对电脑B传输过来的图片做相应鼠标等操作映射到电脑B上。于是有了如下的解决方案：电脑A、B各登陆1个QQ，QQ A 和QQ B,然后远程桌面连接过去，通过在电脑B上用B QQ申请 QQ A进行远程协助。然后断掉连接、QQ A上接受申请，然后就可以通过QQ的远程桌面控制电脑B了，然后再运行程序。结果……结果失败～ 意思就是这样还是解决不了问题。实验证明，不用远程连接，而直接让人在电脑B上操作，申请电脑A这边的远程协助，这样是可以的。但不能每次都得先让其他人在电脑B上帮忙申请下远程协助吧。

最后在<a href="mailto:http://www.renren.com/242915121/profile%3Fref=opensearch_normal" target="_blank">@大鑫</a>的帮助下得到解决。

方法：

1、电脑A用windows自带远程桌面连接到电脑B，在电脑B上登陆QQ B，电脑A这边已经登陆了QQ A。

2、在电脑B上通过QQ B申请远程协助QQ A。

[<img class="aligncenter" style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="/wp-content/uploads/2013/11/image_thumb1.png" alt="image"  />](/wp-content/uploads/2013/11/image1.png)

<p style="text-align: left;">
  3、电脑A上 QQ A接受邀请。
</p>

[<img class="aligncenter" style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="/wp-content/uploads/2013/11/image_thumb2.png" alt="image"  />](/wp-content/uploads/2013/11/image2.png)

此时已经建立好连接了。并也能通过QQ的远程协助控制电脑B了。

4、**关键，**在windows自带的远程桌面连接工具中通过在电脑B上<a href="https://gist.github.com/tl3shi/7462590" target="_blank">运行如下脚本</a>。没有的话，copy一个过去。

[<img class="aligncenter" style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="/wp-content/uploads/2013/11/image_thumb3.png" alt="image"  />](/wp-content/uploads/2013/11/image3.png)

注意得以管理员身份运行。运行后，此时通过windows远程连接的会话会断开。现在只能通过QQ的远程协助操作电脑B了。

5、下面就是见证奇迹的时刻了。

[<img class="aligncenter" style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="/wp-content/uploads/2013/11/image_thumb4.png" alt="image"  />](/wp-content/uploads/2013/11/image4.png)

现在能够检测到电脑B上的显卡对cuda 支持。

以上演示是得到了显卡对Cuda支持的驱动，相应的OpenGL也一样。其实现在操作就跟在本地实际操作电脑B一样了。

原理：

**个人认为，**以上关键步骤中的那个脚本(那个脚本是个循环试探，其实可以在电脑B上通过命令行query session得到在线的准确的会话，然后运行那个命令得到准确的session切换)中有个应用程序tscon,其相应的语法用法可以<a href="mailto:http://support.microsoft.com/kb/321703/zh-cn" target="_blank">参考这里</a>。其实QQ远程协助也是用到了windows底层的RDP协议。从电脑A通过远程桌面通过QQ B申请QQ A远程协助，此时被控电脑B有两个session，即一个QQ远程协助的另外一个windows远程桌面的。此时运行tscon是将session切换到QQ桌面的那个session。而这个session就是被控那台电脑的。因此gpu opengl啥驱动之类的就以为是本地执行的。因此才得以成功。

其实这也是个人猜测而已啦，实际上什么原理也还不清楚呢。能解决这个问题就好。也希望懂的童鞋给予解释下。另外有同学指出一些团队协助类的软件也能支持，没试过不清楚。
