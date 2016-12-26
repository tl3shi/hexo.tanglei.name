---
id: 281
title: 大型数据库实验(二)
date: 2011-01-03T04:20:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=281
duoshuo_thread_id:
  - 1351844048792453183
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 数据库应用
tags:
  - Oracle
  - 存储过程
---
第二个题目主要考查了触发器以及存储过程的使用，题目描述如下：
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;
  
2、医院药品都实行效期管理，效期早的药品先使用。请设计一个程序来按效期使用药品，要求：1、使用触发器来维护两个表之间的库存的一致性。2、对药品出库时,能正确选择批次。

用到的表以及数据如下所示：

```sql
--药品库存表kc
create table kc(
id number(2) primary key, --药品id
ypname varchar2(20),--药品名称
num number(5) --数量
);
insert into kc values (1,'青霉素',3000);
insert into kc values (2,'双黄连',4000);

--药品批次库存表batchkc
create table batchkc(
id number(2) references kc(id), --药品id
validdate date, --到期时间
bnum number(5), --数量
primary key (id,validdate)
);
insert into batchkc values (1,'01-5月-04',2500);
insert into batchkc values (1,'01-12月-04',500);
insert into batchkc values (2,'12-1月-04',1000);
insert into batchkc values (2,'07-6月-04',1000);
insert into batchkc values (2,'13-8月-04',1000);
insert into batchkc values (2,'13-12月-05',1000);
```

这个还好，至少对每个字段进行了说明。。就比较清晰了。
  
按照要求写一个存储过程，传入两个参数，一个是药品的名称，另外一个就是要出库的数量。代码如下：

```sql
--chuku.prc
create or replace procedure chuku(c_ypname varchar2,c_num number)
as
begin
       declare
       kc_num number ;--库存中的数量
       needLeft number;--临时变量，还需要出库的数量
       yp_id number;--库存药品id
       cursor cur_batchkc(kc_id number) is
              select bnum,id,validdate from batchkc where id=kc_id order by validdate asc --时间升序
              for update;
       begin
              select num,id into kc_num,yp_id from kc where ypname=c_ypname;

              if(kc_num >= c_num) then --如果库存中的药品数量>要出库的数量的话 就出库
                        DBMS_OUTPUT.PUT_LINE('正在计算出库顺序：');
                        DBMS_OUTPUT.PUT_LINE('出库列表如下：');
                        needLeft := c_num; --还需要最初始出库那么多
                        for it in cur_batchkc(yp_id) loop --遍历
                            if(it.bnum > needLeft) then --还有可以用来出库滴
                                       update batchkc set bnum = bnum-needLeft where current of cur_batchkc;
                                       DBMS_OUTPUT.PUT_LINE('batchkc-ID           出库数量        过期时间');
                                       DBMS_OUTPUT.PUT_LINE(it.id||'                   '||needLeft||'           '||it.validdate);
                                       exit;--第一条记录就满足出库数量的提交 可以退出了
                             elsif (it.bnum=needLeft) then --刚好满足
                                   delete from batchkc where current of cur_batchkc;
                                   DBMS_OUTPUT.PUT_LINE('batchkc-ID           出库数量         过期时间');
                                   DBMS_OUTPUT.PUT_LINE(it.id||'                   '||needLeft||'           '||it.validdate);
                                   exit;--刚好 满足 也退出
                             else --第一条记录满足不了了。
                                  delete from batchkc where current of cur_batchkc;--满足不了先出库
                                  DBMS_OUTPUT.PUT_LINE('batchkc-ID           出库数量          过期时间');
                                  DBMS_OUTPUT.PUT_LINE(it.id||'                   '||it.bnum||'           '||it.validdate);
                                  needLeft := needLeft - it.bnum;--还需要的数量减少
                             end if;
                        end loop;
              else --库存不足啦
                   DBMS_OUTPUT.PUT_LINE('药品不够啦');
              end if;
       end;
end;
/
```

上面有注释，应该能看懂吧。然后还得有个触发器，让去update或者delete的时候自动去维护两张表的关系。代码如下：

```sql
create or replace trigger tri_batchkc
after delete or update on batchkc for each row--行级触发器
declare
      v_num NUMBER;
begin
       if DELETING then
          update kc set num=num-:old.bnum where id=:old.id;
      end if;

       select num into v_num from kc where id=:old.id;
           if v_num=0 then
            --刚好出库完毕 就可以把当前的记录删掉啦
            delete from kc where id=:old.id;
           end if;

           if UPDATING then
            update kc set num=num-(:old.bnum-:new.bnum) where id=:old.id;
           end if;
end;
/
```

实现的效果如下：
  
[<img class="alignleft size-medium wp-image-282" title="chuku" src="/wp-content/uploads/2011/01/chuku.jpg" alt=""  />](/wp-content/uploads/2011/01/chuku.jpg)
  
注意的是，为了实验中的方便。这里在存储过程中都没有去commit，免得一会又得重新@导入数据。
  
上上一个题目中也是滴。
