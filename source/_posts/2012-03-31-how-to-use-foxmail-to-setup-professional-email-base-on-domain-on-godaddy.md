---
id: 1675
title: godaddy域名企业邮箱客户端配置
date: 2012-03-31T21:44:35+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1675
duoshuo_thread_id:
  - 1351844048792453325
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 我做站长
  - 经验技巧
tags:
  - Foxmail
  - godaddy
---
今天本人入手新域名一枚：<a href="http://tanglei.me" target="_blank">tanglei.me</a>，有空再玩玩。之前的爱山寨(i3zhai.com)也是在这里注的，记得有个免费企业邮局(企业邮局就是诸如<tanglei@tanglei.name>，以自己的域名作为后缀的电子邮件地址,也叫企业邮箱)帐号的，于是今天去设置了下。(具体设置就是到godaddy主页，首部导航Email，然后如图有一个Email的下拉列表，你有几个域名(貌似info的木有送)，就送了几个邮箱。如果从来没有设置过，点击setup就开通了，再转至email management管理端设置邮箱帐号密码即可使用，Web 端很慢，不方便使用。一般配置outlook，foxmail客户端方便些。[<img title="godaddy-域名免费企业邮局 1" src="/wp-content/uploads/2012/03/godaddy1_thumb.jpg" alt="godaddy-域名免费企业邮局 1"  data-pinit="registered" />](/wp-content/uploads/2012/03/godaddy1.jpg) )

注意客户端配置时接受/发送邮件的服务器不能采取默认的，例如我在foxmail上配置pop3时，默认的pop3服务器是pop.tanglei.me，等。正确的配置应该是：

```csharp
接受邮件服务器(pop3):pop.secureserver.net
发送邮件服务器(smtp):smtpout.secureserver.net
```

如图所示：

[<img title="godaddy-域名邮箱-企业邮箱-客户端配置 1" src="/wp-content/uploads/2012/03/godaddy1_thumb1.jpg" alt="godaddy-域名邮箱-企业邮箱-客户端配置 1"  data-pinit="registered" />](/wp-content/uploads/2012/03/godaddy11.jpg)

不然会出现，本来用户名和密码正确，测试连接时总是验证失败。

正确配置后，就可以正常使用了。
