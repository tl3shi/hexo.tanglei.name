---
id: 1174
title: pat1011—World Cup Betting
date: 2011-09-26T14:26:36+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1174
duoshuo_thread_id:
  - 1351844048792453277
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
<div id="problemContent">
  <p>
    With the 2010 FIFA World Cup running, football fans the world over were becoming increasingly excited as the best players from the best teams doing battles for the World Cup trophy in South Africa. Similarly, football betting fans were putting their money where their mouths were, by laying all manner of World Cup bets.
  </p>
  
  <p>
    Chinese Football Lottery provided a &#8220;Triple Winning&#8221; game. The rule of winning was simple: first select any three of the games. Then for each selected game, bet on one of the three possible results &#8212; namely W for win, T for tie, and L for lose. There was an odd assigned to each result. The winner&#8217;s odd would be the product of the three odds times 65%.
  </p>
  
  <p>
    For example, 3 games&#8217; odds are given as the following:
  </p>
  
  <pre> W    T    L
1.1  2.5  1.7
1.2  3.0  1.6
4.1  1.2  1.1</pre>
  
  <p>
    To obtain the maximum profit, one must buy W for the 3rd game, T for the 2nd game, and T for the 1st game. If each bet takes 2 yuans, then the maximum profit would be (4.1*3.0*2.5*65%-1)*2 = 37.98 yuans (accurate up to 2 decimal places).
  </p>
  
  <p>
    <strong>Input</strong>
  </p>
  
  <p>
    Each input file contains one test case. Each case contains the betting information of 3 games. Each game occupies a line with three distinct odds corresponding to W, T and L.
  </p>
  
  <p>
    <strong>Output</strong>
  </p>
  
  <p>
    For each test case, print in one line the best bet of each game, and the maximum profit accurate up to 2 decimal places. The characters and the number must be separated by one space.
  </p>
  
  <p>
    <strong>Sample Input</strong>
  </p>
  
  <pre>1.1 2.5 1.7
1.2 3.0 1.6
4.1 1.2 1.1</pre>
  
  <p>
    <strong>Sample Output</strong>
  </p>
  
  <pre>T T W 37.98</pre>
</div>

* * *

```C
#include <stdio.h>

int findmax(float a,float b,float c)
{
	int res = 0;
	float max = (a>b?a:b)>c?(a>b?a:b):c;
	res = (max==a)?0:(max==b?1:2);
	return res;
}
float round(float origin, int precision)
{
	int i=0;
	for( i = 0; i < precision;i++)
	{
		origin = origin * 10;
	}
	float result = (float)(int)(origin + 0.5);
	for( i = 0; i < precision;i++)
	{
		result = result / 10;
	}
	return result;
}

int main()
{
	//printf("%.2f\n",round(37.952f,2));
	//printf("%.2f",round(37.955f,2));

	//printf("%d",findmax(1.1f,2.5f,1.7f));
	float games[3][3];
	int i=0,j=0;
	int max;
	float rmb=1.0f;
	for(i=0;i<3;i++)
		for(j=0;j<3;j++)
		scanf("%f",&games[i][j]);

	for(i=0;i<3;i++)
	{
		max = findmax(games[i][0],games[i][1],games[i][2]);
		if(max == 0) printf("W ");
		else if(max == 1) printf("T ");
		else printf("L "); 

		rmb*=games[i][max];
	}
	//(4.1*3.0*2.5*65%-1)*2

	rmb=round((rmb*0.65f-1)*2,2);
	//rmb=(rmb*0.65f-1)*2;
	printf("%.2f",rmb);

	return 0;
}
```
