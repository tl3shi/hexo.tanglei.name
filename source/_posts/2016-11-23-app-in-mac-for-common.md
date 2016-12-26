---
title: Mac 软件推荐续(!程序猿篇)
layout: post
categories: 
  - 经验技巧
tags: 
  - 经验技巧
  - Mac
---

注意题目, "程序猿篇"前面有逻辑运算符“!”, 其实不太恰当, 这篇不是说程序猿不能用, 也不是只针对程序猿的, 总之就是针对普通大众啦~ Alfred, RescueTime, Moom, Karabiner, Manico, MacDown, Near Lock, iStat Menus, Parallels Desktop, Squirrel 你听说过几个? 
(**update**: 被这个题目给蠢哭了, 非程序员并不能看懂前面的“!”, 以为是给程序猿写的, 就不会继续看了, 程序猿看懂了“!”, 认为针对非程序猿的, 也就不会继续往下看了!!)

## Alfred v2
在[前面一篇文章](http://www.tanglei.name/blog/app-in-mac-preface.html)中, 其实也已经推荐了这个神器了, 这里再强调并补充一个大家可能会用到的workflow, 即印象笔记(evernote): 可以快速搜索印象笔记/evernote 中保存的内容. 

这个得首先去 [印象笔记官网](https://app.yinxiang.com/api/DeveloperToken.action) 生成一个 token, 然后安装 [alfred-evernote](https://github.com/tl3shi/alfred-evernote) 并配置好(es-token 你自己的generated-token) token, 成功后即可使用. 查询支持不同的语法格式, 详情可以看 [evernote 查询语法](https://dev.evernote.com/doc/articles/search_grammar.php). 

![alfred-workflow-for-evernote](/resources/app-in-mac/alfred-es-search.png)

如上图所示, 搜索某关键字后直接回车则是默认在应用程序中打开, 按住 cmd 后会从浏览器中打开该笔记. 由于最开始开发的作者是国际版 evernote, 中国版补丁的作者也忘记改这个链接了, 所以在浏览器中打开的跳转链接不对, 直接下载我修改后 workflow 是 OK 的, 请从[github](https://github.com/tl3shi/alfred-evernote) 下载, 其实就是修改一下其中的 `app.js`中的 `get-link`方法(将 `https://www.evernote.com` 替换成 `https://app.yinxiang.com` ).

---

## RescueTime
时间管理

这个软件可以悄无声息的帮你记录你使用电脑的情况, 包括对各种软件用时统计, 分类统计, 并且还支持多种平台(win/mac/ubuntu/android/等), 可以定期出报告, 比如每周邮件出周报, 汇报你当周的使用情况. 

来个例子, 如下图所示为我某一周的周报:  

![rescuetime weekly report](/resources/app-in-mac/rescuetime-email.png)

周报显示该周我用了电脑近47个小时, 综合生产力评分79%. 这个生产力评分是根据你使用不同软件的不同时间加权计算出来的. 一些通用的软件, RescueTime 能够自动识别, 比如可能用iTerm2 或者 VisualStudio 等软件会归属于*Software Development*大类, 属于 `very productive` 级别, 使用 wechat 或者 QQ, 就被判断为 `distracting`, 当然你可以自定义设置, 一些软件本身没有能识别出来的, 也需要你手动去设置级别. 具体浏览网页的数据需要安装相应的Chrome 插件. 

![rescuetime detail report](/resources/app-in-mac/rescuetime-detail.png)

网页版本的可以看到更加详细的记录. 你还可以设置一些目标, 比如当天需要使用*productive*的软件3小时以上, RescueTime可以汇报你完成目标的情况. 

![rescuetime report](/resources/app-in-mac/rescuetime.png)

免费版本的也足够用了, 付费版本的可以看到更长时间段的或更详细的年报等数据. 
或许这个软件能够帮助你更好的管理时间, 或者它仅仅是不辞辛劳帮你记录下你使用电脑/手机情况也是极好的. 所以墙裂推荐大家用这款软件.

---

## Moom 
窗口管理

![moom](/resources/app-in-mac/moom.png)

利用这个软件可以很方便快捷的对应用程序窗口进行管理, 能够让多个窗口整齐的摆放在桌面上. 设置好快捷键后, 激活然后加方向键可以让当前应用程序准确定位到并充满桌面的1/2, 1/4等, 或者移动到另外一个屏幕(程序员多屏用得较广泛). 当然还可以自己设置比如充满整个屏幕的3/4, 等等. 直接用键盘快捷键即可完成的功能, 就不需要再移动手去用鼠标/trackpad去最大/小化改变窗口大小等等了. 

---

## Karabiner
键盘映射

我第一次使用时, 是因为我使用了外接键盘(如下图), 我把外接键盘放到内置笔记本键盘上, 就需要禁用掉内置键盘, 每次去手动调整当然很麻烦. 于是就找到这个软件帮助我. 

![hhkp pro2 type-s](http://www.tanglei.name/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-mini-usb-connector.jpg)

它可以帮助我自动切换外界键盘和内置笔记本键盘(插拔USB外接键盘自动切换), 除此之外, 它还支持很多功能. 
举例而言因为我用的 HHKB 是没有单独方向键, 用内置的组合方向键又特别别扭, 就可以利用它帮助映射. 比如我选择启用了 *Vi Mode* , 用 **s + h/l/j/k**, 或者 再启用 *Emacs Mode*, 用 **ctrl + p/n/b/f**代表方向键. (其实 Mac 很多快捷键都跟 Emacs 中的快捷键一致的, 准备再下一篇文章中再详细介绍常用快捷键及推荐适用于开发者的应用)

---

## Manico
快速切换应用程序

长按 `alt` 键盘可弹出切换菜单, + 具体的数字或者字母即可快速切换, 不需要再连续按键 `cmd+tab` 或者 `cmd+shift+tab` 来回切换了.

![Manico](/resources/app-in-mac/manico1.png)

---

## MacDown
文档编辑

Markdown 文本编辑器, 支持 WYSIWYG(What You See Is What You Get, 所见即所得) 类似 Mou, MacDown 直接支持类似 latex 语法, 
例如可以方便地输入数学公式用 `$$2^x + log_2y^{2+z}$$`, 
因其对此类数学公式和代码高亮等支持得更好更方便, 因此我选用了 MacDown. 

![macdown](/resources/app-in-mac/macdown.png)

如果你还不知道什么是 Markdown, 可以花时间学一些, 用熟悉了, 估计你都不太想再用 Office Word 了.

---

## cheetsheet
快捷键提示

只需要长按 *cmd*, 可弹出当前 active 的软件的快捷键. 

![cheetsheet](/resources/app-in-mac/cheetsheet.png)

---

## Near Lock
装13神器

[NearLock](http://www.nearlock.me/) 这款软件是 Mac + iPhone 结合使用, 利用蓝牙进行距离感应, 能够对 Mac 电脑进行自动锁屏/开锁.

![Near Lock](/resources/app-in-mac/nearlock-small.png)
上图我将手机和Mac的软件截图放在一块了, 内外两层分别是Mac和手机上的截图, 从中能够看到手机与Mac之间的距离, 当前解锁/锁屏状态, 可以设置锁屏/解锁的距离阈值或者修改锁定设置为休眠或屏保.

想象一下, 正对着电脑 working 呢, 突然来电话了, 以前可能需要手动锁屏然后拿手机到外面(方便接电话的地方)接电话, (不锁屏, 让同事发现你看了不该看的东西就不好了! :) 阴险脸 ), 接完电话回来后, 再手动输入密码登入电脑. 

而自从有了这个软件, 拿着电话直接离开便是, 软件自动帮你锁屏, 回来的时候, 刚坐到电脑屏幕前, 便看见软件自动帮你输入密码登入系统(目睹这个过程相当爽啊). 节约时间不说, 这看起来多高大上啊. 所以这款软件可是装 X 的神器啊. 

(有兴趣的同学可以开发下支持Win/Android的)

---

## iStat Menus
资源状态

![iStat Menus](/resources/app-in-mac/istat-menu.png)

状态栏上显示当前电脑的运行状况, CPU/内存/网络IO等等, 比如发现电脑突然变慢了, 发现 CPU 暴涨, 可以方便地抓出是哪个应用程序. 别看到CPU利用率都占满小方框了, 听到电脑风扇“呼呼”响了, 还一直操作电脑. 

---

## CleanApp
清理电脑

清理电脑(删除软件)的工具, 类似 CleanMyMac 之类的工具. 其实我认为此类软件在 Mac上用处不是很大, 想要删除某个 App, 直接进 **/Applications** 目录直接删除那个应用程序即可. 因为 Mac 应用程序数据基本上都存在 */Applications/xx.app* 这个目录下, 虽然表面上看 *xx.app* 是个应用程序文件, 双击即可运行. 只不过 CleanApp/CleanMyMac 能够删除更多的一些*.plist*等类似配置信息等(这个占用空间真的很小).  

---

## Parallels Desktop
虚拟机

![parallel-win8](/resources/app-in-mac/parallel-win8.png)

有的软件/网页, 我们还不得不用 Win 系统, 比如某些银行的网银啊, 再比如敝司的 OA 系统(墙裂鄙视)只支持 IE. 这个时候就不得不用一下 Win 系统. Win 下用得多的虚拟机是 VMWare, Mac 下这个软件类似. Win 系统可以跑在这个 App 下, 可以和 Mac "无缝" 连接在一起. 类似的虚拟机软件还有 VirtualBox, VMWare 等. 

---

## Squirrel 
输入法

这是一款开源的输入法软件, 我曾经也试用过一段时间, 但最终还是因为词库同步等比较麻烦(比如不能方便的将手机输入的词库和 PC 同步), 就放弃了. 
![Mac 输入法Squirrel](/resources/app-in-mac/squirrel.gif)

上图是"明无梦"用「小鹤双拼·语句流」输入的效果, 中英混输 + Emoji 表情哦, 我刚开始也是被这个效果所吸引尝试的 (然而后来并没驾驭得了). 
这个输入法高端玩家可以试试. 定制性极强, 经过配置可以打造成你自己独一无二的输入法. 

想试用/体验的"玩家"可以参考这篇文章 [安装及配置 Mac 上的 Rime 输入法——鼠鬚管 (Squirrel)](http://www.dreamxu.com/install-config-squirrel/).

---

全文完, 下一篇将介绍我认为程序员可能会用到的一些好用的软件. 

p.s 如果你觉得这文章对你有那么一点点收获, 请不要犹豫扫描下面二维码关注我的公众号, 如果你再能帮忙转发一下就更好了. 么么哒.

![tanglei 微信号](/resources/wechat-tangleithu.jpg)
