---
id: 1528
title: python中a+=b与a=a+b详解
date: 2012-03-13T23:20:14+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1528
duoshuo_thread_id:
  - 1351844048792453178
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Python
keywords:
  - a+=b
  - a=a+b
  - python
---
在上一篇文章中谈到了我碰到的<a href="/blog/a-python-problem-about-a-plusequal-b-and-a-equal-a-plus-b.html" target="_blank">关于python里a+=b和a=a+b</a>问题。在<a href="http://www.zhihu.com/question/20114936" target="_blank">知乎</a>上也问了这个问题，看了各位大侠的解释，现在似乎明白了，得赶紧记下来总结下，不然以后又忘了。

总体上讲，a+=b是改变了a原始的值，而a=a+b是计算出a+b后，a在指向那个值。这个也跟a和b的类型有关。当a和b是int或者string不可改变的时候，二者效果一样。后面给出详细解释。

[海坡](http://haipo.me/)也提出了问题的关键在于递归到i=1时，**subset += (elements[0:size])**这句代码。这句话将 elements 里的“指针”**值**复制到subset“数组”里，即将 elements[0] ~ elements[size-1] 的引用添加进 subset 中，这相当于 subset += [elements[0], elements[1], &#8230; , elements[size-1]] 。这意味着 subset 这个 List 中的新添加元素与 elements[0] ~ elements[size-1] 绑定的是同样的对象。 subset 并没有获得 elements 的引用，是 subset 的新添加元素得到了 elements 中的元素的引用。哎呀，复杂了。看代码吧。解释原因写在注释里面了。

简单点，我想下面这个应该容易理解：

```python
>>> a=[1,2,3,4] 
>>> b=a 
>>> a+=[5] 
>>> a,b 
([1, 2, 3, 4, 5], [1, 2, 3, 4, 5])#a,b的“地址”一样 
>>> a=[1,2,3,4] 
>>> b=a 
>>> a=a+[5]#a+[5]后有一个新地址，再使a指向这个新地址，因此a不再是以前的a,而b还是以前的那个a//b，所以b不变 
>>> a,b 
([1, 2, 3, 4, 5], [1, 2, 3, 4])
```

再看看下面几句代码：

```python
>>> a=[[1],[2]] 
>>> b=[] 
>>> b+=a[0:1]#这句将列表a中第一个元素的“指针”给了b[0],此时a[0]和b[0]是一样的 
>>> a,b 
([[1], [2]], [[1]]) 
>>> b[0][0]='change'#b[0]就相当于取到了a里面的第一个元素，也是一个列表。b[0][0]也就定位到了a[0][0],对应的内容就是1 
>>> a,b 
([['change'], [2]], [['change']])#因此b[0][0]改了，a[0][0],也相应的改了。 
>>> id(b[0][0]);id(a[0][0])#不用说，地址一样 
11534048 
11534048 
>>> id(b[0]);id(a[0]) 
12903888 
12903888 
>>> b[0],a[0] 
(['change'], ['change']) 
>>> b[0]='another'#这里应该是有一块新地址，再让b[0]指向这个新地址。  
>>> a,b 
([['change'], [2]], ['another'])# 因此a中的值没有变
>>> a[0] 
['change'] 
>>> id(b[0]);id(a[0]) #此时，b[0]跟a[0]的地址不一样
13056672 
12903888
```

有了对上面这些的正确理解，就不难理解<a href="/blog/a-python-problem-about-a-plusequal-b-and-a-equal-a-plus-b.html" target="_blank">前面的提到的问题</a>了。在底层递归中，返回了elements中元素的“指针”，在外层里通过这样调用set[j]  = set[j] +  (elements[i])，没问题，因为elements没变(set[j]指向新的地址而已)。而用set[j] += elements[i]可能会等价于elements[*] += elements[i]就是在原地址中改变内容了。

以上就差不多解释清楚了。期间，还遇到一个问题：看如下代码

```python
>>> a=[1,2]#初始化a，为列表[1,2]
>>> a+='3' #直接+=方式，追加元素”3”
>>> a
[1, 2, '3']
>>> a+=['4'] #追加列表，比上面的‘3’ 多了个[]。
>>> a
[1, 2, '3', '4']#同样能追加成功，怎么感觉有无[]没有区别啊?
>>> a+'5'#当然，直接+字符串，就抛异常了。
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: can only concatenate list (not "str") to list
```

要解释这个问题，看看python里的源码即可。知道+=这个操作实际上是调用了\_\_iadd\_\_方法(可以用此重载操作符，<a href="http://stackoverflow.com/questions/1047021/overriding-in-python-iadd-method" target="_blank">stackoverflow上有这个重载+=的问题</a>).而在\_\_iadd\_\_方法内部，是直接调用了extend()方法，而a.extend(‘3’)和a.extend([‘3’])没有区别吗？表面上看来是没有区别的。

```python
>>> a=[1,2]
>>> a.extend('3')
>>> a
[1, 2, '3']
>>> a.extend(['3'])
>>> a
[1, 2, '3', '3']
>>>
```

而实际上，在extend(arg)方法内部，又去调用了append方法

```python
def extend(self, values):
        for v in values:
            self.append(v)
```

这样，’3’  和 [‘3’] 就没区别被append进去了。字符串会被当作数组append进去。

```python
>>> a
[1, 2, '3', '3']
>>> a.extend('abc')
>>> a
[1, 2, '3', '3', 'a', 'b', 'c']
>>> a.extend(['23','ab'])
>>> a
[1, 2, '3', '3', 'a', 'b', 'c', '23', 'ab']
```

现在应该差不多了。
  
再次感谢知乎上的各位悉心解答。
