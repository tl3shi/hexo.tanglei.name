---
id: 1646
title: ubuntu自动挂载Windows分区以及对NTFS分区写和执行权限
date: 2012-03-25T23:23:39+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1646
duoshuo_thread_id:
  - 1351844048792453168
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 'Linux'
  - 经验技巧
tags:
  - Linux
  - Ubuntu
---
这两天都用了下ubuntu写代码，记得以前好像不是那么容易使eclipse和windows下的workspace同步的，得需要一些配置才可以。现在把它写下来备份一下。

首先，有一个自动挂载Windows分区(NTFS)的工具,而不用每次开机都去通过命令mount之类的。可以通过修改/etc/fstab这个文件，也可以通过这个软件可以实现自动挂载，还可以使ubuntu对ntfs的分区进行写和可执行的权限，叫：**NTFS写入支持配置程序**。ntfs-config的安装与设置方法： 安装输入 

``sudo apt-get install ntfs-config ``

打开软件设置： 

``sudo ntfs-config ``

或者直接通过图形化菜单直接打开。会自动打开图形化界面进行设置,如图，一目了然。(内部设备写支持是硬盘，外部是移动硬盘啊U盘之类的吧。) 注意这个ntfs-config软件在ubuntu10.10下可能会出现问题，反正我之前是出现了这个问题才在网上找到解决方案的。需要改一个python文件。**修改/usr/lib/pymodules/python2.6/NtfsConfig/NtfsConfig.py文件，将第56行的”os.mkdir“改为”os.makedirs“** 。 </div> 

[<img title="NTFS 写入支持配置程序_011" src="/wp-content/uploads/2012/03/NTFS_011_thumb.jpg" alt="NTFS 写入支持配置程序_011"  data-pinit="registered" />](/wp-content/uploads/2012/03/NTFS_011.jpg)

其实这个软件也是通过对/etc/fstab这个文件进行设置的吧。这样的设置方式貌似不爽。如果进/media下，ls一下，全绿的，意思就是全部777权限吧，一是看起来不爽，第二是万一一个不小心，对图中的什么winxp、win7之类的rm * 了就悲剧了。所以还是需要对/etc/fstab进行修改下。首先是权限的设置，可以利用添加<a href="http://en.wikipedia.org/wiki/Umask" target="_blank">umask参数</a>(或者fmask，dmask 分别是代表file，directory对文件和目录设置相应的权限)，umask具体怎么算，可以<a href="http://baike.baidu.com/view/1867757.htm" target="_blank">参考这里</a>。设置之后，有可能会出现这样的情况，就是比如想在平常windows下的分区进行相关的python或者java的程序编写，就算以root身份进行chmod操作，也不会生效

[<img title="image" src="/wp-content/uploads/2012/03/image_thumb5.png" alt="image"  />](/wp-content/uploads/2012/03/image5.png)

这样的话，javac就编译不会通过(并不是编译语法错误之类的，copy到ubuntu下的分区绝对可以正常执行)。或者还会出现想把ubuntu下的一个文件copy到windows下的ntfs分区，也提示没有权限(设置的是755权限)，需得用“管理员身份”打开资源管理器：sodu nautilus，进行操作。还需要对fstab配置进行修改，因为前面的copy等操作设置的755，普通user操作不了，得root身份可以，整个挂载的分区是以root身份挂载的，而普通登陆用户非root，所以进行不了copy操作。在fstab添加参数user，意思就是以user的身份挂载，普通user就可以(前面对应的umask权限)copy啊之类的。下面是我的fstab文件的配置，其实也就是增加了user参数和fmask/dmask参数:普通分区跟系统分区还是有区别对待的.fstab相应的具体参数可以到<a href="http://blog.csdn.net/liuyuan_jq/article/details/1826131" target="_blank">这里</a>看看。以上如果不生效，可能是命令之间有冲突。我开始就没有生效，后来用了uid参数才达到的效果了。以下是我的配置：

```bash
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>

proc	/proc	proc	nodev,noexec,nosuid	0	0
#Entry for /dev/sda10 :
UUID=7ce6538a-7554-46e5-a566-d1bcadbd10dd	/	ext4	errors=remount-ro	0	1
#Entry for /dev/sda6 :
UUID=12DAE060DAE04199	/media/WIN-7	ntfs 	dmask=022,fmask=022,locale=zh_CN.utf8	0	0
#Entry for /dev/sda8 :
UUID=77AC005CA3AD01EA	/media/life	ntfs 	dmask=022,fmask=022,locale=zh_CN.utf8	0	0
#Entry for /dev/sda7 :
UUID=662E6D3FBC51DC33	/media/study	ntfs 	dmask=022,fmask=022,locale=zh_CN.utf8,uid=tl3shi 	0	0
#Entry for /dev/sda5 :
UUID=D0C46945C4692EC2	/media/tools	ntfs 	dmask=022,fmask=022,locale=zh_CN.utf8	0	0
#Entry for /dev/sda1 :
UUID=7438F85038F8133A	/media/winxp	ntfs 	dmask=022,fmask=022,nosuid,nodev,locale=zh_CN.utf8	0	0
#Entry for /dev/sda9 :
UUID=a9e889bd-87cc-4468-913d-98c22a05add0	none	swap	sw	0	0
```

注意看13行，我要study盘以普通用户(tl3shi)身份挂载，方便开发时可以直接运行。效果如下:

```bash
tl3shi@tanglei3shi:~$ ls -l /media
总计 96
drwxr-xr-x 1 root   root 20480 2012-04-04 11:27 life
drwxr-xr-x 1 tl3shi root 28672 2012-04-06 14:13 study
drwxr-xr-x 1 root   root 16384 2012-04-04 11:27 tools
drwxr-xr-x 1 root   root  8192 2012-04-04 11:27 WIN-7
drwxr-xr-x 1 root   root 24576 2012-04-04 11:27 winxp
tl3shi@tanglei3shi:~$ 
```

另外,还有一个软件,就是在**windows下读取ubuntu下ext分区**的工具:<a href="http://sourceforge.net/projects/ext2fsd/files/" target="_blank">ext2fsd</a>.Ext2 File System Driver for Windows,<a href="http://sourceforge.net/projects/ext2fsd/files/latest/download?source=files" target="_blank">这个链接</a>是sourceforge下载。
