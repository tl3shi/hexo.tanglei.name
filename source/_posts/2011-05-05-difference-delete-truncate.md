---
id: 607
title: Oracle delete和 truncate区别
date: 2011-05-05T03:13:52+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=607
duoshuo_thread_id:
  - 1351844048792453179
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 课程学习
tags:
  - Oracle
  - 数据库
---
刚才去做了一个公司的实习生招聘笔试题目，其中有Oracle delete和 truncate区别，记得以前赵明老师讲过一点，只是有点印象，具体想不出来了。网上查了下。发现下面这篇文章不错，遂转之。

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-size: small;"><span style="font-family: 宋体;">删除表中的数据的方法有</span><span lang="EN-US"><span style="font-family: 宋体;">delete,truncate,</span></span></span>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-size: small;"><span style="font-family: 宋体;">它们都是删除表中的数据</span><span style="font-family: 宋体;"><span lang="EN-US">,</span><span style="font-family: 宋体;">而不能删除表结构</span><span lang="EN-US">,delete </span><span style="font-family: 宋体;">可以删除整个表的数据也可以删除表中某一条或</span><span lang="EN-US">N</span><span style="font-family: 宋体;">条满足条件的数据</span><span lang="EN-US">,</span><span style="font-family: 宋体;">而</span><span lang="EN-US">truncate</span><span style="font-family: 宋体;">只能删除整个表的数据</span><span lang="EN-US">,</span><span style="font-family: 宋体;">一般我们把</span><span lang="EN-US">delete </span><span style="font-family: 宋体;">操作收作删除表</span><span lang="EN-US">,</span><span style="font-family: 宋体;">而</span><span lang="EN-US">truncate</span><span style="font-family: 宋体;">操作叫作截断表</span><span lang="EN-US">.</span></span></span>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <strong><span style="font-size: small;"><span style="font-family: 宋体;"><span lang="EN-US"> </span></span></span><span style="font-family: verdana; color: #303030; font-size: 10pt;" lang="EN-US">truncate</span><span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">操作与</span><span style="font-family: verdana; color: #303030; font-size: 10pt;" lang="EN-US">delete</span><span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">操作对比</span></strong>
</div>

<div>
  <table class="MsoTableGrid" style="border-collapse: collapse; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-alt: solid windowtext .5pt; mso-yfti-tbllook: 480; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext; border: medium none;" border="1" cellspacing="0" cellpadding="0">
    <tr style="height: 14.9pt; mso-yfti-irow: 0; mso-yfti-firstrow: yes;">
      <td style="padding-bottom: 0cm; background-color: transparent; padding-left: 5.4pt; width: 74.9pt; padding-right: 5.4pt; height: 14.9pt; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; border: windowtext 1pt solid;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">操作</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-top: windowtext 1pt solid; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">回滚</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-top: windowtext 1pt solid; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">高水线</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-top: windowtext 1pt solid; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">空间</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-top: windowtext 1pt solid; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">效率</span>
        </div>
      </td>
    </tr>
    
    <tr style="height: 14.9pt; mso-yfti-irow: 1;">
      <td style="border-bottom: windowtext 1pt solid; border-left: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.9pt; padding-right: 5.4pt; height: 14.9pt; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: verdana; color: #303030; font-size: 10pt;" lang="EN-US">Truncate</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">不能</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">下降</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">回收</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 14.9pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">快</span>
        </div>
      </td>
    </tr>
    
    <tr style="height: 15.75pt; mso-yfti-irow: 2; mso-yfti-lastrow: yes;">
      <td style="border-bottom: windowtext 1pt solid; border-left: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.9pt; padding-right: 5.4pt; height: 15.75pt; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: verdana; color: #303030; font-size: 10pt;" lang="EN-US">delete</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 15.75pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">可以</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 15.75pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">不变</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 15.75pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">不回收</span>
        </div>
      </td>
      
      <td style="border-bottom: windowtext 1pt solid; padding-bottom: 0cm; background-color: transparent; border-top-color: #ece9d8; padding-left: 5.4pt; width: 74.95pt; padding-right: 5.4pt; height: 15.75pt; border-left-color: #ece9d8; border-right: windowtext 1pt solid; padding-top: 0cm; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;" width="100" valign="top">
        <div class="MsoNormal" style="text-align: center; text-indent: 0cm; margin: 0cm 0cm 0pt;">
          <span style="font-family: 宋体; color: #303030; font-size: 10pt; mso-ascii-font-family: verdana; mso-hansi-font-family: verdana;">慢</span>
        </div>
      </td>
    </tr>
  </table>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span lang="EN-US"><span style="font-family: 宋体; font-size: small;"> </span></span>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-family: 宋体;"><span style="font-size: small;">下面分别用实例查看它们的不同</span></span>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-family: 宋体;"><span style="font-size: small;"> </span></span><strong>1.回滚</strong>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  首先要明白两点
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  1.在oracle 中数据删除后还能回滚是因为它把原始数据放到了undo表空间,
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-family: 宋体;"><span style="font-size: small;">2.DML语句使用undo表空间,DDL语句不使用undo,而delete是DML语句,truncate是DDL语句,别外DDL语句是隐式提交. 所以truncate操用不能回滚,而delete操作可以. 两种操作对比(首先新建一个表,并插入数据)</span></span>
</div>

<div class="MsoNormal" style="margin: 0cm 0cm 0pt;">
  <span style="font-family: 宋体;"><span style="font-size: small;"><br /> </span></span>
</div>

```sql
SQL> create table t
  2  (
  3  i number
  4  );
Table created.
SQL> insert into t values(10);
SQL> commit;
Commit complete.
SQL> select * from t;
         I
----------
        10
```

Delete删除,然后回滚 

```sql
SQL> delete from t;
1 row deleted.
SQL> select * from t;
no rows selected
#删除后回滚
SQL> rollback;
Rollback complete.
SQL> select * from t;
         I
----------
        10
```

Truncate截断表,然后回滚. 

```sql
SQL> truncate table t;
Table truncated.
SQL> rollback;
Rollback complete.
SQL> select * from t;
no rows selected
```

可见delete删除表还可以回滚,而truncate截断表就不能回滚了.(前提是delete操作没有提交)
  
2.高水线
  
所有的Oracle表都有一个容纳数据的上限（很象一个水库历史最高的水位），我们把这个上限称为“high water mark”或HWM。这个HWM是一个标记(专门有一个数据块用来记录高水标记等)，用来说明已经有多少数据块分配给这个表. HWM通常增长的幅度为一次5个数据块.
  
delete语句不影响表所占用的数据块, 高水线(high watermark)保持原位置不动
  
truncate 语句缺省情况下空间释放,除非使用reuse storage; truncate会将高水线复位
  
下面对两种操作对比 

```sql
SQL> analyze table t estimate statistics;
Table analyzed.
SQL> select segment_name,blocks from dba_segments where segment_name=upper('t');
SEGMENT_NAME                       BLOCKS
------------------------------ ----------
T                                      24
SQL> select table_name,blocks,empty_blocks from user_tables where table_name=upper('t');
TABLE_NAME                         BLOCKS EMPTY_BLOCKS
------------------------------ ---------- ------------
T                                      20            3
```

USER_TABLES.BLOCKS 列代表该表中曾经使用过得数据库块的数目，即水线。
  
注意：USER\_TABLES.BLOCKS EMPTY\_BLOCKS (20+3=23)比DBA\_SEGMENTS.BLOCKS少一个数据库块，这是因为有一个数据库块被保留用作表头。DBA\_SEGMENTS.BLOCKS 表示分配给这个表的所有的数据库块的数目。USER_TABLES.BLOCKS表示已经使用过的数据库块的数目(水线)。
  
Delete删除表 

```sql
SQL> delete from t;
10000 rows deleted
SQL> commit;
Commit complete.
SQL> analyze table t estimate statistics;
Table analyzed.
SQL> select table_name,blocks,empty_blocks from user_tables where table_name=upper('t');
TABLE_NAME                         BLOCKS EMPTY_BLOCKS
------------------------------ ---------- ----------------------------------------------------------------
T                                      20            3
```

Truncate截断表 

```sql
SQL> truncate table t;
Table truncated.
SQL> analyze table t estimate statistics;
Table analyzed.
SQL> select table_name,blocks,empty_blocks from user_tables where table_name=upper('t');
TABLE_NAME                         BLOCKS EMPTY_BLOCKS
------------------------------ ---------- --------------------------------------------------------
T                                       0            7
```

可见,delete表,BLOCK(高水线)不变,而truncate表BLOCKS(高水线)变为0
  
现在我们也看到blocks+empty_blocks=7,也就是oracle分配区时默认一次7+1(表头)=8个blocks;
  
高水线的作用: HWM对数据库的操作有如下影响：
  
a) 全表扫描通常要读出直到HWM标记的所有的属于该表数据库块，即使该表中没有任何数据。
  
b) 即使HWM以下有空闲的数据库块，键入在插入数据时使用了append关键字，则在插入时使用HWM以上的数据块，此时HWM会自动增大。
  
因此高水线是oracle优化时一个重要的参数
  
3.空间
  
既然高水线用来说明已经有多少数据块分配给这个表，那么高水线也可理解为表的空间占用。
  
即使delete将表中的数据全部删除，HWM还是为原值，所以还有那么多的空间分配给这个表，即它的空间还没有回收，
  
而truncate表后高水线变为0，那现在它就表示没有分配空间，即它的空间被回收了。
  
4．效率
  
要想查看delete,truncate那个效率更高，先构建一个大表，然后查看它们分别对些表删除所需的时间。
  
有个相当形象的比喻：领导给你两本书让你扔掉,delete就是你守在复印机前,把书一页页撕下来复印一份,再一页页扔到垃圾桶里,truncate就是直接把两本书扔到垃圾桶里，那个快那个慢不言而喻。
  
先在表中插入100000条记录，并打开时间 

```sql
SQL> set timing on;
SQL> begin
  2  for i in 1..100000 loop
  3  insert into t values('10');
  4  commit;
  5  end loop;
  6  end;
  7  /
PL/SQL procedure successfully completed.
Elapsed: 00:01:12.50
```

Delete删除表 

```sql
SQL> delete from t;
100000 rows deleted.
Elapsed: 00:00:20.09
```

Truncate 截断表 

```sql
#先把表回滚
SQL> rollback;
Rollback complete.
Elapsed: 00:00:17.36
SQL> select count(*) from t;
  COUNT(*)
-------------------
    100000
Elapsed: 00:00:00.01
SQL> truncate table t;
Table truncated.
Elapsed: 00:00:00.20
```

可见删除同一个大小的表，delete用了20.09秒，而truncate只用了0.2秒.

以上内容转自：http://chenxy.blog.51cto.com/729966/168459
