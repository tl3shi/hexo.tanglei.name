---
id: 1037
title: SecureCRT上传和下载文件命令
date: 2011-07-18T21:16:09+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1037
duoshuo_thread_id:
  - 1351844048792453257
categories:
  - 经验技巧
tags:
  - Linux
  - 工具
---
公司开发机跟本机交互，通常用SecureCRT。
  
secureCRT在linux上面的sz,rz命令与ssh的配合设置一下上传和下载的默认目录就行options–>session options–>file transfer 下可以设置上传和下载的目录。
  
剩下的你只要在用SecureCRT登陆linux终端的时候：
  
发送文件到客户端：sz filename zmodem接收可以自行启动.
  
从客户端上传文件到linux服务端：rz 然后在 SecureCRT 里选文件发送,协议 zmodem.
