---
id: 1166
title: pat1006—Sign In and Sign Out
date: 2011-09-23T14:13:32+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1166
duoshuo_thread_id:
  - 1351844048792453394
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
<div id="problemContent">
  <p>
    At the beginning of every day, the first person who signs in the computer room will unlock the door, and the last one who signs out will lock the door. Given the records of signing in&#8217;s and out&#8217;s, you are supposed to find the ones who have unlocked and locked the door on that day.
  </p>
  
  <p>
    <strong>Input Specification:</strong><br /> Each input file contains one test case. Each case contains the records for one day. The case starts with a positive integer M, which is the total number of records, followed by M lines, each in the format:
  </p>
  
  <pre>ID_number Sign_in_time Sign_out_time</pre>
  
  <p>
    where times are given in the format HH:MM:SS, and ID number is a string with no more than 15 characters.
  </p>
  
  <p>
    <strong>Output Specification:</strong>
  </p>
  
  <p>
    For each test case, output in one line the ID numbers of the persons who have unlocked and locked the door on that day. The two ID numbers must be separated by one space.
  </p>
  
  <p>
    Note: It is guaranteed that the records are consistent. That is, the sign in time must be earlier than the sign out time for each person, and there are no two persons sign in or out at the same moment.
  </p>
  
  <p>
    <strong>Sample Input:</strong>
  </p>
  
  <pre>3
CS301111 15:30:28 17:00:10
SC3021234 08:00:00 11:25:25
CS301133 21:45:00 21:58:40</pre>
  
  <p>
    <strong>Sample Output:</strong>
  </p>
  
  <pre>SC3021234 CS301133</pre>
</div>

思路是转换成秒，比较时间。代码如下：

```C
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int gettime(char[]);
int main()
{
	int n,i;
	int maxtime=0,mintime=0;
	char inperson[16];
	char outperson[16];
	char person[16];
	char time1[9],time2[9];
	//printf("%d",gettime("00:01:28"));
	scanf("%d",&n);
	maxtime=gettime("00:00:01");
	mintime=gettime("23:59:59");
	for(i=0;i<n;i++)
	{
		scanf("%s%s%s",person,time1,time2);

		if(mintime>gettime(time1)){
			strcpy(inperson,person);
			mintime = gettime(time1);
		}
		if(maxtime<gettime(time2)){
			strcpy(outperson,person);
			maxtime = gettime(time2);
		}
	}
	printf("%s %s",inperson,outperson);

	return 0;
}

int gettime(char time[])
{
	
	int i=0,j=0;
	char t[3];
	for(i=0;i<2;i++){
		t[j++]=time[i];
	}
	t[j]='\0';
	int hour = atoi(t);

	for(i=3,j=0;i<5;i++){
		t[j++]=time[i];
	}
	t[j]='\0';
	int min = atoi(t);

	for(i=6,j=0;i<8;i++){
		t[j++]=time[i];
	}
	t[j]='\0';
	int sec = atoi(t);

	return 3600*hour+min*60+sec;
}
```
