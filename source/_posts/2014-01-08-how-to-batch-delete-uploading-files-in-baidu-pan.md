---
id: 2287
title: 百度云管家批量删除正在上传文件列表
date: 2014-01-08T21:55:19+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2287
duoshuo_thread_id:
  - 1351844048792453496
categories:
  - 经验技巧
tags:
  - Sqlite
  - Windows
  - 百度
---
百度网盘给了2T的空间，得好好利用起来。   <img class="wlEmoticon wlEmoticon-smile" style="border-style: none;" src="/wp-content/uploads/2014/01/wlEmoticon-smile.png" alt="微笑" />但是。。。。

由于误操作，添加了一个本地文件夹（我其实**之前已经把这个文件夹上传过**了，虽然它可能会类似md5一下，文件相同就说秒传之类的，但貌似md5不准啊，列表里面的文件，我看网盘里面确实已经存在了，估计它以为我修改了文件吧。），此文件夹下有**成千上万**个文件，而百度云管家目前把所有单个文件添加到上传列表，没有一个目录结构，意味着不能删除递归某个文件夹下的内容。(这一点，感觉用户体验很差呀，重复的目录没仔细检测也就罢了吧，至少能目录删除呀。）

[<img title="clip_image001" src="/wp-content/uploads/2014/01/clip_image001_thumb.png" alt="clip_image001"  />](/wp-content/uploads/2014/01/clip_image001.png)

就算一次全选，然后右键删除，也得来回捣腾N多次，很麻烦，并且还容易把百度云管家**搞死**。不信，你可以试试，添加3k多个文件，然后Ctrl + A 全选，然后删除，估计就死了，或者等它响应个1分钟活过来了。需求来了，就是想**批量删除百度网盘正在上传(已添加)的文件列表**。

研究了下，百度网盘客户端本地数据库是用**sqlite**数据库存的，于是乎就可以了。文件名字叫“**BaiduYunGuanjia.db**”，在安装路径的BaiduYunGuanjia\users\12c1exxxxxxxx5xxxx91bd3这个目录下。然后你就可以清清楚楚地看到百度云管家上传、下载等是怎么存储的。就这么几个表：

[<img title="image" src="/wp-content/uploads/2014/01/image_thumb.png" alt="image"  />](/wp-content/uploads/2014/01/image.png)

sqlite命令行用得不熟，还是去下个[sqlite客户端](http://sourceforge.net/projects/sqliteman/files/latest/download)吧，然后打开百度云管家本地的数据库，这样还是比cmd下清晰。

[<img title="image" src="/wp-content/uploads/2014/01/image_thumb1.png" alt="image"  />](/wp-content/uploads/2014/01/image1.png)

有兴趣可以研究下每个字段对应啥啥具体意思，然后用相应的sql删除，重启下百度云管家就可以了。我这里就直接根据local_path删除吧。

这个貌似安全性欠佳呀，直接用sqlite数据库，不知道以后百度网盘的客户端（嗯，人家叫云管家）会不会加个密之类的。在此Mark一下吧。
