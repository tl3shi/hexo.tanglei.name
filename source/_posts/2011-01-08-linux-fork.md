---
id: 303
title: Linux之fork详解
date: 2011-01-08T13:50:35+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=303
duoshuo_thread_id:
  - 1351844048792453317
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 'Linux'
tags:
  - Linux
---
今天写实验报告。遇到了fork函数。网上看了下。总结如下：
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;
  
首先介绍下背景知识。大家都知道进程可以理解为程序的一次执行过程。每一个特定的时候只有一个进程占用CPU。当一个进程的时间片用完后，系统把相关的寄存器的值保存到该进程表相应的表项里。同时把代替该进程即将执行的进程的上下文从进程表中读出，并更新相应的寄存器值，这个过程称为上下文交换。上下文交换其实就是读出新的进程的PC(程序计数器),指示当前进程的下一条将要执行的指令。一个进程，主要包含三个元素：

o. 一个可以执行的程序；
  
o. 和该进程相关联的全部数据（包括变量，内存空间，缓冲区等等）；
  
o. 程序的执行上下文（execution context）。
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;
  
fork()函数是用来创建子进程的，当一个程序创建了一个子进程，那么原先的进程称为该子进程的父进程。操作系统的进程表的每个表项中存放着一个进程的情况。首先，操作系统在进程表中为该进程建立新的表项。子进程与父进程共享代码段，但数据空间是相互独立的。**子进程数据空间的内容是父进程的完整拷贝，上下文也完全相同。**pid在父进程与子进程的返回值是不同的，如果pid<0创建失败。在子进程中返回的pid=0，因为子进程可以通过getpid()得到自己的进程ID。在父进程中返回的是子进程的实际的PID。子进程是从fork()之后执行的。
  
**特别注意：子进程copy父进程的变量，内存与缓冲区，即整个的数据空间的内容，但数据空间是独立的。**
  
还是用例子来说明：
  
下面是forktest.c

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
	int c_pid;//记录子进程的ID	
	int status=1;
	char * str="this is a string";
/*fork对于父进程来说返回的是子进程的pid，而对于子进程来说返回的是0。若调用失败，则返回-1。 
*/
//这里实际上只执行了1次，到缓冲了。下面if else里面的第一个printf把缓冲的内容打印出来了。
	printf("%s,pid=%d",str,getpid());//会打印两次。printf实际上是把输出的内容放到了缓冲队列中，只有看到n时才输出到屏幕上 看到的效果是两次pid都是父进程的。
//sleep(2);
	//printf("%s,pid=%d\n",str,getpid());//only one time
	if((c_pid = fork()) == 0){//判断是否是子进程
		printf("子进程正在工作...\n");
		printf("子进程的PID是:%d\n",getpid());
		printf("父进程的PID是:%d\n",getppid());
		exit(0);
	}else{
		printf("父进程正在工作...\n");
		printf("父进程的PID是:%d\n",getpid());
		printf("子进程的PID是:%d\n",c_pid);
	}

	wait(&status);
	return 0;
}
```

然后看看结果。

```c
root@tanglei3shi:/home/tl3shi/courseLinux/fork# gcc -o forktest1 forktest1.c
root@tanglei3shi:/home/tl3shi/courseLinux/fork# ./forktest1
this is a string,pid=24866父进程正在工作...
父进程的PID是:24866
子进程的PID是:24867
this is a string,pid=24866子进程正在工作...
子进程的PID是:24867
父进程的PID是:24866
root@tanglei3shi:/home/tl3shi/courseLinux/fork# 
```

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;
  
然后将第一个printf中的换行\n去掉。即把上面的注释部分换下。如下：

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
	int c_pid;//记录子进程的ID	
	int status=1;
	char * str="this is a string";
/*fork对于父进程来说返回的是子进程的pid，而对于子进程来说返回的是0。若调用失败，则返回-1。 
*/
//这里实际上只执行了1次，到缓冲了。下面if else里面的第一个printf把缓冲的内容打印出来了。
	//printf("%s,pid=%d",str,getpid());//会打印两次。printf实际上是把输出的内容放到了缓冲队列中，只有看到n时才输出到屏幕上 看到的效果是两次pid都是父进程的。
//sleep(2);
	printf("%s,pid=%d\n",str,getpid());//only one time
	if((c_pid = fork()) == 0){//判断是否是子进程
		printf("子进程正在工作...\n");
		printf("子进程的PID是:%d\n",getpid());
		printf("父进程的PID是:%d\n",getppid());
		exit(0);
	}else{
		printf("父进程正在工作...\n");
		printf("父进程的PID是:%d\n",getpid());
		printf("子进程的PID是:%d\n",c_pid);
	}

	wait(&status);
	return 0;
}
```

再看结果：

```c
root@tanglei3shi:/home/tl3shi/courseLinux/fork# gcc -o forktest1 forktest1.c
root@tanglei3shi:/home/tl3shi/courseLinux/fork# ./forktest1
this is a string,pid=25112
父进程正在工作...
父进程的PID是:25112
子进程的PID是:25113
子进程正在工作...
子进程的PID是:25113
父进程的PID是:25112
root@tanglei3shi:/home/tl3shi/courseLinux/fork# 
```

后面这个结果还容易理解些，关键就是第一次，结果为啥是打印了两次this is a string呢？在注释中也已经说明了。其实也还是只执行了一次。只不过。第一次父进程打印时候，只是把那句话缓存了。再下面if else里面父进程和子进程的第一个printf \n的时候才是输出到屏幕上了。这样理解应该还是比较容易的。那句话只执行了一次。而不是两次。网上有的说法，个人认为是错误的，我这样理解就合情合理啦。
  
哈哈……
