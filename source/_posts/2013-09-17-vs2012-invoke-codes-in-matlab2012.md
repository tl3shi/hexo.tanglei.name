---
id: 2200
title: 'C++调用matlab&#8212;matlab2012生成dll供VS2012调用'
date: 2013-09-17T23:25:57+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2200
duoshuo_thread_id:
  - 1351844048792453489
categories:
  - 经验技巧
tags:
  - C++
  - 敲敲代码
  - 工具
---
网上一大片此类文章，这里主要说下matlab(R2012a)或者2012b版本中还没有兼容VS2012，因此提供以下几个配置文件。以解决在通过matlab提供的编译生成dll时的工具会不兼容VS2012的问题。只需要加入以下几个配置文件即可。

> In Matlab 2012b (x64), command &#8220;mex -setup&#8221; will not find the compiler of vs2012, because the 2012b version of Matlab was released before the 2012 version of visual studio. To repair this problem, 4 files need added into Matlab install folders:
  
> 1.  Add
  
> [msvc110opts.bat](https://docs.google.com/open?id=0B4aXYHshkgELS1kyV1czS2duU2M)
  
> [msvc110opts.stp](https://docs.google.com/open?id=0B4aXYHshkgELc293VVptSV9uQkE)
  
> into folder
  
> ..\MATLAB\R2012b\bin\win64\mexopts\
  
> 2.  Add
  
> [msvc110compp.bat](https://docs.google.com/open?id=0B4aXYHshkgELa3FLOWxWUldacTg)
  
> [msvc110compp.stp](https://docs.google.com/open?id=0B4aXYHshkgELR3I4THN6dzJjNHc)
  
> into folder
  
> ..\MATLAB\R2012b\bin\win64\mbuildopts\
  
> (Note: the above 4 files are for 64-bit version of Matlab)

根据自己的安装环境修改下bat文件里面的相关路径(path,include,lib)，若上面链接失效，这里提供一份本地备份的可以在这里下载：[matlab2012_vs2012](/wp-content/uploads/2013/09/matlab2012_vs2012.rar)

引用自墙外：[Matlab 2012b mex setup with VS2012](http://jimdavid.blogspot.com/2012/12/matlab-2012b-mex-setup-with-vs2012.html)
