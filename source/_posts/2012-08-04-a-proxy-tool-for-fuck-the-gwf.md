---
id: 1902
title: 推荐一个不错的Fan-Wall工具-西厢代理
date: 2012-08-04T23:01:38+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1902
duoshuo_thread_id:
  - 1351844048792453310
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - 经验技巧
---
### windows环境下：

1. [下载客户端](http://code.google.com/p/west-chamber-season-3/downloads/list) ，解压缩，双击WCProxy.exe，桌面右下角就有了个绿色的墙图标。下载后看到有一个安全证书，不妨也导入吧，运行同目录下certmgr.exe，导入同目录下CA.crt。
  
2. 把浏览器HTTP/HTTPS 代理设置为 127.0.0.1:1998。

p.s.
  
这里再推荐下<a href="https://chrome.google.com/webstore/detail/dpplabbmogkhghncfbfdeeokoefdjegm" target="_blank">chrome代理切换插件Proxy SwitchySharp</a>，比较方便可以自己配正则自动切换是否通过代理网络访问网站。可以在线导入配置，如图，导入的URL为： 

``http://west-chamber-season-3.googlecode.com/files/SwitchyOptions.bak``

[<img title="SwitchySharp代理设置" src="/wp-content/uploads/2012/08/SwitchySharp_thumb.jpg" alt="SwitchySharp代理设置"  />](/wp-content/uploads/2012/08/SwitchySharp.jpg)这个Windows 版本更新比较慢，如果你电脑里面有python开发环境的话，可以有个随时获取最新的。可以到此<a href="https://github.com/liruqi/west-chamber-season-3/zipball/master" target="_blank">下载代码</a>，解压缩，或者直接 

``git clone git://github.com/liruqi/west-chamber-season-3.git``

。进入west-chamber-proxy 文件夹，双击westchamberproxy.py运行，控制台可以看到一些运行状态，别关了。然后就好好的享受自由的墙外生活吧。

[<img title="proxy-fuck-gfw-facebook" src="/wp-content/uploads/2012/08/proxyfuckgfwfacebook_thumb.jpg" alt="proxy-fuck-gfw-facebook"  />](/wp-content/uploads/2012/08/proxyfuckgfwfacebook.jpg)

### Linux环境下

还是<a href="https://github.com/liruqi/west-chamber-season-3/zipball/master" target="_blank">下载代码</a>，unzip，然后cd 到 west-chamber-proxy; 启动代理：./wcproxy start；

### 其他环境

还有Mac\Android\iOS的版本。详情到<a href="https://github.com/liruqi/west-chamber-season-3" target="_blank">项目主页</a>看看吧。

 另外，如果不是经常去墙外，而又经常用google doc啊reader啊之类的产品的话，再推荐一个host，<a href="https://code.google.com/p/smarthosts/" target="_blank">smarthost项目主页在这里</a>。

该开源项目目前由<a href="http://liruqi.info" target="_blank">LIRUQI</a>维护，其blog主页样式也不常见哦。

[<img title="image" src="/wp-content/uploads/2012/08/image_thumb.png" alt="image"  />](/wp-content/uploads/2012/08/image.png)
  
[注意]，请遵守相关法律法规，此办法的用途[只能]用于浏览“健康”网页，供学习交流使用。:)
