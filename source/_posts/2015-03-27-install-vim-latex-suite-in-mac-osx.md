---
id: 2638
title: Mac下安装使用vim插件latex-suite
date: 2015-03-27T19:36:40+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2638
duoshuo_thread_id:
  - 1351844048792453518
categories:
  - 经验技巧
tags:
  - Latex
  - Vim
---
最近写毕业论文~嗯~痛苦的过程~ 因为之前开题报告~水的论文都是latex，所以决定毕业论文仍然用latex，就不用在乎学校繁琐格式的排版了，模版的话当然就用<a href="https://github.com/xueruini/thuthesis.git" target="_blank">thutheis</a>.

vim下有个latex的插件~用着还不错~貌似那个IDE都没代码提示之类的. win下教程较多，直接下一步下一步即可.mac 下我按照官网的instruction还出了点问题，现在记录下来分享下。

先看看这个<a href="http://vim-latex.sourceforge.net/index.php?subject=download&title=Download" target="_blank">install instruction</a>。下载在<a href="http://sourceforge.net/projects/vim-latex/" target="_blank">这里download</a>。

方法1.make install 安装时注意路径.  得修改到自己vim的路径等配置：例如/Users/TangLei/.vim , 默认是到/usr/local什么的. 还是直接copy的好。

方法2.直接copy.

**/Users/TangLei/.vim/bundle** —这里放了所有的插件

注意看下这个脚本有木有pathogen(帮忙管理插件)， 并在vimrc里启用: **execute pathogen#infect()**

然后 修改配置 .vimrc 参考 <http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html>

效果：

例如: 输入”table + F5” 出现下面的代码

[<img title="Image" src="/wp-content/uploads/2015/03/Image_thumb1.png" alt="Image" border="0" />](/wp-content/uploads/2015/03/Image2.png)

再比如自动插入标签：ctrl+n

[<img title="Image(1)" src="/wp-content/uploads/2015/03/Image1_thumb1.png" alt="Image(1)" border="0" />](/wp-content/uploads/2015/03/Image11.png)

其他相关技巧啥的直接看help吧.

另外若F9 交叉引用出不来的话改 latex-suite/texrc，将 TexLet g:Tex_UsePython = 1  中的1 改为 0。

其他相关材料：

  * [VIM LATEX-SUITE REFERENCE CARD](http://michaelgoerz.net/refcards/vimlatexqrc.pdf)
  * [ubuntu 9.10 安装 vim latex-suite](http://blog.csdn.net/guanggy/article/details/4790111)
