---
title: 我的博客之路
layout: post
categories: 
  - 经验技巧
tags: 
  - Blog
  - 经验技巧
  - 我做站长
---

我大约在2010年左右有了自己的第一个域名, 也是从那个时候开始搭建博客的. 第一个域名是 `i3zhai.com` "爱山寨", 也是从哪个时候开始玩网站的. 想当初, 还挂了一个 BBS, 就以 "山寨" 产品推荐和评测为主, 想着可以通过一个论坛来赚广告费呢. 然而并没有发现有什么点击量, 后来就放弃了. 

刚开始就用这个 `i3zhai.com` 域名搭建了 Blog, 后台搞起了 wordpress, 慢慢接触一些 Blog 的玩法. 比如可以在 Blog 上挂一些广告外链赚点广告费啊(基本上能够抹平域名+虚拟主机的钱), 感觉这个域名太"山寨"后来就直接换成了我现在的主要域名 `tanglei.name`, 意思说从2010年开始这个博客就一直存在了, 目前400篇文章左右, 大部分是水文, 感觉真正有质量的文章也就几十来篇吧. 其中还包括当初复习考试的一些笔记啊等. 陆陆续续迁移了好几个版本, 历史文章也"舍不得"丢弃, 也一直保留着. 其实好多文章真没什么价值, 也舍不得抛弃, 毕竟当初辛辛苦苦 po 出来的, 也就这样保留着吧, 记录一下"历史"进程. 

我的 blog 主要经过了一下几个历程: 

### 纯 wordpress

![唐磊的 wordpress 博客](/resources/blog-historys/wordpress.tanglei.name.png)

这是最初级的版本, 相当长一段时间内也一直用上面这个主题, 后来接触到 `markdown` 这个标记语言, 发现这玩意太好用了, 就一发不可收拾, 但想着这个主题用着也挺好的, 也不想换, 于是演化出了第二个版本

### wordpress + markdown 

由于没有找到合适的 wordpress 的 markdown 插件, 于是就自己写了一个 [markdown2wordpress](https://github.com/tl3shi/markdown2wordpress). 后端框架等仍然用 wordpress, 繁琐的排版等问题就直接交给 markdown, 不用登陆 wordpress 后台进行调整等操作. 

这个工具依赖于python-wordpress-xmlrpc, 一个 python 实现的 wordpress 的客户端, 可以方便调用 wordpress 提供的接口, markdown 的渲染依赖于 pandoc, 代码高亮用的是 `highlight.js`
图片用图床的形式, 或者直接以 github 外链的形式. 

因此我用这个工具又坚持了一阵, 当然这期间也[尝试过使用一些 octopress 等博客引擎](https://www.tanglei.name/blog/github-with-octopress.html), 但一直没找到一个顺眼的主题. 

### jekyll 


![唐磊的 jekyll 博客](/resources/blog-historys/jekyll.tanglei.name.png)

再后来, 发现 wordpress 还是太臃肿了, 于是就直接抛弃了. 这篇博文记录了迁移过程: [最终还是放弃了Wordpress](https://www.tanglei.name/blog/give-up-wordpress-to-jekyll.html)

jekyll或者octopress这类的博客引擎的好处在于, 用 markdown 书写, 编译后直接生成 html, 直接 host 在 github 上即可. 因此我用 github pages host 了我的博客近1年左右. 

目前比较流行的轻量级博客解决方案都是类似的方式, 前端用便于书写的 markdown, 渲染成 html, 用github pages 或者 coding.net 等托管静态 html. 

在于做的好处在于, 博主们真正关注的只需要写 markdown 就可以了(类似写论文用 latex 一样), 不用去关注比如在 wordpress 后台排版, 传图片等等操作, 还可以借助 `travis-ci` 这样的工具, 写完文章后 `git push` 一下即可, **CI** 负责自动 pull 代码, build 代码生成 html 并 deploy 到 github pages 等相应 server 上.  (github pages 本身也提供自动 build 等功能, 但其依赖的工具有限, 比如只能用有限的 jekyll 插件等, 而 `travis-ci` 不一样, 差什么工具自己加一条命令安装一下即可.) 

### hexo 

![唐磊的 hexo 博客](/resources/blog-historys/hexo.tanglei.name.png)

最近又看了一下之前折腾的 hexo 框架, 发现了一个不错的主题模板如上图所示, 正在考虑是否要迁移到 hexo 上呢. 其实之前 hexo环境就一直有, 只需要切换主题即可, 点击 [hexo.tanglei.name](http://hexo.tanglei.name/) 即可看到效果. 

因为之前用的 jekyll 那个模板总体感觉还行, 但我总体感觉不如hexo.tanglei.name 这个好看, 由于都是 markdown, 所以切换起来相对比较容易. 

其实现在这种静态博客系统的优点有了, 缺点也有, 比如一些动态的东西就需要依赖于第三方服务. 比如

1. 留言系统: 用得较多的是 duoshuo 和 disqus, disqus 国内被墙, 多说貌似现在也处于半死状态, 没人维护了. 
2. 搜索: 简单的搜索可以借助 Google / Baidu 等搜索引擎, 通过 `keywords site: www.tanglei.name` 检索限制关键字来源在搜索引擎的系统里. 但如果搜索引擎没有收录完全等就搜不到了. 最近切换hexo主题还知道了有专门做搜索服务的公司 swiftype, 提交一个网站入口给 swiftype, swiftype 会抓取你整个网站, 然后做 index 等, 最后提供接口供搜索. (果然卖服务的公司越来越多)

![](/resources/blog-historys/hexo.tanglei.name-search.png) 
	
目前博客主题还没切换, 要不大家投个票, 看哪个风格更好看? 