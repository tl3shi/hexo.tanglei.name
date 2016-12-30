---
id: 1514
title: Python中__init__和__new__方法详解
date: 2012-03-10T17:55:39+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1514
duoshuo_thread_id:
  - 1351844048792453346
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 学到老
tags:
  - OOP
  - Python
---
前面说已经开是[学习python了](/blog/start-to-learn-python.html)，然后随便看了下语法，就看到了OO了。结果发现这个\_\_init\_\_()和\_\_new\_\_()方法才有些神奇。引用官方API的解释

> object.**\_\_new\_\_**(_cls_[, _&#8230;_])
> 
> Called to create a new instance of class _cls_. [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) is a **static** method (special-cased so you need not declare it as such) that takes the class of which an instance was requested as its first argument. The remaining arguments are those passed to the object constructor expression (the call to the class). The return value of [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) should be the new object instance (usually an instance of _cls_).
> 
> Typical implementations create a new instance of the class by invoking the superclass’s [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) method using super(currentclass, cls).\_\_new\_\_(cls[, &#8230;]) with appropriate arguments and then modifying the newly-created instance as necessary before returning it.
> 
> If [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) returns an instance of _cls_, then the new instance’s [**\_\_init\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__init__) method will be invoked like \_\_init\_\_(self[, &#8230;]), where _self_ is the new instance and the remaining arguments are the same as were passed to [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__).
> 
> If [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) does not return an instance of _cls_, then the new instance’s [**\_\_init\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__init__) method will not be invoked.
> 
> [**\_\_new\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__new__) is intended mainly to allow subclasses of immutable types (like int, str, or tuple) to customize instance creation. It is also commonly overridden in custom metaclasses in order to customize class creation.
> 
> object.**\_\_init\_\_**(_self_[, _&#8230;_])
> 
> Called when the instance is created. The arguments are those passed to the class constructor expression. If a base class has an [**\_\_init\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__init__) method, the derived class’s [**\_\_init\_\_()**](http://docs.python.org/py3k/reference/datamodel.html?highlight=__new__#object.__init__) method, if any, must explicitly call it to ensure proper initialization of the base class part of the instance; for example: BaseClass.\_\_init\_\_(self, [args&#8230;]). As a special constraint on constructors, no value may be returned; doing so will cause a [**TypeError**](http://docs.python.org/py3k/library/exceptions.html#TypeError) to be raised at runtime.

然后写代码测试了下。代码如下：

```python
'''
Created on Mar 9, 2012
@author: tanglei|www.tanglei.name
'''
import traceback
class A(object):

    def __new__(self):
        print("new  A,has not return")
    def __init__(self):
        print("init in A")
    def cal(self,num):
        print(num+1)
try: #if not try ,catch,the program will terminate
    t=A()
    t.cal(89)
except :
    traceback.print_exc()

class  B(object):
    def __init__(self):
        print("init in B")
    def cal(self,num):
        print(num+1)   
t=B()
t.cal(89)

class  C(object):
    def __new__(cls):
        print("new C,has return value")
#        return super(C,self).__new__(self)
        return object.__new__(cls, cls)
    def __init__(self):
        print("init in C")
    def cal(self,num):
        print(num+1)   
t=C()
t.cal(89)

class  D(object):
    def __new__(cls):
        print("new D,has a return value")
        return super(D,cls).__new__(cls)  #new should return one instance
    def __init__(self):
        print("...init..in D.")
        return None  #init should not return some value or return None
    def cal(self,num):
        print(num+1)   
t=D()
t.cal(89)

class  E(object):
    def __new__(cls):
        print("new E,has a return value")
        return D()  #new should return one instance,event another instance
    #do not been invoked
    def __init__(self):
        print("...init..in E.")
        return ''  #init should not return some value or return None,
    
    def cal(self,num):
        print(num+1)   

t=E() #E.new,D.new,D.init
t.cal(1)
```

运行结果如图所示意。

[<img title="python_init__new__method 1" src="/wp-content/uploads/2012/03/python_init__new__method1_thumb.jpg" alt="python_init__new__method 1"  data-pinit="registered" />](/wp-content/uploads/2012/03/python_init__new__method1.jpg)

解释下运行结果：

  1. 类A：先调用了\_\_new\_\_方法，没有返回一个实例化对象，因此再调用t.cal()方法时，提示一个NoneType没有定义一个cal的属性/方法，程序直接抛出异常。整个过程中没有调用\_\_init\_\_方法
  2. 类B：没有显示定义\_\_new\_\_方法，程序调用构造方法时，直接用的是\_\_init\_\_方法，得到一个实例，再调用cal方法，正常。
  3. 类C：调用\_\_new\_\_方法，此时调用了父类object的\_\_new\_\_方法(\_\_new\_\_方法是静态方法)，父类会构造一个当前类C的实例，再调用本类中的\_\_init\_\_方法，因此会看到有结果new C,再init C.最后正常调用cal方法。
  4. 类D：跟C相似，此事是用的super调用父类的\_\_new\_\_方法的，\_\_init\_\_方法不能return除了None外的其他值，否则会报错。关于[python中super的使用](http://www.cnblogs.com/lovemo1314/archive/2011/05/03/2035005.html)，这里有篇文章也讲了。
  5. 类E：这里是先调用了E中的\_\_new\_\_方法(打印了new E)，然后返回一个非E的实例，这里返回了一个D的实例(API里面也没说不可以返回其他类的实例),因此将会先实例化D，所以会先调用D中的\_\_new\_\_方法，进而\_\_init\_\_方法(如图结果所示new D，init in D)。最后再调用cal方法。程序正常结束。

从中可以总结如下：

  1. \_\_new\_\_：创建对象时调用，但必须得**返回**一个实例,**通常**返回本类的实例(通过重写父类的方法)，你返回其他的，也不会报错(例如类E中)。这个方法一般也用于覆盖父类的方法，再对父类中的某些特征进行修改使之符合本类的使用。
  2. \_\_init\_\_：创建完对象后调用，对当前对象的实例的一些初始化，无返回值或者返回值为None，返回其他的就会报错。
  3. 如果重写了\_\_new\_\_方法而在\_\_new\_\_里面没有显示或者隐式(类C中的例子)调用\_\_init\_\_则\_\_init\_\_将不起作用(E中的，本应该报错的，但没调用，所以也没报错)。
