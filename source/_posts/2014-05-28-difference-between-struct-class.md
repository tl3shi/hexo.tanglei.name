---
id: 2425
title: struct与class区别联系
date: 2014-05-28T23:08:01+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2425
duoshuo_thread_id:
  - 1351844048792453504
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 学到老
tags:
  - C++
  - OOP
---


注意C中的struct和C++中的struct是不一样的，c中的struct比较原生，仅仅是将一些属性封装起来构成一个整体，没有OO的相关特性。而c++中的struct是对c中的struct进行扩展(兼容c中的struct)，**具备OO的特性**，
其实**c++中的class能干的事情struct几乎都能干**,  什么继承、多态等都OK。直接看下面代码，不同编译器对结果可能不一样：

```cpp
#include <stdio.h>
struct A
{
    int a;
    //D:\github\cpp_hello_world>gcc -x c structtest.cpp
    //structtest.cpp:7:5: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__at
    // _’ before ‘{’ token
    void print() // pure c, this is not allowd
    {
        printf("a printf %d\n", a);
    }
};
 
struct B : A
{
    int b;
    B(int bb)
    {
        b = bb;
        a = -1;
    }
    B(){b = 0; a = 2;}
};

class C
{
public:  // if there's no pubic, cannot use this way:  C c = {11};
    int c;
    char d;
    void func() //normal function(no construct/inherit .etc OO properties), you can also use this way:   C c = {11};
    {
        printf("%d, %c\n", c, d);
    }
    //C(){}
};


struct D
{
    int c;
    char d;
    D() // if there's no Construct or some other OO properties(like inherit), you can use this way:  D d = {1,'y'}
    {
        c = -1;
        d = 'x';
    }
};

struct E
{
    int c;
    char d;
    void func() //normal function, you can also use this way:   E e = {2,'z'};  
    {
        printf("%d, %c\n", c, d);
    }
};


struct AA
{
private:
    int a;
public:
    int b;
};
class BClass: AA
{
public:
    void fun()
    {
        printf("%d\n", b);
    }
};
struct BStruct: AA
{
    void func()
    {
        printf("%d\n", b);
    }
};


struct Base
{
    virtual void fun()
    {
        printf("Base\n");
    }
};
struct Child: Base
{
    void fun()
    {
        printf("Child\n");
    }
};

int main()
{
    B b, b1(1);
    printf("%d, %d \n", b.b, b.a);
    printf("%d, %d \n", b1.b, b1.a);
    A a = {10};
    printf("%d\n", a.a);
    C c = {11, 'a'};
    C c1 = {'d'}; //convert to int 
    C c2 = {}; //init with default
    C c3; 
    printf("%d, %c\n", c.c, c.d);
    printf("%d, %c, %d\n", c1.c, c1.d, c1.d);
    printf("%d, %d\n", c2.c, c2.d);
    printf("%d, %c\n", c3.c, c3.d);//uninit, vs2012 will show Run-Time Check Failure #3 window, 
    c3.func();//uninit, but this way will pass the "Run-Time Check" in vs2012
    //D d = {1,'y'}; //error: in C++98 ‘d’ must be initialized by constructo not by ‘{...}’
    //printf("%d, %c\n", d.c, d.d);

    E e = {2,'z'};  
    printf("%d, %c\n", e.c, e.d);
    e.func();


    BClass bclass;
    BStruct bstruct;
    bclass.fun();
    bstruct.func();
    //printf("%d", bclass.b); // “AA::b”不可访问，因为“BClass”使用“private”从“AA”继承
    printf("%d\n", bstruct.b); //OK

    Base base;
    Child child;
    base.fun();
    child.fun();
    Base* base2 = &child;
    base2->fun();

    return 0;
}
```

VisualStudio 2012默认debug和release结果：

[<img title="Image(8)[4]" src="/wp-content/uploads/2014/05/Image84_thumb.png" alt="Image(8)[4]"  />](/wp-content/uploads/2014/05/Image84.png)[<img title="73028934dad360862f6ed22a22a35c24" src="/wp-content/uploads/2014/05/73028934dad360862f6ed22a22a35c24_thumb.png" alt="73028934dad360862f6ed22a22a35c24"  />](/wp-content/uploads/2014/05/73028934dad360862f6ed22a22a35c24.png)

G++ 4.5.3, 默认和O2(g++ -O2 structtest.cpp)结果：

[<img title="600b675239e56d6d70ac255f68e353f5" src="/wp-content/uploads/2014/05/600b675239e56d6d70ac255f68e353f5_thumb.png" alt="600b675239e56d6d70ac255f68e353f5"  />](/wp-content/uploads/2014/05/600b675239e56d6d70ac255f68e353f5.png)[<img title="44e877ad37f3a2a6f5a77577dfb4adc5" src="/wp-content/uploads/2014/05/44e877ad37f3a2a6f5a77577dfb4adc5_thumb.png" alt="44e877ad37f3a2a6f5a77577dfb4adc5"  />](/wp-content/uploads/2014/05/44e877ad37f3a2a6f5a77577dfb4adc5.png)

mac下的g++(Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn))无优化和O2结果
  
[<img src="/wp-content/uploads/2014/05/struct-and-class.png" alt="" title="struct-and-class"  class="aligncenter size-full wp-image-2430" />](/wp-content/uploads/2014/05/struct-and-class.png)

不同编译器结果不一样主要是体现在printf函数实现(有空再研究下)下以及C c3的未初始化（注意c2和c3的区别）～ 这也告诉我们一定要注意初始化啊～未初始化的值是未定义的，啥结果可能都有。

可以看出：

区别关键就是访问控制，struct默认是public，class默认是private。包括struct下定义的属性/成员访问控制（默认public），继承方式默认public。几个注意的地方，struct还能继承class，class也能继承struct，一定条件下class也能像struct用{&#8230;}初始化构造.当struct/class带有OO特性时，如继承、构造函数、虚函数时，除了默认的访问控制符外，struct跟class行为完全一样。例子中的通过{&#8230;}提供参数化列表构造一个实例,**class也能通过这样的方式构造**。当有继承、构造函数等OO特性定义(非成员函数)时，即便是struct也不能通过{…}初始化构造.

另外，class在c++中还能在模版定义中，类似(typename)，而struct不行。

以上算是struct和class的区别和联系吧。核心思想是记住c++中的struct也能用于OOP,与class的默认访问控制权限不一样。

  * Reference : <http://blog.sina.com.cn/s/blog_48f587a80100k630.html>
  * C# struct和class区别: <http://www.cnblogs.com/gsk99/archive/2011/05/20/1904552.html>
