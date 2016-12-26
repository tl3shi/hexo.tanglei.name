---
id: 956
title: MS里程碑MIUI(android2.3)刷app2sd
date: 2011-07-03T23:02:03+00:00
author: tanglei
layout: post
guid: /blog/ms%e9%87%8c%e7%a8%8b%e7%a2%91miuiandroid2-3%e5%88%b7app2sd.html
duoshuo_thread_id:
  - 1351844048792453433
categories:
  - Android
  - 玩玩手机
tags:
---
上次帮幺叔的里程碑刷了MIUI的系统了.都到2.3了.我的defy都还在2.2呢.然后应要求要做app2sd,因为里程碑就200M的机身内存,他装了应用多了,剩下内存就40M了.所以还得做.然后网上看了好多教程,都试过,好多都不成功.有说用什么用的PLUS工具箱1.96A CM专版，一次成功的啊.等等我都试过还不行.最后看到一篇帖子,成功了.

里面说的附件，自己百度下搜吧。都能down到。这个原贴地址: <http://www.miui.com/thread-63643-1-1.html>

下面把转载下流程。

<div>
  <table style="border-collapse: collapse;" border="0">
    <colgroup> <col style="width: 576px;"></col> </colgroup> <tr>
      <td valign="middle">
        <span style="color: #333333;"><span style="font-family: 宋体;">大家要挂载</span><span style="font-family: Arial;">EXT</span><span style="font-family: 宋体;">分区，首先必须给内存卡分区，先上分区软件<a href="http://www.miui.com/forum-attachment-aid-NzU5ODB8MDZkN2Q2N2J8MTMwODk5NzIxOXwyOTQ4ODM%3D.html" target="_blank"></a></span></span><span style="font-family: Arial;"><span style="color: #ec6200; text-decoration: underline;">gdisk_sd.zip</span><span style="color: #333333;">.</span></span><span style="color: #999999; font-size: 9pt;"><span style="font-family: Arial;"><br /> </span></span></p> 
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333;"><span style="font-family: 宋体;">分区前请备份内存卡数据，分区会格卡</span><span style="font-family: Arial;">.</span><span style="font-family: 宋体;">用读卡器连接电脑，不可以用数据线</span><span style="font-family: Arial;">(</span></span><span style="color: red;"><span style="font-family: Arial;">p.s</span><span style="font-family: 宋体;">我没有实验过，就按照原作者说的做了</span></span><span style="color: #333333;"><span style="font-family: Arial;">).</span><span style="font-family: 宋体;">解压附件打开</span><span style="font-family: Arial;">sd-gb.cmd</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="color: #333333; font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro1.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333; font-family: 宋体;">选择箭头所指编号，然后回车</span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro2.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333;"><span style="font-family: 宋体;">选择</span><span style="font-family: Arial;">3</span><span style="font-family: 宋体;">，切出</span><span style="font-family: Arial;">APP2SD</span><span style="font-family: 宋体;">所需的</span><span style="font-family: Arial;">EXT2</span><span style="font-family: 宋体;">分区，回车</span></span>
        </p>
        
        <p>
          <img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro3.png" alt="" /><span style="color: #333333; font-family: Arial;"><br /> </span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333;"><span style="font-family: 宋体;">输入</span><span style="font-family: Arial;"> FAT32</span><span style="font-family: 宋体;">主分区容量，剩下的自动切为</span><span style="font-family: Arial;">EXT</span><span style="font-family: 宋体;">分区容量，回车</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro4.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333; font-family: 宋体;">开始</span><span style="color: #333333;"><span style="font-family: 宋体;">切割，等待</span><span style="font-family: Arial;">……</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro5.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333; font-family: 宋体;">切割</span><span style="color: #333333;"><span style="font-family: 宋体;">完成，任意键结束，这里给内存卡分区就完成了，然后就是给手机挂载到</span><span style="font-family: Arial;">EXT</span><span style="font-family: 宋体;">分区了</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: 宋体;">这里</span><span style="font-family: 宋体;">我们要用到</span><span style="font-family: Arial;">F</span><span style="font-family: 宋体;">大的</span><span style="font-family: Arial;">PLUS</span><span style="font-family: 宋体;">工具箱</span><span style="font-family: Arial;">1.96A CM</span><span style="font-family: 宋体;">专版，下面是附件<a href="http://www.miui.com/forum-attachment-aid-NzYwMDB8ZjQxZThhYzF8MTMwODk5NzIxOXwyOTQ4ODM%3D.html" target="_blank"></a></span></span><span style="font-family: Arial;"><span style="color: #ec6200; text-decoration: underline;">CM_PlusToolbox1.96A_build110310.apk</span><span style="color: #999999;"><br /> <span style="color: #333333; font-family: 宋体;">安装</span></span></span><span style="color: #333333; font-family: 宋体;">软件，然后打开</span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro6.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333; font-family: 宋体;">选择</span><span style="color: #333333;"><span style="font-family: 宋体;">一键</span><span style="font-family: Arial;">APP2EXT</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: Arial;"><span style="font-family: Arial;"><img src="/wp-content/uploads/2011/07/070311_1501_MSMIUIandro7.png" alt="" /></span><br /> </span></span>
        </p>
        
        <p style="background: #f5f1e8;">
          <span style="color: #333333; font-family: 宋体;">选择</span><span style="color: #333333;"><span style="font-family: 宋体;">第二项，这里要说明一下，挂载有时候第一次不成功，没关系在重新挂载一次就行了，挂载成功手机会自动重启</span><span style="font-family: Arial;">.</span></span>
        </p>
        
        <p>
          <span style="color: #333333;"><span style="font-family: 宋体;">然后就差不多了。</span><span style="font-family: Arial;"><br /> </span></span></td> </tr> </tbody> </table> </div>
