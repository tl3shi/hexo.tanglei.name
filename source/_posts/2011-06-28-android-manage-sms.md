---
id: 940
title: android 中短信管理代码
date: 2011-06-28T15:42:25+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=940
duoshuo_thread_id:
  - 1351844048792453287
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
tags:
---
写android群发消息的小工具，涉及到短信管理，这篇文章写得不错，转载了[android 中短信管理](http://www.cnblogs.com/GnagWang/archive/2011/01/06/1929075.html)。

先贴出相关的协议：
  
content://sms/inbox        收件箱
content://sms/sent        已发送
content://sms/draft        草稿
content://sms/outbox        发件箱
content://sms/failed        发送失败
content://sms/queued        待发送列表

在模拟器上Outbox没有查询到数据，在模拟器上找了老半天也没找到发件箱，很郁闷。
  
数据库中sms相关的字段如下：

```plain
java_id               一个自增字段，从1开始 
thread_id    序号，同一发信人的id相同 
address      发件人手机号码 
person        联系人列表里的序号，陌生人为null 
date            发件日期 
protocol      协议，分为： 0 SMS_RPOTO, 1 MMS_PROTO  
read           是否阅读 0未读， 1已读  
status         状态 -1接收，0 complete, 64 pending, 128 failed 
type 
    ALL    = 0; 
    INBOX  = 1; 
    SENT   = 2; 
    DRAFT  = 3; 
    OUTBOX = 4; 
    FAILED = 5; 
    QUEUED = 6; 
body                     短信内容 
service_center     短信服务中心号码编号 
subject                  短信的主题 
reply_path_present     TP-Reply-Path 
locked
```

检索数据方法很简单： 

```java
Uri uri = Uri.parse("content://sms/inbox");         
Cursor cur = this.managedQuery(uri, null, null, null, null);         
if (cur.moveToFirst()) {         
    do{     
    for(int j = 0; j < cur.getColumnCount(); j++){     
            info = "name:" + cur.getColumnName(j) + "=" + cur.getString(j); 
            Log.i("====>", info); 
        } 
    }while(cur.moveToNext());      
}
```

managedQuery最终也要将参数转换为SQL语句向SQLite发送消息，因此参数跟SQL语句很类似，所以可以在查询字段中加入SQL函数，
  
比如new String[] projection = new String[]{&#8220;count(*) as count&#8221;}等等。
  
managedQuery中的参数依次为uri，
  
查询字段 查询字段数组，也可以将所有需要查询的字段放入一个字符内
                        
比如new projection[]{&#8220;\_id&#8221;, &#8220;thread\_id&#8221;}和new projection[]{&#8220;\_id,thread\_id&#8221;}是一致的。
                        
跟SQL一样，字段名不区分大小写
  
条件 不带Where的SQL 条件字符，如果有参数则用？替代，比如&#8221;\_id=? And thread\_id = ? Or type = &#8216;1&#8217;&#8221;
  
条件中的参数 参数字符数组，跟上述的条件一一对应
  
排序 不带Order by排序字符串，比如_id desc, type
  
如果参数为null，SQL中查询字段为“*”，相关的条件为空白
  
还可以用getContentResolver（）获得一个ContentResolver，
  
getContentResolver().query（）同样返回一个Cursor对象，参数跟managedQuery一致。
  
不过用ContentResolver对象去更新、删除和插入一条数据时报SecurityException。看来没有权限，在Manifest.xml中加入权限：
  
<uses-permission android:name="android.permission.WRITE_SMS"></uses-permission>
  
然后删除短信：
  
this.getContentResolver().delete(Uri.parse(&#8220;content://sms&#8221;), &#8220;_id=?&#8221;, new String[]{&#8220;3&#8221;});
  
删除成功。
  
Url中content://sms 替换成content://sms/ 也成功，但是其它url时程序报错，比如content://sms/inbox
  
看了一下android的源代码，sms支持的协议有：
  
<!--more-->

```java
sURLMatcher.addURI("sms", null, SMS_ALL); 
sURLMatcher.addURI("sms", "#", SMS_ALL_ID); 
sURLMatcher.addURI("sms", "inbox", SMS_INBOX); 
sURLMatcher.addURI("sms", "inbox/#", SMS_INBOX_ID); 
sURLMatcher.addURI("sms", "sent", SMS_SENT); 
sURLMatcher.addURI("sms", "sent/#", SMS_SENT_ID); 
sURLMatcher.addURI("sms", "draft", SMS_DRAFT); 
sURLMatcher.addURI("sms", "draft/#", SMS_DRAFT_ID); 
sURLMatcher.addURI("sms", "outbox", SMS_OUTBOX); 
sURLMatcher.addURI("sms", "outbox/#", SMS_OUTBOX_ID); 
sURLMatcher.addURI("sms", "undelivered", SMS_UNDELIVERED); 
sURLMatcher.addURI("sms", "failed", SMS_FAILED); 
sURLMatcher.addURI("sms", "failed/#", SMS_FAILED_ID); 
sURLMatcher.addURI("sms", "queued", SMS_QUEUED); 
sURLMatcher.addURI("sms", "conversations", SMS_CONVERSATIONS); 
sURLMatcher.addURI("sms", "conversations/*", SMS_CONVERSATIONS_ID); 
sURLMatcher.addURI("sms", "raw", SMS_RAW_MESSAGE); 
sURLMatcher.addURI("sms", "attachments", SMS_ATTACHMENT); 
sURLMatcher.addURI("sms", "attachments/#", SMS_ATTACHMENT_ID); 
sURLMatcher.addURI("sms", "threadID", SMS_NEW_THREAD_ID); 
sURLMatcher.addURI("sms", "threadID/*", SMS_QUERY_THREAD_ID); 
sURLMatcher.addURI("sms", "status/#", SMS_STATUS_ID); 
sURLMatcher.addURI("sms", "sr_pending", SMS_STATUS_PENDING); 
sURLMatcher.addURI("sms", "sim", SMS_ALL_SIM); 
sURLMatcher.addURI("sms", "sim/#", SMS_SIM);
```

其中，delete方法中支持的协议为：
  
SMS_ALL 根据参数中的条件删除sms表数据
  
SMS\_ALL\_ID 根据_id删除sms表数据
  
SMS\_CONVERSATIONS\_ID 根据thread_id删除sms表数据，可以带其它条件
  
SMS\_RAW\_MESSAGE 根据参数中的条件删除 raw表
  
SMS\_STATUS\_PENDING 根据参数中的条件删除 sr_pending表
  
SMS_SIM 从Sim卡上删除数据
  
试一下SMS\_CONVERSATIONS\_ID：&#8221;content://sms/conversations/3 &#8220;，删除thread\_id=&#8221;3&#8221;, \_id=&#8221;5&#8243;的数据
  
在eclipse中的Emulator Control中，以13800给模拟器发送三条数据，然后以13900发送一条
  
this.getContentResolver().delete(Uri.parse(&#8220;content://sms/conversations/3&#8221;), &#8220;_id=?&#8221;, new String[]{&#8220;5&#8221;});
  
成功删除一条数据。
  
在数据库中每个发送者的thread_id虽然一样，但不是固定的，如果把一个发送者的全部数据删除掉，
  
然后换一个新号码发送短信时，thread_id是以数据库中最大的id+1赋值的。
  
<!--more-->


  
update支持的协议有很多：
  
SMS\_RAW\_MESSAGE
  
SMS\_STATUS\_PENDING
  
SMS_ALL
  
SMS_FAILED
  
SMS_QUEUED
  
SMS_INBOX
  
SMS_SENT
  
SMS_DRAFT
  
SMS_OUTBOX
  
SMS_CONVERSATIONS
  
SMS\_ALL\_ID
  
SMS\_INBOX\_ID
  
SMS\_FAILED\_ID
  
SMS\_SENT\_ID
  
SMS\_DRAFT\_ID
  
SMS\_OUTBOX\_ID
  
SMS\_CONVERSATIONS\_ID
  
SMS\_STATUS\_ID
  
以SMS\_INBOX\_ID测试一下：
  
ContentValues cv = new ContentValues();
  
cv.put(&#8220;thread_id&#8221;, &#8220;2&#8221;);
  
cv.put(&#8220;address&#8221;, &#8220;00000&#8221;);
  
cv.put(&#8220;person&#8221;, &#8220;11&#8221;);
  
cv.put(&#8220;date&#8221;, &#8220;11111111&#8221;);
  
this.getContentResolver().update(Uri.parse(&#8220;content://sms/inbox/4&#8221;), cv, null, null);
  
太强了，连thread_id都可以修改。
  
<!--more-->


  
insert支持的协议：
  
SMS_ALL
  
SMS_INBOX
  
SMS_FAILED
  
SMS_QUEUED
  
SMS_SENT
  
SMS_DRAFT
  
SMS_OUTBOX
  
SMS\_RAW\_MESSAGE
  
SMS\_STATUS\_PENDING
  
SMS_ATTACHMENT
  
SMS\_NEW\_THREAD_ID
  
向sms表插入数据时，type是根据协议来自动设置，
  
如果传入的数据中没有设置date时，自动设置为当前系统时间；非SMS_INBOX协议时，read标志设置为1
  
SMS_INBOX协议时，系统会自动查询并设置PERSON
  
threadId为null或者0时，系统也会自动设置
  
一直为造不了&#8221;发送失败&#8221;的邮件而发愁，现在来做一个：
  
content://sms/failed
  
ContentValues cv = new ContentValues();
  
cv.put(&#8220;_id&#8221;, &#8220;99&#8221;);
  
cv.put(&#8220;thread_id&#8221;, &#8220;0&#8221;);
  
cv.put(&#8220;address&#8221;, &#8220;9999&#8221;);
  
cv.put(&#8220;person&#8221;, &#8220;888&#8221;);
  
cv.put(&#8220;date&#8221;, &#8220;9999&#8221;);
  
cv.put(&#8220;protocol&#8221;, &#8220;0&#8221;);
  
cv.put(&#8220;read&#8221;, &#8220;1&#8221;);
  
cv.put(&#8220;status&#8221;, &#8220;-1&#8221;);
  
//cv.put(&#8220;type&#8221;, &#8220;0&#8221;);
  
cv.put(&#8220;body&#8221;, &#8220;@@@@@@@@@&#8221;);
  
this.getContentResolver().insert(Uri.parse(&#8220;content://sms/failed&#8221;), cv);
  
type被设置成了5，thread_id设置为1
  
<!--more-->


  
系统连最起码的数据校验都没有做啊，google对程序员也太仁慈了。
  
看看能不能再挖掘一下sms的功能。先来做一个错误的查询：
  
getContentResolver().query( Uri.parse(&#8220;content://sms/&#8221;) , new String[]{&#8220;a&#8221;}, &#8220;b&#8221;, null, null);
  
log输出错误的SQL语句：
  
SELECT a FROM sms WHERE (b) ORDER BY date DESC
  
query方法中没有Group by，如果想对短信做统计，对Cursor进行遍历再统计也太慢了。
  
在SQL语言中group by在Where后面，那就在条件参数中想想办法：
  
Android组织SQL语句时将条件两端加（），那就拼一个group by出来吧：
  
getContentResolver().query( Uri.parse(&#8220;content://sms/&#8221;) , new String[]{&#8220;count(*) as count, thread\_id&#8221;}, &#8220;1=1） group by (thread\_id&#8221;, null, null);
  
那么输出的SQL= SELECT count(*) as count, thread\_id FROM sms WHERE ( 1=1） group by (thread\_id ) ORDER BY date DESC
  
如果想查询URI没有对应的表怎么办呢，比如想知道 mmssms.db数据库中有哪些表，
  
查询的表是URI定的，再在条件参数中拼凑肯定是不行。
  
那我们把目光往前移，看看在字段参数中能不能凑出来。
  
要查询其它表，关键要去掉系统固定添加的FROM sms，
  
用用SQL中的注释吧，
  
getContentResolver().query(Uri.parse(&#8220;content://sms/&#8221;), new String[]{&#8221; * from sqlite_master WHERE type = &#8216;table&#8217; &#8212; &#8220;}, null, null, null);
  
那么输出的SQL=SELECT * from sqlite_master WHERE type = &#8216;table&#8217; &#8212; FROM sms ORDER BY date DESC
  
居然能够运行。
  
得寸进尺，再进一步，如果加入“；”也能运行的话，哈哈，那么建表、删除表、更新表也能为所欲为咯。
  
getContentResolver().query(Uri.parse(&#8220;content://sms/&#8221;), new String[]{&#8221; \* from sms;select \* from thrreads;&#8211; &#8220;}, null, null, null);
  
很可惜，只运行了第一条SQL语句，看来在关键问题上，android还是有所控制的。
  
不过支持&#8211;也很不错了，这样可以查询数据库中所有的表，而且还可以多表联查。
