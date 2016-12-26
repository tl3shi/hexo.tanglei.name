---
id: 412
title: Android的通知Notification
date: 2011-04-07T15:15:39+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=412
duoshuo_thread_id:
  - 1351844048792453458
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
tags:
  - Android
---
项目需要，当按手机home键时，出现通知栏，从通知栏图标点击快速返回上一个应用的界面。
  
在android下，与通知功能相关的组件大致有以下三大部分：
  
android.app.PendingIntent;
  
android.app.NotificationManager;
  
android.app.Notification;

NotificationManager可以通过系统的服务获取，就是通过它向用户发出通知的
  
notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
  
Notification，通知的主体，通过设置其各种属性，来实现通知的效果，PendingIntent，Intent的封装类，主要是用来导向点击通知后要启动的Activity。不过这里主要牵涉到Intent属性的设置，从而达到实现效果。
  
下面的代码就实现了预想中的效果。

```java
Intent	intent = new Intent(Intent.ACTION_MAIN);
			intent.addCategory(Intent.CATEGORY_LAUNCHER);
			intent.setClass(mContext,mContext.getClass());
			intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | 
					Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
			PendingIntent mContentIntent =PendingIntent.getActivity(mContext,0, intent, 0);
			
                      //这句实现 点击通知图标后消失
			mNotification.flags |= Notification.FLAG_AUTO_CANCEL;
			
			//这里用setLatestEventInfo(上下文,标题,内容,PendingIntent) 
			mNotification.setLatestEventInfo(mContext, "xiaomii", mContext.getClass()+"", mContentIntent);
			//这里发送通知(消息ID,通知对象), 添加通知，第一个参数为自定义的通知唯一标识  
	        mNotificationManager.notify(NOTIFICATION_ID, mNotification);    

```
