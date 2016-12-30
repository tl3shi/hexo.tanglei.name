---
title: Mac 软件推荐(序)
layout: post
categories:
  - 经验技巧
tags:
  - 经验技巧
  - 工具
  - Mac
---

如果你在使用 Mac 电脑, 并且没有如某些人那样愚蠢地安装 Windows 系统, 那么你可以尝试使用以下一些软件. 下面的这些软件都是我自己使用过且觉得还不错的, 在这里推荐给大家.  或者可以极大地提高效率或者可以足够装13. (注: 这里的软件不一定是软件开发者才会使用到的)

##  Alfred v2

这个软件很多文章都在说, 我这里就不多做介绍了. 其具体效果跟 Mac 自带的 Spotlight 类似, 但功能会强大 N 个数量级倍. 我居然不是12年底刚接触 Mac 时用的她(为啥当初没人推荐给我, 直到我快工作了才用上). 如果你看到这篇文章且还没有用, 就赶紧用起来吧. 免费版本的功能也都挺强悍的. 

举例说下常用的几个功能:  

- 文件搜索, 类似 windows 版本的 everything. 设置某个标识(示例中为 "'")开头, 后面为关键字就开始全盘索引(当然可以配置过滤)了, 找到搜索到的文件后, 按 "->" 出现二级菜单, 下一步的操作. 比如复制, 以此命令行 `cd` 到文件/目录(后面有类似的工具推荐), 复制文件路径(finder 不比 windows 能够方便 copy 文件路径)等.

![alfred-file-search](/resources/app-in-mac/alfred-file-search.png)

- 搜索引擎搜索, 同样可以设置关键字, 比如 "google keywords", 回车就能直接打开 google 搜索. 默认的有 google/wiki/gmail/amazon等等, 这个还可以自己方便添加更多的 search, 比如 baidu 等等. 

- 其他的比如, 联系人搜索, 快捷功能(lock/sleep/shutdown)等等, 计算器(直接输入等式即可), 输入应用名称快速打开应用等等.

![alfred-quick-search](/resources/app-in-mac/alfred-quick-search.png)

Workflow 是其更强大的卖点. 比如以下一些或者极其高效或者很有意思的 workflow. 

- Dash: 程序员神器啊. 结合 Dash, 能够非常方便快捷地搜索某种语言的某个 API, 再也不用边写边打开浏览器去搜索了. 遇到了 某个 API 不太清楚, 直接 `ctrl + blank` 输入关键字就直接模糊搜索某 API 了.
![alfred-dash](/resources/app-in-mac/dash.png)
- stackoverflow: 程序猿, 你懂得. 同样设置关键字(例如 `st keywords`) 就能直接搜索 stackoverflow 上相关问题. 相当于在 google 搜索中 `keywords site:stackoverflow.com`;
![alfred-stackoverflow](/resources/app-in-mac/alfred-st.png)

- youdao 翻译, 遇到中英文翻译问题不用再打开浏览器去搜索了. (当然Mac 自带的取词翻译功能也挺不错的: 不知道? 选中关键字, 三指轻点 trackpad )
![alfred-youdao](/resources/app-in-mac/youdao.png)
![mac-translate](/resources/app-in-mac/mac-translate-trackpad.png)
- zhihu: 知乎搜索及知乎日报, 可以设置关键字直接知乎搜索, 或者列出当天的知乎日报推荐列表.
![alfred-zhihu](/resources/app-in-mac/zhihu-daily.png)
- douban: 豆瓣的相关功能, 豆瓣读书/电影等.  最近听到同事谈论某电影, 想看豆瓣评分多少? 很简答, 直接 `movie 电影名` 就出来结果了, 如图
![alfred-douban](/resources/app-in-mac/douban-movie.png)
- tianqi: 调用百度的 API 实现的快捷天气预报
![alfred-weather](/resources/app-in-mac/baidu-tianqi.png)
- mail: 快速搜索邮件
![alfred-mail](/resources/app-in-mac/mail.png)
- 印象笔记(evernote): 快速搜索印象笔记/evernote 中保存的内容
这个得首先去 [印象笔记官网](https://app.yinxiang.com/api/DeveloperToken.action) 生成一个 token, 然后安装好 [alfred-evernote](https://github.com/tl3shi/alfred-evernote)后, 配置好(es-token 你自己的generated-token) token 成功后就可以使用了. 查询有不同的语法格式, 详情可以看[这里](https://dev.evernote.com/doc/articles/search_grammar.php). 

![alfred-印象笔记 workflow](/resources/app-in-mac/alfred-es-search.png)

搜索后直接回车打开是默认在应用程序中打开, 按住 cmd 后会在浏览器中打开(由于最开始开发的作者是国际版 evernote, 中国版补丁的作者也忘记改这个链接了, 所以在浏览器中打开的跳转链接不对, 直接下载我修改后 workflow 是 OK 的 [github](https://github.com/tl3shi/alfred-evernote)), 其实就是修改一下其中的 `app.js`中的 `get-link`方法.

当然还有更多其他好玩有用的 workflow, 你可以直接到[github 这里](https://github.com/hzlzh/AlfredWorkflow.com)"选购", 没有的, 你也可以自己实现(也比较简单, 用 php/python 等都可以实现, 你打开 alfred 设置项, 双击具体某个 workflow 就能看到源码)一个也贡献出来哦. 


*未完待续*...

p.s 其实刚开始是准备1篇写完的, 但目前到此结束一篇了. 一方面内容确实有点多, 另外一个方面也从文章数量上让这公众号多点, 阴险脸.  再一个方面, 大家如果没有使用的, 也可以按照我这个推送节奏1次使用或者熟悉1个软件. 

p.p.s 如果你觉得这文章对你有那么一点点收获, 能帮忙转发一下么. 么么哒 

-----
本文同步发于"唐磊coder"微信公众号(tangleithu)(较微信原文有修改), 欢迎有兴趣的同学扫码关注, 谢谢.

![微信公众号](/resources/wechat-tangleithu.jpg)
