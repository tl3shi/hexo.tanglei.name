---
id: 1890
title: 也试试github+octopress
date: 2012-08-02T12:40:42+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1890
duoshuo_thread_id:
  - 1351844048792453407
categories:
  - Wordpress
  - 我做站长
tags:
  - git
  - github
  - HelloWorld
---
前面讲过[github写博客](/blog/use-github-to-make-hello-world.html)，然后可以绑定独立域名(方法也很简单，添加A记录只想github的page服务：207.97.227.245，上传一个CNAME内容为你的顶级域名的文件到你的代码库中)。由于手上还有一个tanglei.me域名，<del>今天</del>(其实是7.25,在[ubuntu下用blogilo发布](/blog/use-blogilo-to-post-Wordpress-blog-in-ubuntu.html)成草稿了，直到今天8.3才发布出来)就试着配置了下环境。效果可以<a href="http://tanglei.me/blog/2012/07/25/hello-world/" target="_blank">看看这里</a>。

截图留念：

<p align="center">
  <img title="github和octopress配置" src="/wp-content/uploads/2012/07/name_006.jpeg" alt="github和octopress配置" />
</p>

下面说说过程吧。

1、ruby环境。octopress要求ruby的version要>=1.9.2吧，ubuntu下默认sudo apt-get install ruby.的版本是1.8的，因此不对。可以sudo apt-get install ruby1.9.3 ，或者下载源代码 编译安装，再或者用rvm(Ruby Version Manager)之类的工具安装。

2、git clone octopress代码。并安装相关依赖包和配置, 强调下ruby的版本。<a href="http://octopress.org/docs/setup/" target="_blank">看这里</a>

3、github代码库绑定。然后就可以blog了。注意得git push一个CNAME到代码库中，不然自己的域名不会正确跳转。<a href="http://octopress.org/docs/deploying/github/" target="_blank">看这里</a>

4、写文章.先cd your\_local\_octopress\_directory，然后 rake new\_post[&#8220;Your Title of Your Article&#8221;]，在\_source/\_posts/目录下面生存.markdown文件。就开始吧。。。还得学学markdown。呵呵。rake generate、rake preview、reke deploy。。。

整个过程中遇到的几个问题：

  1. Do not use :apt-get install ruby,because the default version is 1.8.However octopress need 1.9.2 or later
  2. 用源代码编译安装或者用rvm安装时，运行到步骤（./configure prefix=&#8217;/usr/local/ruby&#8217;）提示**configure: error: C compiler cannot create executables**,我最终重新安装了GCC即可。或许你遇到了这个问题也可以重新安装GCC试试。
  3. 运行rvm总是提示：**rvm is not a function,rvm use 1.9.3 will not work，并给出了个链接，**参考官网 For RVM to work properly, you have to set the &#8216;Run command as login shell&#8217; checkbox on the Title and Command tab inside of gnome-terminal&#8217;s Settings page。
