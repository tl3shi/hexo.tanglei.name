---
id: 1884
title: python中decorator详解
date: 2012-07-24T21:38:23+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1884
duoshuo_thread_id:
  - 1351844048792453229
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - python
tags:
  - AOP
  - decorator
  - python
---
前面写python的AOP解决方案时提到了decorator，这篇文章就详细的来整理下python的装饰器——decorator。

### python中的函数即objects

一步一步来，先了解下python中的函数。

```python
def shout(word='hello,world'):
    return word.capitalize() + '!'

print shout()
#输出：Hello,world!
#跟其他对象一样，你同样可以将函数对象赋值给其他变量
scream = shout
#注意，shout后面没有用括号()，用括号就是调用了shout方法，这里仅仅是将shout的函数对象复制给scream。
#意味着，你可以通过scream调用shout方法。
print scream()
#同样输出：Hello,world!
#此外，你将代表函数变量的shout删除，shout现在失效，但scream同样可以调用

del shout
print shout()
#会抛异常
#Traceback (most recent call last):
#  File "S:\decorator.py", line 18, in <module>
#    print shout()
#NameError: name 'shout' is not defined

#（当然得注释掉前面的两句代码，或者try catch一下）
print scream()
#同样输出：Hello,world!
```

python中函数还可以嵌套，即将函数定义在另一个函数里面。例如

```python
def talk():
    
    def whisper(word='hello'):
        return word.lower() + '...'

    #在函数talk里面定义whisper函数，马上就可以用了
    print whisper()
#调用talk，里面的whisper()也被调用了
talk()
#输出：hello...
#直接调用whisper可不行。
try:
    print whisper()
except Exception ,e :
    print e
#输出：name 'whisper' is not defined
```

从上面的例子我们已经可以得到，函数可以被赋值给另外的变量，也能在另一个函数里面定义函数。可以推断函数也能返回给另外的函数或者作为参数传递给其他函数。看下面的代码：

```python
def getTalk(type='shout'):
    #函数里面定义另外两个函数
    def shout(word='hello,world'):
        return word.capitalize() + '!'
    def whisper(word='hello'):
        return word.lower() + '...'

    #根据传入的参数，返回相应的函数对象
    #注意，没用(),仅仅返回函数对象，并没有调用
    if type == 'shout':
        return shout
    else:
        return whisper

talk = getTalk()
print talk
#输出：<function shout at 0x011FCA70>
print talk() #调用函数
#输出：Hello,world!
#同样可以这样直接调用
print getTalk('whisper')()
#输出：hello...

#既然能return一个函数，当然也可以将函数作为参数传递给其他的函数
def doBefore(func):
    print 'before calling the func'
    print func()#调用

doBefore(talk)#将前面通过getTalk()得到的函数对象传递给doBefore
#输出：
#before calling the func
#Hello,world!
```

&nbsp;

### 初识decorator

明白以上的这些，将有助于理解装饰器decorator，其实装饰器decorator就是在不改变函数的本身情况下在函数执行的前后包装另外的代码来改变函数的具体表现行为。有点儿AOP的味道。继续从代码来解释。

```python
# 装饰器就是一个将其他函数(也就是被装饰的函数)作为参数的一个function
def my_shiny_new_decorator(a_function_to_decorate):

    # 在这个装饰器函数里面用另外一个函数来包装原函数，
    # 即在调用原来的函数前后分别执行其他的操作.
    def the_wrapper_around_the_original_function():

        # 这里放一些你希望在原来的函数执行之前的代码，例如log、身份验证等
        print "Before the function runs"

        # 调用原函数本身，注意有()
        a_function_to_decorate()

        #同理，这里放一些你希望在原来的函数执行之后的代码，例如释放资源等
        print "After the function runs"

    # 注意，此时，函数 "a_function_to_decorate"并没有被执行.
    # 此时将刚刚创建的用来包装原函数的函数返回
    return the_wrapper_around_the_original_function

# 假设你定义了一个函数，并良好实现，也觉得perfect了。且发誓以后并不准备改动这段代码
def a_stand_alone_function():
    print "I am a stand alone function, don't you dare modify me"

a_stand_alone_function() 
#输出: I am a stand alone function, don't you dare modify me

# 有时候，作为coder，并不是你不动代码就能不动的。PM此时另外又来了个需求，让你在之前
#的基础上再加点XX功能，苦逼的程序猿乖乖的改吧。不过有了装饰器，你能满足PM的需求，又能不违背
#当初许下的不改变原有代码的誓言。仅仅需要将此函数拿去重新装饰一下即可。如下：
a_stand_alone_function_decorated = my_shiny_new_decorator(a_stand_alone_function)
a_stand_alone_function_decorated()
#输出:
#Before the function runs
#I am a stand alone function, don't you dare modify me
#After the function runs
```

如果不想调用a\_stand\_alone\_function\_decorated()这个方法，还是钟情于以前的那个名字，方法也简单。重写下a\_stand\_alone_function方法即可。即：

```python
a_stand_alone_function = my_shiny_new_decorator(a_stand_alone_function)
a_stand_alone_function()
#输出还是一样样
```

### decorator揭秘

上面的代码就是装饰器的体现。现在用python中专门的decorator语法就是酱紫滴：

```python
@my_shiny_new_decorator
def another_stand_alone_function():
    print "Leave me alone"

another_stand_alone_function()
#Before the function runs
#Leave me alone
#After the function runs
```

简单来说，@my\_shiny\_new\_decorator就是another\_stand\_alone\_function = my\_shiny\_new\_decorator(another\_stand\_alone\_function)的缩写。

python中的装饰器其实是GoF中的装饰模式的一个变种。像迭代器iterators也是一种设计模式。

装饰器还可以同时使用多个。

```python
def bread(func):
    def wrapper():
        print "</''''''\>"
        func()
        print "<\______/>"
    return wrapper

def ingredients(func):
    def wrapper():
        print "#tomatoes#"
        func()
        print "~salad~"
    return wrapper

def sandwich(food="--ham--"):
    print food

sandwich()
#输出: --ham--
sandwich = bread(ingredients(sandwich))
sandwich()
#输出:
#</''''''\>
# #tomatoes#
# --ham--
# ~salad~
#<\______/>

#用python中的decorator语法就是：
@bread
@ingredients
def sandwich(food="--ham--"):
    print food

sandwich()
#输出:
#</''''''\>
# #tomatoes#
# --ham--
# ~salad~
#<\______/>
#注意@的顺序。谁在最下面，睡最先被调用。
#下面的sandwich就奇怪了哈，把salad等放在盘子底下
@ingredients
@bread
def strange_sandwich(food="--ham--"):
    print food

strange_sandwich()
#输出:
##tomatoes#
#</''''''\>
# --ham--
#<\______/>
# ~salad~
```

### 被装饰的函数传参

仅仅在包装的函数上将参数传递过来即可。

```python
def a_decorator_passing_arguments(function_to_decorate):
    def a_wrapper_accepting_arguments(arg1, arg2):
        print "传进来的参数是：", arg1, arg2
        function_to_decorate(arg1, arg2)
    return a_wrapper_accepting_arguments

# 既然你调用了装饰过后的函数，你也就调用了包装器，函数也就自然传递到了包装器。

@a_decorator_passing_arguments
def print_full_name(first_name, last_name):
    print "My name is", first_name, last_name

print_full_name("lei", "tang")
# 输出:
#传进来的参数是： lei tang
#My name is lei tang
```

### 装饰类中的方法

python中的方法和函数差不多，只不过类中的方法的第一个参数是当前对象的引用self。

```python
def method_friendly_decorator(method_to_decorate):
    def wrapper(self, lie):
        lie = lie - 3 #减少3
        return method_to_decorate(self, lie)
    return wrapper


class Lucy(object):

    def __init__(self):
        self.age = 32

    @method_friendly_decorator
    def sayYourAge(self, lie):
        print "I am %s, what did you think?" % (self.age + lie)

l = Lucy()
l.sayYourAge(-3)#32-3  -3(wrapper中还减了3岁)=26
#输出: I am 26, what did you think?
```

在不知道参数个数的情况下有一种更加通用的传参方法，就是用\*args, \*\*kwargs。\*args代表没有给定默认值的参数列表(arg1,arg2,……)，**kwwars代表有给定默认值(arg1=val1,arg2=val2,……)

```python
def a_decorator_passing_arbitrary_arguments(function_to_decorate):
    # 包装器接受任意参数
    def a_wrapper_accepting_arbitrary_arguments(*args, **kwargs):
        print "Do I have args?:"
        print args
        print kwargs
        #*args代表没有给定默认值的参数列表(arg1,arg2,……)，**kwwars代表有给定默认值(arg1=val1,arg2=val2,……)
        function_to_decorate(*args, **kwargs)
    return a_wrapper_accepting_arbitrary_arguments

@a_decorator_passing_arbitrary_arguments
def function_with_no_argument():
    print "Python is cool, no argument here."

function_with_no_argument()
#输出
#Do I have args?:
#()
#{}
#Python is cool, no argument here.

@a_decorator_passing_arbitrary_arguments
def function_with_arguments(a, b, c):
    print a, b, c

function_with_arguments(1,2,3)
#输出
#Do I have args?:
#(1, 2, 3)
#{}
#1 2 3 

@a_decorator_passing_arbitrary_arguments
def function_with_named_arguments(a, b, c, platypus="Why not ?"):
    print "Do %s, %s and %s like platypus? %s" %(a, b, c, platypus)

function_with_named_arguments("Bill", "Linus", "Steve", platypus="Indeed!")
#输出
#Do I have args ? :
#('Bill', 'Linus', 'Steve')
#{'platypus': 'Indeed!'}
#Do Bill, Linus and Steve like platypus? Indeed!

class Mary(object):

    def __init__(self):
        self.age = 31

    @a_decorator_passing_arbitrary_arguments
    def sayYourAge(self, lie=-3): # You can now add a default value
        print "I am %s, what did you think ?" % (self.age + lie)

m = Mary()
m.sayYourAge(8)
m.sayYourAge(lie=-8)#注意看下面print出的**kwargs区别
#输出
#Do I have args?:
#(<__main__.Mary object at 0x01228430>, 8)
#{}
#I am 39, what did you think ?
#Do I have args?:
#(<__main__.Mary object at 0x01228430>,)
#{'lie': -8}
#I am 23, what did you think ?

```

### 将参数传给装饰函数

因为装饰函数本身要将一个函数作为参数传递进来，那怎么把参数传给装饰函数呢？其实不能直接将函数传递给装饰函数。但也有解决方案，先看下面的例子

```python
# 装饰器函数也是function
def my_decorator(func):
    print "I am a ordinary function"
    def wrapper():
        print "I am function returned by the decorator"
        func()
    return wrapper

def lazy_function():
    print "zzzzzzzz"

decorated_function = my_decorator(lazy_function)
#输出: I am a ordinary function
#注意此时，被装饰的函数并没有调用。

#同样，用@的方式也得到相同的结果
@my_decorator
def lazy_function():
    print "zzzzzzzz"

#输出:  I am a ordinary function
#当@的时候，就告诉python去调用装饰器函数。这个@后的标签很重要，直接指向装饰器
```

```python
def decorator_maker():

    print "我是构造装饰器的工人，当你让我构造装饰器时，我被执行一次 "

    def my_decorator(func):

        print "我是装饰器，当你装饰一个函数式，我就被执行"

        def wrapped():
            print ("我是包装被装饰函数的包装器，当被装饰函数调用时，我也被执行，"
                  "作为包装器，我的职责是将被装饰的函数结果返回")
            return func()

        print "作为装饰器，我将返回包装器函数"

        return wrapped

    print "作为构造装饰器的工人，我得返回装饰器"
    return my_decorator

# 构造装饰器,赋值给new_decorator
new_decorator = decorator_maker()       
#输出:
#我是构造装饰器的工人，当你让我构造装饰器时，我被执行一次 
#作为构造装饰器的工人，我得返回装饰器
print(0)

# 被装饰的函数
def decorated_function():
    print "我是被装饰的函数"

decorated_function = new_decorator(decorated_function)
#输出:
#我是装饰器，当你装饰一个函数式，我就被执行
#作为装饰器，我将返回包装器函数
print(1)
#调用被装饰的函数
decorated_function()
#输出:
#我是包装被装饰函数的包装器，当被装饰函数调用时，我也被执行作为包装器，我的职责是将被装饰的函数结果返回
#我是被装饰的函数
```

用标记间隔下，整个输出如下：

```python
我是构造装饰器的工人，当你让我构造装饰器时，我被执行一次
作为构造装饰器的工人，我得返回装饰器
0
我是装饰器，当你装饰一个函数式，我就被执行
作为装饰器，我将返回包装器函数
1
我是包装被装饰函数的包装器，当被装饰函数调用时，我也被执行，作为包装器，我的职责是将被装饰的函数结果返回
我是被装饰的函数
```

省略中间步骤，如下

```python
#省略中间步骤，如下
def decorated_function():
    print "我是被装饰的函数"
decorated_function = decorator_maker()(decorated_function)
#我是构造装饰器的工人，当你让我构造装饰器时，我被执行一次 
#作为构造装饰器的工人，我得返回装饰器
#我是装饰器，当你装饰一个函数式，我就被执行
#作为装饰器，我将返回包装器函数

# 最后调用:
decorated_function()    
#输出:
#我是包装被装饰函数的包装器，当被装饰函数调用时，我也被执行，作为包装器，我的职责是将被装饰的函数结果返回
#我是被装饰的函数
```

可以更短

```python
@decorator_maker()
def decorated_function():
    print "我是被装饰的函数"
#输出:
#我是构造装饰器的工人，当你让我构造装饰器时，我被执行一次 
#我是装饰器，当你装饰一个函数式，我就被执行
#作为装饰器，我将返回包装器函数

#最终: 
decorated_function()    
#输出:
#我是包装被装饰函数的包装器，当被装饰函数调用时，我也被执行，作为包装器，我的职责是将被装饰的函数结果返回
#我是被装饰的函数
```

上面@后面是一个函数调用，调用函数当然可以传递参数。就是在上面的@decorator_maker()括号里面加上参数而已。

```python
# -*- coding: utf-8 -*-
def decorator_maker_with_arguments(decorator_arg1, decorator_arg2):

    print "我构造装饰器，并接受参数:", decorator_arg1, decorator_arg2

    def my_decorator(func):
        
        print "我是装饰器，我接收到了参数:", decorator_arg1, decorator_arg2

        # 别混淆了，装饰器参数和函数参数
        def wrapped(function_arg1, function_arg2) :
            print ("我是包装器,我能看到所有的变量.\n"
                  "\t- 来自装饰器: {0} {1}\n"
                  "\t- 来自函数调用: {2} {3}\n"
                  "我可以传递给被装饰的函数"
                  .format(decorator_arg1, decorator_arg2,
                          function_arg1, function_arg2))
            return func(function_arg1, function_arg2)

        return wrapped

    return my_decorator

@decorator_maker_with_arguments("Leonard", "Sheldon")
def decorated_function_with_arguments(function_arg1, function_arg2):
    print ("被装饰的函数，我只能看到自己的参数: {0}"
           " {1}".format(function_arg1, function_arg2))

decorated_function_with_arguments("Lily", "Lucy")

#输出
#我构造装饰器，并接受参数: Leonard Sheldon
#我是装饰器，我接收到了参数: Leonard Sheldon
#我是包装器,我能看到所有的变量.
#	- 来自装饰器: Leonard Sheldon
#	- 来自函数调用: Lily Lucy
#我可以传递给被装饰的函数
#被装饰的函数，我只能看到自己的参数: Lily Lucy


c1 = "Penny"
c2 = "Pony"

@decorator_maker_with_arguments("Leonard", c1)
def decorated_function_with_arguments(function_arg1, function_arg2):
    print ("被装饰的函数，我只能看到自己的参数: {0} {1}".format(function_arg1, function_arg2))

decorated_function_with_arguments(c2, "Lucy")
#我构造装饰器，并接受参数: Leonard Penny
#我是装饰器，我接收到了参数: Leonard Penny
#我是包装器,我能看到所有的变量.
#	- 来自装饰器: Leonard Penny
#	- 来自函数调用: Pony Lucy
#我可以传递给被装饰的函数
#被装饰的函数，我只能看到自己的参数: Pony Lucy
```

通过这种方案就可以实现往装饰器里面传递参数了，甚至可以用上面的\*args, \**kwargs来传递任意参数。值得注意的是**装饰器只被调用了一次，当python在import当前脚本的时候调用。**不能在后面再动态的设置传递的参数，当import xx的时候，被decorated的函数已经被装饰好了，不能再变了。

### decorator注意事项

  * python2.4及其以上版本有此功能
  * 装饰器使代码执行的效率变低了
  * 一旦一个函数已经被装饰好了，就定下来了，不能变了
  * 装饰器decorator在函数之间包装起来了，比较难debug

python自己也提供了几个装饰器，property，staticmethod等。Django用装饰器来管理缓存和视图权限，能够把python的decorator玩透，将会帮你解决很多事情。
  
&nbsp;
  
参考资料(其实就是翻译了下)：<a href="http://stackoverflow.com/questions/739654/understanding-python-decorators" target="_blank">stackoverflow</a>
