---
id: 1695
title: libsvm(v3.11)在python3中的bug(saveModel总报参数错误)
date: 2012-04-10T19:49:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1695
duoshuo_thread_id:
  - 1351844048792453350
categories:
  - 除臭虫
tags:
  - Python
  - 数据挖掘
  - Bug
  - SVM
---
在上一篇文章讲解<a href="/blog/libsvm-in-python.html" target="_blank">libsvm的python版入门实例</a>时，遇到一个遗留问题，就是不能用官网给的API保存训练好的模型文件。总是提示，问题定位到svmutil的svm\_save\_model方法。

> **libsvm.svm\_save\_model**(model\_file\_name, model)  
> ctypes.ArgumentError: argument 1: <class ‘TypeError’>: wrong type

刚开始一直找不到原因，后来偶然一次在服务器(服务器python环境2.6，本机python环境3.2)上跑时，忘记注释掉savemodel这句，最后居然生成了model文件，才发现原来这个是libsvm3.11的一个bug，也是因为python3不向前兼容引起的问题。经过跟libsvm的作者Prof. Lin及其学生交流后发现这个问题。

> I am writing to you for the problem I found in the python interface of LIBSVM.I am using the version 3.11,I found that if I run the program under the environment of python 3.2,it crashes.However,in the environment of python2.5,it does well.&nbsp; 
> 
> I used the python files including svm.py and svmutil.py downloading&nbsp; from your site.When I want to save the model file that has been trained.But it crashed .It says &#8220;<font color="#ff0000">ctypes.ArgumentError: argument 1: <class &#8216;TypeError&#8217;>: wrong type .&#8221; in the file &#8220;..\libsvm\libsvm-3.11\python\svmutil.py&#8221;</font> ,line 45 ,in the method named &#8220;svm\_save\_model&#8221;. The following codes are how I called the interface. 
> 
> &#8230;&#8230;&nbsp; 
> 
> model = svmutil.svm_train(prob ,&#8217;-h 0&#8242;)  
> &nbsp;&nbsp;&nbsp; model\_file\_name = &#8216;test.model&#8217; 
> 
> svmutil.svm\_save\_model(model\_file\_name, model) 
> 
> &#8230;&#8230; 
> 
> However it does well when I change the environment to python 2.5.</blockquote> 
> 
> 最后给出的**解决方案**是： 
> 
> 修改文件svmutil.py. 
> 
> 将32行的model = libsvm.svm\_load\_model(model\_file\_name)修改成model = libsvm.svm\_load\_model(model\_file\_name.encode()) 
> 
> 45行的libsvm.svm\_save\_model(model\_file\_name, model)修改成libsvm.svm\_save\_model(model\_file\_name.encode(), model) 
> 
> 估计下个版本libsvm3.13?会fix这个问题。 
> 
> **原因**是在python3中使用了新类型bytes，用来表示二进制数据和编码文本，str和bytes不能混合，需要时，必须进行显示的转换，转换方法是str.encode()(str->bytes)和bytes.decode()(bytes->str).<a href="http://docs.python.org/release/3.0.1/whatsnew/3.0.html" target="_blank">官网说法猛击这里</a>。以前的strings变成了unicode,在libsvm的C/C++实现中用的char*(DLL里面的),就不兼容了。所以总提示参数错误。 
> 
> 附上<a href="/wp-content/blogresources/libsvmtest.rar" target="_blank">libsvm的入门实例</a>（115网盘网络紧张好像提取不了，iask居然慢慢审核，只有放在自己空间了）（压缩包解压密码:www.tanglei.name）
