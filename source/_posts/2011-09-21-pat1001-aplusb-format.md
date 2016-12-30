---
id: 1160
title: pat1001-A+B Format
date: 2011-09-21T13:58:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1160
duoshuo_thread_id:
  - 1351844048792453419
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 我不会算法
tags: 
  - 保研
  - 考试
  - 算法
keywords:
  - PAT
  - ZOJ
  - 保研
  - 浙大机试
  - 计算机复试
---
前言：自己平时不玩ACM，保研需要，也做做题目，练练手，C语言也学得不好，C++就直接没学过。浙大复试通知上也是说只能用C或者C++。所以……

下面是pat1001，题目如下：

Calculate a + b and output the sum in standard format &#8212; that is, the digits must be separated into groups of three by commas (unless there are less than four digits).

**Input**

Each input file contains one test case. Each case contains a pair of integers a and b where -1000000 <= a, b <= 1000000. The numbers are separated by a space.

&nbsp;

**Output**

For each test case, you should output the sum of a and b in one line. The sum must be written in the standard format.

**Sample Input**

<pre>-1000000 9</pre>

**Sample Output**

<pre>-999,991</pre>

<pre>helloworld类型的，答案如下：</pre>

```c
#include <stdio.h>
void myprint(int);
int main()
{
	int a , b ;
	int sum;
	scanf("%d%d",&a,&b);
	sum = a + b;
	myprint(sum);
	return 0;
}
void myprint(int num)
{
/*	if(abs(num) > 999999999){
		printf("%d",(num/1000000000));
		printf(",");
		printf("%d%d%d",num/100000000%10,num/10000000%10,num/1000000%10);
		printf(",");
		printf("%d%d%d",num/100000%10,num/10000%10,num/1000%10);
		printf(",");
		printf("%d%d%d",num/100%10,num/10%10,num%10);
	}else
*/	if(num < 0 ) {
		printf("-");
		num = - num;
	}
	if((num) > 999999){
		printf("%d",(num/1000000));
		printf(",");
		printf("%d%d%d",num/100000%10,num/10000%10,num/1000%10);
		printf(",");
		printf("%d%d%d",num/100%10,num/10%10,num%10);
	}else if((num) > 999)
	{
		printf("%d",(num/1000));
		printf(",");
		printf("%d%d%d",num/100%10,num/10%10,num%10);
	}else{
		printf("%d",num);
	}
}
```

。
  
结果，通过……
