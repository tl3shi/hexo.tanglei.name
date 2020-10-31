---
title: 程序员如何利用工具提升自己的工作效率？
layout: post
categories:
  - 经验技巧
tags:
  - 程序员
  - 开发效率
  - Shell
  - Mac
  - Linux
---

> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。欢迎关注，交流和指导！
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247487786&idx=1&sn=842202cc524477ec1546b4747bdbf1a8&chksm=eb4710cedc3099d86953451729c7f569866e6e58abbbec5c7ebe7423d12e1f11e189bb417f80&token=553253061&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

本文是 “工欲善其事，必先利其器” 系列的第三篇。
没有看过前面推送的，推荐大家前去看看了解下。

- [工欲善其事，必先利其器 -- Mac 软件推荐（序）](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485871&idx=1&sn=c877775df684d8ab8c90bf2d38eee98a&chksm=eb47084bdc30815d19182c51571b096a20b79bdee0956f68167ebc8ed3117364ac0602f83658&token=551126633&lang=zh_CN#rd)
- [有了这几个神器，瞬间逼格就上去了](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&token=551126633&lang=zh_CN#rd)

本篇文章将重点介绍一些可以提高程序猿工作效率的一些软件和工具及相关配置（主要还是针对 Mac）。

## Mac built-in

首先介绍的就是我觉得应该熟悉 Mac 内置的一些软件及配置。 

### trackpad 配置

1. **启用 Tap to click**: 在 `System Preferences -> Trackpad` 中启用， 用 **tap** 替换 **click** 的操作，明明轻轻 **tap** 就可以完成的， 为何还要用力点击才 OK。 现在偶尔用其他人电脑非得用力 click 就太纠结了。
  同时，还有 "右键"功能， **Secondary click**， 用两个手指 tap 弹出右键菜单。 

  ![mac trackpad 设置](/resources/how-to-calculate-apr/mac-os-trackpad.png)

2. **开启单词选词查询**:
  选中某个中英文单词后，三指 tab 会弹出词典释义。 这个在石头哥[之前的这篇文章](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485871&idx=1&sn=c877775df684d8ab8c90bf2d38eee98a&chksm=eb47084bdc30815d19182c51571b096a20b79bdee0956f68167ebc8ed3117364ac0602f83658&token=551126633&lang=zh_CN#rd)中也有介绍。 

![开启单词选词查询](/resources/how-to-calculate-apr/mac-translate-trackpad.png)

3. **Scroll 方向**: 这个自己用习惯了就好。由于我刚开始从 Win 转向 Mac 的时候习惯用 Win 的那种方式，于是就没有开启 `Scroll direction: natural`， 然后也一直沿用至今。 

4. **其他手势**: 有必要熟悉一下，比如知道在 Win 环境下用 `win+d` 可以显示桌面，相应的功能在 Mac 下如何做。 

### 快捷键

作为程序猿，肯定离不开各种快捷键。对于 Mac 内置的一些快捷键，我们还是很有必要知道的。基本的复制/粘贴就不说了，常用的还有:

```bash
空格键: 预览
cmd + , : 设置
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
ctrl + r: bck-i-search/reverse-i-search，输入关键字搜索历史命令
```

上面的这些快捷键特别是在敲命令时还是很有用的(可能有的确实是在命令行中才生效)，特别是结合 zsh 自动补全等功能。

比较 DT 的是就是 `esc` 一起用的时候，不能连续使用。 举个例子，Terminal 中输入了 `git push origin source`，光标在末尾，这时按住`ctrl` 不放， 按一下 `w` 即向前删除一个单词，第一次按 `w` 删除 `source`，再按 `w` 删除 `origin`。 而 `esc + d` 不能这样结合使用(如下 gif 连续按就不 work)，`esc` 必须中途释放再按才能 work。不知道是不是石头使用的姿势不对，有知道的朋友，还帮忙指出一下啊。😁

![bash自动补全](/resources/how-to-calculate-apr/builtin-quick-key-git-push.gif)

啥？你说上面快捷键 `ctrl + w` 等不太好按？按键特别别扭？

你需要做的就是将 `caps lock` 映射为 `ctrl`， `Keyboard -> Modifier Keys`修改，目前我笔记本上的 `ctrl` 键无效。 不过，一般情况下我用我的 HHKB，这种映射方式正好符合 HHKB 的布局。其实石头是在买 HHKB 之前就修改的这个映射，所以切换自如。

另外，借助[之前介绍的Karabiner](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&token=551126633&lang=zh_CN#rd)，可以将一些常用的方向键(上下左右)重新映射一下， 比如我目前是 `s + h/j/k/l` 来表示方向，手不用太移动就能直接按方向(HHKB 本身按方向太麻烦， Mac 内置键盘有方向键还需要大幅度移动手)，用起来方便多了。 

Mac 内置的更多的快捷键列表可以参考 [Mac 官网](https://support.apple.com/zh-cn/HT201236 "Mac 官网")

其他还有一些常用的软件的快捷键，可以用之前介绍的[软件 cheetsheet](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&token=551126633&lang=zh_CN#rd)，长按 **cmd**， 可弹出当前 active 的软件的快捷键。

### 截图

这个从快捷键中单独列出来了，就强调下这个功能。 

`cmd + shift + 3` 截取整个屏幕。 
`cmd + shift + 4` 部分窗口，出现十字供选取，若此时按**空格键**(这个技能得点赞)，会选取当前应用的窗口，再 **tap** 即可完成截图。 

上面快捷键是截图后以文件形式保存在桌面(默认是桌面，当然你也可以自己修改保存位置)， 在上面快捷键基础上再同时按 `ctrl` 就会把图片保存在内存/剪贴板中，直接去相应窗口粘贴即可。

## home brew

类似 Centos 的 **yum**， Ubuntu 的 **apt-get**，能够方便管理安装软件包。 
Mac 上类似的应用还有**port**， 我刚开始试用过 port，貌似 brew 上的源会多一些。 

brew-cask 是 brew 的一个加强版，可以安装一些桌面应用，例如 Chrome 等等之类。 

这里就不多介绍了，详情可以到官网查看:

- [brew](http://brew.sh/ "brew")
- [brew-cask](https://caskroom.github.io/ "brew-cask")

## iTerm2 

[iTerm2官网](http://www.iterm2.com/features.html "iTerm2官网")有介绍功能。以下是觉得可能常用的功能。 

1. **分屏功能**
	- `cmd + d` 竖着分屏， `cmd + shift + d` 横着分屏
	- `cmd + t` 新建一个 tab，`cmd + num` 切换到第 num 个 tab
	- 当前窗口含有分屏时， 通过 `cmd + [` 和 `cmd + ]` 来进行切换小的分屏

2. **热键** 设置一个热键，比如我的是 `alt + 空格`， 弹出 iTerm2， 且以半透明的方式显示在当前 active 的窗口上面。

![iTerm2 hotkey](/resources/how-to-calculate-apr/iterm2-hotkey.png)

3. 搜索
	- `cmd + f`搜索输入关键字后，匹配的会黄色高亮，此时按 `tab` 或者 `shift + tab` 会自动向后/前以 word 的方式选中高亮的，并自动 copy 到剪切板。
	- `cmd + alt + e`，在所有的 tab 中全局搜索，搜索出候选项后，再选择你想要进入的 tab。
	

![](/resources/how-to-calculate-apr/iterm2-search-all.png)

4. 密码

这个功能可能会常用，程序猿得经常登录到远程服务器吧，密码又记不住。可以把常用密码保存起来，需要输入密码的时候，用快捷键 `Option + cmd + f` 弹出密码管理器，选择一个自动输入即可。

![密码管理](/resources/how-to-calculate-apr/iterm2-password-manager.png)

5. 其他
	- 新版本的 iTerm2 还支持直接在控制台里 ls 图片文件(图片显示在控制台里)。(如上图下半部分，连 gif 都支持)
	- 自动识别控制台里的内容，如含有链接或者本地文件路径可以用 `cmd` 加点击的方式直接打开链接或者文件(如下图上半部分)。 这个功能很重要呢，比如在编译过程中，出现了 warning 或者 error，一般会打印出具体文件路径，此时直接从控制台就能打开文件进行 fix 了。 
	- 自动补全，iTerm2 本身是支持自动补全的(`cmd + ;`)，不过建议直接结合后面的zsh 使用。`cmd + shift + h` 剪贴板历史(下图最后一行)。
	- 一些高级的功能目前可能处于测试版本，你若用的稳定版是不支持的，需要到官网下测试版。还有更多的功能请到 iTerm2 官网探索吧。 

![iTerm2 imgcat](/resources/how-to-calculate-apr/iterm2-imgcat.png)

## zsh

这个墙裂推荐啊。结合 [oh my zsh](http://ohmyz.sh/ "oh my zsh")，丰富的[插件资源(zsh)](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview "插件资源(zsh "插件资源(zsh)")。 

语法高亮，自动补全等特别好，在此推荐的几个插件或功能。

1. **git**: 当前目录若是在一个 git repo 下面的话，会自动显示当前的分支信息等等。然后可以自己搞一些 alias，简写命令，比如石头常用的一些： 

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

2. **autojump**: 这个也炒鸡赞。会自动记录你 `cd` 过的目录，下次你直接 `j keyword` 就会自动 `cd` 到以 *keyword* 匹配的目录。输入 `d` 会展示当前会话访问过的目录，然后对应目录有标号，接下来按标号即可跳转。

3. **osx**: 举个最简单的例子，比如你现在正在 finder 中浏览一个很深的目录，现在突然想 cd 到这个目录去做一些命令操作。如果你用 Xtrafinder 这样的软件的话道有这样的功能，如果配上这个插件，你直接输入 `cdf` (cd finder)就自动 `cd` 到 finder 打开的目录下。 

4. **zsh-autosuggestions**，如下图所示，我在 *app-in-mac* 这个目录下，刚输入了 `git`， 此时光标还在 `p` 前面， zsh 就已经自动给我补全了 `git push origin source`， 此时我只要按 `ctrl + e` 跳转到行尾(所以熟悉上文中的快捷键很有必要啊)，回车即可执行命令了。 

![iTerm2 zsh plugins](/resources/how-to-calculate-apr/zsh-plugins.png)

更多的还是请到官网查看。

## sublime text

文本编辑器，也有丰富的插件支持，直接到[sublime官网](http://www.sublimetext.com/ "sublime官网")看吧。这个 App，我用得也不是很多。 

这里分享一个小的功能，怎么在命令行用 sublime 打开特定的文件。其实就是添加一个软链即可。 (直接 `open filename` 会以文件默认关键的软件打开)

```bash
➜  app-in-mac git:(source) ✗ subl dungeon-game.cpp
➜  app-in-mac git:(source) ✗ which subl
/usr/local/bin/subl
➜  app-in-mac git:(source) ✗ ls -la /usr/local/bin/subl
lrwxr-xr-x  1 tanglei  admin  62  1 24  2016 /usr/local/bin/subl -> /Applications/Sublime Text.app/Contents/SharedSupport/bin/subl
```

## Vim 

介绍 Vim 的文章也很多了，这里就不详细展开了。分享下石头用的部分插件。
为了让多台电脑同步我的 vim 配置/插件等，我直接放 github 了([ref vimconfigs](https://github.com/tl3shi/vimconfigs.git "ref vimconfigs"))，不同电脑只需要再建一个软链到github 中的 vimrc 即可。

![vim 自动补全](/resources/how-to-calculate-apr/vim-autocomplete.png)

- Vundle/Pathogen: 插件管理，我用的Pathogen，直接将下面 github repo clone 到 `~/.vim/bundle/` 目录下即可。
- NERDTree: 文件目录树 [NERDTree](https://github.com/scrooloose/nerdtree.git "NERDTree")
- YouCompleteMe: [YouCompleteMe](https://github.com/Valloric/YouCompleteMe "YouCompleteMe") 自动补全，对C系列，结合其他的可支持 Java/Python/Js 等，  跪求 Scala 支持
- ctrlp.vim: [快速搜索文件 ctrlp](https://github.com/ctrlpvim/ctrlp.vim "快速搜索文件 ctrlp")
- minibufexpl.vim: 会把最近打开的文件列出来方便跳转，[minibufexpl.vim github src](https://github.com/fholgado/minibufexpl.vim.git "minibufexpl.vim github src")
- conque-term: shell 跑在 vim 里面， [conque-term github src](https://github.com/tl3shi/conque-term.git "conque-term github src")
- ag: 代码搜索， 可结合 ctrlp.vim，如果后者搜索太慢的话， [ag github src](https://github.com/rking/ag.vim.git "ag github src")
- tagbar/taglist: 标签，能显示类结构信息等，[tagbar github src](https://github.com/majutsushi/tagbar.git "tagbar github src")
- vim-surround:  处理诸如 `()， ""， []` 等配对信息，[vim-surround github src](https://github.com/tpope/vim-surround.git] 等配对信息，[vim-surroundgithub src" "]` 等配对信息，[vim-surround github src")， [vim-surround ref](http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/ "vim-surround ref")
- vim-easymotion: 快速跳转，关键字后会给匹配到的标记，再选标记并跳转(类似后文介绍 Chrome 插件的Vimium中的链接标记并跳转功能，按键 `f` 会将本文所有链接突出显示并用字母标记，然后按相应的字母则会新开标签页打开)。 [vim-easymotion github src](https://github.com/easymotion/vim-easymotion.git "vim-easymotion github src")， [vim-easymotion ref](http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html "vim-easymotion ref")
- vim-powerline: 增强状态栏 [vim-powerline github src](https://github.com/Lokaltog/vim-powerline.git "vim-powerline github src")
- vim-indent-guides: 缩进可视化，[vim-indent-guides github src](https://github.com/nathanaelkane/vim-indent-guides "vim-indent-guides github src")

具体效果等配置方法可以参考下面的两篇文章，插件具体用法可阅读具体插件的 doc。 

Reference 

- [将你的 Vim 打造成轻巧强大的IDE](http://yuez.me/jiang-ni-de-vim-da-zao-cheng-qing-qiao-qiang-da-de-ide/ "将你的 Vim 打造成轻巧强大的IDE")
- [所需即所获：像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide "所需即所获：像 IDE 一样使用 vim")

## Dash 

其实介绍[前文](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485871&idx=1&sn=c877775df684d8ab8c90bf2d38eee98a&chksm=eb47084bdc30815d19182c51571b096a20b79bdee0956f68167ebc8ed3117364ac0602f83658&token=551126633&lang=zh_CN#rd) 介绍 Alfred 已经提到过，这里再介绍一下，程序猿必备神器。 

内置各种语言，各种环境的各种文档。该 App 还提供各种 API 供其他工具交互使用。例如 Vim(不是想象当中自动补全功能，只是能够快捷地搜索 API)， Sublime 等。  (p.s 要是有人写了一个 Vim 插件，能够支持调用 dash 的 API(如果有的话) 自动补全代码， 那应该会很受欢迎的)

![dash 搜索 API](/resources/how-to-calculate-apr/dash.png)

![](/resources/how-to-calculate-apr/dash-main.png)


## 其他App

### chrome 

插件

- AdBlock: 广告屏蔽;
- EditThisCookie: 修改 cookie;
- Evernote Web Clipper: 印象笔记;
- JSONView and JSONLint for Google Chrome™: 请求返回的json进行beautify方便查看;
- Markdown Here: 在富文本输入markdown， 渲染成 html;
- Markdown Preview Plus: 渲染 **.md** 文件，相当于 preview markdown;
- Open Screenshot: 网页截图，能够自动下拉截长图;
- Postman: 请求伪造/抓包等，也可以用`curl`;
- Proxy SwitchySharp: proxy 切换;
- RescueTime: [前文有介绍的RescueTime](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&token=551126633&lang=zh_CN#rd);
- undirect: google/baidu 搜索结果，点击直达网站，这个貌似不太好用了。征求替代品; 
- Vimium: 操作 vim 一样操作浏览器，移动查找等功能，还有前文提到的快速标记链接并跳转;

### Charles

类 Windows 下 Fiddler 抓包应用。 

相关命令 `tcpdump`

## 其他有用的命令行

一些好用的命令(基本的什么`ls/cd/cp/rm`之类的这里就直接忽略了)，我觉得作为程序猿还是应该了解，至少只当某个场景下直接用相应的命令就能解决。 具体参数可以再 `--help` 或者 `man commond`  再看。

- screen: 特别是 ssh 到登录远程时用以管理会话
- curl: 网络请求， 相关的还有 `traceroute, dig` 等
- find: 文件查找
- grep/zgrep/zcat: 查看日志的时候用
- awk: 这个本身就很强大了，具体编程语法不用太掌握但可以了解一些基本的用法，帮助你拼接一些语句。比如石头常用来批量拼接一些 SQL 语句。
- sed: 文本替换，还有 `tr`，注意 sed 的语法 Mac 和 一般 Linux 还有些不一样( 比如原文替换的时候 mac 里需要用参数 `-i ""`)， 比如之前[石头迁移 wordpress 到 jekyll](https://www.tanglei.name/blog/give-up-wordpress-to-jekyll.html "石头迁移 wordpress 到 jekyll") 上的时候需要将一些链接整体替换成新的路径。
- cut: 按列取数据，`awk` 也可以
- sort: 这个就不多说了
- uniq: 一般和 `sort` 一块用，只能去重相邻的行
- diff: 比较文件，类似的还有 `comm` (输出3列，分别是: 只在文件1， 只在文件2 和两个文件都在的行)
- paste: 两个文件按列拼接
- od: 以16/8/2进制查看文件
- wc: 统计文件字节数/字数/行数

结合这些命令可能就能完成某些复杂的功能，举个例子：

如线上的web 访问日志会记录 *请求时间，请求路径，参数* 等等。 现在需要统计当天请求路径为 A，排名前10的参数，就可以 ` grep 路径A | cut 取出想要的数据列 | sort | uniq ` 之类的。

或者比如统计 http 404 请求最多的10个路径。 再比如，随机生成3个长度为8包含字母数字的字符串(偶尔会用到，比如各种生产 secret key 的时候)，直接用如下命令即可

```
➜  _includes git:(source) ✗ cat /dev/urandom | sed 's/[^a-zA-Z0-9]//g' | head -n 3 | cut -c 1-8
MaL6nEmZ
00m2Ub19
rsc4AOQm
```

石头之前写过一篇综合应用，就是用 shell 脚本来完成一些统计功能。文章在这里["大数据"分析首批北京积分落户同学](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247483842&idx=1&sn=d13fbc26e1492a42e1674b638615f29b&chksm=eb470026dc308930d17294fd2329a0d2d770bf88b88ae8518181b61747f4c90a4daaabc076a2&token=551126633&lang=zh_CN#rd)，文中介绍了如何根据一个 json 文件如何快速统计取得户口名额最多的top10公司，获取取得户口名额的人中姓氏最多的等等。

其他的可能较少用，但一旦用，能省不少时间。网上也有一些 online 的工具，但哪有这个快准狠。

- openssl sha1/aes-256-ecb/des/base64 等等: 比如经常要和其他服务联调，有验证签名等，就可以临时用 shell 写个脚本，验证一下看看 API 的返回值和效果。
- md5/base64: 常见的 md5，base64 编码。
- sips: `scriptable image processing system` 比如批量处理图片大小，压缩等等

## 后记

觉得本号分享的文章有价值，记得添加星标哦。周更很累，不要白 piao，需要来点正反馈，安排个 “一键三连”（点赞、在看、分享）如何？😝 这将是我持续输出优质文章的最强动力。

![来个一键三连](/resources/how-to-calculate-apr/3lian.gif)

> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。