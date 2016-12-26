---
id: 931
title: android发送短信代码
date: 2011-06-28T13:21:46+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=931
duoshuo_thread_id:
  - 1351844048792453260
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - coding小工具
tags:
  - coding小工具
---
想写一个短信群发器，用于过年过节啊之类的发送短信给亲朋好友。并且是定制的。首先来看下如何发送短信，网上大量参考，自己也测试了下。下面代码只实现了发送短信的功能。没有界面啥可言。

```java
package name.tanglei.msgsend;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.util.Log;

public class msgSendDemo extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        SmsManager m = SmsManager.getDefault();
        String destinationAddress = "10086";
        String text="msg content";
        String sentSmsAction = "SENT_SMS_ACTION";
        String deliveredSmsAction = "DELIVERED_SMS_ACTION";
        Intent sentIntent = new Intent(sentSmsAction);
        Intent deliveredIntent = new Intent(deliveredSmsAction);
        PendingIntent sentPi =  PendingIntent.getBroadcast(this.getApplicationContext(),0,sentIntent,0);
        PendingIntent deliveryPi = PendingIntent.getBroadcast(this.getApplicationContext(),0,deliveredIntent,0);
        
        registerReceiver(new BroadcastReceiver()
		{
			@Override
			public void onReceive(Context arg0, Intent arg1)
			{
				switch (getResultCode())
				{
				case Activity.RESULT_OK:
					Log.e("tl3shi", "msg has been sent sucessfully!");
					break;
				default:
					Log.e("tl3shi", "faily!");
				}
			}
		}, new IntentFilter(sentSmsAction));
        
       m.sendTextMessage(destinationAddress, null, text, sentPi, deliveryPi);
    }
 
}
```

当然，直接运行后，可以看到Logcat有代码输出，在虚拟机里面也输出了msg has been sent sucessfully!，明显Activity.RESULT_OK不要是发送短信成功的标识了。先将就吧。在我的defy下也输出同样的效果，但后来10086给回复证明了短信确实是发送出去的。[<img src="/wp-content/uploads/2011/06/android-send-msg-code.jpg" alt="android发送信息源码" title="android发送信息源码"  class="aligncenter size-full wp-image-932" />](/wp-content/uploads/2011/06/android-send-msg-code.jpg)
  
当然，要有发送信息的权限，在manifest中得加入

```xml
<uses-permission android:name="android.permission.SEND_SMS"/>
```

```java
/**
*destinationAddress : 目标地址，手机号码
*scAddress： 短信中心号码，为null时使用缺省短信中心号码。
*text: 发送的信息内容。
*sendIntent: 如果非空，可以来跟踪短信发送的状态：已发送，发送失败等。
*deliveryIntent: 如果非空，但短信发送到目标时通知发送者。
**/
public final void sendTextMessage(String destinationAddress, String scAddress, String text, PendingIntent sentIntent, PendingIntent deliveryIntent)
```

本例中的代码 m.sendTextMessage(destinationAddress, null, text, sentPi, deliveryPi); 改成m.sendTextMessage(destinationAddress, null, text, null, null); 效果完全一样的。后面再调整到底有没法发送成功的监听调整吧。
