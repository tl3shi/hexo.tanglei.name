---
id: 1162
title: pat1002-A+B for Polynomials
date: 2011-09-22T14:04:15+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1162
duoshuo_thread_id:
  - 1351844048792453427
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 我不会算法
tags:
  - PAT
  - ZOJ
  - 保研复试
  - 浙大机试
---
继续做吧。题目如下：

<div id="problemContent">
  <p>
    This time, you are supposed to find A+B where A and B are two polynomials.
  </p>
  
  <p>
    <strong>Input</strong>
  </p>
  
  <p>
    Each input file contains one test case. Each case occupies 2 lines, and each line contains the information of a polynomial: K N1 a<sub>N1</sub> N2 a<sub>N2</sub> &#8230; NK a<sub>NK</sub>, where K is the number of nonzero terms in the polynomial, Ni and a<sub>Ni</sub> (i=1, 2, &#8230;, K) are the exponents and coefficients, respectively. It is given that 1 <= K <= 10，0 <= NK < &#8230; < N2 < N1 <=1000.
  </p>
  
  <p>
    <strong>Output</strong>
  </p>
  
  <p>
    For each test case you should output the sum of A and B in one line, with the same format as the input. Notice that there must be NO extra space at the end of each line. Please be accurate to 1 decimal place.
  </p>
  
  <p>
    <strong>Sample Input</strong>
  </p>
  
  <pre>2 1 2.4 0 3.2
2 2 1.5 1 0.5</pre>
  
  <p>
    <strong>Sample Output</strong>
  </p>
  
  <pre>3 2 1.5 1 2.9 0 3.2</pre>
</div>

**解题思路说明：**用大数组，下标是指数，数组里面的值是系数，刚开始始终只对一部分(题意没理解清楚)，在泱泱的帮助下，全部通过。代码如下：

```C
#include <stdio.h>
int main()
{
	float array[1001];
	int a,b,i;
	for(i = 1000;i>=0;i--){
		array[i]=0.0f;
	}
	scanf("%d",&a);
	for(i=0;i<a;i++){
		int exp = 0;
		float coe = 0.0f;
		scanf("%d",&exp);
		scanf("%f",&coe);
		array[exp]=coe;
	}
	scanf("%d",&b);
	for(i=0;i<b;i++){
		int exp = 0;
		float coe = 0.0f;
		scanf("%d",&exp);
		scanf("%f",&coe);
		array[exp]+=coe;
	}
	int result=0,flag=0;
	for(i = 1000;i>=0;i--)
	{
		if(array[i] != 0)
		{
			result++;
			flag=i;
		}
	}
	if(result == 0)
	{
		printf("%d",result);
		return 0;
	}
	
	printf("%d ",result);
	for(i = 1000;i>=0;i--)
	{
		if(array[i] != 0)
			printf("%d %.1f",i,array[i]);
		else 
			continue;
		if(i != flag) 
			printf(" ");
		
	}	
	return 0;
}
```
