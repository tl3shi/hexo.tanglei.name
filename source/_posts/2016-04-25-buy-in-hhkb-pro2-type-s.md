---
title: 入手传说中的 HHKB Pro2 Type-S 
layout: post
categories: 
  - MyLife
tags: 
  - MyLife
  - 快捷键
  - 经验技巧
---

今年生日给自己入手了一个生日礼物了, 那就是传说中的程序猿键盘 -- HHKB. 
之前室友买的HHKB Pro2 Type-S 有刻版本, 后来他又买了无刻的键帽, 于是我就直接买HHKB Pro2 Type-S无刻版本了, 日本亚马逊官网29800日元. 由于最近刚好有朋友去日本游玩, 然后刚好又有朋友在日本工作, 于是就是采用直接日亚购买寄给日本朋友A, 再让朋友B在日本玩耍时找朋友A人肉带回来即可. 由于恰逢跨境购物之类的海关税收改革, 担心被税, 所以直接让朋友拆掉包装, 扔了外壳直接将裸键盘带回来了. 其实后来看5000RMB以内貌似不必担心([实力辟谣：海关新政后出境游购物怎么办？](http://zhuanlan.zhihu.com/p/20738384)).

先上一张我现在桌面放的一张图片, Pro2 Type-S 白色有刻版, 为啥要放在桌面上, 因为我目前为止海记不熟无刻版的键位啊.

![HHKB Pro2 Type-S 白色有刻](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-type-s-with-print.png)

和我公司电脑MBPR的合影, 因为之前就把电脑的Caps Lock键映射成了 Ctrl了, 所以直接切换过来还比较顺手和省力. 然后发现这HHKB的键盘 USB接口在前面啊, 这个设计不太喜欢. 囧了, 都挡住屏幕了(见后, 可以另外买一个弯头解决). 另外再配一个trackpad又嫌太贵, 就直接放在原来的笔记本内置键盘上吧. 

![HHKB Pro2 Type-S 无刻 配 MacBook Pro Retina](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-type-s-on-mbpr.jpg)
再上一个侧面照. 
![HHKB Pro2 Type-S 无刻 配 MacBook Pro Retina](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-type-s-on-mbpr-right.jpg)


下面这张是回家后与自己的Air合影. 前面的USB接口还是碍眼. 
![HHKB Pro2 Type-S 配MacBook Air](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-type-s-on-mba.jpg)

这是印在键盘背部的开关说明. 可以根据自己的喜好来配置. 
![HHKB Pro2 Type-S 背面配置](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-type-s-back.jpg)

下面来硬货. 

### HHKB小技巧

其实这不仅仅是说HHKB的, 而更多的时一些在使用Mac的小技巧. 这里也一并分享一下(其实是不是应该将标题改为<b>"Mac软件推荐"</b>然后重新考虑新po一篇啊). 

#### 0. 下载HHKB驱动

先去pfu官网下一个驱动. 这个驱动解决了如 `{}[]:"` 等键位可能错乱, 跟相应有刻标的不一致, 我开始用的时候就发生了这种情况. [驱动下载地址](http://www.pfu.co.jp/hhkeyboard/macdownload.html)

#### 1. Mini-USB 弯头

上面的图片也能看到, 那个mini-usb头在前面, 直直的, 挺别扭的, 还容易挡住前面的屏幕. 因此如果要用MacBook自带的trackpad的话, 买一个Mini-USB的弯头时很有必要的. (这里参考了[ref](http://synckey.github.io/posts/2016/02/26/hhkb-settings-and-shortcut-keys.html#comment-2634817881))如下图:

![HHKB Pro2 Type-S 键盘mini-usb弯头](/resources/buy-in-hhkb-pro2-type-s/hhkb-pro2-mini-usb-connector.jpg)

#### 2. Karabiner

安装这个软件[Karabiner](https://pqrs.org/osx/karabiner/). 刚开始试图找一些shell脚本来启用禁用内置键盘切换外接键盘, github上有一个[HHKBAssistant_for_mac](https://github.com/tl3shi/HHKBAssistant_for_mac.git), 貌似不太好使用. 后来才了解到这个软件Karabinlar, 功能很强大. 我刚开始使用(目前版本10.18.0), 也仅仅启用了下面两个功能:

- 自动切换键盘. 当外接键盘插入时, 自动禁用内置笔记本键盘, 启用USB键盘; 取掉USB键盘, 自动启用内置键盘. 这个设置在 ``core settings -- Disable an internal keyboard while external keyboards are connected.``
- Vi Mode. HHKB键盘没有方向键, 需要集合Fn键才能按方向键(`Fn + [;'.`). 启用Vi Mode, 记这些比较麻烦, 启用Vi Mode 可以结合常用的`hjkl` 来表示方向, 另外将`Fn`用`s`替换, 按起来比较方便.  启用这个功能后, 还可以结合`s+Fn + (hjkl)`来表示 `Home, Page Down, Page Up, End` (这个我道没怎么用)
- 其他还有很多功能后面慢慢再来发现利用吧. 

#### 3. 常用快捷键 

Mac本身的一些常用的快捷键得记住, 跟Emacs的一些基本操作一致. 这个当然跟HHKB键盘没多大的关系, 这个键盘结合这些快捷键更好用嘛. 

    ctrl + p/n: 上/下个命令
    ctrl + b/f: 光标前/后char
    esc + b/f: 光标前/后word
    ctrl + a/e: 到行首/行尾
    ctrl + h/d: 删前/后字符
    ctrl + u: 删除到行首(zsh全删)
    ctrl + k: 删除到行尾
    ctrl + y: 粘贴
    ctrl + w: 删除前一个单词
    esc + d: 删后一个单词
    ctrl + _: undo

zsh中 bindkey 列出快捷键(其中`^[ = esc`)

#### 4. Oh My ZSH 

这里再推荐一个shell, 不用bash, 用zsh, 非常丰富的插件功能啊. 见官网 [Oh My ZSH](http://ohmyz.sh/). 比如命令行补全功能啊等, 比如下图所示, 你之前敲过一个命令 `git push origin source`, 你下次再敲时, 就有 autocomplete 功能, 此时光标还在`p`处, 后面已经帮你提示好了, 你只需要按前面提道的快捷键`Ctrl + E`跳转到行末即可. 

![ZSH 命令行自动提示autocomplete](/resources/buy-in-hhkb-pro2-type-s/zsh-shell-tip.png)

还有一些常用的插件比如:


  - git: 上图也所体现
  - zsh-autosuggestions: 自动提示[git](https://github.com/zsh-users/zsh-autosuggestions)
  - zsh-syntax-highlighting: 语法高亮
  - autojump: 会记住你的一些常用的历史记录位置, 并且带纠错功能(目录中一两个字符输错了也不要紧). 你常常需要比如 `cd ~/xx1/xx2/dir5` 乱七八糟的, 这个功能使得你只需键入 `j dir5` 即可.
  - osx: 比如你现在正在 Finder 中浏览某些文件夹. 此时你正想通过 shell 去处理. 不用你去慢慢看绝对路径是啥, 只需要打开zsh, 然后输入 `cdf` 即跳转到你当前Finder中的路径中.

#### 5. Alfred   

这个就不多说了, 太好用了. [alfred workflow](http://alfredworkflow.com/)

#### 6. Moom

用快捷键改变窗口布局和在多显示器间移动窗口.

#### 7. Dash

离线文档, 配合Alfred更佳.

#### 8. cVim

[cVim](https://chrome.google.com/webstore/detail/cvim/ihlenndgcmojhcghmfjfneahoeklbjjh)浏览器插件: 使用 VIM 方式控制 Chrome 浏览器的插件, 
或者[Vimium](https://chrome.google.com/webstore/detail/dbepggeogbaibhgnhhndojpepiihcmeb)


其他还有很多, 这里分享这几个常见的. 
