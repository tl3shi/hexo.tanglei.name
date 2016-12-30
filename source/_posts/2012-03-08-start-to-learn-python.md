---
id: 1508
title: 开始学python了
date: 2012-03-08T23:19:57+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1508
duoshuo_thread_id:
  - 1351844048792453344
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 学到老
tags:
  - Python
---
说学python已经好久了，这两天终于看了下。最开始还是别人推荐的简明python教程：[chm版本下载](http://ishare.iask.sina.com.cn/f/8343136.html),[在线版本](http://sebug.net/paper/python/)，这个版本是2.x版本滴了，机子上装了3.2的，难怪自己开始想打印hello world都不行。因为教程里说的是，直接print ‘hello world’，结果提示语法错误。后来才知道，print在3.x版本里面已经是一个函数，应该用print(‘hello world!’)这样才可以，我就说怎么连hello world都不行。该教程的[英文版本滴可以参考这里](http://www.swaroopch.com/notes/Python)。

然后稍微看了下语法，试着写写函数之类的。就有以下判断素数的代码：也试着用pdb调试下(只是玩玩而已，知道有这回事，真正做事情的时候应该还是用IDE吧)

```python
import math

_DEBUG=False#True

def isPrime(x):
	#print(math.ceil(math.sqrt(x)))
	if _DEBUG == True:
		import pdb
		pdb.set_trace()

	for i in range(2,math.ceil(math.sqrt(x+1))):#attention range(x,y) === [x,y)
		#print(math.fmod(x,i))  #float value
		if (x%i) == 0 :
			return 0

		else:
			continue

	return 1

print('From 2 to 50,the prime numbers are :')	
for i in range(2,50):
	t = isPrime(i)
	if t == 1:
		print(i,sep=",",end=" ")
print()
```

然后，还记得教程中有说自己写模块。于是就另外写另一个模块，练习输入输出，让用户手动输入数字，再进行判断。

```python
# coding=GBK #加上这句支持中文
import isPrime

i = int(input("请输入要判断的整数:"))
if isPrime.isPrime(i) == 1 :
	print(i,"是一个素数")
else:	
	print(i,"不是一个素数")	

```

运行结果如下

[<img title="image" src="/wp-content/uploads/2012/03/image_thumb.png" alt="image"  data-pinit="registered" />](/wp-content/uploads/2012/03/image.png)

突然发现，跟codes同目录下居然有个\_\_pycache\_\_的目录，下于isPrime.cpython-32.pyc这个文件。后来网上查了查，才大致弄明白了。

\_\_pycache\_\_这个目录跟我第一印象差不多，是一个缓存文件夹，当import一个文件时，python虚拟机会将import的模块编译成字节码文件，跟java类似吧。虽说python是一个解释性语言，但为了提高效率也有编译这一说。编译产生的pyc文件也可以直接运行，肯定是下次再import时，虚拟机会自动去cache这个目录去找，找到了就直接用(应该也有一个检测文件签名的机制，不然怎么知道是不是最新的)，找不到再重新编译，这样就能提高解释效率了，用UE能打开pyc文件，可以看到pyc 是一种二进制文件，是由py文件经过编译后，应该就跟java中的class文件一个道理，一种byte code，py文件变成pyc文件后，加载的速度有所提高。说是pyc是一种跨平台的字节码，是由python的虚拟机来执行的，又跟JVM差不多。pyc的内容，是跟python的版本相关的，不同版本编译后的pyc文件是不同的。

扩展下，pyc文件可以由内置的类库来产生，就是用 py_compile 模块。就用这个来手动编译单个文件或者多个文件。不用等到import才被动编译了。

详细的pyc文件解析可以参考这里：[Pyc文件解析](http://blog.donews.com/lemur/archive/2006/02/21/736881.aspx)

参考资料：
  
python的pyc和pyo文件：<http://gmingzhe.blog.51cto.com/810664/163444>
  
Python 中的pyc文件的用途：<http://www.cppblog.com/lauer3912/archive/2011/08/12/153233.aspx>
