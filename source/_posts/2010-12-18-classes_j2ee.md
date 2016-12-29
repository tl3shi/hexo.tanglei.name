---
id: 84
title: J2EE考点
date: 2010-12-18T11:34:55+00:00
author: tanglei
excerpt: |
  J2EE考点 环境配置  JAVA常用的命令 JAVA的特点 JAVA类型转换顺序，方法(略)
  JAVA关键字
layout: post
guid: http://www.tanglei.name/?p=84
duoshuo_thread_id:
  - 1351844048792453280
categories:
  - 课程学习
tags:
  - J2EE
  - JAVA
  - 考试
---
1、 JAVA的环境配置

a)         Java_HOME:  D:\jdk1.5.0

b)        PATH:  D:\jdk1.5.0\bin;

c)         CLASSPATH: .; D:\jdk1.5.0\lib\tools.jar; D:\jdk1.5.0\jre\lib\rt.jar;

2、 JAVA常用的命令

Java ,javac,javadoc

3、 JAVA的特点

简单，面向对象，健壮性，安全性，分布性，多线程

跨平台

4、 JAVA类型转换顺序，方法(略)

5、 JAVA关键字

基本数据类型

a)         **byte**

b)        **short**

c)         **int**

d)        **long**

e)         **float**

f)          **double**

g)        **char**

h)        **boolean**

循环关键字

i)           **do**

j)           **while**

k)         **for**

l)           **break**

m)      **continue**

**包相关关键字**

 **package**

 **import**

6、 JAVA类，对象，多态，继承，封装，构造方法，异常，方法重载，静态成员，Import

7、 JAVA常见异常

8、 Eclipse配置文件，LIB位置，.class文件用途，.project文件用途,打包JAR

9、 JAVA接口与实现类（代码题） 抽象类，接口注意事项，，数据类型定义,this

10、             Final的三个用处：如果将某个变量修饰为final，那么该变量就成为常量，如果将某个成员方法修饰为final，则意味着该方法不能被子类覆盖，如果将某个类修饰为final，则说明该类无法被继承

11、             J2EE的13种技术和简介

JNDI，EJB，RMI ，Java IDL/CORBA ，JMS，JTA，JTS ，JavaMail，JAF

JDBC， XML， JSP，Java Servlet

12、             JAVA分层结构

a)         运行在客户端机器上的客户层组件

b)        运行在J2EE服务器上的Web层组件

c)         运行在J2EE服务器上的业务逻辑层组件

d)        运行在EIS服务器上的企业信息系统层软件

13、             JAVA服务模型

a)         安全(Security)模型

b)        事务管理（Transaction Management）模型

c)         远程连接（Remote Client Connectivity）模型

d)        生存周期管理（Life Cycle Management）模型

e)         数据库连接池（Database Connection Pooling）模型

14、             版本控制基本操作

a)         提交:commit，check in

b)        检出:check out

c)         更新:update

d)        合并:merge

e)         显示历史：show history

15、             调试操作

a)         打断点

b)        查看变量，语句执行情况

c)         操作上有单步执行，进入方法等

16、             Tomcat目录结构

Bin: <span style="text-decoration: underline;"></span><span style="text-decoration: underline;">存放平台上启动和关闭的脚本文件</span>

Conf: 存放配置文件

Lib: 存放服务器所需的各种JAR文件

Logs:日志文件

Temp：临时文件

Webapps:Web项目发布目录

Work:将JSP装换为JAVA SERVLET

17、             Servlet运行简介（图）及生命周期

18、             Servlet/JSP规范与Tomcat版本

3.0/2.2\____ 7.0.0

2.5/2.1\____ 6.0.18

2.4/2.0\____ 5.5.25

2.3/1.2\____ 4.1.36

2.2/1.1\____ 3.3.2 [[tl3shi1]](file:///R:/j2ee-beta3.doc#_msocom_1)

19、             常用端口

Tomcat:8080

Oracle:1521(这个是对的么？)——对 还有SQLSERVER?1433  Mysql？3306

JBoss:8080

SQLServer:1433

20、             常见服务端，数据库，版本控制软件\

服务端

Tomcat(严谨的说是jsp服务器)  Weblogic  Jboss   Apache  Webspere

数据库

SqlServer ,Oracle,DB2,MySQL

版本控制软件

CVS(Concurrent Versions System) \ VS \ Clearcase

Svn

git

21、             JDBC常用接口

a)         Connection

b)        Driver

c)         Statement

d)        PreparedStatement

e)         CallableStatement

f)          ResultSet

22、             事务的三个方法

a)         conn.setAutoCommit(**false**);

b)        conn.commit()

c)         conn.rollback()

23、             事务的特性

**原子性（atomicity****）** **一致性（consistency****）** **隔离性（isolation****）** **持久性（durability****）**

24、             JDBC基本步骤

加载驱动

获得连接

获得语句对象

获得结果集

遍历结果集

关闭数据库有关对象

25、             JNDI相关知识 //这个也考啊？

26、             XML相关知识[用途，结构，语法规则，命名规范]

27、             DOM4J实例程序

28、             servlet运行体系简介

29、             request结构

³          路径：IP，端口，目录

³      会话：会话id，生成时间，属性

³      协议：

³      编码：

³      参数：参数，参数Map

30、             response

31、             session应用：过滤器，监听器，控制器，验证码及其他简单显示功能

32、             JSP构成元素

³      网页代码

³      指令元素

³      脚本元素

³      操作元素

³      注释和模版数据

33、             JSP作用域

³          页面域：对象只对于其所在页面是可访问的

³      请求域：在请求的生命周期内有效

³      会话域：会话的对象对于参与某客户端会话的所有组件有效

³      应用域：应用域的对象在整个应用的生命周期都有效

34、             EL表达式,C标签使用

35、             Spring的组成

36、             依赖注入方式

n           接口注入

n       构造方法注入

n       设置属性注入

37、             事务管理方式

n           编程式事务

n       声明式事务

38、             EJB三种bean，状态

n           会话Bean（Session Bean）

分为有状态和无状态两种

n       实体Bean（Entity Bean）

n       消息驱动Bean（MessageDriven Bean）

39、             JBOSS相关知识及目录结构 //这个也要考？

a)         Bin：开始和停止JBoss的地方

b)        Client：与JBoss通信所必须的客户端Java库(jar)

c)         Docs：JBoss有关文档及XML类型定义文件

d)        Lib：JBoss启动用到的Java库

e)         Server：各种启动类型的服务器端EJB配置所需文件

Server/ default下子目录结构(对4.2)

a)         Conf:配置文件

b)        Data：数据库文件。如内嵌的

c)         Deploy：热部署目录

d)        Lib：启动默认配置时需要加载的jar

e)         Log：日志文件记录

f)          Tmp：临时文件目录

40、             WebServices的三标准：SOAP(Simple Object Access Protocol),WSDL(Web Services   Description ),UDDL(Universal Discovery、Description、Integration)

41、             XMLHttpRequest 六种方法，6种属性

n           abort()

n       停止当前请求

n       getAllResponseHeaders()

n       把HTTP请求的所有响应首部作为键/值对返回

n       getResponseHeader(&#8220;header&#8221;)

n       返回指定首部的串值

n       send(content)

n       向服务器发送请求

n       setRequestHeader(&#8220;header&#8221;, &#8220;value&#8221;)

n       把指定首部设置为所提供的值。在设置任何首部之前必须先调用open()

n       open(&#8220;method&#8221;, &#8220;url&#8221;)

n       建立对服务器的调用。

n       method参数可以是GET、POST或PUT。

n       url参数可以是相对URL或绝对URL。

n       这个方法还包括3个可选的参数

——————————————————————————————————

n       Onreadystatechange

n       每个状态改变时都会触发这个事件处理器，通常会调用一个JavaScript函数

n       responseText

n       服务器的响应，表示为一个串

n       readyState 请求的状态。

n       有5个可取值：

n       0 = 未初始化

n       1 = 正在加载

n       2 = 已加载

n       3 = 交互中

n       4 = 完成

n       responseXML

n       服务器的响应，表示为XML

n       这个对象可以解析为一个DOM对象

n       statusText

n       HTTP状态码的相应文本（OK或Not Found（未找到）等等）

n       Status

n       服务器的HTTP状态码

200对应OK

404对应Not Found

<hr size="1" />
这个都考。狠！</p>
