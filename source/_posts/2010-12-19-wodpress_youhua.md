---
id: 99
title: 为Wordpress添加评论表情和显示评论头像
date: 2010-12-19T13:57:19+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=99
duoshuo_thread_id:
  - 1351844048792453146
categories:
  - 经验技巧
tags:
  - Wordpress
  - 我做站长
---
看到人家blog搞得比较炫，对比下自己的。比较朴实了。所以今天优化了下我的blog.评论添加了表情支持。和显示评论增加了头像。期间也遇到了不少问题。网上一查WordPress 评论头像设置方法。一大堆。我也按照方法设置了。注册了gravatar头像。然后去评论人家blog时，就能显示到我的头像了。但回头看看自己的，不行。本机架设了Wordpress自己给自己留言。还是不行。然后查原因，我用的主题i3theme集成了gravatar头像了呀。还是不行。看了这篇文章《WordPress如何显示日志评论者的头像》http://blog.newchen.com/post/454，又按照他说说的方法本机测试了。出现了我的头像。开始位置放得不对，没有在循环里面去，所以导致只能显示我的一个头像。（因为都是本机测试，只能显示本人的绑定的email的头像了）。然后寻找放到循环里面去了就OK了。

I3theme里面的确集成了gravatar，估计版本间有问题吧。调用的方法不一致，导致最后显示不了头像。<?php echo get\_avatar( $comment, 50 ); ?>这个句代码能正确显示出来。而i3theme本身还有个if else的判断是否有gravatar，却没有显示出来。应该是版本兼容问题。但出现的头像很突然的&#8221;立“在那里，不太好看。又改了下显示的静态内容，若XX在XX时间对你说 啊之类的话。这加了之后，发现与真正评论的内容有不很容易区分，于是又加了个hr，能区分了，但多个评论内容之间区分又不怎么明显，看comments。php源码，是传统的分奇偶数有不同的CSS，自己的DIV +CSS确实不咋样，就懒得去花时间改了，要是可以的话改改奇偶数的评论的背景CSS就好了，以区分各个评论之间的内容。搞了好久，才勉强出现了现在的这个样子。然而就在上传至blog.i3zhai.com的时候出现了问题。因为我加的表情路径<img src=&#8221;wp-includes/images/smilies/icon\_question.gif&#8221; alt=&#8221;&#8221; />，而本机直接访问就是localhost/Wordpress/wp-includes/……就能访问到表情位置了。传至web后，当然不是真正的路径。出现了如下的错误;

[<img class="alignleft size-full wp-image-100" title="bug" src="/wp-content/uploads/2010/12/bug.jpg" alt=""  />](/wp-content/uploads/2010/12/bug.jpg)

才发现，这个问题还能暴露godaddy空间的路径啊。有闲心的话，还可以研究下攻击到挂在godaddy上的同IP的其他网站呢。呵呵。……

这个解决简单。直接该smiley.php文件的<a href=&#8221;javascript:grin(&#8216;:?:&#8217;)&#8221;><img src=&#8221;**这里面添加blog的地址，(eg:http://www.tanglei.name)**/wp-includes/images/smilies/icon\_question.gif&#8221; alt=&#8221;&#8221; /></a>当然可以用php的函数获取请求的url，我又试了试。结果发现$\_SERVER [参数&#8217;]，换了几个参数都不行，难得搞了。就写死吧，还提高效率一些。呵呵。_其实后来才发现Wordpress有函数调用<?php bloginfo(&#8216;url&#8217;); ?>就可以了。_

期间也遇到了什么鼠标放到那不显示alt内容，点击时，textarea没有反映之类的问题，又查，这篇文章也给了很好的解决方案《完美实现WordPress评论表情》http://ons.me/80.html。就是上面链接表情的url不用hre去链接，直接用onclick函数就可以了。显示alt提示内容时，用用CSS里面的cursor:pointer，就可以解决问题。唉，自己DIV+CSS确实知识不够啊啊。还有一点要说明的是，下面的表情，alt我难得手动一个一个加了。有的汉字是与表情对应的，有的不对应，也将就用吧。

Wordpress的index.php，single.php也改了下。加了分页显示，首页显示每篇文章的一部分内容[实际上是用php的函数去截取显示前面的内容的]，版权信息等等。丑是丑了点，不过都按照自己的想法去实现了，至于UI方面，就不勉强自己了。

不过我的评论模块还是不美观，就将就用吧。不想再装什么插件了。
