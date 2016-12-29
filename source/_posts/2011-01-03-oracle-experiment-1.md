---
id: 272
title: 大型数据库实验(一)
date: 2011-01-03T03:49:39+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=272
duoshuo_thread_id:
  - 1351842949280825461
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 课程学习
tags:
  - Oracle
  - 存储过程
  - 数据库应用
---
这两天做了oracle的实验了。第一题目描述如下：

表PAY_TABLE结构为：

Name                   Null?                           Type

NAME                  NOT NULL                 VARCHAR2(20)

PAY_TYPE           NOT NULL                 VARCHAR2(8)

PAY_RATE          NOT NULL                 NUMBER(8,2)

EFF_DATE          NOT NULL                 DATE

PREV_PAY                                              NUMBER(8,2)

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;

数据：

NAME                         PAY\_TYPE           PAY\_RATE          EFF\_DATE          PREV\_PAY

SANDRA SAMUELS       HOURLY                12.50                     01-JAN-04

ROBERT BOBAY            HOURLY                11.50                     15-MAY-03

KEITH  JONES           HOURLY                10.00                     31-OCT-04

SUSAN WILLIAMS       HOURLY                9.75                      01-MAY-04

CHRISSY ZOES            SALARY                 50000.00               01-JAN-04

CLODE EVANS             SALARY                 42150.00                01-MAR-04

JOHN SMITH                     SALARY                 35000.00               15-JUN-03

要求：要给为你工作的时间超过了六个月的员工增加薪金。符合条件的钟点工的薪金增加4%，而符合条件的雇员的薪金需要增加5%。
  
建表以及数据的sql如下：

```sql
create table pay_table
(
NAME	 VARCHAR2(20) NOT NULL ,
PAY_TYPE	VARCHAR2(8) 	NOT NULL,
PAY_RATE	NUMBER(8,2) 	NOT NULL,
EFF_DATE	DATE 	NOT NULL,
PREV_PAY	NUMBER(8,2)
);

insert into pay_table values('SANDRA SAMUELS','HOURLY',12.50,to_date('01-01-04','DD-MM-YY'),null);
insert into pay_table values('ROBERT BOBAY','HOURLY',11.50,to_date('15-03-03','DD-MM-YY'),null);
insert into pay_table values('KEITH  JONES','HOURLY',10.00,to_date('31-10-04','DD-MM-YY'),null);
insert into pay_table values('SUSAN WILLIAMS','HOURLY',9.75,to_date('01-05-04','DD-MM-YY'),null);
insert into pay_table values('CHRISSY ZOES','SALARY',50000.00,to_date('01-01-04','DD-MM-YY'),null);
insert into pay_table values('CLODE EVANS','SALARY',42150.00,to_date('01-03-04','DD-MM-YY'),null);
insert into pay_table values('JOHN SMITH','SALARY',35000.00,to_date('15-06-03','DD-MM-YY'),null);
insert into pay_table values('KEVIN TROLLBERG','SALARY',27500.00,to_date('15-06-03','DD-MM-YY'),null);
```

插入日期时还得注意格式。与当前session中的格式一致。
  
<!--more-->唉，赵明老师也不给个备注。。各个字段给解释下才行嘛。PREV_PAY现在才发现估计是记录上一次的工资值。当时做的时候还没有注意呢，不管了。也就是个update的语句。下面用存储过程实现如下：

```sql
create or replace procedure proc_dbtest
as
begin
  declare
    cursor pay_cursor is select name,pay_type,pay_rate,eff_date from pay_table;
     months number;--入职到现在相差月份数量
     indexRecord pay_cursor%rowtype;--游标的定义，指向单行记录
     newPayRate number(8,2);--新的工资率

   begin
     open pay_cursor;--打开游标
     loop
          fetch pay_cursor into indexRecord;--取出一行放入定义的indexRecord中
          exit when pay_cursor%notfound;
          --注意学会用oracle中的日期函数。
          months:= MONTHS_BETWEEN(sysdate, indexRecord.eff_date);--返回当前日期和记录中的日期相差的月份数量
          if(months>6) then
                       if(indexRecord.pay_type='HOURLY') then
                            newPayRate:=indexRecord.pay_rate*1.04;
                       else --薪金 增加5%
                            newPayRate:=indexRecord.pay_rate*1.05;
                       end if;
          --更新新的工资率 
          update pay_table set pay_rate=newPayRate where current of pay_cursor;
          commit;
          end if;
     end loop;
     close pay_cursor;--关闭
    end;
end;
```

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-
  
这个实验主要考查了oracle中存储过程的基本语法，以及游标的使用。注意会用oracle中的日期函数。用好了日期函数，可以节约很大的逻辑。
