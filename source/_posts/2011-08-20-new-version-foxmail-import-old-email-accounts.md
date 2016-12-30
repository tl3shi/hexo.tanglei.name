---
id: 1125
title: 新版foxmail7导入旧版邮箱帐号
date: 2011-08-20T17:26:10+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1125
duoshuo_thread_id:
  - 1351844048792453240
categories:
  - 经验技巧
tags:
  - Foxmail
---
看到foxmail 7 发布了。之前在笔记本上都是用的foxmail，现在换公司电脑了，用outlook，然后那么多帐号又懒得一个一个设置。然后foxmail 7 说是已经支持exchange，然后我就下了安装在公司电脑上，还好安装之后就自动导入了outlook的设置，过滤设置也OK。然后就是希望能够把以前的哪些帐号导入。

在笔记本上用foxmail，本想着直接通过在线升级解决问题，但未成功。然后手动下载安装，安装时，提示说不能直接覆盖以前的目录，因为数据结构等都很大的变化。但我硬是覆盖安装了。运气好，能够导入所有的帐号。
  
<img class="alignleft" src="/wp-content/uploads/2011/08/082011_0925_foxmail71.png" alt=""  />

然后就试着想导出帐号设置，再导入到公司的电脑里面，这样就不用我天天开一次笔记本收一次邮件了。结果悲剧的是居然没有导出功能。还试着将什么accounts.cfg之类的配置文件copy到公司电脑中企图能够导入，最终失败。再然后试着将foxmail 7 整个目拷到公司电脑，停止掉以前安装的foxmail7的应用程序，直接点击这个copy过来的相当于绿色版本的，居然能够运行成功，于是乎，就成功的把这些帐号导过来了。然后再试着将以前公司电脑的foxmail7文件夹改名，copy过来的程序仍能够正常运行，再delete掉之前安装的foxmail7. 现在就解决我的帐号导入问题了。
  
不过导入后，只有公司邮箱leitang@tencent.com可以正常收发邮件，其他的不能报10060连接终端，首先想到的是直接在rtx上搜索foxmail，企图搜到相关工作人员的同事，但没收到。在foxmail的腾讯微博求助，没反映。再发foxmail邮箱咨询，这个效果挺快滴。不一会，rtx上就有人找我了。![](/wp-content/uploads/2011/08/082011_0925_foxmail72.png)，也想到过是因为公司做了限制，用公司设置代理就可以了。还给foxmail开发人员提了建议：
  
![foxmail导入邮箱帐号](/wp-content/uploads/2011/08/082011_0925_foxmail73.png)

声明下：以前的foxmail版本是6.5，现在安装的是foxmail7(build067)版本，覆盖安装没问题，能够直接导入以前的帐号等问题。另外copy foxmail整个目录也可以正常运行。估计foxmail不敢保证能够导入，所以安装的时候提示不要覆盖安装，让选另一个目录,看它官方微博都这样说。

![foxmail导入帐号](/wp-content/uploads/2011/08/082011_0925_foxmail74.png)

不过我相信，不久就会支持这些功能滴。
  
【update 2012.9】

在新版的foxmail7(此次我用的是build 091)，方法：

> 「如何将旧电脑Foxmail数据保存在新电脑中？」1.在旧电脑上，确保关闭foxmail，复制安装目录下的Data文件夹；2.在新电脑里安装Foxmail，确保关闭foxmail，将拷贝好的Data文件夹覆盖新安装目录下的Data；3.开启Foxmail，完成！//也可以将foxmail文件夹直接复制拷贝到新电脑里哦。

如果只需要导入帐号设置，而不需要将已经接受的所有mail信息复制/导入的话，不复制Data目录下Mails目录即可，另外如果要复制联系人信息等可以使用foxmail导出联系人等功能，或者直接copy foxmail目录下的Address目录到新安装电脑的相应路径即可。
