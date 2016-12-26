---
id: 2212
title: mac air升级到Mavericks(10.9)后finder不能用
date: 2013-10-28T01:03:32+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2212
duoshuo_thread_id:
  - 1351844048792453490
categories:
  - 经验技巧
tags:
  - mac
  - OS
---
前两天把mac air升级到最新版Mavericks,10.9版后，发现finder无法用，重启啊什么都不行。最后才发现原来是金山快盘惹的祸。

看来码农代码得写得好才行啊，自己的问题搞不好，连累别人。

金山快排论坛上给出了解决方案

> <table cellspacing="0" cellpadding="0">
>   <tr>
>     <td id="postmessage_361912">
>       有用户反馈在系统升级到osx 10.9后，finder一直无法打开，卸载<a href="http://www.kuaipan.cn/" target="_blank">金山快盘</a>后重启就正常了。目前这个问题已经修复，请按下面步骤操作即可：1.退出快盘2.下载kuapan.app.zip到本地路径<br /> <a href="http://www.kuaipan.cn/file/id_1183705871716650.htm" target="_blank">http://www.kuaipan.cn/file/id_1183705871716650.htm</a></p> 
>       
>       <p>
>         3.打开终端，切换到kuapan.app.zip所在目录，输入：<br /> unzip kuaipan.app.zip 回车<br /> cp -r kuaipan.app /Applications/ 回车
>       </p>
>       
>       <p>
>         4.运行快盘</td> </tr> </tbody> </table> </blockquote> 
>         
>         <p>
>           金山快排没升级前也可以这样解决,在金山快排设置下取消“显示通知消息“。
>         </p>
>         
>         <p>
>           貌似后来快盘又打了补丁。现在可以用了。
>         </p>
