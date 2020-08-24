# 10 年 bloger 告诉你程序猿如何优雅地写博客

>关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。用不同的视角分享高质量技术文章，以每篇文章都让人有收获为目的，欢迎关注，交流和指导！公众号后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

石头大约在 2010 年左右有了自己的第一个域名，也是从那个时候开始写博客的。至今确实有 10 年时间了。

最初玩 blog，其实更多的还是抱着学习的态度。比如刚学习完了 DNS 解析，HTML 语法，不 “实战”一把么？后续陆陆续续把读书笔记、课程总结都往博客上放。

为什么要写 blog，我觉得有几个好处啦：

- 可以把它作为整理学习笔记的地方，方便沉淀学习，就跟当初我开始玩一样。更多的是写给自己看，玩玩“建站”流程（独立博客），也算一个小技能。
- “成就自己、帮助他人”。 在日常工作中，你肯定也有通过别人的博客解决了你的某个问题，这个时候“反哺”一下开放的互联网也何尝不是一件快事。当有人通过搜索引擎检索到你的内容并留言说感谢帮助他解决一个类似问题的时候，还是有一丝丝成就感的。
- 锻炼写作能力。一个问题自己懂和把它讲给别人懂，是两个完全不一样的概念。
- 打造个人 IP。例如著名的 coolshell，ruanyifeng 等，大部分人应该都知道吧？
- 赚钱。这个就不用多说了。（说出来，你可能不信，就连我 10 年前没啥内容的 blog，当初也有是有“外快”赚的：记得当初是给“友链”的方式导流，1 个月 5~10 块，刚好能覆盖我的域名、虚拟主机的费用。）
- ... 

通过这 10 年的摸索，石头也尝试过多种写 blog 的方法。不过说来惭愧，貌似也没什么说得出的成绩。

目前也积累了有 400+篇文章，不过感觉真正有质量的文章也就几十来篇。折腾过很多 blog 程序，陆陆续续迁移了好几个版本，历史文章也”舍不得”丢弃，也一直保留。其实好多文章在我现在看来好像价值不大，但扔舍不得抛弃，毕竟当初辛辛苦苦 po 出来的。感兴趣的同学可以通过 “www.tanglei.name” 这个网址进行访问。

![](http://www.tanglei.name/resources/how-to-blog-elegantly-as-a-software-engineer/image-20200823151456726.png)


## 我的博客之路

### 纯 wordpress

下图是我博客最初级的版本，在相当长一段时间内也一直用这个主题。

![Wordpress 博客](/resources/how-to-blog-elegantly-as-a-software-engineer/wordpress.tanglei.name.jpg)

“时光荏苒、岁月如梭”，上面的截图也很有意思——

- 右上角的动态“腾讯微博”，不知道你有没有用过？

- 左上角的 Rss 订阅，现在不知道是否还有人用，用的人多吗？反正我好久没打开我的订阅文章了。

用 Wordpress 写博客，有一个缺点就是，每次写需要登录后台，排版、配图等比较麻烦。并且还得掏钱买虚拟主机、自己运营维护wordpress 程序、MySQL 等。

再后来接触到 `markdown` 这个标记言，才发现这玩意太好用了，就一发不可收拾。一直用 markdown 写作沿用至今。

### wordpress + markdown 插件

博客主题想保留就一直还是用 wordpress，但有希望写作用 markdown。

由于没有找到合适的 wordpress 的 markdown 插件，于是就自己写了一个 [markdown2wordpress](https://github.com/tl3shi/markdown2wordpress)。后端框架等仍然用 wordpress，繁琐的排版等问题就直接交给 markdown，也不用登陆 wordpress 后台进行调整等操作。

这个工具依赖于 python-wordpress-xmlrpc，一个 python 实现的 wordpress 的客户端，可以方便调用 wordpress 提供的接口，markdown 的渲染依赖于 pandoc，代码高亮用的是 `highlight.js`
图片用图床的形式，或者直接以 github 外链的形式。

用这个工具又坚持了一段时间。

但石头当初买的虚拟主机（共享型）还是多个人公用的形式，性能较差，网站就经常挂，一会虚拟机挂了，一会MySQL又挂了，然后还中过木马。实在是忍受不了了。

### github page 服务

github page 服务 https://pages.github.com/，按照官网说的那样，直接将源文件托管在 Github 上，仅仅需要编辑、push即可，然后变化马上就能体现了。 

![image-20200823183039944](/resources/how-to-blog-elegantly-as-a-software-engineer/github-pages.png)

这样不但省去了虚拟主机、MySQL 等费用，同时 github page 还支持自定义域名、git 版本管理，markdown 自动渲染简直就是专门给程序员量身定做的（好像确实也是的）。

程序猿只用专注于写 markdown 文件即可，渲染 html 等都交给 gitub。

下图是我搭建后的一个截图。

![github和octopress配置](/resources/how-to-blog-elegantly-as-a-software-engineer/github-octopress.jpeg)

详细过程可以参考下我的这几篇 Blog：

- [GitHub搭建博客教程](https://www.tanglei.name/blog/use-github-to-make-hello-world.html)

- [也试试github+octopress](https://www.tanglei.name/blog/github-with-octopress.html) 

再搭建过程中，还会涉及到历史文章的迁移等，感兴趣的可以参考[最终还是放弃了Wordpress](https://www.tanglei.name/blog/give-up-wordpress-to-jekyll.html)。

github pages 服务的好处在于，博主们真正关注的只需要写 markdown 就可以了(类似写论文用 latex 一样)，根本不用去关注比如在 wordpress 后台排版，传图片等等操作。 

### github pages + travis-ci 

github pages 服务本身支持的博客引擎比较少，比如希望一些定制化的插件等，github pages 默认服务就不够了。

但本质上讲，github pages 服务就是提供了一个自定义域名解析到静态 html 的 repo。markdown 转 html 的这个过程， github 支持得不够，可以通过其他的方式。

比如本地写 markdown，然后本地安装 hexo 等博客引擎，渲染成 html 后直接 push 到 github page 的远程仓库即可。

我曾经也使用过多个博客引擎，如下图：

![jekyll博客主题](/resources/how-to-blog-elegantly-as-a-software-engineer/jekyll.tanglei.name.jpg)

![hexo主题](/resources/how-to-blog-elegantly-as-a-software-engineer/hexo.tanglei.name.jpg)

travis 是一款免费的 CI 工具，能帮你做的事情是啥？ 就是上面你本地的流程可以交给它来做。现在我写 blog 的流程是：

1. 本地写 blog，md 格式的。工具可以直接用之前推荐的 [程序员利器](https://mp.weixin.qq.com/s/PlDF6pn55vE1_7rusC3K2w) 中的 markdown 写作工具 Macdown 或者Typora。
2. git commit && git push 即可。
3. travis 开始工作，安装 blog 程序，然后 build 静态 html，最后 push 到指定的 github pages 仓库。

贴一下我的 travis 配置，大家就知道是怎么玩的了。

```json
branches:
  only:
  - master
language: node_js

# v14/stable(2020-05) produces empty html https://github.com/hexojs/hexo/issues/4257
node_js:
    - 'v13.8.0'

cache: npm

before_install:
- git config --global user.name "tangleithu"
- git config --global user.email travis@tanglei.name

install:
- npm install hexo-cli -g
- npm install

script:
- hexo clean
- hexo g
- git log | head -n 6
- export COMMIT=`git log | head -n 1`
- mv public .deploy && cd .deploy && du -sh
- git init && git add -A . && git commit -m "commit from travis, origin $COMMIT" 
- git push --force "https://tl3shi:$GITHUB_TOKEN@github.com/tl3shi/hexo.tanglei.name.git" master:gh-pages 
```

借助 travis 可玩的东西就多了。 

比如，是不是可以同一文章多个平台发。举例，现在大家普遍玩法是各大博客平台同步发表。是否可以直接在 CI 流程里面加 juejin、博客园等 post 流程呢？

感兴趣的朋友试试？（石头好久都有这个想法了，但却一直没有付出行动）

### 解决 github 慢的问题	 

用 github 确实很方便，各种免费的服务白piao，但缺点也比较明显，就是国内访问比好慢。gitee 也提供类似的服务，但前面看了一眼，自定义域名好像要收费？

一个比较简单的方法是用 CDN 来解决这个问题。 blog 本身全是静态资源，html、图片等，很适合用 CDN 来加速。 

在这篇[云服务器，域名备案及 CDN 服务体验](https://www.tanglei.name/blog/try-qcloud-vm-cdn.html) 文章中，我记录了之前具体的流程。

CDN 的工作流程就是你添加一个域名的 CNAME，指向 CDN 厂商的域名，所以用户发起请求的时候实际是解析到云厂商的 CDN 服务器的，CDN 后台配置一个源站点，例如 `www.tanglei.name`，用户请求到 CDN 服务器时，如果没有命中，则就去源站点请求并将内容缓存至 CDN 服务器。

以下是我之前测试 CDN 的一个效果截图。

![CDN配置效果图](http://www.tanglei.name/resources/qcloud/www.tanglei.me-ping-cdn.png)

下图是访问一个 [含有一些图片的页面](http://www.tanglei.name/blog/app-in-mac-for-common.html)的测试结果，其中： 

- 请求 `www.tanglei.name` 会直接路由到 github pages 的文件；
- 通过 `www.tanglei.me` 会走云厂商的 CDN；

![CDN测试结果tanglei.name](http://www.tanglei.name/resources/qcloud/tanglei.name-vs-tanglei.me-cdn.png)

访问一个 10K 的页面，基本在半秒就加载完毕了，对于个人博客来讲，已经很够用了。上图的结果还有一些如 USA 的节点拉低了平均值，国外的一些节点还是走 github 更快。如果有需求做全球加速的话，还可以用比如敝司的全球加速服务哦（CDN包括海外众多节点）。

## 最后

本文只是石头在探索过程发现觉得合适自己的方法，每个人喜欢的姿势可能不一样，仅供参考。希望你能找到适合你的姿势。

觉得本号分享的文章有价值，记得添加星标哦。别白 piao，需要来点正反馈，安排个 “一键三连”（点赞、在看、分享）如何？😝 这将是我持续输出优质文章的最强动力。

![](/resources/一键三连.gif)

