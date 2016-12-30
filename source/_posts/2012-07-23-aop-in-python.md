---
id: 1881
title: python中的AOP
date: 2012-07-23T00:39:37+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1881
duoshuo_thread_id:
  - 1351844048792453290
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 工作那些事儿
tags:
  - AOP
  - Python
  - 设计模式
---
背景：之前在腾讯实习的时候做了相关接口监控报送状态时写了<a href="/blog/aop-in-php.html" target="_blank">PHP中的AOP</a> ，这几天在UMeng实习要做到一个log模块，之前的类似代码是这样的：

```python
def getnewcomments(request ):
    sub_request_info = Log.request_log(request)//Log http的请求
    //具体业务逻辑省略……
    cs = service();
    Log.response_log(cs, sub_request_info)//Log 响应信息
    return HttpResponse(json.dumps(cs), mimetype="application/json")
```

感觉，每个方法里面都去调用一次log\_resequest，log\_response非常别扭，log本来跟这个具体的业务逻辑没有多大的关系，这样写代码就耦合了，不容易扩展。就想想能不能找出一种方法类似之前spring里面接触的AOP的概念，把记录日志的模块从具体的业务逻辑里面单独隔离出来。后来，网上搜了下，有一种解决方案，现在记录下来。

这种方案是基于python的decorator,准备再写一篇文章专门关于python的decorator.方案的demo代码如下：

```python
#coding:utf-8
#author:tanglei|http://www.tanglei.name

def log(fun):
	print 'log: '+fun.__name__
	def wrapped(*args,**kws):
		print 'before.' +str(args)
		retVal = fun(*args,**kws)
		print 'after. ' +  str(args)
		return retVal
	return	wrapped


@log
def service(para):
	print 'service:' + para

@log
def service2(para):
	print 'service2: ' + para

if __name__ == '__main__':
	service('first')
	print '------'
	service2('second')

```

注意看结果里面的，在service调用前后before和after分别先后被调用了。但可能对首先输出的log：service比较好奇。其实可以这样理解，python中的函数也是object，在@log的时候，其实已经构造出来了。看看下面的，你应该就会明白了。我以上的代码另存为aop2.py，import时就发生了如下的结果：

```python
tl3shi@tanglei3shi:/media/study$ python
Python 2.6.6 (r266:84292, Sep 15 2010, 15:52:39) 
[GCC 4.4.5] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import aop2
log: service
log: service2
>>> 
```

这下应该想通了。
