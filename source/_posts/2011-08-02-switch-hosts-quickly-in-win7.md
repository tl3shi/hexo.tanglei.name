---
id: 1077
title: WIN7下快速切换hosts方法
date: 2011-08-02T22:32:16+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1077
duoshuo_thread_id:
  - 1351844048792453416
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 工作那些事儿
tags:
  - hosts
  - 工作日志
  - 工具
---
公司搞开发，往往配置hosts在开发环境里面。然后，有时候又需要访问外网。现在在开发朋友网www.pengyou.com，开发的时候域名是写死了滴，但指向的服务器IP，因环境不同而不同，比如开发环境，测试环境，和外网的真实环境。这样开发就得直接在hosts文件里面配置了。每次想在机子上访问pengyou网站的外网时，都得去改hosts文件。公司配的WIN7系统，网上下的一些什么各种hosts快速切换小工具啊之类的不行。leaner给的一个.hta文件也不行。还不能建个快捷方式直接改，改完后另存为不行。非得通过cmd.exe以管理员身份运行。记事本打开保存才可以。。后台想到自己以前用学校机房和自己寝室的一个改变IP的批处理文件。就想着也通过这样来实现吧。然而不是那么简单。写不出复杂的批处理，写一两个命令种改可以吧。就把多个环境的hosts先写好保存dev.txt out.txt之类的。直接用命令copy 到windows\system32\drivers\etc\hosts 即可。最后执行的时候吧。以管理员身份执行。不能直接在批处理文件.bat上已管理员身份运行，不行。通过cmd.exe以管理员身份运行，再cd到.bat目录下，运行。才可以。后来看到firefox有个插件可以用，进去看了下，介绍了两条命令http://code.google.com/p/fire-hostadmin/wiki/GAIN\_HOSTS\_WRITE_PERM，可以实现对hosts文件具有可写的权限。

```c
cacls %windir%/system32/drivers/etc/hosts /E /G Users:W

cacls %windir%/system32/drivers/etc/hosts /E /G "User Account Name":W
```

我试了试，我这种方法也OK了。现在终于好了。直接放在桌面上，右键选中批处理文件，以管理员身份运行，就能快速转换环境了。

**总结下**：

<div>
  先以管理员身份运行这两个命令：如图：
</div>
    
![](/wp-content/uploads/2011/08/080211_1432_hosts1.png)</li> 
    
  <div style="text-align: justify;">
      然后准备好不同环境的hosts文件。以及写简单的命令。如图：外网hosts不用配，我里面就一个井号#。命令也简单：copy .\host214.txt C:\WINDOWS\system32\drivers\etc\hosts
    </div></ul> 
    
![WIN7下快速切换hosts方法](/wp-content/uploads/2011/08/080211_1432_hosts2.png)
    
OK。现在可以实现快速切换了。不过每次都右键以管理员身份运行才可以。我是木权限设置自动以管理员身份运行滴啦。
