---
id: 1164
title: pat1005—Spell It Right
date: 2011-09-22T14:09:36+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1164
duoshuo_thread_id:
  - 1351844048792453363
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 我不会算法
tags:
  - PAT
  - ZOJ
  - 保研
  - 浙大机试
  - 计算机复试
---
Given a non-negative integer N, your task is to compute the sum of all the digits of N, and output every digit of the sum in English.

**Input Specification:**

Each input file contains one test case. Each case occupies one line which contains an N (<= 10<sup>100</sup>).

**Output Specification:**
  
自己平时没怎么玩C语言真是遗憾啊。搞个动态分配数组等内存，啥啥都不会，写这些代码也就当熟悉下C语言的语法吧。

```C#
include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
	int * array;
	int t[1000];
	char inputstr[1000];
	int i=0,sum=0,len=0,j=0;
	//scanf("%s",inputstr);
	gets(inputstr);
	array = (int *)malloc(sizeof(int) * (strlen(inputstr)+1));
	
	len=strlen(inputstr);
	for(i=0;i<len;i++)
	{
		if(inputstr[i] != '\0')
			array[i]=inputstr[i]-'0';
		else
			break;
	}
	for(i = 0;i<len; i++)
		sum+=array[i];
//	printf("%d",sum);
	i=0;
	do{
		t[i++]=sum%10;
		sum=sum/10;
	}while(sum);

	for(j=i-1;j>=0;j--)
	{
		switch (t[j])
		{
			case 1: printf("one");break;
			case 2: printf("two");break;
			case 3: printf("three");break;
			case 4: printf("four");break;
			case 5: printf("five");break;
			case 6: printf("six");break;
			case 7: printf("seven");break;
			case 8: printf("eight");break;
			case 9: printf("nine");break;
			case 0: printf("zero");break;
		}
		if(j != 0) printf(" ");
	}
	
	return 0;
}
```

For each test case, output in one line the digits of the sum in English words. There must be one space between two consecutive words, but no extra space at the end of a line.

**Sample Input:**

<pre>12345</pre>

**Sample Output:**

<pre>one five</pre>
