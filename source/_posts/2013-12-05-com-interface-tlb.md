---
id: 2248
title: COM接口示例
date: 2013-12-05T11:19:04+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2248
duoshuo_thread_id:
  - 1351844048792453493
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - C++
  - Windows
  - 敲敲代码
  - HelloWorld
---
> 最近一个合作973项目，需要调用人家的接口。对方给了一个dll文件和函数接口说明，然后我就视图通过传统生成的dll，loadlibrary去查找函数指针，通过函数指针去调用，失败。后来才发现人家给的dll不是一个一般的dll而是一个com接口，需要注册啊之类的。

COM的目的是跨越编程语言的，比如人家用VB、C#之类的写，然后你的项目是用C++写的，出于某种原因，你需要直接重用人家的实现，别人处于安全或者也没必要给你实现，只需要封装一个COM接口供你调用即可。COM接口不同于一般函数生成dll，通过LoadLibrary载入dll通过函数名找到函数指针进行调用相应的函数。

下面通过一个简单的例子说明COM接口的应用。开发环境用Visual Studio。
  
下面代码用C#实现了一个”重要”的接口功能，那就是加法。

```csharp
using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace comtest
{   
    public interface ProgramInterface 
    {
        int add(int a, int b);
    }
    //默认是ClassInterfaceType.AutoDispatch，不显示注解也OK
    //[ClassInterface(ClassInterfaceType.AutoDual)]
    //可以参考http://www.cnblogs.com/JessieDong/archive/2009/7/21.html
    public class Program : ProgramInterface
    {
        public Program() 
        { }

        public int add(int a, int b) 
        {
            return a + b;
        }
    }
}
```

写好后，右击项目属性，选择“应用程序”，点击“程序集信息”后勾选“使程序集COM可见”。（英文版如下）

[<img title="clip_image002" src="/wp-content/uploads/2013/12/clip_image002_thumb.jpg" alt="clip_image002"  />](/wp-content/uploads/2013/12/clip_image002.jpg)

然后选择”生成”tab，勾选“为COM互操作注册”。（英文版如下）

[ <img title="clip_image004" src="/wp-content/uploads/2013/12/clip_image004_thumb.jpg" alt="clip_image004"  />](/wp-content/uploads/2013/12/clip_image004.jpg)

然后生成，生成可能失败，提示权限不够，然后以管理员身份运行再生成。

[<img title="clip_image006" src="/wp-content/uploads/2013/12/clip_image006_thumb.jpg" alt="clip_image006"  />](/wp-content/uploads/2013/12/clip_image006.jpg)

如下消息看到成功生成了Dll。

1> comtest -> D:\cpp\comtest\comtest\bin\Release\comtest.dll

生成的dll就可以给另外的人调用了。调用方需要用regasm注册一下生成tlb文件。

[ <img title="clip_image007" src="/wp-content/uploads/2013/12/clip_image007_thumb.png" alt="clip_image007"  />](/wp-content/uploads/2013/12/clip_image007.png)

调用方可以直接import这个tlb文件后，直接写一个空的main函数，

``#import  "D:\cpp\comtest\Release\comtest.tlb" raw_interfaces_only``

然后生成，这样build后可以生成一个comtest.tlh 文件，visual studio 就能智能提示。

[ <img title="clip_image008" src="/wp-content/uploads/2013/12/clip_image008_thumb.png" alt="clip_image008"  />](/wp-content/uploads/2013/12/clip_image008.png)

调用方式可以是这样：

<pre>ProgramInterfacePtr  ptr(__uuidof(Program));</pre>

ProgramInterface就是刚刚在C#里面声明的那个接口名称，然后加后缀Ptr声明就是声明接口的一个智能指针（tlh文件里面有相应的宏），Program为具体实现相应接口的类。然后通过ptr指针去调用相应实现方法。注意在声明ptr之前记得要通过CoInitialize(NULL);初始化一些com环境。
  
调用方完整代码如下：

```cpp
#include <windows.h>
#include <iostream>
using namespace std;

#import  "D:\cpp\comtest\Release\comtest.tlb" raw_interfaces_only

using namespace comtest;
int main()
{
    cout << "hello world" << endl;
    
    HRESULT hr =  CoInitialize(NULL);
    if(hr!=S_OK)
    {
        printf("hr failed/n");
        exit(-1);
    }
    ProgramInterfacePtr  ptr(__uuidof(Program));
    long a = 1;
    long b = 2;
    long c;
    ptr->add(a, b, &c);
    cout << c << endl;
   
}
int main1()//this also works
{
    HRESULT hr = CoInitializeEx(NULL,COINIT_MULTITHREADED);
    if(hr!=S_OK)
    {
        printf("hr failed/n");
        exit(-1);
    }
    comtest::ProgramInterfacePtr  ptr;
    long a = 1;
    long b = 2;
    long c;
    hr = ptr.CreateInstance(__uuidof(Program), NULL, CLSCTX_ALL);
    if(hr == S_OK)
    {
        ptr->add(a, b, &c);
        cout << "result = " << c;
    }
    else
    {
        cout << "fail" << endl;
    }
}
```

运行就能看到如下结果

[ <img title="image" src="/wp-content/uploads/2013/12/image_thumb.png" alt="image"  />](/wp-content/uploads/2013/12/image.png)


Reference：

[1]Excel 调用c# 生成的dll <https://richnewman.Wordpress.com/2007/04/15/a-beginner%E2%80%99s-guide-to-calling-a-net-library-from-excel/>
  
[2]Com 组件介绍 <http://www.cppblog.com/3522021224/archive/2007/06/22/26803.html>
  
[3]Wiki: [http://en.wikipedia.org/wiki/Component\_Object\_Model](http://en.wikipedia.org/wiki/Component_Object_Model)
