---
id: 2434
title: 访问favicon.ico总提示下载保存
date: 2014-06-19T13:21:38+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2434
duoshuo_thread_id:
  - 1351844048792453505
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
 - 经验技巧
tags:
  - Apache
  - 我做站长
---
Blog从虚拟主机换到了VPS，网站的favicon.ico图标出现了问题。用浏览器访问 </blog/favicon.ico> 总提示下载.html保存（另存为……）.

<div>
  <div>
    web服务器用的apache的话，解决方案是：apache的配置文件<strong>httpd.conf</strong> 里添加</p> 
    
    ```AddType image/x-icon .ico```
    
    <div>
      重启apache服务器，再次访问~ 若仍然提示下载~ 则试图让浏览器强制刷新，比如url后面加个随机串
    </div>
    
    <div>
      <a href="/blog/favicon.ico?123">http:.html/www.tanglei.name/favicon.ico?123</a>
    </div>
    
    <div>
      能够访问到图片了，不提示下载了，一般到这步也就解决了。
    </div>
    
    <div>
      若悲剧的是直接访问仍然提示下载~(我就遇到了)，则<strong>删除浏览器缓存</strong>，重启浏览器再次访问，应该就OK。
    </div>
  </div>
  
  <div>
  </div>
  
  <div>
    若仍然解决不了，则去/etc/mime.types 或者类似的路径去检测下下面这句有没有，若无则添加，重复上面的步骤试试~
  </div>
  
  ```image/x-icon ico```
  
  <div>
    实在不行，我也不知道了~
  </div>
</div>
