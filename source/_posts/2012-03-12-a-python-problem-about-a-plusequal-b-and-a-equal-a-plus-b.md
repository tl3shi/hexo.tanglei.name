---
id: 1522
title: python问题求助-关于a+=b与a=a+b的问题
date: 2012-03-12T08:56:19+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1522
duoshuo_thread_id:
  - 1351844048792453418
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Python
  - 数据挖掘
---
在看apriori的算法，决定自己练练手，写写代码。最近又在[学python](/tag/#python)，所以准备用python实现。其中一个子过程是要求候选项Ck的k项子集。在这个求子集的方法中遇到了问题了，并且很神奇。最开始一直找不到问题所在，当单步调试发现问题所在之处时却倍感神奇。下面用代码示例来说明下这个问题的神奇之处。

```python
# coding=UTF-8 
'''
Created on Mar 11, 2012
@author: tanglei|www.tanglei.name
'''

elements=[['1'],['2'],['3']] 
def getSubset(k,size):
    subset=[]
    if k == 1:
        subset += (elements[0:size])
        return subset
    else:
        i = size - 1
        while i >= k-1 :
            set = getSubset(k-1,i)
            j = 0
            while j < len(set):
                #Attention a+=b  a=a+b  
```

  <font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #set[j] += (elements[i]) #Why Elements change here?</font>
               
  <font color="blue">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set[j] = set[j] + (elements[i])</font>

```python
                j += 1
            subset += (set)
            i -= 1
        return subset
print("elements:",elements)    
test = getSubset(2,len(elements))
print(test)
print("elements",elements)
```

本例中是求集合[[&#8216;1&#8217;],[&#8216;2&#8217;],[&#8216;3&#8217;]]的2-itemset子集。 看如上代码中，红色那句先注释掉，用a=a+b的形式，运行结果如下。这个结果是正确的，为{1,3}、{2,3}、{1,2}。

[<img title="clip_image002" src="/wp-content/uploads/2012/03/clip_image002_thumb1.jpg" alt="clip_image002"  />](/wp-content/uploads/2012/03/clip_image0022.jpg)

若将代码中换成a+=b的形式，即去掉蓝色代码部分，换成红色的代码。意料中，应该结果一样。但实际结果却出乎意料。

[<img title="python_a =b_a=a b 1" src="/wp-content/uploads/2012/03/python_ab_aab1_thumb.jpg" alt="python_a =b_a=a b 1"  data-pinit="registered" />](/wp-content/uploads/2012/03/python_ab_aab1.jpg)

不但子集没求对，就连原始的集合elements都被改变了。看了好久搞不定是哪里出了问题了。之前对a+=b和a=a+b的印象仅仅停留在涉及一个强制类型转换的原因，难道这个也是吗？搞不懂，像高人求助……

p.s顺便求一个代码高亮的插件，既能良好展示代码，又能自定义代码的某句的格式，比如本页中的的那两句有颜色代码，自定义格式了就不能用之前用的插件了。用那个插件，就又不能自定义格式了。本人用codecolorer，既想保持有良好的代码格式体现，又想能用于本页中，自己加font这样的标签，用于提到哪句代码更方便。现在本页是用了两段codecolorer的inline格式，加自定义font color属性的两句代码，给拼起来的，实在麻烦。
