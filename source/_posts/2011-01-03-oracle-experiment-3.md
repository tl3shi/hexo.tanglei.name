---
id: 286
title: 大型数据库实验(三)
date: 2011-01-03T04:46:57+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=286
duoshuo_thread_id:
  - 1351844048792453166
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 课程学习
tags:
  - Oracle
  - 数据库应用
  - 存储过程
---
接着看第三个题目吧。题目描述如下：
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-
  
使用游标，利用数组对EMP进行批检索（员工号、姓名、工作、工资和奖金，每次提取5行），并用print_rows（自定义过程）打印结果。
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-
  
这里说的emp就是scott/tiger下面的数据吧。我们还是别乱用最原始的数据，自己把scott中emp数据copy一份出来。用CREATE TABLE emp AS SELECT * FROM scott.EMP;来copy。注意登陆的用户要有使用scott中数据的权限。例如给个dba角色。咋看一下这个题目没怎么明白意思。揣测了下赵明老师的意思，应该要用到的知识点有：cursor,bulk collect 还要自定义存储过程。至于bulk collect有啥好处，我这里也不说了，网上一大堆，大概就是提高效率啊之类的。原理呢。网上也有。这里摘一段他的课件上的东西
  
In the context of bulk querying, set-at-a-time row retrieval means fetching the required rows in sets instead of fetching all rows at once.
  
This amounts to limiting the number of rows fetched at a time—that is, in a single fetch—instead of fetching all the rows in a single fetch.
  
This may result in more context switches than when all the rows are fetched in a single fetch but is optimal when the limiting value is correctly specified.
  
An accurate limiting value results in both performance and memory benefits.
  
然后课件上有个大概框架如下：

```sql
DECLARE
    t_outtab_type IS TABLE OF input_table%ROWTYPE;
    v_outtab t_outtab_type;
    CURSOR c_in IS SELECT * FROM input_table WHERE key_col = '<val1>';
BEGIN
    OPEN c_in;
    LOOP
        FETCH c_in BULK COLLECT INTO v_outtab LIMIT 100;
        FOR i IN 1..v_outtab.COUNT LOOP
            -- Process the rows one by one according to required logic.
            NULL;
        END LOOP;
        EXIT WHEN c_in%NOTFOUND;
    END LOOP;
    CLOSE c_in;
END;
/
```

就仿造例子写一个吧。实现这个题目意思的存储过程如下所示：

```sql
create or replace procedure fetchPer5fromEmp
as
begin
    declare
              type emp_array is table of emp%rowtype;
              emp_list  emp_array:=emp_array();
              cursor cur_emp is
                     select * from emp;
             fifth number:=1;--记录第几个五行记录
    begin
            open cur_emp;
            loop
                 fetch cur_emp bulk collect into  emp_list limit 5;--限制取出个数
                       DBMS_OUTPUT.put_line('--------------第'||fifth||'个五行记录---------');
                       for i in emp_list.first..emp_list.last loop
                       print_rows(emp_list(i));--调用自定义过程，传入数字里的一个值
                       end loop;
                       fifth:=fifth+1;
                       exit when cur_emp%notfound;--注意这句话，比如这个题目中只有14条记录，当循环2次后，第三次如果没有这条语句就会报错啦。刚开始我也没加，后来单步调试才知道这里少了这句话。
            end loop;
            DBMS_OUTPUT.put_line('总过得到记录总数为：'||cur_emp%rowcount);--cowcount是去当前游标的记录数，这里当然就是最后游标里面的总数量了。
            close cur_emp;
    end;
end;
/
```

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-实现打印的存储过程如下：

```sql
create or replace procedure print_rows(e emp%rowtype)
as
begin

   DBMS_OUTPUT.PUT_LINE(e.empno || '--' ||e.ename || '--' || e.job || '--' || e.sal || '--' || e.comm );

end;
/
```

实现效果如下图所示：
  
[<img src="/wp-content/uploads/2011/01/fetchper5fromemp.jpg" alt="" title="fetchper5fromemp"  class="alignleft size-medium wp-image-287" />](/wp-content/uploads/2011/01/fetchper5fromemp.jpg)
  
注意limit的使用。
        
整个实验就完了，oracle就3个题目。由于自己以前学过一段时间的oracle，可以说这次实验既是对以前的复习，也是重新学习plsql编程。才发现自己以前学的忘了差不多了。不过总的说来还是满有收获滴。也沿用了以前的一些小技巧。例如将sql写在文本文件当中，在sqlplus中直接通过@命令导入执行，可以提高效率。再写存储过程啊之类的plsql代码的时候还是容易忘把serveroutput打开，dbms\_output.putline调用了没有反映。仍然有粗心的地方。就比如dbms\_output.putline写成了dbms\_output\_putline还始终找不到出了啥错误，到处google也好百度也罢，没搞定。最后才发现是点用了下划线。以前存储过程、触发器有些印象，不过像bulk collect之类的还是没有用过，这对自己来说又是提高了眼界了吧。在写存储过程时，还是得依靠像plsql-devloper这样的工具帮忙，虽然赵老师说科班出身不依赖工具，但像这种存储过程借助那样的工具实在是要方便得多，单步调试找错要方便些。不过自己还是得注意不要太依赖与工具。以后的路还长啊，仍需不断努力，给自己加油吧。
