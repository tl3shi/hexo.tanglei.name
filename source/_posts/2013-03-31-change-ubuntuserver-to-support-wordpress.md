---
id: 2094
title: 换主机风波-ubuntu配置Wordpress
date: 2013-03-31T00:46:24+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2094
duoshuo_thread_id:
  - 1351844048792453271
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Ubuntu
  - Wordpress
  - 我做站长
  - 虚拟主机
---
今天突然发现博客主机流量超过了15G而被停调了。 


![流量超标](/wp-content/uploads/2013/03/033013_1646_ubuntuw1.png) 

于是就换了主机了，换了一台ubuntu主机。过程如下： 

  1. <div>
      安装web服务器.
    </div>
    
    ``sudo apt-get install apache2``
    
    安装好后，会自动启动service. 


![](/wp-content/uploads/2013/03/033013_1646_ubuntuw2.png) 

  1. <div>
      安装php运行环境
    </div>
    
    ``sudo apt-get install php5 ``


![](/wp-content/uploads/2013/03/033013_1646_ubuntuw3.png) 

验证下php环境，ok. 


![Wordpress 运行环境](/wp-content/uploads/2013/03/033013_1646_ubuntuw4.png) 

  1. <div>
      配置虚拟主机.
    </div>
    
    修改Httpd.conf，将Wordpress放到相应目录. 发现木有mysql驱动. 


![php mysql 驱动](/wp-content/uploads/2013/03/033013_1646_ubuntuw5.png) 

```bash
sudo apt-get install php5-mysql
service apache2 stop/start
```


![mysql远程访问](/wp-content/uploads/2013/03/033013_1646_ubuntuw6.png) 

配置正确，没有给远程访问的权限，将localhost 改为%，Connected! 

改hosts后，能够访问。 


![Wordpress设置固定链接无效的解决办法](/wp-content/uploads/2013/03/033013_1646_ubuntuw7.png) 

不过里面的链接失效。 


![Wordpress设置固定链接无效的解决办法](/wp-content/uploads/2013/03/033013_1646_ubuntuw8.png) 

我这个固定链接是采用.htaccess方式，查了下是因为apache没有开启rewrite模块支持，于是 

```bash
ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
```

重启apache服务。访问即可。 

然后在修改域名A记录指向新主机，dns解析估计不会马上生效。开始会因为缓存等原因仍然访问不了，不过不要紧，本地flushdns一下，其他地方就得等了，各个省市的一些机房可能不一样。 

 

参考资料： 

[Wordpress设置固定链接无效的解决办法](http://kpjack.blog.51cto.com/627289/327354)
