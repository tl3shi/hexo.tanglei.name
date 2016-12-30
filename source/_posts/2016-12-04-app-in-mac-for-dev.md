---
title: Mac 软件推荐(续)之程序猿篇
layout: post
categories: 
  - 经验技巧
tags: 
  - 经验技巧
  - 工具
  - Mac
  - 程序员
---

在前面一篇文章["Mac 软件推荐续(!程序猿篇)"](http://www.tanglei.name/blog/app-in-mac-for-common.html) (文章取名装X失败, 悲伤)中, 我已经介绍了一些大众化的软件, 当然作为程序猿的你也应该参考参考. 
本篇文章将介绍一些可以提高程序猿工作效率的一些软件和工具及相关配置. 

## Mac built-in

首先介绍的就是我觉得应该熟悉 Mac 内置的一些软件及配置. 

### trackpad 配置

1. **启用 Tap to click**: 在 `System Preferences -> Trackpad ` 中启用, 用 **tap** 替换 **click** 的操作, 明明轻轻 **tap** 就可以完成的, 为何还要用力点击才 OK. 现在偶尔用其他人电脑非得用力 click 就太纠结了.
同时, 还有 "右键"功能, **Secondary click**, 用两个手指 tap 弹出右键菜单. 
![mac trackpad 设置](/resources/app-in-mac/mac-os-trackpad.png)

2. **开启单词选词查询**:
选中某个中英文单词后, 三指 tab 会弹出词典释义. 这个在[之前一篇文章](http://www.tanglei.name/blog/app-in-mac-preface.html)中也有介绍. 

3. **Scroll 方向**: 这个道是自己习惯就好. 由于我刚开始从 Win 转向 Mac 的时候习惯用 Win 的那种方式, 于是就没有开启 *Scroll direction: natural*, 然后也一直沿用至今. 

4. **其他手势**: 有必要熟悉一下, 比如知道在 Win 环境下用 `win+d` 可以显示桌面, 相应的功能在 Mac 下如何做. 

### 快捷键

作为程序猿, 肯定离不开各种快捷键. 对于 Mac 内置的一些快捷键, 我们还是很有必要知道的.  基本的复制/粘贴就不说了, 常用的还有

```
空格键: 预览
cmd + ,: 设置
cmd + -/=: 缩小/放大
ctrl + u: 删除到行首(与zsh冲突, zsh中是删除整行)
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
ctrl + r: bck-i-search/reverse-i-search, 输入关键字搜索历史命令
```

上面的这些快捷键特别是在敲命令时还是很有用的(可能有的确实是在命令行中才生效), 特别是结合 zsh 自动补全等功能. 比较 DT 的是就是 `esc` 一起用的时候, 不能连续使用. 举个例子, terminal 中输入了 `git push origin source`, 光标在末尾, 这时按住`ctrl` 不放, 按一下 `w` 即向前删除一个单词, 第一次按 `w` 删除 *source*, 再按 `w` 删除 *origin*. 而 `esc + d` 不能这样结合使用(如下 gif连续按就不 work), `esc` 必须中途释放再按才能 work. 

![bash自动补全](/resources/app-in-mac/builtin-quick-key-git-push.gif)

啥? 你说上面快捷键 `ctrl + w` 等不太好按? 按键特别别扭? 
你需要做的就是将 `caps lock` 映射为 `ctrl`, `Keyboard -> Modifier Keys `修改, 目前我笔记本上的 `ctrl` 键无效. 不过, 一般情况下我用我的 HHKB, 这种映射方式正好符合 HHKB 的布局. (其实我是在买 HHKB 之前就修改的这个映射)

另外, 借助之前介绍的**Karabiner**, 可以将一些常用的方向键(上下左右)重新映射一下, 比如我目前是 `s + h/j/k/l` 来表示方向, 手不用太移动就能直接按方向(HHKB 本身按方向太麻烦, Mac 内置键盘有方向键还需要大幅度移动手), 用起来方便多了. 

Mac 内置的更多的快捷键列表可以参考 [Mac 官网](https://support.apple.com/zh-cn/HT201236)

其他还有一些常用的软件的快捷键, 可以用之前介绍的软件 cheetsheet, 长按 **cmd**, 可弹出当前 active 的软件的快捷键.

### 截图

这个从快捷键中单独列出来了, 就强调下这个功能. 

`cmd + shift + 3` 截取整个屏幕. 
`cmd + shift + 4` 部分窗口, 出现十字供选取, 若此时按**空格键**(这个技能得点赞), 会选取当前应用的窗口, 再 **tap** 即可完成截图. 

上面快捷键是截图后以文件形式保存在桌面(默认是桌面, 当然你也可以自己修改保存位置), 再上面快捷键基础上再同时按 `ctrl` 就会把图片保存在内存/剪贴板中, 直接去相应窗口粘贴即可.


## home brew

类似 centos 的 **yum**, ubuntu 的 **apt-get**, 能够方便管理安装软件包. 
Mac 上类似的应用还有**port**, 我刚开始试用过 port, 貌似 brew 上的源会多一些. 
brew-cask 是 brew 的一个加强版, 可以安装一些桌面应用, 例如 chrome 等等之类的. 

这里就不多介绍了, 详情可以到官网查看. 
[brew](http://brew.sh/)
[brew-cask](https://caskroom.github.io/)

## iTerm2 

[iTerm2官网](http://www.iterm2.com/features.html)有介绍功能. 以下是觉得可能常用的功能. 

1. **分屏功能**
	- `cmd + d` 竖着分屏, `cmd + shift + d` 横着分屏
	- `cmd + t` 新建一个 tab, `cmd + num` 切换到第 num 个 tab
	- 当前窗口含有分屏时, 通过 `cmd + [` 和 `cmd + ]` 来进行切换小的分屏

2. **热键** 设置一个热键, 比如我的是 `alt + 空格`, 弹出 iTerm2, 且以半透明的方式显示在当前 active 的窗口上面.
![iTerm2 hotkey](/resources/app-in-mac/iterm2-hotkey.png)

3. 搜索
	- `cmd + f`搜索输入关键字后, 匹配的会黄色高亮, 此时按 `tab` 或者 `shift + tab` 会自动向后/前以word 的方式选中高亮的, 并自动 copy 到剪切板.
	- `cmd + alt + e`, 在所有的 tab 中全局搜索, 搜索出候选项后, 再选着你想要进入的 tab. 
	
![iTerm2 search](/resources/app-in-mac/iterm2-search-all.png)

4. 其他
	- 新版本的 iTerm2 还支持直接在控制台里 ls 图片文件(图片显示在控制台里).(如上图下半部分, 连 gif 都支持)
	- 自动识别控制台里的内容, 如含有链接或者本地文件路径可以用 `cmd` 加点击的方式直接打开链接或者文件(如下图上半部分). 这个功能很重要呢, 比如在编译过程中, 出现了 warning 或者 error, 一般会打印出具体文件路径, 此时直接从控制台就能打开文件进行 fix 了. 
	- 自动补全, iTerm2 本身是支持自动补全的(`cmd + ;`), 不过建议直接结合后面的zsh使用. `cmd + shift + h` 剪贴板历史(下图最后一行).
	- 一些高级的功能目前可能处于测试版本, 你若用的稳定版是不支持的, 需要到官网下测试版. 还有更多的功能请到 iTerm2 官网探索吧. 

![iTerm2 imgcat](/resources/app-in-mac/iterm2-imgcat-show-history.png)

## zsh

这个墙裂推荐啊. 结合 [oh my zsh](http://ohmyz.sh/), 丰富的[插件资源](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview). 

语法高亮, 自动补全等特别好, 在此推荐的几个插件或功能.

1. **git**: 当前目录若是在一个 git repo 下面的话, 会自动显示当前的分支信息等等. 然后可以自己搞一些 alias, 简写命令, 比如我常用的一些. 

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

2. **autojump**: 这个也炒鸡赞. 会自动记录你 `cd` 过的目录, 下次你直接 `j keyword` 就会自动 `cd` 到以 *keyword* 匹配的目录. 输入 `d` 会展示当前会话访问过的目录, 然后对应目录有标号, 接下来按标号即可跳转.

3. **osx**: 举个最简单的例子, 比如你现在正在 finder 中浏览一个很深的目录, 现在突然想 cd 到这个目录去做一些命令操作. 如果你用xtrafinder 这样的软件的话道有这样的功能, 如果配上这个插件, 你直接输入 `cdf` (cd finder)就自动 `cd` 到 finder 打开的目录下. 

4. **zsh-autosuggestions**, 如下图所示, 我在 *app-in-mac* 这个目录下, 刚输入了 `git`, 此时光标还在 `p` 前面, zsh 就已经自动给我补全了 `git push origin source`, 此时我只要按 `ctrl + e` 跳转到行尾(所以熟悉上文中的快捷键很有必要啊), 回车即可执行命令了. 

![iTerm2 zsh plugins](/resources/app-in-mac/zsh-plugins.png) 

更多的, 还是请到官网查看. 

## sublime text

文本编辑器, 也有丰富的插件支持, 直接[官网](http://www.sublimetext.com/)看吧. 这个 App, 我用得也不是很多. 

这里分享一个小的功能, 怎么在命令行用 sublime 打开特定的文件. 其实就是添加一个软链即可. (直接 `open filename` 会以文件默认关键的软件打开)

```bash
➜  app-in-mac git:(source) ✗ subl dungeon-game.cpp
➜  app-in-mac git:(source) ✗ which subl
/usr/local/bin/subl
➜  app-in-mac git:(source) ✗ ls -la /usr/local/bin/subl
lrwxr-xr-x  1 tanglei  admin  62  1 24  2016 /usr/local/bin/subl -> /Applications/Sublime Text.app/Contents/SharedSupport/bin/subl
```

## Vim 

介绍 Vim 的文章也很多了. 这里就不详细展开了. 分享下我用的部分插件. (最近被 IntelliJ IDEA 搞得恶心了, 准备尝试抛弃), 
为了让多台电脑同步我的 vim 配置/插件等, 我直接放 github 了([ref vimconfigs](https://github.com/tl3shi/vimconfigs.git)), 不同电脑只需要再建一个软链到github 中的 vimrc 即可.

![vim 自动补全](/resources/app-in-mac/vim-autocomplete.png)

- Vundle/Pathogen: 插件管理, 我用的Pathogen, 直接将下面 github repo clone 到 `~/.vim/bundle/` 目录下即可
- NERDTree: 文件目录树[nerdtree github src](https://github.com/scrooloose/nerdtree.git)
- YouCompleteMe: [YouCompleteMe github src](https://github.com/Valloric/YouCompleteMe) 自动补全, 对C系列, 结合其他的可支持 Java/Python/Js 等,  跪求 Scala 支持
- ctrlp.vim: [快速搜索文件](https://github.com/ctrlpvim/ctrlp.vim)
- minibufexpl.vim: 会把最近打开的文件列出来方便跳转, [github src](https://github.com/fholgado/minibufexpl.vim.git)
- conque-term: shell 跑在 vim 里面, [github src](https://github.com/tl3shi/conque-term.git)
- ag: 代码搜索, 可结合 ctrlp.vim, 如果后者搜索太慢的话, [github src](https://github.com/rking/ag.vim.git)
- tagbar/taglist: 标签, 能显示类结构信息等, [tagbar github src](https://github.com/majutsushi/tagbar.git)
- vim-surround:  处理诸如`(), "", []` 等配对信息, [github src](https://github.com/tpope/vim-surround.git), [ref](http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/)
- vim-easymotion: 快速跳转, 关键字后会给匹配到的标记, 再选标记并跳转(类似后文介绍 Chrome 插件的Vimium中的链接标记并跳转功能:按键 `f` 会将本文所有链接突出显示并用字母标记, 然后按相应的字母则会新开标签页打开). [github src](https://github.com/easymotion/vim-easymotion.git), [ref](http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html)
- vim-powerline: 增强状态栏 [github src](https://github.com/Lokaltog/vim-powerline.git)
- vim-indent-guides: 缩进可视化, [github src](https://github.com/nathanaelkane/vim-indent-guides)

具体效果等配置方法可以参考下面的两篇文章, 插件具体用法可阅读具体插件的 doc. 

Reference 

- [将你的Vim 打造成轻巧强大的IDE](http://yuez.me/jiang-ni-de-vim-da-zao-cheng-qing-qiao-qiang-da-de-ide/)
- [所需即所获：像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide)

## Dash 

其实介绍[前文](http://www.tanglei.name/blog/app-in-mac-preface.html) 介绍 Alfred 已经提到过, 这里再介绍一下. 程序猿应该必备啊. 内置各种语言, 各种环境的各种文档. 该 App 还提供各种 API 供其他工具交互使用. 例如 Vim(不是想象当中自动补全功能, 只是能够快捷地搜索 API), Sublime 等.  (p.s 要是有人写了一个 Vim 插件, 能够支持调用 dash 的 API(如果有的话) 自动补全代码, 那应该会很受欢迎的)

![dash](/resources/app-in-mac/dash-main.png)


## 其他App

### chrome 

插件

- AdBlock: 广告屏蔽;
- EditThisCookie: 修改 cookie;
- Evernote Web Clipper: 印象笔记;
- JSONView and JSONLint for Google Chrome™: 请求返回的json进行beautify方便查看;
- Markdown Here: 在富文本输入markdown, 渲染成 html;
- Markdown Preview Plus: 渲染 **.md** 文件, 相当于 preview markdown;
- Open Screenshot: 网页截图, 能够自动下拉截长图;
- Postman: 请求伪造/抓包等, 也可以用`curl`;
- Proxy SwitchySharp: proxy 切换;
- RescueTime: [前文有介绍的RescueTime](www.tanglei.name/blog/app-in-mac-for-common.html);
- undirect: google/baidu 搜索结果, 点击直达网站, 这个貌似不太好用了. 征求替代品; 
- Vimium: 操作 vim 一样操作浏览器, 移动查找等功能, 还有前文提到的快速标记链接并跳转;

### Charles

类 Windows 下 Fiddler 抓包应用. 

相关命令 `tcpdump`

## 其他有用的命令行

一些好用的命令(基本的什么`ls/cd/cp/rm`之类的这里就直接忽略了), 我觉得作为程序猿还是应该了解, 至少只当某个场景下直接用相应的命令就能解决. 具体参数可以再 `--help` 或者 `man commond`  再看.

- screen: 特别是 ssh 到登录远程时用以管理会话
- curl: 网络请求, 相关的还有 `traceroute, dig` 等
- find: 文件查找
- grep/zgrep/zcat: 查看日志的时候用
- awk: 这个本身就很强大了, 具体编程语法不用太掌握但可以了解一些基本的用法, 比如之前用到过给一个log文件, 能够取里面的参数拼接update 的sql(文件里有相应 update 的值和 where 条件值)
- sed: 文本替换, 还有 `tr`, 注意 sed 的语法 Mac 和 一般 Linux 还有些不一样( 比如原文替换的时候 mac 里需要用参数 `-i ""`), 比如之前[迁移 wordpress 到 jekyll](/blog/give-up-wordpress-to-jekyll.html) 上的时候需要将一些链接整体替换成新的路径.
- cut: 按列取数据, `awk` 也可以
- sort: 这个就不多说了
- uniq: 一般和 `sort` 一块用, 只能去重相邻的行
- diff: 比较文件, 类似的还有 `comm` (输出3列, 分别是: 只在文件1, 只在文件2 和两个文件都在的行)
- paste: 两个文件按列拼接
- od: 以16/8/2进制查看文件
- wc: 统计文件字节数/字数/行数

结合这些命令可能就能完成某些复杂的功能, 举个例子, 如线上的web 访问日志会记录 *请求时间, 请求路径, 参数* 等等. 现在需要统计 当天请求路径为 A, 排名前10的参数, 就可以 ` grep 路径A | cut 取出想要的数据列 | sort | uniq ` 之类的, 或者比如统计http 404 请求最多的10个路径. 再比如, 随机生成3个长度为8包含字母数字的字符串(偶尔会用到, 比如各种生产 secret key 的时候),  直接用如下命令即可

```
➜  _includes git:(source) ✗ cat /dev/urandom | sed 's/[^a-zA-Z0-9]//g' | head -n 3 | cut -c 1-8
MaL6nEmZ
00m2Ub19
rsc4AOQm
```

其他的可能较少用, 但一旦用, 能省不少时间. 网上也有一些 online 的工具, 但哪有这个快准狠.

- openssl sha1/aes-256-ecb/des/base64 等等: 比如当前我们开发用的 MVC 框架play framework用来加密 session 的算法, 可以方便算出 encoded 的 sessionid 进行 debug.
- md5/base64: 常见的 md5, base64 编码
- sips: `scriptable image processing system` 比如批量处理图片大小, 压缩等等

---

全文完, 关于 Mac 使用技巧和工具软件推荐, 一共如下3篇文章: 

- [Mac 软件推荐(序)](http://www.tanglei.name/blog/app-in-mac-preface.html)
- [Mac 软件推荐续 -- 大众篇](http://www.tanglei.name/blog/app-in-mac-for-common.html)
- [Mac 软件推荐续 -- 程序猿篇](http://www.tanglei.name/blog/app-in-mac-for-dev.html)

p.s 如果你觉得这文章对你有那么一点点收获, 请不要犹豫扫描下面二维码关注我的公众号, 如果你再能帮忙转发一下就更好了. 么么哒.

![tanglei 微信号](/resources/wechat-tangleithu.jpg)
