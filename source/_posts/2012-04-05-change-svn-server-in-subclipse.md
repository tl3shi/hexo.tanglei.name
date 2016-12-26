---
id: 1683
title: SVN插件subclipse修改服务器url
date: 2012-04-05T22:08:49+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1683
duoshuo_thread_id:
  - 1351844048792453415
categories:
  - 经验技巧
tags:
  - eclipse
  - hosts
---
在实验室写代码，有些脚本得放在服务器跑，有时候直接在服务器上改，有时候有是在本机改，代码同步就不怎么方便。于是在本机配好了SVN server，服务器直接从本机check out代码，本机和服务器做了相应的改动后commit。这样也方便代码同步。

实验室IP采取动态获取IP地址，上次服务器从本机check out代码时的url写死了IP，做修改后update等连不上。原因就是服务器IP地址变了(本机获取了新IP)。开始琢磨着在哪里改改配置等完事，结果貌似不起作用,.svn/entries这个文件有记录checkout时SVN服务器的IP，但修改貌似update时没有生效，还是以前的IP。可能在某个地方的其他文件还有配置吧。而服务器没有安装TortoiseSVN(只是subclipse插件)，无法直接右键relocate，后来才发现在这里可以改。打开Window—Show View—SVN—SVN Repositories视图，选中代码库右键直接有relocate，修改即可。

[<img title="subclipse修改服务器URL" border="0" alt="subclipse修改服务器URL" src="/wp-content/uploads/2012/04/subclipseURL1_thumb.jpg"  />](/wp-content/uploads/2012/04/subclipseURL1.jpg) 

以上不是想强调的地方，想到IP是死的，一种方案当时是手动写死IP(配置静态IP，不自动获取)，这样就避免了SVN服务器IP变化。另外一种方案可以修改hosts，指定一个固定的域名指向SVN服务器。试用本场景就是指定一个域名比如[www.tanglei.name](http://www.tanglei.name)（当然这个如果在本机中就直接影响了该网站的访问，可以换个虚拟的[www.xxx.xx](http://www.xxx.xx)），指向SVN服务器，也就是我本机的IP地址。下次IP地址变了，直接改hosts即可。WIN xp下直接写批处理，copy 一个含有host规则覆盖真实hosts文件即可，方便快捷切换。Win 7下可以<a href="/blog/switch-hosts-quickly-in-win7.html" target="_blank">看这里</a>,之前写的Win7快速切换hosts。
