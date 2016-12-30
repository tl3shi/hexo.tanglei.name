---
id: 2461
title: C++ 传参时传内置类型时用传值(pass by value)方式效率较高
date: 2014-07-02T23:21:39+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2461
duoshuo_thread_id:
  - 1351844048792453507
categories:
  - 学到老
tags:
  - C++
  - 性能优化
---
在《Effective C++》里提到对内置(C-like)类型在函数传参时pass by value比pass by reference更高效，当用OO的c++自定义类型(存在构造/析构等)pass by reference to const 更好，STL里的迭代器和函数对象是用C指针实现的，因此pass by value更好。至于为什么，下面的代码验证了下。

```cpp
#include <iostream>
using namespace std;

int f(int i)
{
   int r = i + 1;
   return r;
}

int g(const int & i)
{
    int r = i + 1;
    return r;
}

int h(int * p)
{
    int r = * p + 1;
    return r;
}

int inter(int * &p)
{
    int r = * p + 1;
    return r;
}

int main()
{
    int i = 0x11111111;
    f(i);
    g(i);
    h(&i);

    int * x = &i;
    r = inter(x);
    return 0;
}
```

用VS 2012 默认Debug配置下生成的汇编代码如下： 

```cpp
     4: int f(int i)
     5: {
00F343D0  push        ebp 
00F343D1  mov         ebp,esp 
00F343D3  sub         esp,0CCh 
00F343D9  push        ebx 
00F343DA  push        esi 
00F343DB  push        edi 
00F343DC  lea         edi,[ebp-0CCh] 
00F343E2  mov         ecx,33h 
00F343E7  mov         eax,0CCCCCCCCh 
00F343EC  rep stos    dword ptr es:[edi] 
     6:    int r = i + 1;
00F343EE  mov         eax,dword ptr [i]  //直接将i的值取出来给eax
00F343F1  add         eax,1  //eax+1
00F343F4  mov         dword ptr [r],eax 
     7:    return r;
00F343F7  mov         eax,dword ptr [r] 
     8: }
00F343FA  pop         edi 
00F343FB  pop         esi 
00F343FC  pop         ebx 
00F343FD  mov         esp,ebp 
00F343FF  pop         ebp 
00F34400  ret
```

后面的几个函数，只截取了关键代码了。

```asm
    10: int g(const int &i)
    11: { 
 ...... 
    12:     int r = i + 1;
00F3449E  mov         eax,dword ptr [i]  // 跟传指针一样，取i的地址到eax
00F344A1  mov         ecx,dword ptr [eax]  // 将eax的值取出来 放到ecx中
00F344A3  add         ecx,1  // ecx值+1
00F344A6  mov         dword ptr [r],ecx 
    13:     return r;
00F344A9  mov         eax,dword ptr [r] 
    14: }
......
```

[<img class="size-full wp-image-2472 aligncenter" src="/wp-content/uploads/2014/07/1.png" alt="传引用 传指针"  />](/wp-content/uploads/2014/07/1.png)

```asm
    16: int h(int * p)
    17: {
......
    18:     int r = *p + 1;
00F3453E  mov         eax,dword ptr [p]         // 取p的地址，让到eax中
00F34541  mov         ecx,dword ptr [eax]   //把eax的值取出来，让到ecx中
00F34543  add         ecx,1   //exc的值+1
00F34546  mov         dword ptr [r],ecx 
    19:     return r;
00F34549  mov         eax,dword ptr [r] 
    20: }
......
```

指针跟上面引用一样。 

```asm    
    22: int inter(int * &p)
    23: {
......
    24:     int r = *p + 1;
01233DBE  mov         eax,dword ptr [p]  //取传进参数（指针）的地址-&gt;eax
01233DC1  mov         ecx,dword ptr [eax] //取参数指针的地址--&gt;ecx, (是真正值的地址)
01233DC3  mov         edx,dword ptr [ecx]  //取ecx的内容-&gt;edx
01233DC5  add         edx,1 //edx 值+1
01233DC8  mov         dword ptr [r],edx 
    25:     return r;
01233DCB  mov         eax,dword ptr [r] 
    26: }
......
```

[<img class="aligncenter size-full wp-image-2471" title=" " src="/wp-content/uploads/2014/07/2.png" alt="pass by value"  />](/wp-content/uploads/2014/07/2.png)
  
从汇编代码可以看出，为啥内置类型作为函数参数传递时更高效。 

<div>
  另外关于C++函数调用过程压栈等汇编情况可参考 http://blog.csdn.net/dongtingzhizi/article/details/6680050
</div>
