---
id: 2199
title: C++继承函数默认参数
date: 2013-09-08T13:10:41+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2199
duoshuo_thread_id:
  - 1351844048792453488
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - c++
  - 敲敲代码
tags:
  - c++
  - OOP
---
直接上代码，如下，你觉得应该输出什么？

```cpp
#include <iostream>
using namespace std;
class Shape
{
    public:
        //virtual void draw(const string color="red") = 0;
        virtual void draw(const string color="red")
        {
            cout << "shape draw :" << color << endl;
        }
};

class Rectangle : public Shape
{
    public:
        virtual void draw(const string color="green")
        {
            cout << "rectangle draw : " << color << endl;
        }
};

class Circle : public Shape
{
    public:
    virtual void draw(const string color)
    {
        cout << "circle draw : " << color << endl;
    }
};

int main()
{
    Shape * ps;
    Shape *pc = new Circle;
    Shape *pr = new Rectangle;
    pc->draw("xx");
    pr->draw();

    return 0;
}

```

答案是：

```python
circle draw : xx
rectangle draw : green
```

若真是这样，就没必要这里post一篇了。奇怪的是真实情况输出第二行是，rectangle draw : **red** ~~居然是样子~！

原来还是自己弱爆了~虽说写了不少类似C++/C#代码，却对C++继承等机制不是太了解，只凭着从Java移植过来的感觉~果然不行。

上例中，得记住virtual函数动态绑定，而缺省参数是静态绑定。声明pc,pr时的静态类型为Shape指针，默认参数为shape class的默认参数。最后效果就是Shape 和 Rectangle类各出一半。因此才在[1]上有个原则：绝不重新定义继承而来的缺省参数值。

参考资料：

[1] Meyers, Scott. Effective C++: 55 specific ways to improve your programs and designs. Pearson Education, 2005.
