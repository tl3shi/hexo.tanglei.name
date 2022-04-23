---
title: 博客的图都挂了~
layout: post
categories:
  - MyLife
tags:
  - 总结
  - 转载
---

> 关于程序员石头(ID: tangleithu)：从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接]()，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

大家好，我是石头哥。 

有朋友告诉我，我的博客上的图片基本都挂了。

啊，要不是别人提醒，我都忘记了，我还有个博客。 ：） 

哈哈哈哈，主要是博客我自己基本也都不主动访问了，还是有一些 N 多年前的 blogger 好友会通过 rss 订阅的方式看到更新。说实话，我自己通过 feedly 订阅的博客也好久没看了。

目前博客上的文章，都是本地 `git` 管理，`push` 之后，就自动的 `deploy` 更新了。

之前的这篇文章记录了我写博客的缘由以及严谨过程 —— [10 年 bloger 告诉你要不要写博客，又该如何优雅地写博客？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488750&idx=1&sn=bddb76b8e85d04b303b3d10024b8a56b&chksm=eb47150adc309c1cfe5f847acaf6a3eb7de3efb3c7f2a87e708a686a740aa364c33c80ea3000&token=1931883326&lang=zh_CN#rd) 

图片挂了，是因为将 gitee 仓库作为图床被加了防盗链了，毕竟流量得花钱的！

## 说说图床

谈到图床，从开始用 wordpress 到后面的静态博客系统，期间都使用过不少的图床。

![Wordpress 博客](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/wordpress-blog.png)



还记得很多年前就过某国外的图床 XX（忘记名字了），各种被压缩、加水印、甚至打广告等等，从那时起就明白，自己的图片资源，一定得掌握在自己手中才是硬道理。

所以不管博客系统几经变更，我的历史文章也都意义保留了下来，甚至最开始的 wordpress 的评论数据我都还有。

再后来，基本用 github pages 服务作为免费博客系统进行托管，前面加一层 CDN 即可解决网络慢的问题。

因此也就从用 github pages 起就一直用 github 图床，因为网络不稳定，得挂梯子；后来考虑网络更快，改到 gitee，没想到没用多久，就挂了。



![picture-load-failed](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/picture-load-failed.png)![]()



## 解决方法

因为图片资源一直在自己手里，因此解决方法也非常简单：

1. 下载原图片文件，直接 clone 即可。（其实也可以用 git submodule 的方式，link 一下，CI 自动 deploy 的时候下载即可）

![image-20220405004126237](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004126237.png)

2. 用 `sed` 命令批量替换图片即可，再次推荐[提升开发效率N倍的20+命令行神器!(附 demo)](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489026&idx=1&sn=cf1650652a44d65730c5ee04258ad9e1&chksm=eb4717e6dc309ef037674943645abe8356aa726416ea46f3349ba227520bd40c95f8a49aa3e5&token=1931883326&lang=zh_CN#rd)

![image-20220405004625844](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004625844.png)

一条简单的命令行即可搞定~

``````shell
sed -i "" 's|https://gitee\.com/tangleithu/blog-resources/raw/master|/resources/gitee-blog-resources|g' 2022-01-18-experience-with-work-at-amazon-II.md
``````

再 `git diff ` 一下，已经 ok 了。 

![image-20220405004856721](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004856721.png)

然后 `git push` 一把，看看效果如何？—— 问题解决。

![image-20220405114818417](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405114818417.png)

当然，大家也可以用一些类似阿里云 OSS 对象存储等服务，保存自己的图片，同时也可以开 CDN 服务的。再结合一些编辑器的插件等，写文章还是效率不错的。

不过，再次提醒大家，图片资源等一定要掌握在自己的手中哦，不要轻信一些第三方图床，不然说没了就没了。

## 后记

最后，平时多学几个 shell 命令防身，还是相当不错的，必要时可以节省不少时间，可以看看之前写的提效工具系列文章 —— [开发效率](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1514114646939648003&scene=173&from_msgid=2247489026&from_itemidx=1&count=3&nolastread=1#wechat_redirect)。

推荐阅读：

- [Mac 神器 —— Alfred 免费下载](https://mp.weixin.qq.com/s/oivV09c1n168DE5o108ZMQ)

- [优秀的程序员是如何利用工具来提升工作效率的？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247487786&idx=1&sn=842202cc524477ec1546b4747bdbf1a8&chksm=eb4710cedc3099d86953451729c7f569866e6e58abbbec5c7ebe7423d12e1f11e189bb417f80&scene=178&cur_album_id=1514114646939648003#rd)
- [有了这几个神器，瞬间逼格就上去了](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&token=551126633&lang=zh_CN&scene=21#wechat_redirect)

微信修改了推送机制，还请记得星标、在看、点赞、留言多互动，这样才能让我的文章及时送达到你手中，ღ 笔芯 。

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

