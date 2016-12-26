---
id: 358
title: android传感器开发基础
date: 2011-02-25T13:49:18+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=358
duoshuo_thread_id:
  - 1351844048792453314
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Android
tags:
  - Android
  - 传感器
---
本文节选于机械工业出版社推出的《Android应用开发揭秘》一书，作者为杨丰盛。本书内容全面，详细讲解了Android框架、Android组件、用户界面开发、游戏开发、数据存储、多媒体开发和网络开发等基础知识，而且还深入阐述了传感器、语音识别、桌面组件开发、Android游戏引擎设计、Android应用优化、OpenGL等高级知识。另外，本书还全面介绍了如何利用原生的C/C++（NDK）和Python、Lua等脚本语言（Android Scripting Environment）来开发Android应用，并以迭代的方式重现了各种常用的Android应用和经典Android游戏的开发全过程。

**第9章  Android特色开发**

Android 是一个面向应用程序开发的丰富平台，它拥有许多具有吸引力的用户界面元素、数据管理和网络应用等优秀的功能。Android 还提供了很多颇具特色的接口。本章我们将分别介绍这些吸引开发者眼球的特色开发，主要包括：传感器系统（Sensor）、语音识别技术（RecognizerIntent）、Google Map和用来开发桌面的插件（Widget）。通过本章的学习，读者将对Android有一个更深入的了解，可以开发出一些有特色、有创意的应用程序。

**9.1  传感器**

据调查，2008年全球传感器销售额为506亿美元，预计到2010年全球传感器销售额可达600亿美元以上。调查显示，东欧、亚太区和加拿大成为传感器市场增长最快的地区，而美国、德国、日本依旧是传感器市场分布最大的地区。就世界范围而言，传感器市场增长最快的领域依旧是汽车，占第二位的是过程控制，当然现在也被广泛应用于通信。那么，传感器的定义是什么呢？有哪些种类的传感器呢？Android中提供了哪些传感器呢？

1．传感器的定义

传感器是一种物理装置或生物器官，能够探测、感受外界的信号、物理条件（如光、热、湿度）或化学组成（如烟雾），并将探知的信息传递给其他装置或器官。国家标准GB7665—87对传感器的定义是：“能感受规定的被测量并按照一定的规律转换成可用信号的器件或装置，通常由敏感元件和转换元件组成”。传感器是一种检测装置，能感受被测量的信息，并能将检测的感受到的信息，按一定规律变换成为电信号或其他所需形式的信息输出，以满足信息的传输、处理、存储、显示、记录和控制等要求。它是实现自动检测和自动控制的首要环节。

2．传感器的种类

可以从不同的角度对传感器进行分类：转换原理（传感器工作的基本物理或化学效应）；用途；输出信号类型以及制作材料和工艺等。

根据工作原理，传感器可分为物理传感器和化学传感器两大类。

物理传感器应用的是物理效应，诸如压电效应，磁致伸缩现象，离化、极化、热电、光电、磁电等效应。被测信号量的微小变化都将转换成电信号。

化学传感器包括那些以化学吸附、电化学反应等现象为因果关系的传感器，被测信号量的微小变化也将转换成电信号。

大多数传感器是以物理原理为基础运作的。化学传感器的技术问题较多，例如可靠性问题、规模生产的可能性、价格问题等，解决了这些问题，化学传感器的应用将会有巨大增长。而有些传感器既不能划分为物理类，也不能划分为化学类。

3．Android中传感器的种类

Google Android操作系统中内置了很多传感器，比如G1自带了一个非常实用的加速感应器（微型陀螺仪），有了它，G1手机就支持重力感应、方向判断等功能，在部分游戏或软件中可以自动识别屏幕的横屏、竖屏方向来改变屏幕显示布局。下面是Android中支持的几种传感器：

Sensor.TYPE_ACCELEROMETER：加速度传感器。
  
Sensor.TYPE_GYROSCOPE：陀螺仪传感器。
  
Sensor.TYPE_LIGHT：亮度传感器。
  
Sensor.TYPE\_MAGNETIC\_FIELD：地磁传感器。
  
Sensor.TYPE_ORIENTATION：方向传感器。
  
Sensor.TYPE_PRESSURE：压力传感器。
  
Sensor.TYPE_PROXIMITY：近程传感器。
  
Sensor.TYPE_TEMPERATURE：温度传感器。
  
下面我们通过一个例子来分析Android中传感器的使用（具体实现参见本书所附代码：第9章\ Examples\_09\_01），这里分析的是方向传感器（TYPE_ORIENTATION）。
  
4．Android 中传感器的功能
  
要在Android中使用传感器，首先需要了解SensorManager和SensorEventListener。顾名思义，SensorManager就是所有传感器的一个综合管理类，包括了传感器的种类、采样率、精准度等。我们可以通过getSystemService方法来取得一个SensorManager对象。代码如下：

SensorManager mSensorManager = (SensorManager)getSystemService(SENSOR_SERVICE); 

取得SensorManager对象之后，可以通过getSensorList方法来获得我们需要的传感器类型，保存到一个传感器列表中。通过如下代码可以得到一个方向传感器：
  
List<Sensor> sensors = mSensorManager.getSensorList(Sensor.TYPE_ORIENTATION);
  
要与传感器交互，应用程序必须注册以侦听与一个或多个传感器相关的活动。Android中提供了registerListener来注册一个传感器，并提供了unregisterListener来卸载一个传感器。registerListener方法包括3个参数：第1个参数，接收信号的Listener实例；第2个参数，想接收的传感器类型的列表（即上一步创建的List<Sensor>对象）；第3个参数，接收频度。调用之后返回一个布尔值，true表示成功，false表示失败。当然，之后不再使用时，我们还需要卸载。代码如下：

```java
//注册传感器  
 Boolean  mRegisteredSensor = mSensorManager.registerListener(this, sensor,   
 SensorManager.SENSOR_DELAY_FASTEST);  
 //卸载传感器  
 mSensorManager.unregisterListener(this);
```

其中，SensorEventListener是使用传感器的核心部分，包括以下两个方法必须实现：
  
onSensorChanged (SensorEvent event) 方法在传感器值更改时调用。该方法只由受此应用程序监视的传感器调用。该方法的参数包括一个SensorEvent对象，该对象主要包括一组浮点数，表示传感器获得的方向、加速度等信息。例如，以下代码可以取得其值：

```java
float x = event.values[SensorManager.DATA_X];  
float y = event.values[SensorManager.DATA_Y];  
float z = event.values[SensorManager.DATA_Z];  ```

onAccuracyChanged (Sensor sensor,int accuracy) 方法在传感器的精准度发生改变时调用。其参数包括两个整数：一个表示传感器，另一个表示该传感器新的准确值。
  
具体实现如代码清单9-1所示。
  
代码清单9-1 第9章\Examples\_09\_01\src\com\yarin\android\Examples\_09\_01\Activity01.java

```java
public class Activity01 extends Activity implements SensorEventListener  
{  
    private boolean         mRegisteredSensor;  
    //定义SensorManager  
    private SensorManager       mSensorManager;  
    public void onCreate(Bundle savedInstanceState)  
    {  
        super.onCreate(savedInstanceState);  
        setContentView(R.layout.main);  
        mRegisteredSensor = false;  
        //取得SensorManager实例  
        mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);  
    }  
    protected void onResume()  
    {  
        super.onResume();  
        //接收SensorManager的一个列表(Listener)  
        //这里我们指定类型为TYPE_ORIENTATION(方向传感器)  
        List<Sensor> sensors = mSensorManager.getSensorList  
        (Sensor.TYPE_ORIENTATION);  
        if (sensors.size() > 0)  
        {  
            Sensor sensor = sensors.get(0);  
            //注册SensorManager  
            //this->接收sensor的实例  
            //接收传感器类型的列表  
            //接收的频率  
            mRegisteredSensor = mSensorManager.registerListener(this,   
            sensor, SensorManager.SENSOR_DELAY_FASTEST);  
        }  
    }  
    protected void onPause()  
    {  
        if (mRegisteredSensor)  
        {  
            //如果调用了registerListener  
            //这里我们需要unregisterListener来卸载/取消注册  
        mSensorManager.unregisterListener(this);  
            mRegisteredSensor = false;  
        }  
        super.onPause();  
    }  
    //当精准度发生改变时  
    //sensor->传感器  
    //accuracy->精准度  
    public void onAccuracyChanged(Sensor sensor, int accuracy)  
    {  
        //处理精准度改变  
    }  
    // 当传感器在被改变时触发  
    public void onSensorChanged(SensorEvent event)  
    {  
        // 接收方向传感器的类型  
        if (event.sensor.getType() == Sensor.TYPE_ORIENTATION)  
        {  
            //这里我们可以得到数据，然后根据需要来处理  
            //由于模拟器上面无法测试效果，因此我们暂时不处理数据  
            float x = event.values[SensorManager.DATA_X];  
            float y = event.values[SensorManager.DATA_Y];  
            float z = event.values[SensorManager.DATA_Z];  
        }  
    }  
} 
```

上面的例子中演示了如何获得方向传感器的方向、加速度等信息，我们可以根据得到的数值与上一次得到的数值之间的关系来进行需要的操作。SensorManager中还有很多常量和一些常用的方法，如下：

getDefaultSensor：得到默认的传感器对象。
  
getInclination：得到地磁传感器倾斜角的弧度值。
  
getOrientation：得到设备旋转的方向。
  
getSensorList：得到指定传感器的列表。
