---
title: 工欲善其事，必先利其器 | 开发者怎么利用工具提高效率
layout: post
categories:
  - 经验技巧
tags:
  - 经验技巧
  - 工具
  - Mac
---

如果你在使用 Mac 电脑， 并且没有如某些人那样**地安装并使用 Windows 系统， 那么你可以尝试使用以下这些软件。

在 Mac 装 Windows 使用，感觉有点“暴殄天物”（文化有限，只能找到这个词），没有恶意黑 Windows，Windows 有 Windows 的使用场景，对于普通人民群众来说，确实使用 Windows 够了，微软现在也出了不错的笔记本。但你确实不该买 Mac 然后确使用 Windows 系统，这样其实装 X 效果不好。

下面的这些软件都是我自己使用过且觉得还不错的，在这里推荐给大家，这些软件或者可以极大地提高效率或者偶尔也足够装13（哈哈，乱入了一两款 App）。 

Alfred， RescueTime， Moom， Karabiner， Manico， MacDown， Near Lock， iStat Menus， Parallels Desktop， Squirrel 你听说过几个?  

##  Alfred

这个软件很多文章都在说，我这里就不多做过多介绍了。 其具体效果跟 Mac 自带的 Spotlight 类似， 但功能会强大 N 个数量级倍。我居然不是12年底刚接触 Mac 时用的她(为啥当初没人推荐给我，直到我快工作了才用上)。如果你看到这篇文章且还没有用，就赶紧用起来吧。免费版本的功能也都挺强悍的。

>注意：本文最开始几年前写的，现在重新做了编辑和整理，其中有的截图可能直接用的以前的图，但不影响阅读和理解，也不影响我到今天仍然强烈推荐。

举例说下常用的几个功能:  

- 文件搜索：类似 Windows 版本的 everything。 设置某个标识(示例中为 “'”)开头，后面为关键字就开始全盘索引(当然可以配置过滤)了， 找到搜索到的文件后，按 "->" 出现二级菜单，下一步的操作。比如复制，以此命令行 `cd` 到文件/目录(后面有类似的工具推荐)，复制文件路径(finder 不比 windows 能够方便 copy 文件路径)等。

![alfred-file-search](/resources/app-in-mac/alfred-file-search.png)

- 剪贴板历史：可以帮你保存你最近的剪贴板历史，通过快捷键选取粘贴。实际工作中经常遇到，本来要复制一个东西已经 `cmd+c` 了，这个时候又来一个更优先需要复制粘贴的，前面那个又被覆盖了，还得再去复制一遍。有了这个功能就不愁了。

![alfred-paste](/resources/app-in-mac/alfred-paste.png)

- 搜索引擎搜索，同样可以设置关键字，比如 "google keywords"， 回车就能直接打开 google 搜索。默认的有 google/wiki/gmail/amazon等等，这个还可以自己方便添加更多的 search，比如 baidu 等等。 

- 各种快捷搜索：其他的比如联系人搜索，快捷功能(`lock/sleep/shutdown`)等等，计算器(直接输入等式即可)，输入应用名称快速打开应用等等。

![alfred-quick-search](/resources/app-in-mac/alfred-quick-search.png)

Workflow 是其更强大的卖点。 比如以下一些或者极其高效或者很有意思的 workflow。 

- Dash: 程序员神器啊。 结合 Dash，能够非常方便快捷地搜索某种语言的某个 API，再也不用边写边打开浏览器去搜索了。 遇到了 某个 API 不太清楚，直接 `ctrl + blank` 输入关键字就直接模糊搜索某 API 了。

![alfred-dash](/resources/app-in-mac/dash.png)

- stackoverflow: 程序猿，你懂得。同样设置关键字(例如 `st keywords`) 就能直接搜索 stackoverflow 上相关问题。 相当于在 google 搜索中 `keywords site:stackoverflow.com`。

![alfred-stackoverflow](/resources/app-in-mac/alfred-st.png)

- youdao 翻译，遇到中英文翻译问题不用再打开浏览器去搜索了。 (当然 Mac 自带的取词翻译功能也挺不错的: 不知道? 选中关键字， 三指轻点 trackpad )
![alfred-youdao](/resources/app-in-mac/youdao.png)
![mac-translate](/resources/app-in-mac/mac-translate-trackpad.png)
- zhihu: 知乎搜索及知乎日报，可以设置关键字直接知乎搜索，或者列出当天的知乎日报推荐列表。
![alfred-zhihu](/resources/app-in-mac/zhihu-daily.png)
- douban: 豆瓣的相关功能，豆瓣读书/电影等。最近听到同事谈论某电影， 想看豆瓣评分多少? 很简答， 直接 `movie 电影名` 就出来结果了， 如图：
![alfred-douban](/resources/app-in-mac/douban-movie.png)
- tianqi: 调用百度的 API 实现的快捷天气预报
![alfred-weather](/resources/app-in-mac/baidu-tianqi.png)
- mail: 快速搜索邮件
![alfred-mail](/resources/app-in-mac/mail.png)
- 印象笔记(evernote): 快速搜索印象笔记/evernote 中保存的内容
这个得首先去 [印象笔记官网](https://app.yinxiang.com/api/DeveloperToken.action) 生成一个 token，然后安装好 [alfred-evernote](https://github.com/tl3shi/alfred-evernote)后， 配置好(es-token 你自己的generated-token) token 成功后就可以使用了。 查询有不同的语法格式， 详情可以看[这里](https://dev.evernote.com/doc/articles/search_grammar.php)。 

![alfred-印象笔记 workflow](/resources/app-in-mac/alfred-es-search.png)

搜索后直接回车打开是默认在应用程序中打开，按住 `cmd` 后会在浏览器中打开(由于最开始开发的作者是国际版 evernote，中国版补丁的作者也忘记改这个链接了，所以在浏览器中打开的跳转链接不对，直接下载我修改后 workflow 是 OK 的 [github](https://github.com/tl3shi/alfred-evernote))， 其实就是修改一下其中的 `app.js`中的 `get-link`方法。

当然还有更多其他好玩有用的 workflow， 你可以直接到[github 这里](https://github.com/hzlzh/AlfredWorkflow.com)"选购"， 没有的， 你也可以自己实现一个也贡献出来哦。 自己贡献也比较简单，用 `php/python` 等都可以实现，你打开 alfred 设置项，双击具体某个 workflow 就能看到源码。

----
## RescueTime  TODO

时间管理

这个软件可以悄无声息的帮你记录你使用电脑的情况，包括对各种软件用时统计，分类统计，并且还支持多种平台(`win/mac/ubuntu/android/`等)，可以定期出报告，比如每周邮件出周报，汇报你当周的使用情况。 

**划重点**：若在公司场合，请注意信息安全，最好不要在公司电脑装类似的软件哦。

来个例子， 如下图所示为我某一周的周报:  

![rescuetime weekly report](/resources/app-in-mac/rescuetime-email.png)

周报显示该周我用了电脑近47个小时，综合生产力评分79%。这个生产力评分是根据你使用不同软件的不同时间加权计算出来的。一些通用的软件， RescueTime 能够自动识别，比如可能用 `iTerm2` 或者 `VisualStudio` 等软件会归属于 `Software Development` 大类， 属于 `very productive` 级别， 而使用 `Wechat` 或者 `QQ`， 就被判断为 `distracting`，当然你可以自定义设置，一些软件本身没有能识别出来的，也需要你手动去设置级别。具体浏览网页的数据需要安装相应的 Chrome 插件。 

![rescuetime detail report](/resources/app-in-mac/rescuetime-detail.png)

网页版本的可以看到更加详细的记录。你还可以设置一些目标，比如当天需要使用 `productive`的软件3小时以上，RescueTime可以汇报你完成目标的情况。 

![rescuetime report](/resources/app-in-mac/rescuetime.png)

免费版本的也足够用了，付费版本的可以看到更长时间段的或更详细的年报等数据。 

或许这个软件能够帮助你更好的管理时间，或者它仅仅是不辞辛劳帮你记录下你使用电脑/手机情况也是极好的。所以推荐大家用这款软件（请**注意信息安全**）。

---

## Moom 

窗口管理

![moom](/resources/app-in-mac/moom.png)

利用这个软件可以很方便快捷的对应用程序窗口进行管理，能够让多个窗口整齐的摆放在桌面上。设置好快捷键后，激活然后加方向键可以让当前应用程序准确定位到并充满桌面的`1/2`，`1/4`等等，或者移动到另外一个屏幕(程序员多屏用得较广泛)。当然还可以自己设置比如充满整个屏幕的`3/4`等等。直接用键盘快捷键即可完成的功能，就不需要再移动手去用鼠标/trackpad去最大/小化改变窗口大小等等了。 

---

## Karabiner

键盘映射

我第一次使用时，是因为我使用了外接键盘(如下图)，我把外接键盘放到内置笔记本键盘上，就需要禁用掉内置键盘，每次去手动调整当然很麻烦。 于是就找到这个软件帮助我。 

![hhkp pro2 type-s](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-mini-usb-connector.jpg)

它可以帮助我自动切换外界键盘和内置笔记本键盘(插拔USB外接键盘自动切换)，除此之外它还支持很多功能。
 
举例而言因为我用的 HHKB 是没有单独方向键，用内置的组合方向键又特别别扭，就可以利用它帮助映射。比如我选择启用了 `Vi Mode`，用 `s + h/l/j/k` （或者再启用 `Emacs Mode`用 **ctrl + p/n/b/f**）代表方向键。 (其实 Mac 很多快捷键都跟 Emacs 中的快捷键一致的)

---

## Manico

快速切换应用程序

长按 `alt` 键盘可弹出切换菜单， 然后加上具体的数字或者字母即可快速切换，不需要再连续按键 `cmd+tab` 或者 `cmd+shift+tab` 来回切换了。

![Manico](/resources/app-in-mac/manico1.png)

---

## MacDown

文档编辑

Markdown 文本编辑器， 支持 WYSIWYG(What You See Is What You Get，所见即所得) 类似 Mou，MacDown 直接支持类似 `latex` 语法， 例如可以方便地输入数学公式用 `$$2^x + log_2y^{2+z}$$`， 
因其对此类数学公式和代码高亮等支持得更好更方便，因此我选用了 MacDown。 

![macdown](/resources/app-in-mac/macdown.png)

如果你还不知道什么是 Markdown，可以花时间学一些。

---

## cheetsheet

快捷键提示

只需要长按 *cmd*， 可弹出当前 active 的软件的快捷键。 

![cheetsheet](/resources/app-in-mac/cheetsheet.png)

---

## Near Lock

这个就是前文提到的装13神器，哈哈当初是遇到搞活动，购买的，1 块钱还是多少忘记了。 

[NearLock](http://www.nearlock.me) 这款软件是 Mac + iPhone 结合使用，利用蓝牙进行距离感应，能够对 Mac 电脑进行自动锁屏/开锁。

![Near Lock](/resources/app-in-mac/nearlock-small.png)

上图我将手机和Mac的软件截图放在一块了，内外两层分别是Mac和手机上的截图，从中能够看到手机与Mac之间的距离，当前解锁/锁屏状态，可以设置锁屏/解锁的距离阈值或者修改锁定设置为休眠或屏保。

想象一下，正对着电脑 working 呢，突然来电话了，以前可能需要手动锁屏然后拿手机到外面(方便接电话的地方)接电话，(不锁屏，让同事发现你看了不该看的东西就不好了! :) 阴险脸，其实更多的是信息安全，在某司这样人离开电脑不锁屏，被举报是会被扣钱的)，接完电话回来后，再手动输入密码登入电脑。 

而自从有了这个软件，拿着电话直接离开便是，软件自动帮你锁屏，回来的时候，刚坐到电脑屏幕前，便看见软件自动帮你输入密码登入系统(目睹这个过程相当爽啊)。节约时间不说，这看起来多高大上啊。所以这款软件可是装 X 的神器啊。 

有兴趣的同学可以开发下支持 Win/Android 的。（啊，6 年过去了，都 2020 年了，还没有人开发 Win、Android 版本的？）你说，要是做一款会受欢迎吗？

---

## iStat Menus

资源状态

![iStat Menus](/resources/app-in-mac/istat-menu.png)

状态栏上显示当前电脑的运行状况，CPU/内存/网络IO等等，比如发现电脑突然变慢了，发现 CPU 暴涨，可以方便地抓出是哪个应用程序。别看到CPU利用率都占满小方框了，听到电脑风扇“呼呼”响了，还一直操作电脑。 

---

## CleanApp

清理电脑

清理电脑(删除软件)的工具， 类似 CleanMyMac 之类的工具。 其实我认为此类软件在 Mac上用处不是很大，想要删除某个 App，直接进 `/Applications` 目录直接删除那个应用程序即可。 因为 Mac 应用程序数据基本上都存在 `/Applications/xx.app` 这个目录下，虽然表面上看 `xx.app` 是个应用程序文件，双击即可运行。只不过 CleanApp/CleanMyMac 之类的能够删除更多的一些`*.plist`等类似配置信息等(这个占用空间真的很小)。  

---

## Parallels Desktop

虚拟机

![parallel-win8](/resources/app-in-mac/parallel-win8.png)

有的软件/网页，我们还不得不用 Win 系统，比如某些银行的网银啊，再比如~~敝司~~（注意：此敝司是当时的敝司，非现在的敝司）的 OA 系统(墙裂鄙视)只支持 IE。这个时候就不得不用一下 Win 系统。Win 下用得多的虚拟机是 VMWare，Mac 下这个软件类似。 但这个软件好处是，Win 系统可以跑在这个 App 下，可以和 Mac "无缝" 连接在一起。类似的虚拟机软件还有 VirtualBox，VMWare 等。 

---

## Squirrel 
输入法

这是一款开源的输入法软件，我曾经也试用过一段时间，但最终还是因为词库同步等比较麻烦(比如不能方便的将手机输入的词库和 PC 同步)， 就放弃了。 

![Mac 输入法Squirrel](/resources/app-in-mac/squirrel。gif)

上图是"明无梦"用「小鹤双拼·语句流」输入的效果，中英混输 + Emoji 表情哦，我刚开始也是被这个效果所吸引尝试的 (然而后来并没驾驭得了)。 

这个输入法高端玩家可以试试。 定制性极强，经过配置可以打造成你自己独一无二的输入法。 

想试用/体验的"玩家"可以参考这篇文章 [安装及配置 Mac 上的 Rime 输入法——鼠鬚管 (Squirrel)](http://www.dreamxu.com/install-config-squirrel/)。


# 程序猿部分 分割线TODO

后面的部分内容将介绍一些可以提高程序猿工作效率的一些软件和工具及相关配置。 

## Mac built-in

首先介绍的就是我觉得应该熟悉 Mac 内置的一些软件及配置。 

### trackpad 配置

- 1. **启用 Tap to click**: 在 `System Preferences -> Trackpad ` 中启用， 用 **tap** 替换 **click** 的操作， 明明轻轻 **tap** 就可以完成的，为何还要用力点击才 OK。现在偶尔用其他人电脑非得用力 click 就太纠结了。
同时，还有 "右键"功能， **Secondary click**，用两个手指 tap 弹出右键菜单。 
![mac trackpad 设置](/resources/app-in-mac/mac-os-trackpad.png)

- 2. **开启单词选词查询**:
选中某个中英文单词后， 三指 tab 会弹出词典释义。这个在[之前一篇文章](http://www。tanglei。name/blog/app-in-mac-preface。html)中也有介绍。 

- 3. **Scroll 方向**: 这个道是自己习惯就好。由于我刚开始从 Win 转向 Mac 的时候习惯用 Win 的那种方式， 于是就没有开启 *Scroll direction: natural*，然后也一直沿用至今。 

- 4. **其他手势**: 有必要熟悉一下，比如知道在 Win 环境下用 `win+d` 可以显示桌面，相应的功能在 Mac 下如何做。 

### 快捷键

作为程序猿，肯定离不开各种快捷键。对于 Mac 内置的一些快捷键， 我们还是很有必要知道的。 基本的复制/粘贴就不说了，常用的还有

```
空格键: 预览
cmd + ，: 设置
cmd + -/=: 缩小/放大
ctrl + u: 删除到行首(与zsh冲突， zsh中是删除整行)
ctrl + k: 删除到行尾
ctrl + p/n: 上/下移动一行或者前/后一个命令
ctrl + b/f: 光标前/后移char
esc + b/f: 光标前/后移word(蛋疼不能连续work)
ctrl + a/e: 到行首/行尾
ctrl + h/d: 删前/后字符
ctrl + y: 粘贴
ctrl + w: 删除前一个单词
esc + d: 删后一个单词
ctrl + _: undo
ctrl + r: bck-i-search/reverse-i-search， 输入关键字搜索历史命令
```

上面的这些快捷键特别是在敲命令时还是很有用的(可能有的确实是在命令行中才生效)， 特别是结合 `zsh` 自动补全等功能。 比较 DT 的是就是 `esc` 一起用的时候，不能连续使用。举个例子， terminal 中输入了 `git push origin source`， 光标在末尾， 这时按住`ctrl` 不放， 按一下 `w` 即向前删除一个单词，第一次按 `w` 删除 *source*， 再按 `w` 删除 *origin*。 而 `esc + d` 不能这样结合使用(如下 gif连续按就不 work)， `esc` 必须中途释放再按才能 work。 

![bash自动补全](/resources/app-in-mac/builtin-quick-key-git-push.gif)

啥? 你说上面快捷键 `ctrl + w` 等不太好按? 按键特别别扭? 
你需要做的就是将 `caps lock` 映射为 `ctrl`， `Keyboard -> Modifier Keys `修改， 目前我笔记本上的 `ctrl` 键无效。不过， 一般情况下我用我的 HHKB， 这种映射方式正好符合 HHKB 的布局。 (其实我是在买 HHKB 之前就修改的这个映射)

另外，借助之前介绍的**Karabiner**，可以将一些常用的方向键(上下左右)重新映射一下， 比如我目前是 `s + h/j/k/l` 来表示方向， 手不用太移动就能直接按方向(HHKB 本身按方向太麻烦， Mac 内置键盘有方向键还需要大幅度移动手)， 用起来方便多了。  

Mac 内置的更多的快捷键列表可以参考 [Mac 官网](https://support.apple.com/zh-cn/HT201236)

其他还有一些常用的软件的快捷键，可以用之前介绍的软件 cheetsheet，长按 **cmd**，可弹出当前 active 的软件的快捷键。

### 截图

这个从快捷键中单独列出来了， 就强调下这个功能。 

`cmd + shift + 3` 截取整个屏幕。 
`cmd + shift + 4` 部分窗口， 出现十字供选取， 若此时按**空格键**(这个技能得点赞)， 会选取当前应用的窗口， 再 **tap** 即可完成截图。 

上面快捷键是截图后以文件形式保存在桌面(默认是桌面，当然你也可以自己修改保存位置)，再上面快捷键基础上再同时按 `ctrl` 就会把图片保存在内存/剪贴板中，直接去相应窗口粘贴即可。


## home brew

类似 centos 的 **yum**， ubuntu 的 **apt-get**， 能够方便管理安装软件包。 
Mac 上类似的应用还有**port**， 我刚开始试用过 port， 貌似 brew 上的源会多一些。 
brew-cask 是 brew 的一个加强版，可以安装一些桌面应用，例如 chrome 等等之类的。 

这里就不多介绍了， 详情可以到官网查看。 
[brew](http://brew.sh/)
[brew-cask](https://caskroom.github.io/)

## iTerm2 

[iTerm2官网](http://www.iterm2.com/features.html)有介绍功能。 以下是觉得可能常用的功能。 

- **分屏功能**
	- `cmd + d` 竖着分屏， `cmd + shift + d` 横着分屏
	- `cmd + t` 新建一个 tab， `cmd + num` 切换到第 num 个 tab
	- 当前窗口含有分屏时， 通过 `cmd + [` 和 `cmd + ]` 来进行切换小的分屏

- **热键**：设置一个热键，比如我的是 `alt + 空格`， 弹出 iTerm2， 且以半透明的方式显示在当前 active 的窗口上面。
![iTerm2 hotkey](/resources/app-in-mac/iterm2-hotkey.png)

- 密码管理器：比如经常 ssh 到不同的服务器，密码又不一样。就可以通过这个管理起来，需要输入的时候，直接快捷键弹出，选中特定的账号即可。其实也还有更专业的密码管理器，例如 1Password 和 LastPass，感兴趣可以试试。

![iTerm2 hotkey](/resources/app-in-mac/iterm2-password-manager.png)

- 搜索
	- `cmd + f`搜索输入关键字后，匹配的会黄色高亮，此时按 `tab` 或者 `shift + tab` 会自动向后/前以word 的方式选中高亮的，并自动 copy 到剪切板。
	- `cmd + alt + e`， 在所有的 tab 中全局搜索， 搜索出候选项后， 再选着你想要进入的 tab。 
	
![iTerm2 search](/resources/app-in-mac/iterm2-search-all.png)

- 其他
	- 新版本的 iTerm2 还支持直接在控制台里 ls 图片文件(图片显示在控制台里)。(如上图下半部分， 连 gif 都支持)
	- 自动识别控制台里的内容，如含有链接或者本地文件路径可以用 `cmd` 加点击的方式直接打开链接或者文件(如下图上半部分)。 这个功能很重要呢， 比如在编译过程中，出现了 warning 或者 error， 一般会打印出具体文件路径， 此时直接从控制台就能打开文件进行 fix 了。 
	- 自动补全，iTerm2 本身是支持自动补全的(`cmd + ;`)，不过建议直接结合后面的zsh使用。 `cmd + shift + h` 剪贴板历史(下图最后一行)。
	- 一些高级的功能目前可能处于测试版本，你若用的稳定版是不支持的，需要到官网下测试版。还有更多的功能请到 iTerm2 官网探索吧。 

![iTerm2 imgcat](/resources/app-in-mac/iterm2-imgcat-show-history.png)

## zsh

这个墙裂推荐啊。结合 [oh my zsh](http://ohmyz.sh/)，丰富的[插件资源](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview)。 

语法高亮，自动补全等特别好，在此推荐的几个插件或功能。

- **git**: 当前目录若是在一个 git repo 下面的话， 会自动显示当前的分支信息等等。 然后可以自己搞一些 alias，简写命令，比如我常用的一些。 

```
alias gs='git status'
alias gb='git branch -va'
alias gco='git checkout'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gfom='git fetch origin master'
alias gfod='git fetch origin develop'
alias grod='git rebase origin/develop'
alias grom='git rebase origin/master'
```

- **autojump**: 这个也炒鸡赞。 会自动记录你 `cd` 过的目录，下次你直接 `j keyword` 就会自动 `cd` 到以 *keyword* 匹配的目录。 输入 `d` 会展示当前会话访问过的目录，然后对应目录有标号，接下来按标号即可跳转。

- **osx**: 举个最简单的例子，比如你现在正在 finder 中浏览一个很深的目录， 现在突然想 cd 到这个目录去做一些命令操作。 如果你用xtrafinder 这样的软件的话道有这样的功能， 如果配上这个插件， 你直接输入 `cdf` (cd finder)就自动 `cd` 到 finder 打开的目录下。 

- **zsh-autosuggestions**，如下图所示，我在 *app-in-mac* 这个目录下， 刚输入了 `git`， 此时光标还在 `p` 前面， zsh 就已经自动给我补全了 `git push origin source`，此时我只要按 `ctrl + e` 跳转到行尾(所以熟悉上文中的快捷键很有必要啊)， 回车即可执行命令了。 

![iTerm2 zsh plugins](/resources/app-in-mac/zsh-plugins.png) 

更多的，还是请到官网查看。 

## sublime text

文本编辑器，也有丰富的插件支持，直接[官网](http://www。sublimetext.com/)看吧。这个 App，我用得也不是很多。 

这里分享一个小的功能，怎么在命令行用 sublime 打开特定的文件。 其实就是添加一个软链即可。 (直接 `open filename` 会以文件默认关键的软件打开)

```bash
➜  app-in-mac git:(source) ✗ subl dungeon-game。cpp
➜  app-in-mac git:(source) ✗ which subl
/usr/local/bin/subl
➜  app-in-mac git:(source) ✗ ls -la /usr/local/bin/subl
lrwxr-xr-x  1 tanglei  admin  62  1 24  2016 /usr/local/bin/subl -> /Applications/Sublime Text。app/Contents/SharedSupport/bin/subl
```

## Vim 

介绍 Vim 的文章也很多了。 这里就不详细展开了。分享下我用的部分插件。 为了让多台电脑同步我的 vim 配置/插件等， 我直接放 github 了([ref vimconfigs](https://github.com/tl3shi/vimconfigs.git))，不同电脑只需要再建一个软链到github 中的 vimrc 即可。

![vim 自动补全](/resources/app-in-mac/vim-autocomplete.png)

- Vundle/Pathogen: 插件管理， 我用的Pathogen， 直接将下面 github repo clone 到 `~/。vim/bundle/` 目录下即可
- NERDTree: 文件目录树[nerdtree github src](https://github.com/scrooloose/nerdtree。git)
- YouCompleteMe: [YouCompleteMe github src](https://github.com/Valloric/YouCompleteMe) 自动补全， 对C系列， 结合其他的可支持 Java/Python/Js 等，  跪求 Scala 支持
- ctrlp.vim: [快速搜索文件](https://github.com/ctrlpvim/ctrlp.vim)
- minibufexpl.vim: 会把最近打开的文件列出来方便跳转， [github src](https://github.com/fholgado/minibufexpl.vim.git)
- conque-term: shell 跑在 vim 里面， [github src](https://github.com/tl3shi/conque-term.git)
- ag: 代码搜索， 可结合 ctrlp。vim， 如果后者搜索太慢的话， [github src](https://github.com/rking/ag.vim.git)
- tagbar/taglist: 标签， 能显示类结构信息等，[tagbar github src](https://github.com/majutsushi/tagbar.git)
- vim-surround:  处理诸如`()， ""， []` 等配对信息， [github src](https://github.com/tpope/vim-surround。git)，[ref](http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/)
- vim-easymotion: 快速跳转，关键字后会给匹配到的标记，再选标记并跳转(类似后文介绍 Chrome 插件的Vimium中的链接标记并跳转功能:按键 `f` 会将本文所有链接突出显示并用字母标记， 然后按相应的字母则会新开标签页打开)。 [github src](https://github.com/easymotion/vim-easymotion.git)， [ref](http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html)
- vim-powerline: 增强状态栏 [github src](https://github.com/Lokaltog/vim-powerline.git)
- vim-indent-guides: 缩进可视化，[github src](https://github.com/nathanaelkane/vim-indent-guides)

具体效果等配置方法可以参考下面的两篇文章， 插件具体用法可阅读具体插件的 doc。 

Reference 

- [将你的Vim 打造成轻巧强大的IDE](http://yuez。me/jiang-ni-de-vim-da-zao-cheng-qing-qiao-qiang-da-de-ide/)
- [所需即所获：像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide)

## Dash 

其实介绍[前文](http://www.tanglei.name/blog/app-in-mac-preface.html) 介绍 Alfred 已经提到过，这里再介绍一下。程序猿应该必备啊。 内置各种语言，各种环境的各种文档。该 App 还提供各种 API 供其他工具交互使用。例如 Vim(不是想象当中自动补全功能， 只是能够快捷地搜索 API)，Sublime 等。 (p.s 要是有人写了一个 Vim 插件，能够支持调用 dash 的 API(如果有的话) 自动补全代码，那应该会很受欢迎的)

![dash](/resources/app-in-mac/dash-main.png)

## 其他有用的命令行

一些好用的命令(基本的什么`ls/cd/cp/rm`之类的这里就直接忽略了)， 我觉得作为程序猿还是应该了解， 至少只当某个场景下直接用相应的命令就能解决。 具体参数可以再 `--help` 或者 `man commond` 再看。

推荐这篇文章 [Shell 助力开发效率提升](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100000118&idx=1&sn=229e2a7c3c79018abc6078917c487050&chksm=6b4700925c3089846fd6c2f20c33d54ca7d045931466c5a92891d3e7070cb8c12477602fb1be#rd)详细了解通过 Shell 帮助开发效率提升。 


- screen: 特别是 ssh 到登录远程时用以管理会话
- curl: 网络请求， 相关的还有 `traceroute， dig` 等
- find: 文件查找
- grep/zgrep/zcat: 查看日志的时候用
- awk: 这个本身就很强大了， 具体编程语法不用太掌握但可以了解一些基本的用法， 比如之前用到过给一个log文件， 能够取里面的参数拼接update 的sql(文件里有相应 update 的值和 where 条件值)
- sed: 文本替换， 还有 `tr`， 注意 sed 的语法 Mac 和 一般 Linux 还有些不一样( 比如原文替换的时候 mac 里需要用参数 `-i ""`)， 比如之前[迁移 wordpress 到 jekyll](/blog/give-up-wordpress-to-jekyll。html) 上的时候需要将一些链接整体替换成新的路径。
- cut: 按列取数据， `awk` 也可以
- sort: 这个就不多说了
- uniq: 一般和 `sort` 一块用， 只能去重相邻的行
- diff: 比较文件， 类似的还有 `comm` (输出3列， 分别是: 只在文件1， 只在文件2 和两个文件都在的行)
- paste: 两个文件按列拼接
- od: 以16/8/2进制查看文件
- wc: 统计文件字节数/字数/行数

结合这些命令可能就能完成某些复杂的功能，举个例子，如线上的web 访问日志会记录 *请求时间,请求路径,参数* 等等。 现在需要统计 当天请求路径为 A， 排名前10的参数， 就可以 ` grep 路径A | cut 取出想要的数据列 | sort | uniq ` 之类的， 或者比如统计 http 404 请求最多的10个路径。再比如，随机生成3个长度为8包含字母数字的字符串(偶尔会用到， 比如各种生产 secret key 的时候)， 直接用如下命令即可

```
➜  _includes git:(source) ✗ cat /dev/urandom | sed 's/[^a-zA-Z0-9]//g' | head -n 3 | cut -c 1-8
MaL6nEmZ
00m2Ub19
rsc4AOQm
```

在比如这篇文章就通过 shell 实战了一下，[	
"大数据"分析首批北京积分落户同学](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=100000193&idx=1&sn=a32c95fdb85e578a25603347b32ed8a0&chksm=6b4700255c308933cb1de9e1f6b311e0d90295b551789f26c44332cc5b76fc230b2af378716a#rd)用常见的 shell 命令做一些统计功能。

其他的可能较少用，但一旦用，能省不少时间。网上也有一些 online 的工具，但哪有这个快准狠。

- openssl sha1/aes-256-ecb/des/base64 等等: 比如当前我们开发用的 MVC 框架play framework用来加密 session 的算法， 可以方便算出 encoded 的 sessionid 进行 debug。
- md5/base64: 常见的 md5， base64 编码
- sips: `scriptable image processing system` 比如批量处理图片大小， 压缩等等

---

全文完，关于 Mac 使用技巧和工具软件推荐，一共如下3篇文章: 

- [Mac 软件推荐(序)](http://www.tanglei.name/blog/app-in-mac-preface.html)
- [Mac 软件推荐续 -- 大众篇](http://www.tanglei.name/blog/app-in-mac-for-common.html)
- [Mac 软件推荐续 -- 程序猿篇](http://www.tanglei.name/blog/app-in-mac-for-dev.html)

如果你觉得这文章对你有那么一点点收获，请不要犹豫扫描下面二维码关注我的公众号，如果你再能帮忙转发一下就更好了。么么哒。