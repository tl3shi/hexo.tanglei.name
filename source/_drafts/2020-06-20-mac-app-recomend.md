## 背景

这周让大脑放松一下，不推送技术干货了，继续“工欲善其事，必先利其器” 这个话题。想看干货的可以看这个 [技术专辑](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1338658897502191616&subscene=21)。

在上一篇文章中，我推荐了一款 Mac 必备的软件，以及相应的插件 —— [工欲善其事，必先利其器 -- Alfred](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100002217&idx=1&sn=b4641e9f96c26e9393fc8cac997d70c2&chksm=6b47084d5c30815bb613b05854445c155d99264b56643fac9c94112e127a7e1701ab04c22771#rd)

今天我继续推荐一些本人觉得比较优秀的其他软件。

## RescueTime 

这是一款时间管理的软件。这个软件可以悄无声息的帮你记录你使用电脑的情况，包括对各种软件用时统计，分类统计，并且还支持多种平台(`win/mac/ubuntu/android/`等)，可以定期出报告，比如每周邮件出周报，汇报你当周的使用情况。 

**划重点**：若在公司场合，请注意信息安全，最好不要在公司电脑装类似的软件哦。

来个例子，如下图所示为我某一周的周报:  

![rescuetime weekly report](https://static01.imgkr.com/temp/32292b8b1941466da117bc4f3d44fa14.png)

周报显示该周我用了电脑近47个小时，综合生产力评分79%。这个生产力评分是根据你使用不同软件的不同时间加权计算出来的。

一些通用的软件，RescueTime 能够自动识别，比如可能用 `iTerm2` 或者 `VisualStudio` 等软件会归属于 `Software Development` 大类， 属于 `very productive` 级别，而使用 `Wechat` 或者 `QQ`，就被判断为 `distracting`，当然你可以自定义设置，一些软件本身没有能识别出来的，也需要你手动去设置级别。

具体浏览网页的数据需要安装相应的 Chrome 插件。 

![rescuetime detail report](https://static01.imgkr.com/temp/fcd312e18ba142338ae2c05bc6a1d2f5.png)

网页版本的可以看到更加详细的记录。你还可以设置一些目标，比如当天需要使用 `productive`的软件3小时以上，RescueTime 可以汇报你完成目标的情况。 

![rescuetime report](https://static01.imgkr.com/temp/681fd61a9904429cb98ccad96d177788.png)

免费版本的也足够用了，付费版本的可以看到更长时间段的或更详细的年报等数据。 

或许这个软件能够帮助你更好的管理时间，或者它仅仅是不辞辛劳帮你记录下你使用电脑/手机情况也是极好的。所以推荐大家用这款软件。

再次强调：请**注意信息安全**。

## Moom 

这个是用来做窗口管理的。 

![moom](https://static01.imgkr.com/temp/b3a41a291f854078ae5a8d19c49237ec.png)

利用这个软件可以很方便快捷的对应用程序窗口进行管理，能够让多个窗口整齐的摆放在桌面上。

设置好快捷键后，激活然后加方向键可以让当前应用程序准确定位到并充满桌面的`1/2`，`1/4`等等，或者移动到另外一个屏幕(程序员多屏用得较广泛)。

当然还可以自己设置比如充满整个屏幕的`3/4`等等。直接用键盘快捷键即可完成的功能，就不需要再移动手去用鼠标/trackpad去最大/小化改变窗口大小等等了。 

## Karabiner

这个用来做键盘映射。

我第一次使用时，是因为我使用了外接键盘(如下图)，我把外接键盘放到内置笔记本键盘上，就需要禁用掉内置键盘，每次去手动调整当然很麻烦。 于是就找到这个软件帮助我。 

![hhkb pro2 type-s](https://static01.imgkr.com/temp/79dd69f13b6a43b49f75835a25746910.png)

哈哈，图上的那个小 USB 转弯头也很重要，当仅仅用笔记本的场景时，有了这个小弯头，我的 HHKB 就刚好覆盖了原来的键盘区域。 

秀一下我现在的装备，在公司一般有外接显示器，不会把外接键盘放在笔记本上面，因此用不了上面的弯头了。配上升降桌，程序猿必备啊。久坐不太好，偶尔需要站立办公（防止腰椎间盘突出）。

![hhkb pro2 type-s-new](https://static01.imgkr.com/temp/96fc53bb39f24beb996d5067d196fb5e.png)

它可以帮助我自动切换外界键盘和内置笔记本键盘(插拔USB外接键盘自动切换)，除此之外它还支持很多功能。
 
举例而言因为我用的 HHKB 是没有单独方向键，用内置的组合方向键又特别别扭，就可以利用它帮助映射。

比如我选择启用了 `Vi Mode`，用 `s + h/l/j/k` （或者再启用 `Emacs Mode`用 **ctrl + p/n/b/f**）代表方向键。 (其实 Mac 很多快捷键都跟 Emacs 中的快捷键一致的)。


## Manico

快速切换应用程序。

长按 `alt` 键盘可弹出切换菜单，然后加上具体的数字或者字母即可快速切换，不需要再连续按键 `cmd+tab` 或者 `cmd+shift+tab` 来回切换了。

![Manico](https://static01.imgkr.com/temp/44c9b6a840e541aaaedfc6803ef1a115.png)

这个快速切换应用程序，其实可以通过之前石头推荐的[这篇文章中介绍的 Alfred](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100002217&idx=1&sn=b4641e9f96c26e9393fc8cac997d70c2&chksm=6b47084d5c30815bb613b05854445c155d99264b56643fac9c94112e127a7e1701ab04c22771#rd) 来实现的。

## MacDown

md文档编辑。

Markdown 文本编辑器，支持 WYSIWYG(What You See Is What You Get，所见即所得) 类似 Mou，MacDown 直接支持类似 `latex` 语法，例如可以方便地输入数学公式用 `$$2^x + log_2y^{2+z}$$`， 
因其对此类数学公式和代码高亮等支持得更好更方便，因此我选用了 MacDown。 

![macdown](https://static01.imgkr.com/temp/c72d519644924939a7372263d57092f7.png)


如果你还不知道什么是 Markdown，可以花时间学一些。

## cheetsheet

快捷键提示

只需要长按 *cmd*， 可弹出当前 active 的软件的快捷键。 

![cheetsheet](https://static01.imgkr.com/temp/504da464a5004938a04a879ba2846603.png)

## Near Lock

这个就是[前文提到的装13神器](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485871&idx=1&sn=c877775df684d8ab8c90bf2d38eee98a&chksm=eb47084bdc30815d19182c51571b096a20b79bdee0956f68167ebc8ed3117364ac0602f83658&token=45298936&lang=zh_CN#rd)，哈哈当初是遇到搞活动，购买的，1 块钱还是多少忘记了。 

[NearLock](http://www.nearlock.me "NearLock") 这款软件是 Mac + iPhone 结合使用，利用蓝牙进行距离感应，能够对 Mac 电脑进行自动锁屏/开锁。

![Near Lock](https://static01.imgkr.com/temp/d0114c42b1824f74be70b18e4bc63228.png)


上图我将手机和Mac的软件截图放在一块了，内外两层分别是Mac和手机上的截图，从中能够看到手机与Mac之间的距离，当前解锁/锁屏状态，可以设置锁屏/解锁的距离阈值或者修改锁定设置为休眠或屏保。

想象一下，正对着电脑 working 呢，突然来电话了，以前可能需要手动锁屏然后拿手机到外面(方便接电话的地方)接电话，(不锁屏，让同事发现你看了不该看的东西就不好了! :) 阴险脸。

其实更多的是信息安全，在某司这样人离开电脑不锁屏，被举报是会被扣钱的，接完电话回来后，再手动输入密码登入电脑。 

而自从有了这个软件，拿着电话直接离开便是，软件自动帮你锁屏，回来的时候，刚坐到电脑屏幕前，便看见软件自动帮你输入密码登入系统(目睹这个过程相当爽啊)。

节约时间不说，这看起来多高大上啊。所以这款软件可是装 X 的神器啊。 

有兴趣的同学可以开发下支持 Win/Android 的。（啊，6 年过去了，都 2020 年了，还没有人开发 Win、Android 版本的？）你说，要是做一款会受欢迎吗？


## iStat Menus

资源状态

![iStat Menus](https://static01.imgkr.com/temp/4dd0df61cc9b4d74a81180949f8152cd.png)

状态栏上显示当前电脑的运行状况，CPU/内存/网络IO等等，比如发现电脑突然变慢了，发现 CPU 暴涨，可以方便地抓出是哪个应用程序。别看到CPU利用率都占满小方框了，听到电脑风扇“呼呼”响了，还一直操作电脑。 

## CleanApp

清理电脑

清理电脑(删除软件)的工具， 类似 CleanMyMac 之类的工具。 其实我认为此类软件在 Mac上用处不是很大，想要删除某个 App，直接进 `/Applications` 目录直接删除那个应用程序即可。

因为 Mac 应用程序数据基本上都存在 `/Applications/xx.app` 这个目录下，虽然表面上看 `xx.app` 是个应用程序文件，双击即可运行。只不过 CleanApp/CleanMyMac 之类的能够删除更多的一些`*.plist`等类似配置信息等(这个占用空间真的很小)。  

## Parallels Desktop

虚拟机

![parallel-win8](https://static01.imgkr.com/temp/1167257ae868461196f4f097265f26aa.png)


有的软件/网页，我们还不得不用 Win 系统，比如某些银行的网银啊，再比如~~敝司~~（注意：此敝司是当时的敝司，非现在的敝司）的 OA 系统(墙裂鄙视)只支持 IE。

这个时候就不得不用一下 Win 系统。Win 下用得多的虚拟机是 VMWare，Mac 下这个软件类似。 但这个软件好处是，Win 系统可以跑在这个 App 下，可以和 Mac "无缝" 连接在一起。类似的虚拟机软件还有 VirtualBox，VMWare 等。 

## Squirrel 

输入法

这是一款开源的输入法软件，我曾经也试用过一段时间，但最终还是因为词库同步等比较麻烦(比如不能方便的将手机输入的词库和 PC 同步)， 就放弃了。 

![](https://hexo.tanglei.name/resources/app-in-mac/squirrel.gif)

上图是"明无梦"用「小鹤双拼·语句流」输入的效果，中英混输 + Emoji 表情哦，我刚开始也是被这个效果所吸引尝试的 (然而后来并没驾驭得了)。 

这个输入法高端玩家可以试试。定制性极强，经过配置可以打造成你自己独一无二的输入法。 

想试用/体验的"玩家"可以参考这篇文章 [安装及配置 Mac 上的 Rime 输入法——鼠鬚管 (Squirrel)](http://www.dreamxu.com/install-config-squirrel/ "安装及配置 Mac 上的 Rime 输入法——鼠鬚管 (Squirrel)")。

## 总结一下

来个总结，在[前面一篇文章](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100002217&idx=1&sn=b4641e9f96c26e9393fc8cac997d70c2&chksm=6b47084d5c30815bb613b05854445c155d99264b56643fac9c94112e127a7e1701ab04c22771#rd)中，推荐了 [Mac神器 -- Alfred](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100002217&idx=1&sn=b4641e9f96c26e9393fc8cac997d70c2&chksm=6b47084d5c30815bb613b05854445c155d99264b56643fac9c94112e127a7e1701ab04c22771#rd)， 这篇又分别推荐了如下 App：

- 时间管理 RescueTime
- 窗口管理 Moom
- 键盘映射 Karabiner
- 应用切换 Manico
- md文本编辑 MacDown
- 快捷键 cheetsheet
- 装 X 神器 Near Lock
- 资源状态管理 iStat Menus
- 软件卸载 CleanApp
- 虚拟机 Parallels Desktop
- 输入法 Squirrel

后面还会有一篇内容，我将推荐一些程序猿专用的一些神器来帮助提高效率，敬请期待。