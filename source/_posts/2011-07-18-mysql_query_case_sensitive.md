---
id: 1035
title: php中mysql_query函数区分大小写
date: 2011-07-18T20:58:01+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1035
duoshuo_thread_id:
  - 1351844048792453279
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 除臭虫
tags:
  - PHP
  - Mysql
---
今天写php代码的时候，发现一个问题，因为我的数据库是用mysqlfront建的，自动添加的字段是Id作为主键。然后我在查询的时候写了这样的代码：

```sql
$sql = "SELECT id,post_user,post_title,post_time FROM posts ";
$result=mysql_query($sql);
$row =  mysql_fetch_array($result)
```

然后去$row[&#8216;Id&#8217;]始终获取不到数据，结果将sql语句中的id改成了Id就行了，开始怀疑mysql数据库区分大小写，不过这么久的经验来看应该不区分的啊。结果网上查了下有如下结果：
  
　 

>
MySQL在Linux下数据库名、表名、列名、别名大小写规则是这样的：
　　1、数据库名与表名是严格区分大小写的；
　　2、表的别名是严格区分大小写的；
　　3、列名与列的别名在所有的情况下均是忽略大小写的；
　　4、变量名也是严格区分大小写的；
　　MySQL在Windows下都不区分大小写。

　　所以在不同操作系统中为了能使程序和数据库都能正常运行，最好的办法是在设计的时候都转为小写，但是如果在设计的时候已经规范化大小写了，那么在Windows环境下只要对数据库的配置做下改动就行了，具体操作如下：
　　在MySQL的配置文件中my.ini [mysqld] 中增加一行
　　lower_case_table_names = 1
　　参数解释：
　　0：区分大小写
　　1：不区分大小写

然后就觉得奇怪了不区分大小写，为啥。后来测试了下终于发现原因了。原来是msyql_query这个方法的原因，select的是str1，那么必须得通过str2作为key去获得相应的value，这里的str2必须equals，而不是equalsIgnorecase.也就是说，结果集里面必须**跟sql语句中select的大小写保持一致**才能取出来。
