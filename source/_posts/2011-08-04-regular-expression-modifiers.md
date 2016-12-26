---
id: 1090
title: php正则表达式修饰符
date: 2011-08-04T22:40:01+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1090
duoshuo_thread_id:
  - 1351844048792453421
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - PHP
tags:
  - PHP
  - 正则表达式
---
看代码看到类似 

```phppreg_replace('/[\n\r]/is', '', $str);```

的东西，没搞明白/is的意思，前面那篇文章也没说。后来查了下才明白是修饰符。看看下面这篇文章,学习下。

我们在<span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">正则表达式的学习中会碰到修饰符，那么关于</span><span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">正则表达式修饰符的理解以及使用我们需要注意什么呢？那么我们来具体的看看它的概念以及相关内容。在学习</span><span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">正则表达式修饰符之前先来理解下贪婪模式，前面在元字符中提到过</span><span style="font-family: 'Times New Roman';">&#8220;?&#8221;</span><span style="font-family: 宋体;">还有一个重要的作用，即</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">贪婪模式</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">，什么是</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">贪婪模式</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">呢？</span>

PHP<span style="font-family: 宋体;">正则表达式贪婪模式：</span>

比如我们要匹配以字母<span style="font-family: 'Times New Roman';">&#8220;a&#8221;</span><span style="font-family: 宋体;">开头字母</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">结尾的字符串，但是需要匹配的字符串在</span><span style="font-family: 'Times New Roman';">&#8220;a&#8221;</span><span style="font-family: 宋体;">后面含有很多个</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">，比如</span><span style="font-family: 'Times New Roman';">&#8220;a bbbbbbbbbbbbbbbbb&#8221;</span><span style="font-family: 宋体;">，那正则表达式是会匹配第一个</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">还是最后一个</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">呢？如果你使用了贪婪模式，那么会匹配到最后一个</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">，反之只是匹配到第一个</span><span style="font-family: 'Times New Roman';">&#8220;b&#8221;</span><span style="font-family: 宋体;">。</span>

PHP<span style="font-family: 宋体;">正则表达式贪婪模式使用实例：</span>

1 /a.+?b/

2 /a.+b/U

对比不使用贪婪模式的实例如下：

3 /a.+b/

上面使用了一个修饰符<span style="font-family: 'Times New Roman';">U</span><span style="font-family: 宋体;">，详见关于修饰符的介绍。</span>

PHP<span style="font-family: 宋体;">正则表达式修饰符的理解：</span>

在<span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">正则表达式里面的修饰符可以改变正则的很多特性，使得正则表达式更加适合你的需要（注意：修饰符对于大小写是敏感的，这意味着</span><span style="font-family: 'Times New Roman';">&#8220;e&#8221;</span><span style="font-family: 宋体;">并不等于</span><span style="font-family: 'Times New Roman';">&#8220;E&#8221;</span><span style="font-family: 宋体;">）。</span>

PHP<span style="font-family: 宋体;">正则表达式修饰符的种类及介绍：</span>

◆i <span style="font-family: 宋体;">：如果在修饰符中加上</span><span style="font-family: 'Times New Roman';">&#8220;i&#8221;</span><span style="font-family: 宋体;">，则正则将会取消大小写敏感性，即</span><span style="font-family: 'Times New Roman';">&#8220;a&#8221;</span><span style="font-family: 宋体;">和</span><span style="font-family: 'Times New Roman';">&#8220;A&#8221; </span><span style="font-family: 宋体;">是一样的。</span>

◆m<span style="font-family: 宋体;">：默认的正则开始</span><span style="font-family: 'Times New Roman';">&#8220;^&#8221;</span><span style="font-family: 宋体;">和结束</span><span style="font-family: 'Times New Roman';">&#8220;$&#8221;</span><span style="font-family: 宋体;">只是对于正则字符串如果在修饰符中加上</span><span style="font-family: 'Times New Roman';">&#8220;m&#8221;</span><span style="font-family: 宋体;">，那么开始和结束将会指字符串的每一行：每一行的开头就是</span><span style="font-family: 'Times New Roman';">&#8220;^&#8221;</span><span style="font-family: 宋体;">，结尾就是</span><span style="font-family: 'Times New Roman';">&#8220;$&#8221;</span><span style="font-family: 宋体;">。</span>

◆s<span style="font-family: 宋体;">：如果在修饰符中加入</span><span style="font-family: 'Times New Roman';">&#8220;s&#8221;</span><span style="font-family: 宋体;">，那么默认的</span><span style="font-family: 'Times New Roman';">&#8220;.&#8221;</span><span style="font-family: 宋体;">代表除了换行符以外的任何字符将会变成任意字符，也就是包括换行符！</span>

◆x<span style="font-family: 宋体;">：如果加上该修饰符，表达式中的空白字符将会被忽略，除非它已经被转义。</span>

◆e<span style="font-family: 宋体;">：本修饰符仅仅对于</span><span style="font-family: 'Times New Roman';">replacement</span><span style="font-family: 宋体;">有用，代表在</span><span style="font-family: 'Times New Roman';">replacement</span><span style="font-family: 宋体;">中作为</span><span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">代码。</span>

◆A<span style="font-family: 宋体;">：如果使用这个修饰符，那么表达式必须是匹配的字符串中的开头部分。比如说</span><span style="font-family: 'Times New Roman';">&#8220;/a/A&#8221;</span><span style="font-family: 宋体;">匹配</span><span style="font-family: 'Times New Roman';">&#8220;abcd&#8221;</span><span style="font-family: 宋体;">。</span>

◆E<span style="font-family: 宋体;">：与</span><span style="font-family: 'Times New Roman';">&#8220;m&#8221;</span><span style="font-family: 宋体;">相反，如果使用这个修饰符，那么</span><span style="font-family: 'Times New Roman';">&#8220;$&#8221;</span><span style="font-family: 宋体;">将匹配绝对字符串的结尾，而不是换行符前面，默认就打开了这个模式。</span>

◆U<span style="font-family: 宋体;">：和问号的作用差不多，用于设置</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">贪婪模式</span><span style="font-family: 'Times New Roman';">&#8220;</span><span style="font-family: 宋体;">。</span>

PHP<span style="font-family: 宋体;">正则表达式修饰符的相关内容就向你介绍到这里，希望对你了解和掌握</span><span style="font-family: 'Times New Roman';">PHP</span><span style="font-family: 宋体;">正则表达式修饰符有所帮助。</span>

<hr size="1" />
