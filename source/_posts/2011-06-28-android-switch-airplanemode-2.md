---
id: 922
title: android手机定时切换飞行模式代码(二)
date: 2011-06-28T11:41:48+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=922
duoshuo_thread_id:
  - 1351844048792453193
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
  - coding小工具
tags:
  - Android关机闹钟
  - Android自动切换飞行模式
  - Android自动开机
---
这个类主要就是时间到了，自动切换了。

```java
package com.i3zhai;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings.System;
import android.util.Log;
import android.widget.Toast;

public class AlarmReceiver extends BroadcastReceiver
{

	private Context context;

	@Override
	public void onReceive(Context arg0, Intent data)
	{
		context = arg0;
		Log.d(AirPlaneModeActivity.TAG, "the alrm time is up");

		int startState = data.getIntExtra("startState", -1);
		int endState = data.getIntExtra("endState", -1);
		Log.d(AirPlaneModeActivity.TAG, "start state:" + startState);
		Log.d(AirPlaneModeActivity.TAG, "end state:" + endState);
		if (startState == 1)
		{
			Log.d(AirPlaneModeActivity.TAG, "set the fly mode true");
			setAirPlaneState(true);
		}
		if (endState == 1)
		{
			Log.d(AirPlaneModeActivity.TAG, "set the fly mode false");
			setAirPlaneState(false);
		}
	}

	public void setAirPlaneState(boolean state)
	{
		try
		{
			ContentResolver cr = context.getContentResolver();
			if (state
					&& System.getString(cr, System.AIRPLANE_MODE_ON)
							.equals("0"))
			{
				Toast.makeText(context, "正在转飞行模式", Toast.LENGTH_LONG).show();
				// 在receiver中10S没有处理 就会异常。
				/* 本来想切换前，给用户点提示，可以取消啥滴。不然用户正在用，直接给切换了不爽啊。
				 * try { Log.e("tl3shi", "befor sleep"); Thread.sleep(5*1000);
				 * Log.e("tl3shi", "end sleep "); } catch (Exception e) {
				 * Log.e("tl3shi",e.toString()); e.printStackTrace(); }
				 */
				System.putString(cr, System.AIRPLANE_MODE_ON, "1");
				Intent intent = new Intent(Intent.ACTION_AIRPLANE_MODE_CHANGED);
				intent.putExtra("state", true);
				context.sendBroadcast(intent);
			} else if (!state
					&& System.getString(cr, System.AIRPLANE_MODE_ON)
							.equals("1"))
			{
				System.putString(cr, System.AIRPLANE_MODE_ON, "0");
				Intent intent = new Intent(Intent.ACTION_AIRPLANE_MODE_CHANGED);
				intent.putExtra("state", false);
				context.sendBroadcast(intent);
			}
		} catch (Exception e)
		{
			Toast.makeText(context, "设置失败", Toast.LENGTH_SHORT).show();
		}
	}
}
```
