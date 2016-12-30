---
id: 2494
title: 跨平台文本文件及缓冲区的一个坑
date: 2014-07-06T15:02:44+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2494
duoshuo_thread_id:
  - 1351844048792453508
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 除臭虫
tags:
  - C++
  - Windows
  - Mac
---
此坑是参加微软秋令营活动下午编程测试时踩上的，编程测试题目本身不算难，难的是……对于没有ACM之类比赛的同学来说，要按照其要求读入输入和输出相应格式的结果来说就呵呵了。一个小算法总共可能花40分钟的时间，有30分钟的时间是用来解决输入输出的。对于平时在实验室写项目的同学来说，应该不会有太多的机会去写底层std io 和 file io，应该都封装好了，写具体逻辑吧。 不过从另外一个方面也说明了自己基础还是掌握得不牢固呀~比如不记得控制精度输出的函数等之类的。另外提醒下做类似的题目得小心输入输出格式及下面要讲到的缓冲区的问题。

编程测试是这样的，测试前，工作人员将题目和题目的输入数据等通过U盘copy给你，然后自己读题做题，最后再将自己的代码及输出结果copy回U盘~(微软收集U盘后统一对结果进行check。突然发现要是check答案的程序在匹配标准答案的文件和我输出的文件是没有注意本文提到的问题，那就又呵呵了)。

实际上，问题也不大，就是文本文件行末换行符的问题，下意识可能会注意这个问题，但在上述的情景下，忘掉这个问题也是情有可原的 :)

下图SampleInput是U盘copy到mac上的文本文件(Windows环境下生成的)，SampleInput2.txt是在mac下打开SampleInput.txt的内容，然后copy再保存的，**表面**内容是一样的。

[<img title="Image" src="/wp-content/uploads/2014/07/Image_thumb.jpg" alt="Image"  />](/wp-content/uploads/2014/07/Image.jpg)

然后看下面的代码，就是读取文件里面的前两行并输出。

[<img title="Image(1)" src="/wp-content/uploads/2014/07/Image1_thumb.jpg" alt="Image(1)"  />](/wp-content/uploads/2014/07/Image1.jpg)

(g++编译)运行结果：

[<img title="Image(2)" src="/wp-content/uploads/2014/07/Image2_thumb.jpg" alt="Image(2)"  />](/wp-content/uploads/2014/07/Image2.jpg)

前面也提到结果是因为Win下换行符和Mac下换行符的不一致的问题，不过思考下输入SampleInput.txt的**输出结果为啥是**?

```plain
:6c|1
:12dedcba|1
```

vim -b file 可以看到^M~ （注意替换^M时输入应该是：ctrl+v,ctrl+m / 也可以用\r）

[<img title="Image(3)" src="/wp-content/uploads/2014/07/Image3_thumb.jpg" alt="Image(3)"  />](/wp-content/uploads/2014/07/Image3.jpg)

vim 打开后,通过命令 **:%!xxd** 可以查看文件二进制格式，【新技能Get】。

SampleInput2.txt
  
[<img title="Image(4)" src="/wp-content/uploads/2014/07/Image4_thumb.jpg" alt="Image(4)"  />](/wp-content/uploads/2014/07/Image4.jpg)

SampleInput.txt

[<img title="Image(5)" src="/wp-content/uploads/2014/07/Image5_thumb.jpg" alt="Image(5)"  />](/wp-content/uploads/2014/07/Image5.jpg)

查看ASCii表，0a(10)换行, 0d(13)回车，&#8221;回车&#8221;是告诉打字机把打印头定位在左边界；&#8221;换行&#8221;，告诉打字机把纸向下移一行（参考[回车与换行](http://www.ruanyifeng.com/blog/2006/04/post_213.html)：原文说windows行末是\r\n, linux/unix是\n, 而mac是\r，不过从上面可以看出我的mac osx也是\n, Ruanyifeng06年post的这篇，应该是Apple做了改变和unix/linux保持一致了吧?）。

回到前面的一个疑问，即读取Windows下的那两行并输出结果的问题，来看看结果的第一行 ``6c|1`` ，冒号后面的应该是字符串的长度6，可以看出里面除了“abc|1”外，还有那个回车“\r”，这里其实是因为输出缓冲区的问题，IO设计者为了提高效率不会说接受到IO指令就往设备输出，应该是达到一定长度后再统一一次输出。默认情况下标准输入(stdin)和标准输出(stdout)是行级缓冲区，stderr是无缓冲的(不同实现可能不一样)，“abc|1”放到缓冲区了,然后\r，前面也提到效果就当前打印机头(这里就是当前缓冲区输入指针)直接回退到开头，然后再放“:”(覆盖了之前缓冲区里面的值“a”)和长度6(覆盖“b”)于是缓冲区里的数据现在是”:6c|1”，现在遇到了换行符std::endl，换行输出到设备(控制台)。

同理，“abcdedcba|1“遇到\r后直接到行首, 再”:12”，最后输出“:12dedcba|1”。

再举个例子，如下代码应该是直接输出“Hello world.”

```cpp
//"Hello world."
void testr()
{
    char ss[] = "abcd\refgh";
    cout << ss << "1234";
    cout << "0000" << (char)(13) << "Hello world." << endl;
}
```

另外，提醒下Xcode IDE运行的输出结果跟控制台输出的运行结果是**不一致**的。XCode IDE输出应该是解析到\r就输出了吧，标准控制台的话仍然是跟上面的分析一致。
  
[<img title="Image(6)" src="/wp-content/uploads/2014/07/Image6_thumb.jpg" alt="Image(6)"  />](/wp-content/uploads/2014/07/Image6.jpg)

Ref:

  * ASCII: <http://www.asciitable.com/>
  * 回车与换行: [http://www.ruanyifeng.com/blog/2006/04/post_213.html](http://www.ruanyifeng.com/blog/2006/04/post_213.html "http://www.ruanyifeng.com/blog/2006/04/post_213.html")
