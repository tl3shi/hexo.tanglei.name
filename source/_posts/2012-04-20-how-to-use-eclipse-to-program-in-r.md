---
id: 1741
title: R语言开发的eclipse插件安装教程
date: 2012-04-20T17:54:46+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1741
duoshuo_thread_id:
  - 1351844048792453312
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 数据挖掘
  - 敲敲代码
tags:
  - eclipse
  - eclipse插件
  - R语言
---
之前开发用惯了eclipse(从Java,JS,android到php,python等)，现在准备接触下R，还是想用eclipse，不想再去花时间熟悉另外的IDE。 

本文先讲eclipse3.6+R-2.15.0+StatET的配置，然后讲成功安装之前遇到的问题(主要是版本不兼容的问题)。 

eclipse3.6可以到<a href="http://download.eclipse.org/eclipse/downloads/drops/R-3.6.2-201102101200/" target="_blank">这里</a>下载,其他eclipse最好3.6版本及其以上的，免得引起不必要的版本兼容问题。 

这里就讲直接在线安装StatET插件了(可以到<a href="http://www.walware.de/?page=/it/downloads/rj.mframe" target="_blank">这里</a>下载对应版本的插件进行离线安装例如<a href="https://www.google.com.hk/search?sourceid=chrome&ie=UTF-8&q=eclipse%E6%8F%92%E4%BB%B6+link%E6%96%87%E4%BB%B6" target="_blank">link文件安装</a>)。在线安装很简单，点击Add,随便输入name(eg:statet)和添加网址即可,我PC里除了常用的3.4外还有3.6，这里用3.6，对应安装网址：<http://download.walware.de/eclipse-3.6>，若是3.7，则是<http://download.walware.de/eclipse-3.7>。 

[<img title="eclipse-R-开发插件StatEt-walware" border="0" alt="eclipse-R-开发插件StatEt-walware" src="/wp-content/uploads/2012/04/eclipseRStatEtwalware_thumb.jpg"  />](/wp-content/uploads/2012/04/eclipseRStatEtwalware.jpg)&nbsp; 

安装好后，最好重启下，接下来配置R的运行时环境。 

[<img title="eclipse-R-开发插件StatEt" border="0" alt="eclipse-R-开发插件StatEt" src="/wp-content/uploads/2012/04/eclipseRStatEt_thumb.jpg"  />](/wp-content/uploads/2012/04/eclipseRStatEt.jpg) 

选择电脑中安装R的相应目录。 

然后就可以跟其他Javaproject，pythonproject等一样，new一个R的project了 

[<img title="R的eclipse插件安装教程" border="0" alt="R的eclipse插件安装教程" src="/wp-content/uploads/2012/04/image_thumb2.png"  />](/wp-content/uploads/2012/04/image2.png) 

在新建好的project上就可以再new一个R-script File，写代码吧。沿用参考的例子：

```python
prime<-function(n)
{
    prime1<-function(x)
    {
        y<-TRUE
        for(i in (x%/%2):2)
        {
            if(x%%i==0) y=FALSE
            if(x==2 | x==3) y=TRUE
        }
        y
    }
    x<-c()
    for (i in 2:n)
    {
        if(prime1(i)) x<-c(x,i)
        if(i==n) return(x)
    }
}
prime(100)
prime(1000)
```

<pre>然后运行Run，第一次Run可能要进行配置，选择Rterm,默认的RJ可能会因为版本兼容性提示dll不存在之类的。</pre>

<pre><a href="/wp-content/uploads/2012/04/image3.png"><img title="image" border="0" alt="image" src="/wp-content/uploads/2012/04/image_thumb3.png"  /></a> </pre>

<pre>记住一些常用的快捷键吧，按Ctrl+R有提示。终于出结果了</pre>

<pre><a href="/wp-content/uploads/2012/04/image4.png"><img title="image" border="0" alt="image" src="/wp-content/uploads/2012/04/image_thumb4.png"  /></a> </pre>

本文例子来源：<a href="http://cos.name/2008/12/eclipse-statet-for-r-editor/" target="_blank">打造得心应手的统计编程平台－－Eclipse + StatET</a> 

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212; 

之前还是准备安装在常用的eclipse3.4版本上,于是下载对应的eclipse3.4对应的statet插件. 然后本机开始配置的R环境是R-2.14.2，配置好之后，运行出错。如下图 

[<img title="eclipseR插件报错" border="0" hspace="12" alt="eclipseR插件报错" src="/wp-content/uploads/2012/04/clip_image002_thumb.jpg"  />](/wp-content/uploads/2012/04/clip_image002.jpg)

An error occurred while running R [R Console]. R2.4 : R Console/Rterm ~ S:\programs\_for\_study\R-2.14.2\bin\Rterm.exe (Apr 20, 2012 2:55:21 PM) terminates unexpected.An error occured while starting Rterm process.Cannot run program &#8220;S:\programs\_for\_study\R-2.14.2\bin\Rterm.exe&#8221; (in directory &#8220;S:\programs\_for\_study\eclipse-SDK-3.4.2-win32\eclipse&#8221;): **CreateProcess error=2,XXX**

原因是在S:\programs\_for\_study\R-2.14.2\bin目录下没有找到Retrm.exe,查看安装的R-2.14.2环境，发现没有。有一个i386目录，试图直接将其copy出来(R-2.14.2\bin\i386下copy出来的Rgui运行也没有反映，必须打开i386下面的才可以。)，eclipse能不会报错(控制台有类似cat(&#8220;Synch262515423447114\n&#8221;);输出)，运行但不出结果。。。修改R interaction Connector used to Run R code到R-GUI(win),自己先运行R-GUI，再run就会有结果出现，修改Connector 输出到eclipse的控制台是没办法出结果的。看来是插件跟R的版本不兼容的问题了。这才让我重新安装插件到eclipse3.6。
