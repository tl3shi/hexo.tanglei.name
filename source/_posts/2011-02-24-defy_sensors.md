---
id: 355
title: Defy传感器列表
date: 2011-02-24T13:41:48+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=355
duoshuo_thread_id:
  - 1351844048792453304
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
tags:
  - Defy
  - 传感器
---
项目需要，买android手机，入手defy。先测试下defy的传感器。。

直接上代码:

```java
package com.i3zhai.blog;

import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

import android.app.Activity;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class DefySensors extends Activity
{

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		//顺便把内置的一些系统参数信息获取到
		getDefyParams();
		
		// 准备显示信息的UI组建
		final TextView tx1 = (TextView) findViewById(R.id.TextView01);

		// 从系统服务中获得传感器管理器
		SensorManager sm = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

		// 从传感器管理器中获得全部的传感器列表
		List<Sensor> allSensors = sm.getSensorList(Sensor.TYPE_ALL);

		// 显示有多少个传感器
		tx1.setText("经检测该手机有" + allSensors.size() + "个传感器，他们分别是：\n");

		// 显示每个传感器的具体信息
		for (Sensor s : allSensors)
		{

			String tempString = "\n" + "  设备名称：" + s.getName() + "\n"
					+ "  设备版本：" + s.getVersion() + "\n" + "  供应商："
					+ s.getVendor() + "\n";

			switch (s.getType())
			{
			case Sensor.TYPE_ACCELEROMETER:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 加速度传感器accelerometer" + tempString);
				break;
			case Sensor.TYPE_GYROSCOPE:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 陀螺仪传感器gyroscope" + tempString);
				break;
			case Sensor.TYPE_LIGHT:

				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 环境光线传感器light" + tempString);
				break;
			case Sensor.TYPE_MAGNETIC_FIELD:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 电磁场传感器magnetic field" + tempString);
				break;
			case Sensor.TYPE_ORIENTATION:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 方向传感器orientation" + tempString);
				break;
			case Sensor.TYPE_PRESSURE:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 压力传感器pressure" + tempString);
				break;
			case Sensor.TYPE_PROXIMITY:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 距离传感器proximity" + tempString);
				break;
			case Sensor.TYPE_TEMPERATURE:
				tx1.setText(tx1.getText().toString() + s.getType()
						+ " 温度传感器temperature" + tempString);
				break;
			default:
				tx1.setText(tx1.getText().toString() + s.getType() + " 未知传感器"
						+ tempString);
				break;
			}
		}

	}
	
	public void getDefyParams()
	{
		Properties pro = System.getProperties();
		Enumeration em = pro.keys();
		while (em.hasMoreElements())
		{
			String t = (String) em.nextElement();
			Log.e("tl3shi", t +" : "+pro.getProperty(t));
			System.out.println(t +" : "+pro.getProperty(t));
		}
	}
}
```

layout的XML就不上了，一个textview而已。
  
效果如下：得到6个传感器……
  
[<img src="/wp-content/uploads/2011/03/defy_sensors.png" alt="" title="defy_sensors"  class="aligncenter size-full wp-image-356" />](/wp-content/uploads/2011/03/defy_sensors.png)
  

  
系统参数啊环境变量之类的：
  
[<img src="/wp-content/uploads/2011/02/defy_envir.jpg" alt="" title="defy_envir"  class="aligncenter size-large wp-image-361" />](/wp-content/uploads/2011/02/defy_envir.jpg)
