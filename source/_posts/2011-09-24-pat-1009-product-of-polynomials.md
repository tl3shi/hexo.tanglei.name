---
id: 1170
title: pat1009—Product of Polynomials
date: 2011-09-24T14:19:05+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1170
duoshuo_thread_id:
  - 1351844048792453359
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
跟前面多项式相加解题思路一致。

This time, you are supposed to find A*B where A and B are two polynomials.

**Input Specification:**

Each input file contains one test case. Each case occupies 2 lines, and each line contains the information of a polynomial: K N1 a<sub>N1</sub> N2 a<sub>N2</sub> &#8230; NK a<sub>NK</sub>, where K is the number of nonzero terms in the polynomial, Ni and a<sub>Ni</sub> (i=1, 2, &#8230;, K) are the exponents and coefficients, respectively. It is given that 1 <= K <= 10, 0 <= NK < &#8230; < N2 < N1 <=1000.

&nbsp;

**Output Specification:**

For each test case you should output the product of A and B in one line, with the same format as the input. Notice that there must be NO extra space at the end of each line. Please be accurate up to 1 decimal place.

**Sample Input**

<pre>2 1 2.4 0 3.2
2 2 1.5 1 0.5</pre>

**Sample Output**

<pre>3 3 3.6 2 6.0 1 1.6</pre>

通过的答案： 

```C
#include <stdio.h>
int main()
{
	float array1[1001],array2[1001],array[2002];
	int a,b,i,j,maxexp1=0,maxexp2=0;
	int flag;
	for(i = 1000,j=2000;i>=0,j>=0;i--,j--){
		array1[i]=0.0f;
		array2[i]=0.0f;
		array[j]=0.0f;
	}

	scanf("%d",&a);
	for(i=0;i<a;i++){
		int exp = 0;
		float coe = 0.0f;
		scanf("%d",&exp);
		scanf("%f",&coe);
		if(exp>maxexp1) maxexp1=exp;
		array1[exp]=coe;
	}
	scanf("%d",&b);
	for(i=0;i<b;i++){
		int exp = 0;
		float coe = 0.0f;
		scanf("%d",&exp);
		scanf("%f",&coe);
		if(exp>maxexp2) maxexp2=exp;
		array2[exp]=coe;
	}

	for(i=0;i<=maxexp1;i++)
	{
		for(j=0;j<=maxexp2;j++){
			array[i+j]+=array1[i]*array2[j];
		}
	}
	

	int result=0;
	for(i = 2000;i>=0;i--){
		if(array[i] != 0)
		{
			result ++;
			flag=i;
		}
	}
	if(result==0)
		printf("0");
	else{
		printf("%d ",result);
		for(i=2000;i>=0;i--)
		{
			if(array[i]!=0)
			{
				printf("%d %.1f",i,array[i]);
				if(i != flag) printf(" ");
			}
			
		}
	}
	return 0;
}
```
