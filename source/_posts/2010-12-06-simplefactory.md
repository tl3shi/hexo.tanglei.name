---
id: 9
title: SimpleFactory
date: 2010-12-06T06:04:18+00:00
author: tanglei
excerpt: |
  |
    简单工厂
    简单工厂模式(Simple Factory Pattern)：又称为静态工厂方法(Static Factory Method)模式，它属于类创建型模式。在简单工厂模式中，可以根据自变量的不同返回不同类的实例。简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。
    使用简单工厂模式设计一个可以创建不同几何形状(Shape)的绘图工具类，如可创建圆形(Circle)、方形(Rectangle)和三角形(Triangle) 对象，每个几何图形都要有绘制draw()和擦除erase()两个方法，要求在绘制不支持的几何图形时，提示一个UnsupportedShapeException，绘制类图并编程实现。
layout: post
guid: http://www.tanglei.name/?p=9
duoshuo_thread_id:
  - 1351844048792453469
categories:
  - 课程学习
tags:
  - 设计模式
---
简单工厂
  
简单工厂模式(Simple Factory Pattern)：又称为静态工厂方法(Static Factory Method)模式，它属于类创建型模式。在简单工厂模式中，可以根据自变量的不同返回不同类的实例。简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。
  
类图如图所示
  
[<img src="/wp-content/uploads/2010/12/simplefactory1.png" alt="" title="simplefactory"  class="alignleft size-full wp-image-28" />](/wp-content/uploads/2010/12/simplefactory1.png)
  
下面还是通过一个例子来说明吧
  
用刘伟老师的实验里的例子。
  
使用简单工厂模式设计一个可以创建不同几何形状(Shape)的绘图工具类，如可创建圆形(Circle)、方形(Rectangle)和三角形(Triangle) 对象，每个几何图形都要有绘制draw()和擦除erase()两个方法，要求在绘制不支持的几何图形时，提示一个UnsupportedShapeException，绘制类图并编程实现。
  
[<img src="/wp-content/uploads/2010/12/sfdemo.png" alt="" title="sfdemo"  class="alignleft size-full wp-image-29" />](/wp-content/uploads/2010/12/sfdemo.png)

shape类：
  
package com.i3zhai.inter;
  
/\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****
   
* Module: Shape.java
   
* Author: Administrator
   
* Purpose: Defines the Interface Shape
   
\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****/

import java.util.*;

/*\* @pdOid 6d55d9ad-98d7-4bc0-86af-fc06db1c6faa \*/
  
public interface Shape {
     
/*\* @pdOid d3231e85-bfea-41dc-b1c3-b20764909fe9 \*/
     
void draw();
     
/*\* @pdOid 0ecca84e-b591-411f-9240-8f951b88f59c \*/
     
void erase();

}

实现类：
  
package com.i3zhai.iml;
  
/\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****
   
* Module: Circle.java
   
* Author: Administrator
   
* Purpose: Defines the Class Circle
   
\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****/

import com.i3zhai.inter.Shape;

/*\* @pdOid 7b0970a0-51d8-4082-8bdc-c1d446992564 \*/
  
public class Circle implements Shape {

public void draw()
	  
{
		  
System.out.println(&#8220;Cicle draw&#8221;);
	  
}

public void erase()
	  
{
		  
System.out.println(&#8220;Cicle erase&#8221;);
	  
}
  
}

package com.i3zhai.iml;
  
/\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****
   
* Module: Rectangle.java
   
* Author: Administrator
   
* Purpose: Defines the Class Rectangle
   
\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****/

import com.i3zhai.inter.Shape;

/*\* @pdOid 4278da12-2f32-4090-be12-a2367726927e \*/
  
public class Rectangle implements Shape {

public void draw()
	  
{
		  
System.out.println(this.getClass() + &#8221; :draw&#8221;);//难得写了 直接这样区分吧
	  
}

public void erase()
	  
{
		  
System.out.println(this.getClass() + &#8221; :erase&#8221;);

}
  
}

Triange类的实现一样。不贴代码了。
  
工厂类：package com.i3zhai;
  
/\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****
   
* Module: ShapeFactory.java
   
* Author: Administrator
   
* Purpose: Defines the Class ShapeFactory
   
\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\***\*****/

import com.i3zhai.iml.Circle;
  
import com.i3zhai.iml.Rectangle;
  
import com.i3zhai.iml.Triangle;
  
import com.i3zhai.inter.Shape;

/*\* @pdOid fce0c368-7a6f-4f1e-910a-47be9d5eb099 \*/
  
public class ShapeFactory {
     
/** @param shape
      
\* @pdOid e37c9785-6431-4e2b-a880-f4ed2d0a94de \*/
     
public static Shape createShape(String shape) {

if(&#8220;circle&#8221;.equalsIgnoreCase(shape))
		     
return new Circle();
	     
if(&#8220;rectangle&#8221;.equalsIgnoreCase(shape))
		     
return new Rectangle();
	     
if(&#8220;Triangle&#8221;.equalsIgnoreCase(shape))
		     
return new Triangle();
	     
throw new UnsupportedShapeException();
     
}
  
再写个解析配置文件XML的工具类：
  
package com.i3zhai.util;
  
import java.io.File;

import javax.xml.parsers.DocumentBuilder;
  
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
  
import org.w3c.dom.Node;
  
import org.w3c.dom.NodeList;
  
public class XMLUtil
  
{
	  
public static Object getType()
	  
{
		  
try
		  
{
			  
DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance();
			  
DocumentBuilder builder = dFactory.newDocumentBuilder();
			  
Document doc;
			  
doc = builder.parse(new File(&#8220;config.xml&#8221;)); 

NodeList nl = doc.getElementsByTagName(&#8220;typeName&#8221;);
              
Node classNode=nl.item(0).getFirstChild();
              
String cName=classNode.getNodeValue();

return cName;
             
}
           	  
catch(Exception e)
           	  
{
           		  
e.printStackTrace();
           		  
return null;
           	  
}
		  
}
  
}

}
  
配置文件
  
<?xml version="1.0"?>


  
<config>
	  
<typeName>rectangle1</typeName>
  
</config>
  
在上面typename里面输入要构造的图形名称 就可以了。
  
这样就实现了不改源代码 构造不同的图形产品。满足OCP。
