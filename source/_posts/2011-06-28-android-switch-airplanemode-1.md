---
id: 920
title: android手机定时切换飞行模式代码(一)
date: 2011-06-28T11:38:02+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=920
duoshuo_thread_id:
  - 1351844048792453167
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
这是好久以前的代码了，给贴出来。当时拿到defy不久。网上找自动开机啊，或者关机闹钟啊之类的都一个答案。没有。想想自己的电脑，没有自动关机的吧，关机了啥软件也不能运行了。但仔细想，每次开机，手机能定位正确的时间，肯定还是有个啥在运行的，不过要想利用它，估计够呛。不过有定时运行各种软件等。然后好多人建议飞行模式跟关机相比，是最接近的了，就切换飞行模式吧。网上也有相应的软件，不过挂了广告，显然不爽。然后想着自己就写一个，参照了网上各种资源，代码如下。AirPlaneModeActivity 类主要用于获取用户定义的时间，告诉系统。另一个类(二)中会有。

```java
package com.i3zhai;

import java.util.Calendar;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.app.TimePickerDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.provider.Settings.System;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.TimePicker;
import android.widget.Toast;

public class AirPlaneModeActivity extends Activity
{
	static final String TAG = "tl3shi";
	private static final String ALARM_ACTION_START = "com.i3zhai.ALARM_ACTION_START";
	private static final String ALARM_ACTION_END = "com.i3zhai.ALARM_ACTION_END";
	private Calendar calendar;
	RadioButton startBtn;
	 RadioButton  stopBtn;
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		calendar = Calendar.getInstance();
		final Button startTimeBtn = (Button) findViewById(R.id.startTimeBtn);
		startTimeBtn.setOnClickListener(new TimeButtonClickListener(
				startTimeBtn, true));
		final Button endTimeBtn = (Button) findViewById(R.id.endTimeBtn);
		endTimeBtn.setOnClickListener(new TimeButtonClickListener(endTimeBtn,
				false));
		// 根据之前的设置，恢复开始时间和结束时间
		SharedPreferences preferences = getSharedPreferences(
				"TimerAirPlaneMode", MODE_PRIVATE);
		int sh = preferences.getInt("startHour", -1);
		int sm = preferences.getInt("startMinute", -1);
		int eh = preferences.getInt("endHour", -1);
		int em = preferences.getInt("endMinute", -1);
		if (sh != -1 && sm != -1)
		{
			startTimeBtn.setText(formatTime(sh, sm));
		}
		if (eh != -1 && em != -1)
		{
			endTimeBtn.setText(formatTime(eh, em));
		}

		startBtn = (RadioButton) findViewById(R.id.start);
		startBtn.setOnClickListener(new ControlButtonClickListener(true));
		 stopBtn = (RadioButton) findViewById(R.id.stop);
		stopBtn.setOnClickListener(new ControlButtonClickListener(false));
	}

	class ControlButtonClickListener implements RadioButton.OnClickListener
	{
		private boolean flag;

		public ControlButtonClickListener(boolean flag)
		{
			this.flag = flag;
		}

		@Override
		public void onClick(View arg0)
		{
			//已经选择了  
			if(startBtn.isChecked()){
				startBtn.setEnabled(false);
				stopBtn.setEnabled(true);
			}
			if(stopBtn.isChecked()){
				stopBtn.setEnabled(false);
				startBtn.setEnabled(true);
			}
			if (flag)
			{
				Log.d(AirPlaneModeActivity.TAG, "start the auto fly mode");
				SharedPreferences preferences = getSharedPreferences(
						"AirPlaneModeActivity", MODE_PRIVATE);

				int sh = preferences.getInt("startHour", -1);
				int sm = preferences.getInt("startMinute", -1);
				if (sh == -1 || sm == -1)
				{
					Toast.makeText(AirPlaneModeActivity.this, "请设置开始时间",
							Toast.LENGTH_LONG);
					return;
				}
				int eh = preferences.getInt("endHour", -1);
				int em = preferences.getInt("endMinute", -1);
				if (eh == -1 || em == -1)
				{
					Toast.makeText(AirPlaneModeActivity.this, "请设置结束时间",
							Toast.LENGTH_LONG);
					return;
				}
				// 设置日历的时间，主要是让日历的年月日和当前同步
				calendar.setTimeInMillis(java.lang.System.currentTimeMillis());
				// 设置日历的小时和分钟
				calendar.set(Calendar.HOUR_OF_DAY, sh);
				calendar.set(Calendar.MINUTE, sm);
				// 将秒和毫秒设置为0
				calendar.set(Calendar.SECOND, 0);
				calendar.set(Calendar.MILLISECOND, 0);
				// 建立Intent和PendingIntent来调用闹钟管理器
				Intent startIntent = new Intent(ALARM_ACTION_START);
				startIntent.putExtra("startState", 1);
				PendingIntent startPendingIntent = PendingIntent.getBroadcast(
						AirPlaneModeActivity.this, 0, startIntent, 0);
				// 获取闹钟管理器
				AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
				// 设置开始时间对应的闹钟
				alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, calendar
						.getTimeInMillis(), 24 * 60 * 60 * 1000,
						startPendingIntent);
				// 设置结束时间对应的闹钟
				// 设置日历的小时和分钟
				Intent endIntent = new Intent(ALARM_ACTION_END);
				endIntent.putExtra("endState", 1);
				PendingIntent endPendingIntent = PendingIntent.getBroadcast(
						AirPlaneModeActivity.this, 1, endIntent, 0);
				calendar.set(Calendar.HOUR_OF_DAY, eh);
				calendar.set(Calendar.MINUTE, em);
				alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, calendar
						.getTimeInMillis(), 24 * 60 * 60 * 1000,
						endPendingIntent);
				Toast.makeText(AirPlaneModeActivity.this, "设置已经启用", Toast.LENGTH_LONG).show();
			} else
			{
				Log.d(AirPlaneModeActivity.TAG, "shutdown the auto flg mode");
				Intent intent = new Intent(ALARM_ACTION_START);
				PendingIntent pendingIntent = PendingIntent.getBroadcast(
						AirPlaneModeActivity.this, 0, intent, 0);
				// 获取闹钟管理器
				AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
				// 取消开始和结束闹钟
				alarmManager.cancel(pendingIntent);

				Intent intent2 = new Intent(ALARM_ACTION_END);
				PendingIntent pendingIntent2 = PendingIntent.getBroadcast(
						AirPlaneModeActivity.this, 1, intent2, 0);
				alarmManager.cancel(pendingIntent2);
				// 关闭飞行模式
				System.putString(getContentResolver(), System.AIRPLANE_MODE_ON,
						"0");
				Intent flyIntent = new Intent(
						Intent.ACTION_AIRPLANE_MODE_CHANGED);
				flyIntent.putExtra("state", false);
				sendBroadcast(flyIntent);
				Toast.makeText(AirPlaneModeActivity.this, "设置已经取消！",
						Toast.LENGTH_SHORT).show();
			}
		}
	}

	class TimeButtonClickListener implements Button.OnClickListener
	{
		private final Button button;
		private boolean flag;// true 表示开始时间 false表示结束时间

		public TimeButtonClickListener(final Button button, boolean flag)
		{
			this.button = button;
			this.flag = flag;
		}

		@Override
		public void onClick(View arg0)
		{
			new TimePickerDialog(AirPlaneModeActivity.this,
					new TimePickerDialog.OnTimeSetListener()
					{
						@Override
						public void onTimeSet(TimePicker arg0, int h, int m)
						{
							Log.d(TAG, "set the time:" + h + ":" + m);
							SharedPreferences preferences = getSharedPreferences(
									"AirPlaneModeActivity", 0);
							SharedPreferences.Editor editor = preferences
									.edit();
							editor.putInt("flag", flag ? 1 : 0);
							if (flag)
							{
								editor.putInt("startHour", h);
								editor.putInt("startMinute", m);
							} else
							{
								editor.putInt("endHour", h);
								editor.putInt("endMinute", m);
							}
							editor.commit();// 这步很关键
							// button.setText(String.valueOf(h)+":"+String.valueOf(m));
							button.setText(formatTime(h, m));
						}
					}, calendar.get(Calendar.HOUR_OF_DAY), calendar
							.get(Calendar.MINUTE), true).show();
		}
	}

	/**
	* 格式化时间为00:00   
	* @param h
	* @param m           
	* @return 
	*/
	public String formatTime(int h, int m)
	{
		StringBuffer buf = new StringBuffer();
		if (h < 10)
		{
			buf.append("0" + h);
		} else
		{
			buf.append(h);
		}
		buf.append(" : ");

		if (m < 10)
		{
			buf.append("0" + m);
		} else
		{
			buf.append(m);
		}
		return buf.toString();
	}
}
```
