---
id: 2170
title: BibTex Batch Export|latex论文引用批量导出
date: 2013-06-22T22:04:10+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2170
duoshuo_thread_id:
  - 1351844048792453486
categories:
  - PHP
  - python
  - 敲敲代码
  - 经验技巧
tags:
  - Latex
  - 小工具
---
最近查阅文献，需要整理下所看论文，之前也没用过latex，这次从网上下了一个latex的论文模版，然后查看其引用格式是bibtex，之前下论文的时候也没注意将论文的引用格式保存下，嫌一个一个去http://scholar.google.com/搜题目，然后点site再下载麻烦，于是乎写了一个本地python脚本，完成了bibtex的批量导出，实验了下还不错(不考虑中文论文)。考虑到可能其他人也用的着，就改写成了web版的，如下，在文本框输入要批量导出的论文题目，一行一个。(为缓解服务器压力，一次只支持5个，这种东西只考虑了实用性，安全性等没考虑，**求别黑**！)点击get it，耐心等待会儿，下面就会把bibtex的格式显示出来，直接copy到你的引用文件.bib即可.
  
效果如图：
  


<center>
  <img width="400px" height="600px" src="/blog/tools.htmlbibtex-batch-export.png" alt="bibtex参考文献格式批量导出" />
</center>


  
**直接在如下文本框中输入论文标题，一行一个，然后点击&#8221;Get it&#8221; 即可**
  


若上面展示不清楚，请移步到这里：<a href="/blog/tools.htmlbatchbibtex.html" target="_blank">bibtex批量导出</a>
  
有任何疑问或者建议，请留言~

* * *[for SEO or practicing my english] </p> 

## How to Batch download bibtex data or how to batch export bibtex from google scholar?

Recently, I have to search and read some papers related to my research work.
  
At first time, I forgot to download the reference format of bibtex, when I want to site
  
someone&#8217;s paper, It&#8217;s boring for me to copy the title and search from scholar.google.com once and once again.
  
So I wrote a python script for me to download more than one paper per time. I have checked this script in my local computer, and it works well. Since I thought someone else may need this function, I changed this local script to Web version as above. If you cannot find it in this page, you can click [HERE](/blog/tools.htmlbatchbibtex.html).
  
You just need to copy the titles to the textarea(one line per paper), and then click &#8220;Get it&#8221;, after a while, you&#8217;ll get all
  
the references format of bibtex. Hope this script is useful.
  
You are welcome to leave a message below if you have any suggestion or any problem.
