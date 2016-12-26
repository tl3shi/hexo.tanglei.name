---
id: 1612
title: GitHub搭建博客教程
date: 2012-03-22T23:11:52+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1612
duoshuo_thread_id:
  - 1351844048792453296
categories:
  - 我做站长
  - 经验技巧
tags:
  - git
  - github
  - HelloWorld
---
上次不知道是谁问我有否考虑把博客迁移到github上，今天无意间又碰到了关于这个问题，于是就试了试。用github首先得安装SCM工具Git，还记得上一次接触Git，还是在上<a href="/blog/category.htmlsoftware-engineering/software-configuration-management/" target="_blank">软件配置管理</a>课的时候讲<a href="/blog/scm-tools.html" target="_blank">软件配置管理工具</a>时遇到的，有关git的教程，这个讲得比较好[Git中文教程](http://progit.org/book/zh/)。

今天中午就在Windows环境下配置了git和github，搞了个hello world出来。下面把流程说下。

  * **安装Git**

到<http://code.google.com/p/msysgit/downloads/list>下载,或者也可以下载[git图形化的工具乌龟](http://code.google.com/p/tortoisegit/downloads/list)。因为之前装了TortoiseSVN，如果再转一个git感觉不大好。所以就没装图形化的，且下载的是前者的便携版[PortableGit-1.7.9-preview20120201.7z](http://code.google.com/p/msysgit/downloads/detail?name=PortableGit-1.7.9-preview20120201.7z&can=2&q=)。下载好后，直接解压即可。为了方便使用，将bin目录添加至环境变量。

  * **配置Github环境**

Check for SSH keys.Backup and remove existing SSH keys.Git跟目录下查看是否有.ssh目录(可能隐藏了滴)，如果是第一次用的话，可能没有，没关系。有的话注意备份以前的ssh key。

接下来就是要生成新的SSH key(Generate a new SSH key).用如下命令(注意是否已经bin目录添加至环境变量，没有添加环境变量可以选择添加，或者选择cd到bin目录下。否则可能出现不是内部或者外部命令之类的)。提示输入要保存的key文件，<a href="http://help.github.com/win-set-up-git/" target="_blank">官网Windows教程</a>说可以直接按回车采取默认的目录和文件名//.ssh/id_rsa，不过我这windows Xp不知道咋回事，直接按回车，说找不到//.ssh目录之类的吧，于是手动输入一个。然后输入密码(这个密码是后面commit/check in时要输入的密码).最后看到key fingerprint is…字样说明key生成OK。

[<img title="clip_image001" src="/wp-content/uploads/2012/03/clip_image001_thumb.gif" alt="clip_image001"  hspace="12" data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image001.gif)

接下来需要将这个生成的key添加至github中(Add your SSH key to GitHub).登陆到github中，然后用如图所示的,右上角点击设置,左边选择 SSH keys,添加一个key,将刚才生成的key文件id_rsa.pub中的内容复制出来粘贴在此。

[<img title="clip_image002" src="/wp-content/uploads/2012/03/clip_image002_thumb2.jpg" alt="clip_image002"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image0023.jpg)

添加成功之后，再客户端测试下是否配置成功。(Test everything out).输入下面的命令(原封不动的敲，邮箱不变)。

**ssh -T** **<git@github.com>**

理想中的状态是正如官网所说,代表验证成功。结果悲剧的是。我这边出现了错误：**Permission denied (publickey)**

[<img title="image" src="/wp-content/uploads/2012/03/image_thumb4.png" alt="image"  data-pinit="registered" />](/wp-content/uploads/2012/03/image4.png)

**Permission denied (publickey)错误的解决方案**在官网又说，<a href="http://help.github.com/ssh-issues/" target="_blank">官网有说</a>很可能是找不到key文件，得make sure 生成的key文件在默认的目录./ssh/下面。才想起，刚才自己生成key文件时，默认的位置/.ssh/没有找到，就直接在git目录下生成的，于是直接将生成的两个文件id\_rsa.pub和id\_rsa复制到.ssh/目录下即可。然后再执行上面的命令**ssh -T** [**git@github.com**](mailto:git@github.com)提示成功。记住刚才输入的密码啊,这里要输入.我就差点没记住

[<img title="clip_image002[16]" src="/wp-content/uploads/2012/03/clip_image00216_thumb.jpg" alt="clip_image002[16]"  />](/wp-content/uploads/2012/03/clip_image00216.jpg)

**然后就是设置github的帐户(**Set Up Your Info),用于git各种操作的帐户。

<pre>&gt;git config --global user.name "<em>Firstname Lastname</em>"
&gt;git config --global user.email "<em>your_email@youremail.com</em>"</pre>

设置Set your **GitHub token：**说的是有的应用程序连接github时木有ssh，则需要配置个api token，进github设置页面，复制出API token码，再绑定到github帐号中:

>git config &#8211;global github.user _username_

>git config &#8211;global github.token _0123456789yourf0123456789token_

  * **创建代码库**，并上传hello world

进入github页面，新建一个代码库<https://github.com/repositories/new>(这个链接是直接new 仓库) ，<a href="http://pages.github.com/" target="_blank">官网page教程</a>说的是如果用户名是A，再建一个代码库为A.github.com，然后上传个index.html到A.github.com中，系统自动完成page的转换过程。注意,一定**要跟你登陆的github用户名一样**的,我开始就没注意这点,新建了几个代码库没搞定.我的用户名是tl3shi，因此新建的代码库名称是tl3shi.github.com.建好之后Web页面就有命令行操作提示。跟着做就可以了。如下的命令是将本地写的一个html页面上传到代码库中。

[<img title="github 1" src="/wp-content/uploads/2012/03/github1_thumb.jpg" alt="github 1"  data-pinit="registered" />](/wp-content/uploads/2012/03/github1.jpg)

成功之后，就可以通过<http://tl3shi.github.com/index.html>访问我刚才写的index.html了。

[<img title="clip_image002[18]" src="/wp-content/uploads/2012/03/clip_image00218_thumb.jpg" alt="clip_image002[18]"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image00218.jpg)

OK,整个流程完成了,配置成功.此文完成了从安装git到配置github,最后输出hello world.接下来怎么绑定独立域名,怎么配置其他诸如Wordpress的博客系统框架(如jekyll或_octopress_)就再说了.

参考资料:

<hr align="left" size="1" width="30%" />

<http://help.github.com/ssh-issues/>

<http://help.github.com/win-set-up-git/>
