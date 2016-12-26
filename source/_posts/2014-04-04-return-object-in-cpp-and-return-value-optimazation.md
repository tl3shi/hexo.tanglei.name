---
id: 2385
title: C++函数返回类对象-返回值优化
date: 2014-04-04T17:44:27+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2385
duoshuo_thread_id:
  - 1351844048792453501
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - c++
tags:
  - OOP
  - 性能优化
---
<font size="4" color="red">update</font> 这应该属于Named Return Value Optimization(NRVO)或者Return Value Optimization(RVO)返回值优化的范畴。
  
RVO就是这样的：

```cpp
C func()
{
    return C();
}
int main(int argc, char **argv)
{
    C c = func();
    return 0;
}
```

编译器在func()函数中，返回时没有拷贝构造一个C的实例，一般来讲可以这样实现，比如外面调用的时候是用c去接受的，会直接构造c，然后在函数内部修改c的引用。

```cpp
C func(C &__hidden__)
{
    __hidden__ = C();
    return;
}
```

NRVO即这样：

```cpp
C func()
{
    C c;
    c.method();
    c.member = 10;
    return c;
}

//优化后 
C func(C &__hidden__)
{
    __hidden__ = C();
    __hidden__.method();
    __hidden__.member = 10;
    return;
}
```

但若函数内部实现有不同return的分支，编译器可能就不知道该怎么优化进而不会优化。其中更详细的内容可以参看 <a href="http://msdn.microsoft.com/en-us/library/ms364057%28VS.80%29.aspx" target="_blank">Named Return Value Optimization in Visual C++ 2005</a>。

在C++中，当一个函数返回类对象时得注意因拷贝构造函数的调用引来的开销，具体见下面的例子。例如某个函数直接 

``return Integer(i);``

创建一个临时Integer对象并返回它（没有copy一份），而 

``Integer tmp(i); return tmp;``

调用构造函数创建tmp对象;调用copy构造函数将tmp拷贝到外部返回值的存储单元；在tmp的作用域结尾时调用析构函数；这个也是一般来说这样，具体来说也与具体编译器实现相关。

下面的例子分别用Visual Studio 2012中的编译器（默认和O2优化结果不一样哦）和G++4.7.2(mingw)结果。

```cpp
#include <iostream>
using namespace std;
class A
{
    public:
        int a;

        A(int i):a(i)
        {
            cout << "A() :" << a << endl;
        }

        ~A()
        {
            cout << "~A()" << a << endl;
        }

        A(const A& x):a(x.a)
        {
            cout << "copy A()" << a << endl;
        }
};
A test1()
{
    return A(1);   
}
A test2()
{
    A tmp(2);
    return tmp;
}
int main()
{
    A a = test1();
    A b = test2();
    cout << "before exit" << endl;
    return 0;
}
```

[<img title="image" src="/wp-content/uploads/2014/04/image_thumb.png" alt="image" />](/wp-content/uploads/2014/04/image.png)

[<img title="image" src="/wp-content/uploads/2014/04/image_thumb1.png" alt="image"  />](/wp-content/uploads/2014/04/image1.png)

[<img title="image" src="/wp-content/uploads/2014/04/image_thumb2.png" alt="image"  />](/wp-content/uploads/2014/04/image2.png)

可以看出，编译器面对这样的情况都做了相关的优化，VS2012自带的编译器默认情况下才能看到copy 构造函数的调用。

更多内容，请参看：
  
Named Return Value Optimization in Visual C++ 2005： <a href="http://msdn.microsoft.com/en-us/library/ms364057%28VS.80%29.aspx" target="_blank" >http://msdn.microsoft.com/en-us/library/ms364057%28VS.80%29.aspx</a>
  
c++: RVO and NRVO： <a href="http://stupefydeveloper.blogspot.com/2008/10/c-rvo-and-nrvo.html" target="_blank">http://stupefydeveloper.blogspot.com/2008/10/c-rvo-and-nrvo.html</a>
