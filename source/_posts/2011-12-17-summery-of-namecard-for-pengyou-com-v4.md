---
id: 1313
title: 朋友网V4生成名片并分享-工作小结
date: 2011-12-17T15:37:18+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1313
duoshuo_thread_id:
  - 1351844048792453393
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 实习那些事儿
tags:
  - php图片水印
---
最近的几天的主要工作就是朋友网V4版本[推出的名片](http://www.pengyou.com/leitang?view_type=card)分享发feeds。因为前台是DIV+CSS展示，前台截图生成图片不是那么的容易。因而交给后台来处理。其实后台也不容易啊。需要一个字一个字的画上去，之前也做了相关的[图片加文字](/blog/add-chinese-text-mark-to-picture-in-php.html)的工作。现在需要做的就是把文字内容和图片内容(用户头像)拼到大背景上去。然而有几个难点：

a)         能得到的图片，包括用户的头像信息，和用户设置的自定义的图片信息都是url，图片是存储在存储平台那边的，当然浏览器端要获得相应的图片非常简单，请求链接即可返回图片数据，然后后台服务器就不是那么简单了，没有DNS等解析，无法通过链接得到相应的图片数据，直接IP不可能，那么多图片不是存储在一台服务器上。后来采取的解决方案是通过代理，用一台代理机器，有DNS等服务器去请求，再将数据返回，通过curl去下载图片到服务器，进而再进行相应的拼图操作。

<p align="left">
  b)         在上一步的操作中，从去请求下载图片到拼图这一整个过程完成，需要耗费不少时间，同步做肯定用户受不了，于是要做成异步的，还好公司有一个异步请求的框架SAPS，能够解决这一问题。
</p>

c)         实际的逻辑处理工作，就是取用户的基本信息，还有用户设置的名片等详细信息进行拼图，这个过程比较繁琐一点，虽然没有什么技术含量，要一个一个去试，到底怎样的位置比较好。取用户头像跟名片信息画在一个画布上，再作为整体画在大背景上。如果是完全透明处理，则不用建中间小名片的画布，直接将头像和名片信息印在大背景上。前台的坐标值跟后台拼图时的坐标值是不对应的。还有就是图片压缩，用户自定义的图片过大或者过小，都使得生成的图片不怎么标准，最后上传至用户的相册中进而发分享展示feeds就不那么美观了。

<a href="http://s1123.photobucket.com/albums/l549/tl3shi/?action=view&current=namecard1.jpg" target="_blank"><img src="http://i1123.photobucket.com/albums/l549/tl3shi/namecard1.jpg" alt="Photobucket" border="0" /></a>

就这样，经过测试测试，测出了介绍的文字太长，我没有做截断处理。典型的边界问题，以后还得多注意。改后第一个版本就发出去了，然而后续相继出现了几个问题。首先遇到的一个问题就是，在预发布环境下，设置图片发分享等都OK。发布到外网就不行了。后来查是因为发分享时，分享的是一个跳转至用户名片页的链接，这个链接是相似的，仅仅用户的hash码不一致而已，因此就被安全中心个旁路了，因防止用户分享大量相似链接，这种链接包含广告等垃圾信息而采取的措施，解决方案就是周知安全中心，加白名单，因而能够顺利分享出去。还有一个问题是因为自己的疏忽造成的，拉去用户的头像图片和用户自定义的大背景图片到本地时，我都采取了以QQ号作为标志存储，然后却忽略了中间小名片，我都生成了一章相同文件名的临时文件。这样就悲剧了，高并发数据请求过来，生成的名片信息完全可能出现了，你的名片信息打印到了我的背景上面，本来是A分享出来的数据，结果上面的B的名片信息。还好当时安全中心旁路的原因没有给发出去，否则后果不堪设想啊。

因为开始安全中心旁路的原因，导致分享失败，滞留了两个多小时吧，在SAPS里面的消息队列里堵住了，滞留了10W+的用户请求，后来处理问题后加白名单，才慢慢看到用户分享出来的数据，当时晚上高峰期间，处理速度<请求速度，saps队列不断增长，最后可能导致宕机。可能采取的办法是增加saps服务器，后leader说先等一晚上处理后再说，第二天队列正常。

发布到外网后，还遇到了一个bug，就是如果用户设置完全透明，且是白色背景。点击设置名片模版，在[这里可以设置](http://profile.pengyou.com/index.php?mod=profile&view_type=card)，看不到名片信息。后来查是因为这个原因：

```phpbool imagecopymerge ( resource $dst_im , resource $src_im , int $dst_x , int $dst_y , int $src_x , int $src_y , int $src_w , int $src_h , int $pct ) Copy a part of src_im onto dst_im starting at the x,y coordinates src_x, src_y with a width of src_w and a height of src_h. The portion defined will be copied onto the x,y coordinates, dst_x and dst_y. pct
The two images will be merged according to pct which can range from 0 to 100. When pct = 0, no action is taken, when 100 this function behaves identically to imagecopy() for pallete images, while it implements alpha transparency for true colour images.```

<p align="left">
  即将 src_im 图像中坐标从 src_x，src_y 开始，宽度为 src_w，高度为 src_h 的一部分拷贝到 dst_im 图像中坐标为 dst_x 和 dst_y 的位置上。两图像将根据 pct 来决定合并程度，其值范围从 0 到 100。当 pct = 0 时，实际上什么也没做，当为 100 时对于调色板图像本函数和 imagecopy() 完全一样，它对真彩色图像实现了 alpha 透明。我在处理过程中，直接取了用户设置的透明度，忽略了前台CSS透明度和后台php函数处理参数不一致。
</p>

<p align="left">
  第一个版本发出去后，收到各种产品要说需求要变更，各种痛苦，难怪人人上有一个这样的状态
</p>

> <p align="left">
>   你TM再改，还让不让人睡觉了！！！转自张剑光.class: 需求又改了？改你妹，心里暗暗骂一句，骂完继续苦逼的改代码转自柴一平: 额~转自王丹:转自刘登科:转自段晴:转自刘科: 需求又改了？不如死了算了，一了百了。需求是魔鬼。转自邱从贤: 转自何亮: 转自瑞小熊~~♪:: 转自沈隆:【程序员遇车祸成植物人 需求改动将他唤醒】北京某互联网公司程序员王某遭遇车祸成植物人,医生说活下来希望只有万分之一,唤醒更为渺茫.他的Leader和亲人没放弃,他们根据王某视工作如命的作风,每天都在他身边念:“需求又改了,该干活了!你快来呀!”奇迹终于发生,王某醒过来了,第一句话:“需求又改了?” &#8212;&#8212;这是喜剧还是悲剧？？？？      ”
> </p>

<p align="left">
  ——深深体验到了这一点。
</p>

<p align="left">
  后来跟产品，开发等几个人碰头敲定，再改。这下要求产品给出明确的需求了，找设计商量好后，最后的效果到底要怎么样才算OK。给出了设计图，字体字号间距等都给了我。开发确实苦逼，按照设计师给的，还得给出效果图给她看，然后不满意，再改……呃，不过这个改让我也好受点儿嘛，至少不让前一个版本那样，需求一点都不明确，大小之类就由我拍板定，最后效果不满意还得自己慢慢改。下一个版本估计下周会发.这个版本把中途的小名片突出了下。
</p>

<p align="left">
  <img class="alignnone" src="http://i1123.photobucket.com/albums/l549/tl3shi/namecard.jpg" alt=""  />
</p>

<p align="left">
  以前上项目管理的课的时候也提到过，需求等等一旦定下来，要开发啊产品啊等等签字确认OK，后面再改就没有话说了，现在公司的敏捷开发也用到了这个，比如要求开发自测，得在需求单上注明开发已经自测通过，产品也体验过，再转交测试……这样，也有证据了，再遇到什么问题，证据确凿，各自的环节出了问题也没有啥话可说了。
</p>
