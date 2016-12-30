---
title: 最终还是放弃了Wordpress
author: tanglei
layout: post
categories:
  - MyLife
tags:
  - Wordpress
  - 我做站长
---

### 起因

这个Blog搭建也有好多年了, 一直用Wordpress, 累计也Po了300+文章(虽然里面包括了刚开始搭建blog时放的大量水文), 自从慢慢用markdown作为写作(暂且用这个词吧)的主要工具以来，想换掉Wordpress的愿望越来越强烈。

曾经也写了一个[工具](/blog/codecolorer-adapted-to-highlight.html)， 只用了Wordpress这个外壳，写作的时候用markdown书写， 这个工具一方面满足了我的要求, 技术方案是: ``本地markdown+pandoc——>html——>wordpress-xmlrpc——>wordpress server``, 有兴趣的同学可以试用。 也用这个工具写了几个月的blog(然而并没写多少篇, 懒). 最近突然网上看到了Hexo这个框架，并发现了一个比较简洁的[Hexo主题](https://github.com/tufu9441/maupassant-hexo), 就准备试用下，效果[点击这里](http://hexo.tanglei.name), 如下图

![](/resources/give-up-wordpress-to-jekyll/try-hexo.tanglei.name.png)

然而并不是这么顺利.

### Hexo尝试

- Hexo环境安装等, 直接跟着[官网](http://hexo.io)来即可.
- 寻找主题，发现这两款 `` jacman, maupassant `` 不错.
- Wordpress导出markdown格式的文件用wordpress插件[jekyll-exporter](https://wordpress.org/plugins/jekyll-exporter/), 本地preview一下，发现了不少问题。一个一个说下这些坑.

- 分类目录重复的问题
    - 原因: 多级分类目录, 不能直接用wordpress导出的分类目录。 wordpress导出的分类目录多级的话, 在hexo就会显示重复（jekyll不会有这个问题）。比如 cat1 / cat2, cat3 / cat2 。 这里分类目录里就会显示两个cat2. 分别链接上cat1 / cat2, cat3 / cat2 。 如果修改category.jade种的 ``(list_categories({show_count: true, depth: -1}))`` 的话， 就会只把第一级cat列出来。 （jekyll 会把这些都列出来，没有层级概念）
    - Fix: `` themes/maupassant/layout/_widget/category.jade`` 中 ``list_categories({show_count: false, depth: -1})``
- 上线github看看效果
用了二级域名 `hexo.tanglei.name` (添加CNAME到gh-pages分支即可)
- 留言迁移

	用wordpress中的Disqus插件，将所有评论导出到Disqus. 此时操作的先后顺序注意域名。较好的方案是如果换blog框架不换域名的话，先访问wordpress将所有评论导出到Disqus后再切换域名指向新的github pages。不过这个也没关系，Disqus操作是将每个post的url和评论关联起来，如果域名换了，或者permalink换了，评论和页面就对应不上，Disqus就找不到原来相应post的评论。 不过Disqus提供了一个urlmapping的机制可以调整。可参考[Upload a URL mapping](https://hexo-tanglei.disqus.com/admin/discussions/migrate/)。

- 调整permalink

	我之前wordpress的blog的url都是形如 `www.tanglei.name/blog-url-id/`, 这样 Hexo就会生成很多`blog-url-id`这样的目录，访问这个页面请求时实际上是到`blog-url-id/index.html`， 这样不爽， 于是我将所有的permalink调整了， 变成 ``blog/blog-url-id.html``, ``_config.yml``可直接配置，但需要对wordpress导出的permalink进行调整. 例如将 ``permalink: /return-object-in-cpp-and-return-value-optimazation/`` 调整成 ``return-object-in-cpp-and-return-value-optimazation``， 用`sed`替换即可 ``sed -i "" 's|^permalink: /\([^/]*\)/|permalink: \1|' `ls *.md` ``

- pictures 迁移，改变链接，去掉host
   -  去掉绝对路径， 去掉host

      ```bash
      #去掉绝对路径
      sed -i "" 's|http://www\.tanglei\.name\/wp-content|/wp-content|g' `ls`
      ```
    - 修正一些图片格式因为缩进问题(例如``![](xx.pnag)``前面有tab符)被markdow误认为是``reference/preview block ``错误

      ```bash
      sed -i "" 's|[[:space:]]!\[|![|g' `ls`
      ```

- 代码高亮
    - 之前mardown2wordpress工具将代码插件变换后，export成md后，标签被转义了。

      ```html
      <pre>&lt;cc class="cpp">
      #include &lt;iostream>
      int main(int argc, char** argv)
      {
          std::cout &lt;&lt; "Hello world." &lt;&lt; std::endl;
          std::cout &lt;&lt; "argc: " &lt;&lt; argc &lt;&lt; std::endl;
          for(int i = 0; i &lt; argc; i++)
              std::cout &lt;&lt; argv[i] &lt;&lt; std::endl;
          int t;
          std::cin >> t;
          return 0;
      }
      &lt;/cc></pre>
      ```
整体进行替换

      ```bash
      sed -i "" 's|<pre>&lt;cc class="\([a-zA-Z]*\)">|```\1|g' `ls`
      sed -i "" 's|&lt;/cc></pre>|```|g' `ls`
      sed -i "" 's|&lt;|<|g'  `ls`
      
      sed -i "" 's|</cc></pre>|```|g' `ls`
      sed -i "" 's|<pre><cc>|```|g' `ls`
      ```
    - 还有codecolorer的一些插件生产的代码。

      ```bash
      sed -i "" 's|<cc lang="\([a-zA-Z]*\)">|```\1|g' `ls`
      sed -i "" 's|</cc>|```|g' `ls` 得新增一行
      &#038; --> & //&需要转义
      sed -i "" 's|&#038;|\&|g' `ls`
      ```
   - Hexo 不支持用用三个"`"进行代码高亮，也要进行调整。而这个github和jekyll都是支持的。所有Hexo官网声称的支持所有GFM也是假的。

- 其他资源
    - hexo generate 的时候 会删除 public folder 重新生成里面的每个文件
    - 这个自己写diploy脚本可以解决。

#### 放弃Hexo

最后的最后，尝试了这么多, 我最终并没有选择用hexo， 原因是~ Hexo build太慢太慢太慢了, 我build需要半个小时, 谁有空帮忙解决下啊， [repo在此](https://github.com/tl3shi/hexo.tanglei.name/tree/master)。目前原因还不清楚， 我也尝试了各种方法都不知道(虽然官网生成Hexo用nodejs比什么Jekyll之类的都快很多)。 太慢的原因并不是因为:

- 文章太多, 300+文章, 然后别人也有500+文章20+秒就build出来了。[ref](https://travis-ci.org/Xuanwo/xuanwo.github.io/builds/111696580)
- 代码高亮问题, 我关闭代码高亮也一样
- 分页，分类目录太多, tag太多, 我关闭分类目录和tag也一样，并且在build的过程中，并不是到最后`generate tags/xxx`才慢的, 	前面post也慢。
- 主题的影响， 我切换主题，用默认的主题也一样慢~ (Update: 之前测试的时候可能没有clean之类的没准，应该就是主题的原因，后面有时间再研究下)

没辙了~, 我不可能每次po一篇文章，发布的时候得半小时吧~ 况且后来用travis-ci，10分钟build不出来就被kill了。难道是因为wordpress 导出的markdown含有各种html标签导致hexo解析markdown很慢? maybe~

所以最终结果就是， hexo尝试了下， 并没有使用。 [hexo.tanglei.name](http://hexo.tanglei.name)这个域名也暂时保留并解析吧，后面哪天万一Jekyll用着不爽，Hexo升级fix了这个问题了，可能还会切过来了。

### 尝试Jekyll

最后还是用了Jekyll， 这个blog引擎之前就玩过， 切挂了我另外一个域名[tanglei.me](http://tanglei.me)。 为啥要换成这个呢:

- 反正不准备用Wordpress了，折腾了下Hexo，目前对于我来说不太合适
- 找了个还比较简洁清晰的主题, 就是现在用的这个, 虽然还很不成熟，但也趁这个机会熟悉下前端，慢慢摸索吧。主题源自[guovz](https://github.com/guovz/jekyll-pithy)， 本blog在基础上改了不少。
- gihub能够帮忙编译，本地写好markdown，自己commit就行了。(最后发现这个不太靠谱， 自己写的插件代码之类的github禁用了，比如原来主题的国际化之类的刚开始到github上就翻译不出来等。) 所以刚开始自己写了deploy的脚本，本地生成再push到github，这个时间还可以接受，二十几秒的时间。呃~ 最后才发现原来可以用[travis-ci](https://travis-ci.org/)这样的神器，果然我之前连这个玩意都不知道用。帮忙拉环境build代码并push。

![](/resources/give-up-wordpress-to-jekyll/try-jekyll.tanglei.name.png)
记录下在适配Jekyll的时候做的一些改动和Reference.


- 每个markdown中的permalink， 会覆盖全局的url设置, 将每个md中的permalink删除

  ```bash
  sed -i "" '/^permalink: /d' 2015-07-06-travel-to-northwest-of-china.md
  sed -i "" '/^permalink: /d' `ls`
  ```
- 删掉资源文件夹中，wordpress生产的缩略图 `find . -name "*-*x*"`
- tags 过多 ``for tag in site.tags limit:60 `` [Ref Liquid语法](https://docs.shopify.com/themes/liquid/tags/iteration-tags)
- post中的author如果没有的话就用全局的 [commitid](2c45efe74cd70c9778051763d127d9be3768eb05)
- [Jekyll 3.1.1 无法正确解析 GFM 的解决方法](http://jekyll-china.com/2016/02/jekyll-gfm-regression-issue/?utm_source=tuicool&utm_medium=referral)
- [github pages 支持的插件](https://pages.github.com/versions/)
- 最新的github支持rouge代码高亮[代码高亮](http://platinhom.github.io/2016/02/04/update-github-rouge/)
- disqus 评论 this.page.identifier 用了其他的identifier就加载失败， wordpress导出的会用 `` guid: http://www.tanglei.name/?p=2504 ``中的2504会失败, 直接改为url即可。
- git 当前分支push到远程另外分支上
`` git push -u origin local_branch_name:romote_branch_name `` 一般 remote_branch_name为空则远程会创建同名分支, local 和remote可以不一样，当使用了 -u 参数后，push local时候 默认的远程分支就是remote了
- disqus 总是加载有问题， 上传url mapping后。
   - 要么把script中的disqus_config注释掉，直接用完成的域名shortname，让disqus自己去匹配加载。
   - 要么 script中要加上`‘’`， 防止 script错误。 另外，`this.page.url = 'http://example.com/article/1/';` siteurl加上http://与disqus完全一致。[ref](https://help.disqus.com/customer/portal/articles/472007-i-m-receiving-the-message-%22we-were-unable-to-load-disqus-%22)

- 分页目录整理 之前总是 `/page1/, /page2/` 这样的，改成了 `/page/1/, /page/2/`
- tag权重整理
   - 删除只有1个的tag
   - 按照权重排序显示在首页 ~~TODO~~(最后还是在前端解决的)

- 分页太多，拆分, 可以[ref](https://github.com/levinxo/jekyll-blog/blob/master/_includes/JB/posts_paginator)
- 文章页面显示 前/后一篇 [Commit](https://github.com/tl3shi/jekyll.tanglei.name/commit/c85194471053db8e6f782b9d29f98ca5e64d27dd)
- 移动端Bug, 点击菜单不弹框 [commit](https://github.com/tl3shi/jekyll.tanglei.name/commit/b7a2bdda7d4cfef4359127c3b10a863ede56199a)
- 文章内链得重新修改
   - tag 替换 `` sed -i "" 's|http://www.tanglei.name/tag/|/tag/#|g' `ls`  ``
    - tag后面不能有 `/`

      ```bash
      #替换前 预览下
      sed 's|/tag/#\([^/]*\)\/|/tag/#\1|g' `ls` | grep '/tag/#'
      sed -i "" 's|/tag/#\([^/]*\)\/|/tag/#\1|g' `ls`
      ```
   - 其他链接 `` sed -i "" 's|http://www.tanglei.name/\([^/]*\)\/|/blog/\1.html|g' `ls` ``
   - 少数之前含有目录的链接就不对了, 其他的遇到了再改吧.

- 搜索引擎收录页面跳转。可以用插件jekyll-redirect, 但这个还是会生成太多的目录就放弃了。301 太麻烦，跳转就算了, 搜索引擎的链接404后，在404页面中用一个js跳转即可。(301的话，可以在原有的机器上写`htaccess`将原来的url访问跳转至新的， 过一段时间搜索引擎重新搜录新url后，再完全用static的html) [404页面请戳这里](/404.html)
- sitemap.xml  用插件 jekyll-sitemap.
-     图片响应式布局， wordpress导出时 自动添加了width， 在mobile端显示不友好.

      ```bash
      sed -i "" 's|width="[0-9]*" height="[0-9]*" border="0"||g' `ls`
      sed -i "" 's|width="[0-9]*" height="[0-9]*"||g' `ls`
      # 去掉所有img标签里的style
      sed -i "" 's|<img style="[a-z0-9 -:;]*"|<img|g' `ls`
      ```

- Disqus Bug
    - 首页无评论狂, 找不到 `` <div id="disqus_thread"></div> `` 因此报了一下错误`` "Cannot read property 'appendChild' of null" with Disqus ...``
    - Fix: 添加 ` if($("#disqus_thread").length) `

* 自动部署脚本deploy.sh 替换成 travis-ci
    - [travis添加环境变量](http://stackoverflow.com/questions/23277391/how-to-publish-to-github-pages-from-travis-ci)
	- [travis设置ssh](https://xuanwo.org/2015/02/07/Travis-CI-Hexo-Autodeploy/)

纪念我那逝去的Wordpress, 放截图一张如下， 暂时还可以用 [wordpress.tanglei.name](http://wordpress.tanglei.name)访问. 

![](/resources/give-up-wordpress-to-jekyll/wordpress.tanglei.name.png)
