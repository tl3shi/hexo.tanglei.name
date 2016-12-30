---
id: 924
title: android手机定时切换飞行模式代码(三)
date: 2011-06-28T11:58:46+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=924
duoshuo_thread_id:
  - 1351844048792453291
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - coding小工具
tags:
  - Android
  - Java 
keywords: 
  - Android关机闹钟
  - Android自动切换飞行模式
  - Android自动开机
---
界面就比较丑了，不过现在我机子里面都还在用呢。呵呵
  
[<img src="/wp-content/uploads/2011/06/airplane-mode-switch.jpg" alt="android自动切换飞行模式" title="android自动切换飞行模式"  class="aligncenter size-full wp-image-925" />](/wp-content/uploads/2011/06/airplane-mode-switch.jpg)
  
xml布局代码如下： 

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    >
    
<TextView
	android:layout_width="fill_parent"
	android:layout_height="wrap_content"
	android:gravity="center_horizontal"
	android:textColor="#0000ff"
	android:text="@string/tips"/> 
	
<LinearLayout 
	android:layout_width="fill_parent"
	android:layout_height="wrap_content" 
	android:gravity="center_horizontal"
	android:layout_marginTop="40sp">
	<TextView
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="点击设置开启飞行模式的时间 : "/> 
	<Button 
		android:id="@+id/startTimeBtn"
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="00:30" 
		android:textSize="20sp"
		android:width="100sp"
		android:textStyle="bold"/>
</LinearLayout>
<LinearLayout 
	android:layout_width="fill_parent"
	android:layout_height="wrap_content" 
	android:gravity="center_horizontal">		
	<TextView
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="点击设置关闭飞行模式的时间 : "/> 
	<Button 
		android:id="@+id/endTimeBtn"
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="06:00" 
		android:textSize="20sp"
		android:width="100sp"
		android:textStyle="bold"/>
</LinearLayout>

<TextView
	android:layout_width="fill_parent"
	android:layout_height="wrap_content"
	android:gravity="center_horizontal"
	android:text="@string/state"/> 
<RadioGroup 
	android:layout_width="fill_parent"
	android:layout_height="wrap_content"
	android:orientation="horizontal"
	android:gravity="center_horizontal">
	<RadioButton 
		android:id="@+id/start"
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="开启"/>
	<RadioButton 
		android:id="@+id/stop"
		android:layout_width="wrap_content"
		android:layout_height="wrap_content"
		android:text="关闭"/>
</RadioGroup>
</LinearLayout>
```

manifest文件：

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="com.i3zhai"
      android:versionCode="1"
      android:versionName="1.0">
    <application android:icon="@drawable/icon" android:label="@string/app_name">
        <receiver android:name=".AlarmReceiver">
			<intent-filter>
				<action android:name="com.i3zhai.ALARM_ACTION_START"/>
				<action android:name="com.i3zhai.ALARM_ACTION_END"/>
			</intent-filter>
		</receiver>
        <activity android:name=".AirPlaneModeActivity"
                  android:label="@string/app_name">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

    </application>

	<uses-permission android:name="android.permission.WRITE_SETTINGS" />
	<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
	<uses-permission android:name="android.permission.WAKE_LOCK" />
</manifest> 
```
