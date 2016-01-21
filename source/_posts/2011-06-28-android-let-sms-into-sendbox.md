---
id: 938
title: android将发送短信保存至发件箱代码
date: 2011-06-28T15:45:10+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=938
permalink: /android-let-sms-into-sendbox/
duoshuo_thread_id:
  - 1351844048792453289
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - coding小工具
tags:
  - android保存短信
---
前面讲了，[单纯的发送一条短信](http://www.tanglei.name/android-send-sms/)，看android官方APIDemo说的也是通过RESULT_OK代表发送成功。官方代码如下： 

<pre>&lt;cc class="java"> switch (getResultCode()) {
                case Activity.RESULT_OK:
                    message = "Message sent!";
                    error = false;
                    break;
                case SmsManager.RESULT_ERROR_GENERIC_FAILURE:
                    message = "Error.";
                    break;
                case SmsManager.RESULT_ERROR_NO_SERVICE:
                    message = "Error: No service.";
                    break;
                case SmsManager.RESULT_ERROR_NULL_PDU:
                    message = "Error: Null PDU.";
                    break;
                case SmsManager.RESULT_ERROR_RADIO_OFF:
                    message = "Error: Radio off.";
                    break;
                }&lt;/cc></pre>

后来想，将发送的信息保存在发件箱让用户更加放心些。于是就网上搜了下，这篇文章讲的还不错，也收录自己的blog中，详情见：[android 中短信管理代码](http://www.tanglei.name/android-manage-sms)
  
于是，我在原有的基础上，加了个方法，调用成功了。代码如下：

<pre>&lt;cc class="java">	private void storeMsg(String destinationAddress, String text)
	{
		ContentValues cv = new ContentValues();
		cv.put("address", destinationAddress);
		cv.put("person", "");
		cv.put("protocol", "0");
		cv.put("read", "1");
		cv.put("status", "-1");
		cv.put("body", text);
		this.getContentResolver().insert(Uri.parse("content://sms/sent"), cv);
		Log.e("tl3shi", "msg has stored");
	}&lt;/cc></pre>

根据那篇文章我自己又测试了下，看效果的话，这样就OK了。系统会自动去匹配同一个人的会话信息。注意以上代码权限得加读和写，因为写的时候，也读取了数据库中的id啊之类的字段了。 

<pre>&lt;cc class="xml">&lt;uses-permission android:name="android.permission.WRITE_SMS"/> 
&lt;uses-permission android:name="android.permission.READ_SMS"/>&lt;/cc></pre>

测试效果如下：
  
[<img src="http://www.tanglei.name/wp-content/uploads/2011/06/android-msg-into-sendbox.jpg" alt="android保存以发送短信" title="android保存以发送短信" width="725" height="309" class="aligncenter size-full wp-image-939" />](http://www.tanglei.name/wp-content/uploads/2011/06/android-msg-into-sendbox.jpg)