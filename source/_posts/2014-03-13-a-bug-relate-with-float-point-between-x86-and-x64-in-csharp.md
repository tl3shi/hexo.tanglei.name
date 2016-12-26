---
id: 2358
title: 'C#因x86-x64环境不同引发的浮点&#8221;bug&#8221;~'
date: 2014-03-13T23:49:29+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2358
duoshuo_thread_id:
  - 1351844048792453500
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - c++
  - Windows
tags:
  - bug
  - c++
---
**<font color="red">【update】在<a href="http://coolshell.cn/articles/11235.html">coolshell上本文(一个浮点数跨平台产生的问题)</a>被吐槽了下，在此说明：本文强调的是“合理”结果为什么被“正确”结果替换的原因；另float/double有各自的应用场景，自己应该在速度/精度上有一个权衡；后文说的解决方案是希望产生合理的结果(-202014160)而非正确的结果，不是说想通过编译参数来提高精度。求别吐槽我不知道直接用double就能得到正确且合理的结果了。若带来误解还请原谅～</font>**

背景就简单点儿说，最近一个项目C#编写，涉及浮点运算，来龙去脉省去，直接看如下代码。

```csharp
float p3x = 80838.0f;
float p2y = -2499.0f;
double v321 = p3x * p2y;
Console.WriteLine(v321);
```

很简单吧，马上笔算下结果为-202014162，没问题，难道C#没有产生这样的结果？不可能吧，开启VisualStudio，copy代码试试，果然结果是-202014162。就这样完了么？显然没有！你把编译时的选项从AnyCPU改成x64试试~(服务器环境正是64位滴哦！！)结果居然边成了-202014160，对没错，就是-202014160。有点不相信，再跑两遍，仍然是-202014160。呃，想通了，因为浮点运算的误差，-202014160这个结果是合理的。嗯，再试试C++。//测试环境Intel(R) i7-3770 CPU, windows OS 64. Visual Studio 2012 默认设置。

```cpp
float p3x = 80838.0f;
float p2y = -2499.0f;
double v321 = p3x * p2y;
std::cout.precision(15);
std::cout << v321 << std::endl;
```

呃，好像x86、x64都是这个合理的结果-202014160。奇了个怪了。

合理的运算结果，应该是-202014160，正确的运算结果是-202014162，合理性是浮点精度不够造成的（文后解释了合理性）。若是用两个double相乘可得正确且合理的运算结果。//就别纠结我用的“正确、合理”这两个词是否恰当了。问题是为何C#下X64和X86结果不一致？

用C++同样的代码，X86，X64（DEBUG下，这个后面会说）下得到一致的结果-202014160，容易理解且也是合理的。原因何在？看下编译后生成的代码(截取关键部分)

```asm
//C# x86 下
......
float p3x = 80838.0f;
0000003b  mov         dword ptr [ebp-40h],479DE300h
float p2y = -2499.0f;
00000042  mov         dword ptr [ebp-44h],0C51C3000h
double v321 = p3x * p2y;
00000049  fld         dword ptr [ebp-40h]
0000004c  fmul        dword ptr [ebp-44h]
0000004f  fstp        qword ptr [ebp-4Ch]
.......

//C# X64下
......
float p3x = 80838.0f;
00000045  movss       xmm0,dword ptr [00000098h]
0000004d  movss       dword ptr [rbp+3Ch],xmm0
float p2y = -2499.0f;
00000052  movss       xmm0,dword ptr [000000A0h]
0000005a  movss       dword ptr [rbp+38h],xmm0
double v321 = p3x * p2y;
0000005f  movss       xmm0,dword ptr [rbp+38h]
00000064  mulss       xmm0,dword ptr [rbp+3Ch]
00000069  cvtss2sd    xmm0,xmm0
0000006d  movsd       mmword ptr [rbp+30h],xmm0
......
```

C++ x86 /x64下都生成了类似的代码（这也就是为何C++ x86/x64与C#x64结果一致）即都用了先用浮点乘起来（mulss），然后转成double（cvtss2sd）。 从上面的汇编代码可以看出C# X86生成代码用的指令fld/fmul/fstp等。其中fld/fmul/fstp等指令是由**FPU**(float point unit)浮点运算处理器做的，FPU在进行浮点运算时，用了**80位**的寄存器做相关浮点运算，然后再根据是float/double截取成32位或64位。非FPU的情况是用了SSE中128位寄存器(float实际只用了其中的32位，计算时也是以32位计算的)，这就是导致上述问题产生的最终原因，详细分析见文末说明。

浮点运算标准[IEEE-754](http://en.wikipedia.org/wiki/IEEE_floating_point) 推荐标准实现者提供浮点可扩展精度格式([Extended precision](http://en.wikipedia.org/wiki/Extended_precision))，Intel x86处理器有FPU(float point unit)浮点运算处理器支持这种扩展。 C#的浮点是支持该标准的，其中[其官方文档](http://msdn.microsoft.com/en-us/library/aa691146(v=vs.71).aspx)也提到了浮点运算可能会产生比返回类型更高精度的值（正如上面的返回值精度就超过了float的精度），并说明如果硬件支持可扩展浮点精度的话，那么**所有的**浮点运算都将用此精度进行以提高效率，举个例子x\*y/z, x\*y的值可能都在double的能力范围之外了，但真实情况可能除以z后又能把结果拉回到double范围内，这样的话，用了FPU的结果就会得到一个准确的double值，而非FPU的就是无穷大之类的了。

即产生如上的结果原因是，两个浮点数相乘在非FPU的情况下，用了32位计算产生的结果导致结果存在误差，而FPU是用了80位进行计算的，所以得到的结果是精度很高的，体现在本文的案例上就是个位数上的2。 那么怎么避免这种情况呢？**<font color="red">【update 这里说的解决方案是希望产生合理的结果，而不是正确的结果，即希望产生的结果是-202014160，求别吐槽我不知道直接用double就能得到正确且合理的结果了。】</font>**

对于C++来说有解决方案即禁用可扩展精度，VS2012中C++，[编译选项可以设置(代码生成中)](http://msdn.microsoft.com/zh-cn/library/vstudio/e7s85ffb(v=vs.110).aspx)可选，/fp:[precise | fast | strict]，本例中Release x86下用precise 或者 strict将得到合理的结果(-202014160)，fast将产生正确的结果(-202014162), fast debug/release下结果也不一样哦(release下才优化了)。X64下各个结果可以大家自己去测试下(Debug/Release)，分别看看VS编译后产生的中间代码长什么样。

但对于**C#来说，目前还没找到解决方案**。

所以大家在写代码的时候得保证实际运行环境/测试环境/开发环境的**一致性(包括OS架构啊、编译选项等)**啊，不然莫名其妙的问题会产生（本文就是开发环境与运行环境不一致导致的问题，纠结了好久才发现是这个原因）；遇到涉及浮点运算的时候别忘了有可能是这个原因产生的；另外，float/double混用的情况得特别注意。

Reference：

[1] [C# Language Specification Floating point types](http://msdn.microsoft.com/en-us/library/aa691146(v=vs.71).aspx)
  
[2] [**<font color="red">【update】在<a href="http://coolshell.cn/articles/11235.html">coolshell上本文(一个浮点数跨平台产生的问题)</a>被吐槽了下，在此说明：本文强调的是“合理”结果为什么被“正确”结果替换的原因；另float/double有各自的应用场景，自己应该在速度/精度上有一个权衡；后文说的解决方案是希望产生合理的结果(-202014160)而非正确的结果，不是说想通过编译参数来提高精度。求别吐槽我不知道直接用double就能得到正确且合理的结果了。若带来误解还请原谅～</font>**

背景就简单点儿说，最近一个项目C#编写，涉及浮点运算，来龙去脉省去，直接看如下代码。

```csharp
float p3x = 80838.0f;
float p2y = -2499.0f;
double v321 = p3x * p2y;
Console.WriteLine(v321);
```

很简单吧，马上笔算下结果为-202014162，没问题，难道C#没有产生这样的结果？不可能吧，开启VisualStudio，copy代码试试，果然结果是-202014162。就这样完了么？显然没有！你把编译时的选项从AnyCPU改成x64试试~(服务器环境正是64位滴哦！！)结果居然边成了-202014160，对没错，就是-202014160。有点不相信，再跑两遍，仍然是-202014160。呃，想通了，因为浮点运算的误差，-202014160这个结果是合理的。嗯，再试试C++。//测试环境Intel(R) i7-3770 CPU, windows OS 64. Visual Studio 2012 默认设置。

```cpp
float p3x = 80838.0f;
float p2y = -2499.0f;
double v321 = p3x * p2y;
std::cout.precision(15);
std::cout << v321 << std::endl;
```

呃，好像x86、x64都是这个合理的结果-202014160。奇了个怪了。

合理的运算结果，应该是-202014160，正确的运算结果是-202014162，合理性是浮点精度不够造成的（文后解释了合理性）。若是用两个double相乘可得正确且合理的运算结果。//就别纠结我用的“正确、合理”这两个词是否恰当了。问题是为何C#下X64和X86结果不一致？

用C++同样的代码，X86，X64（DEBUG下，这个后面会说）下得到一致的结果-202014160，容易理解且也是合理的。原因何在？看下编译后生成的代码(截取关键部分)

```asm
//C# x86 下
......
float p3x = 80838.0f;
0000003b  mov         dword ptr [ebp-40h],479DE300h
float p2y = -2499.0f;
00000042  mov         dword ptr [ebp-44h],0C51C3000h
double v321 = p3x * p2y;
00000049  fld         dword ptr [ebp-40h]
0000004c  fmul        dword ptr [ebp-44h]
0000004f  fstp        qword ptr [ebp-4Ch]
.......

//C# X64下
......
float p3x = 80838.0f;
00000045  movss       xmm0,dword ptr [00000098h]
0000004d  movss       dword ptr [rbp+3Ch],xmm0
float p2y = -2499.0f;
00000052  movss       xmm0,dword ptr [000000A0h]
0000005a  movss       dword ptr [rbp+38h],xmm0
double v321 = p3x * p2y;
0000005f  movss       xmm0,dword ptr [rbp+38h]
00000064  mulss       xmm0,dword ptr [rbp+3Ch]
00000069  cvtss2sd    xmm0,xmm0
0000006d  movsd       mmword ptr [rbp+30h],xmm0
......
```

C++ x86 /x64下都生成了类似的代码（这也就是为何C++ x86/x64与C#x64结果一致）即都用了先用浮点乘起来（mulss），然后转成double（cvtss2sd）。 从上面的汇编代码可以看出C# X86生成代码用的指令fld/fmul/fstp等。其中fld/fmul/fstp等指令是由**FPU**(float point unit)浮点运算处理器做的，FPU在进行浮点运算时，用了**80位**的寄存器做相关浮点运算，然后再根据是float/double截取成32位或64位。非FPU的情况是用了SSE中128位寄存器(float实际只用了其中的32位，计算时也是以32位计算的)，这就是导致上述问题产生的最终原因，详细分析见文末说明。

浮点运算标准[IEEE-754](http://en.wikipedia.org/wiki/IEEE_floating_point) 推荐标准实现者提供浮点可扩展精度格式([Extended precision](http://en.wikipedia.org/wiki/Extended_precision))，Intel x86处理器有FPU(float point unit)浮点运算处理器支持这种扩展。 C#的浮点是支持该标准的，其中[其官方文档](http://msdn.microsoft.com/en-us/library/aa691146(v=vs.71).aspx)也提到了浮点运算可能会产生比返回类型更高精度的值（正如上面的返回值精度就超过了float的精度），并说明如果硬件支持可扩展浮点精度的话，那么**所有的**浮点运算都将用此精度进行以提高效率，举个例子x\*y/z, x\*y的值可能都在double的能力范围之外了，但真实情况可能除以z后又能把结果拉回到double范围内，这样的话，用了FPU的结果就会得到一个准确的double值，而非FPU的就是无穷大之类的了。

即产生如上的结果原因是，两个浮点数相乘在非FPU的情况下，用了32位计算产生的结果导致结果存在误差，而FPU是用了80位进行计算的，所以得到的结果是精度很高的，体现在本文的案例上就是个位数上的2。 那么怎么避免这种情况呢？**<font color="red">【update 这里说的解决方案是希望产生合理的结果，而不是正确的结果，即希望产生的结果是-202014160，求别吐槽我不知道直接用double就能得到正确且合理的结果了。】</font>**

对于C++来说有解决方案即禁用可扩展精度，VS2012中C++，[编译选项可以设置(代码生成中)](http://msdn.microsoft.com/zh-cn/library/vstudio/e7s85ffb(v=vs.110).aspx)可选，/fp:[precise | fast | strict]，本例中Release x86下用precise 或者 strict将得到合理的结果(-202014160)，fast将产生正确的结果(-202014162), fast debug/release下结果也不一样哦(release下才优化了)。X64下各个结果可以大家自己去测试下(Debug/Release)，分别看看VS编译后产生的中间代码长什么样。

但对于**C#来说，目前还没找到解决方案**。

所以大家在写代码的时候得保证实际运行环境/测试环境/开发环境的**一致性(包括OS架构啊、编译选项等)**啊，不然莫名其妙的问题会产生（本文就是开发环境与运行环境不一致导致的问题，纠结了好久才发现是这个原因）；遇到涉及浮点运算的时候别忘了有可能是这个原因产生的；另外，float/double混用的情况得特别注意。

Reference：

[1] [C# Language Specification Floating point types](http://msdn.microsoft.com/en-us/library/aa691146(v=vs.71).aspx)
  
[2]](http://stackoverflow.com/questions/6683059/are-floating-point-numbers-consistent-in-c-can-they-be) 
  
[3] [The FPU Instruction Set](http://www.plantation-productions.com/Webster/www.artofasm.com/Linux/HTML/RealArithmetica2.html)

* * *

**附80838.0f * -2499.0f = -202014160.0浮点运算过程的说明**

32位浮点数在计算机中的表示方式为：1位符号位(s)-8位指数位(E)-23位有效数字(M)。
  
32位Float = (-1)^s \* (1+m) \* 2^(e-127), 其中e是实际转换成1.xxxxx*2^e的指数,m是前面的xxxxx(节约1位)

80838.0f = 1 0011 1011 1100 0110.0= 1.00111011110001100*2^16
  
有效位M = 0011 1011 1100 0110 0000 000
  
指数位E = 16 + 127 = 143 =  10001111
  
内部表示 80838.0 =  0 \[1000 1111\] \[0011 1011 1100 0110 0000 000\]
  
= 0100 0111 1001 1101 1110 0011 0000 0000
  
= 47 9d e3 00 //实际调试时看到的内存值 可能是00 e3 9d 47是因为调试环境用了小端表示法法：低位字节排内存低地址端，高位排内存高地址

-2499.0 = -100111000011.0 = -1.001110000110 * 2^11
  
有效位M = 0011 1000 0110 0000 0000 000
  
指数位E = 11+127=138= 10001010
  
符号位s = 1
  
内部表示-2499.0 = 1 \[10001010\] \[0011 1000 0110 0000 0000 000\]
  
=1100 0101 0001 1100 0011 0000 0000 0000
  
=c5 1c 30 00

80838.0 * -2499.0 = ?

首先是指数 e = 11+16 = 27
  
指数位E = e + 127 = 154 = 10011010
  
有效位相乘结果为 1.1000 0001 0100 1111 1011 1010 01 //可以自己动手实际算下
  
实际中只能有23位，后面的被截断即1000 0001 0100 1111 1011 101<span style="text-decoration: line-through;">0 01 </span>
  
相乘结果内部表示=1\[10011010\]\[1000 0001 0100 1111 1011 101\]
  
= 1100 1101 0100 0000 1010 0111 1101 1101
  
= cd 40 a7 dd

结果 =  -1.1000 0001 0100 1111 1011 101 *2^27
  
=  -11000 0001 0100 1111 1011 1010000
  
=  -202014160
  
再转成double后还是-202014160.

如果是FPU的话，上面的有效位结果不会被截断，即
  
FPU结果 = -1.1000 0001 0100 1111 1011 101**001** *2^27
  
= -11000 0001 0100 1111 1011 101**001**
  
= -202014162

全文完，若本文有纰漏之处欢迎指正。
