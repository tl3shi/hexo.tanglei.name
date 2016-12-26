---
id: 164
title: JDK里的设计模式
date: 2010-12-23T08:51:38+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=164
duoshuo_thread_id:
  - 1351842949280825450
categories:
  - JAVA
  - 设计模式
tags:
  - Java
  - 设计模式
---
关于本文的说明：本文是本来从网上收集进过自己细心**整理**而得。参考文章来自：<http://stackoverflow.com/questions/1673841/examples-of-gof-design-patterns>，本人不保证内容的正确性。仅供参考，因用word排版，因此贴到Wordpress格式比较乱，时间关系，不作调整，还请谅解。

Creational patterns 1
  
1. Abstract factory 1
  
2. Builder 2
  
3. Factory method 2
  
4. Prototype 2
  
5. Singleton 3
  
Structural patterns 3
  
6. Adapter 3
  
7. Bridge 3
  
8. Composite 3
  
9. Decorator 4
  
10. Façade 4
  
11. Flyweight 4
  
12. Proxy 5
  
Behavioral patterns 5
  
13. Chain of responsibility 5
  
14. Command 5
  
15. Interpreter 6
  
16. Iterator 6
  
17. Mediator 6
  
18. Memento 6
  
19. Observer 7
  
20. State 7
  
21. Strategy 7
  
22. Template method 8
  
23. Visitor 8

————————————————————————————————————————————————————————

**Creational patterns创建性模式**

**1. Abstract factory创建一组有关联的对象，在JDK中比较常见，还有很多的框架也用了这个模式，例如spring等。**
  
——recognizeable by creational methods returning an abstract/interface type

**
  
**  java.util.Calendar#getInstance()
  
 java.util.Arrays#asList()
  
 java.util.ResourceBundle#getBundle()
  
 java.net.URL#openConnection()
  
 java.sql.DriverManager#getConnection()
  
 java.sql.Connection#createStatement()
  
 java.sql.Statement#executeQuery()
  
 java.text.NumberFormat#getInstance()
  
 java.lang.management.ManagementFactory (all getXXX() methods)
  
 java.nio.charset.Charset#forName()
  
 javax.xml.parsers.DocumentBuilderFactory#newInstance()
  
 javax.xml.transform.TransformerFactory#newInstance()
  
 javax.xml.xpath.XPathFactory#newInstance()

**2. Builder用来简化一个复杂的对象的创建。**
  
——(recognizeable by creational methods returning the instance itself)

 java.lang.StringBuilder#append() (unsynchronized)
  
 java.lang.StringBuffer#append() (synchronized)
  
 java.nio.ByteBuffer#put() (also on CharBuffer, ShortBuffer, IntBuffer, LongBuffer, FloatBuffer and DoubleBuffer)
  
 javax.swing.GroupLayout.Group#addComponent()
  
 All implementations of java.lang.Appendable

**3. Factory method按照需求返回一个类型的实例**
  
—— (recognizeable by creational methods returning a concrete type)
  
 java.lang.Object#toString() (overrideable in all subclasses)
  
 java.lang.Class#newInstance()
  
 java.lang.Integer#valueOf(String) (also on Boolean, Byte, Character, Short, Long, Float and Double)
  
 java.lang.Class#forName()
  
 java.lang.reflect.Array#newInstance()
  
 java.lang.reflect.Constructor#newInstance()

**4. Prototype使用自己的实例创建另一个实例**
  
——recognizeable by creational methods returning a different instance of itself with the same properties)
  
 java.lang.Object#clone() (the class has to implement java.lang.Cloneable)

**5. Singleton单例就不说了**
  
——(recognizeable by creational methods returning the same instance (usually of itself) everytime)
  
 java.lang.Runtime#getRuntime()
  
 java.awt.Desktop#getDesktop()

————————————————————————————————————————————————————————

**Structural patterns结构性模式**

**
  
6. Adapter把一个接口或者类变成另一个**
  
——(recognizeable by creational methods taking an instance of different abstract/interface type and returning an implementation of own/another abstract/interface type which decorates/overrides the given instance)
  
 java.io.InputStreamReader(InputStream) (returns a Reader)
  
 java.io.OutputStreamWriter(OutputStream) (returns a Writer)
  
 javax.xml.bind.annotation.adapters.XmlAdapter#marshal() and #unmarshal()

**7. Bridge抽象和实现解耦，使接口和实现独立出来**
  
——(recognizeable by creational methods taking an instance of different abstract/interface type and returning an implementation of own abstract/interface type which delegates/uses the given instance)
  
 A fictive example would be new LinkedHashMap(LinkedHashSet, List) which returns an unmodifiable linked map which doesn&#8217;t clone the items, but uses them. The java.util.Collections#newSetFromMap() and singletonXXX() methods however comes close.

**8. Composite把单独的对象和组合的对象混合使用**
  
——( recognizeable by behavioral methods taking an instance of same abstract/interface type)
  
 java.util.Map#putAll(Map)
  
 java.util.List#addAll(Collection)
  
 java.util.Set#addAll(Collection)
  
 java.nio.ByteBuffer#put(ByteBuffer) (also on CharBuffer, ShortBuffer, IntBuffer, LongBuffer, FloatBuffer and DoubleBuffer)
  
 java.awt.Container#add(Component) (practically all over Swing thus)

**9. Decorator为一个对象动态的创建不同的动作而不需要因为创建不同的动作而产生很多集成类**
  
—— (recognizeable by creational methods taking an instance of same abstract/interface type) .All subclasses of java.io.InputStream, OutputStream, Reader and Writer have a constructor taking an instance of same type.
  
 Almost all implementations of java.util.List, Set and Map have a constructor taking an instance of same type.
  
 java.util.Collections, the checkedXXX(), synchronizedXXX() and unmodifiableXXX() methods.
  
 javax.servlet.http.HttpServletRequestWrapper and HttpServletResponseWrapper

**10. Façade用一个简单的接口去调用其他的接口**
  
—— (recognizeable by behavioral methods which internally uses instances of different independent abstract/interface types)
  
 javax.faces.webapp.FacesServlet, it internally uses under each the abstract/interface types ServletContext, LifeCycle, ViewHandler,
  
 NavigationHandler and many more without that the enduser has to worry about it (which are however overrideable by injection).

**11. Flyweight有效率的存储大量的小对象**
  
—— (recognizeable by creational methods returning a cached instance, a bit the &#8220;multiton&#8221; idea)
  
 java.lang.Integer#valueOf(int) (also on Boolean, Byte, Character, Short, Long, Float and Double)

 **12. Proxy用一个简单的对象代替复杂的对象，或者代替其他特殊动作的对象**
  
—— (recognizeable by creational methods which returns an implementation of given abstract/interface type which in turn delegates/uses a different implementation of given abstract/interface type)
  
 java.lang.reflect.Proxy
  
 java.rmi.*, the whole API actually.

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;
  
 **Behavioral patterns行为型模式**

**13. Chain of responsibility把一个对象在链接中传值一直到被处理，刘伟常举的例子就是请假的例子。**
  
—— (recognizeable by behavioral methods which (indirectly) invokes the same method in another implementation of same abstract/interface type in a queue)
  
 java.util.logging.Logger#log()
  
 javax.servlet.Filter#doFilter()

**14. Command把一个或者一组命令封装在一个对象当中**
  
——(recognizeable by behavioral methods in an abstract/interface type which invokes a method in an implementation of a different abstract/interface type which has been encapsulated by the command implementation during its creation)
  
 All implementations of java.lang.Runnable
  
 All implementations of javax.swing.Action

**15. Interpreter语法解释器**
  
——( (recognizeable by behavioral methods returning a structurally different instance/type of the given instance/type; note that parsing/formatting is not part of the pattern, determining the pattern and how to apply it is)
  
 java.util.Pattern
  
 java.text.Normalizer
  
 All subclasses of java.text.Format
  
 All subclasses of javax.el.ELResolver

**16. Iterator提供一个一致的方法来顺序遍历一个容器的所有元素**
  
——(recognizeable by behavioral methods sequentially returning instances of a different type from a queue)
  
 All implementations of java.util.Iterator (thus under each also java.util.Scanner!).
  
 All implementations of java.util.Enumeration

**17. Mediator减少对象间的直接依赖，用一个中介来管理消息的通讯**
  
—— (recognizeable by behavioral methods taking an instance of different abstract/interface type (usually using the command pattern) which delegates/uses the given instance)
  
 java.util.Timer (all scheduleXXX() methods)
  
 java.util.concurrent.Executor#execute()
  
 java.util.concurrent.ExecutorService (the invokeXXX() and submit() methods)
  
 java.util.concurrent.ScheduledExecutorService (all scheduleXXX() methods)
  
 java.lang.reflect.Method#invoke()

**18. Memento给一个对象做一个快照**
  
——(recognizeable by behavioral methods which internally changes the state of the whole instance)
  
 java.util.Date (the setter methods do that, Date is internally represented by a long value)
  
 All implementations of java.io.Serializable
  
 All implementations of javax.faces.component.StateHolder

**19. Observer让一个对象向所有侦听自己的所有对象广播自己的消息或者事件。**
  
—— (or Publish/Subscribe) (recognizeable by behavioral methods which invokes a method on an instance of another abstract/interface type, depending on own state)
  
 java.util.Observer/java.util.Observable (rarely used in real world though)
  
 All implementations of java.util.EventListener (practically all over Swing thus)
  
 javax.servlet.http.HttpSessionBindingListener
  
 javax.servlet.http.HttpSessionAttributeListener
  
 javax.faces.event.PhaseListener

**20. State根据自身的状态改变对象的行为**
  
1. ——(recognizeable by behavioral methods which changes its behaviour depending on the instance&#8217;s state which can be controlled externally)
  
 All implementations of java.util.Iterator
  
 javax.faces.lifecycle.LifeCycle#execute() (controlled by FacesServlet, the behaviour is dependent on current phase (state) of JSF lifecycle)

**21. Strategy在一个对象中封装一组算法，运行时可以灵活运用**
  
——(recognizeable by behavioral methods in an abstract/interface type which invokes a method in an implementation of a different abstract/interface type which has been passed-in as method argument into the strategy implementation)
  
 java.util.Comparator#compare(), executed by under each Collections#sort().
  
 javax.servlet.http.HttpServlet, the service() and all doXXX() methods take HttpServletRequest and HttpServletResponse and the implementor
  
 has to process them (and not to get hold of them as instance variables!).
  
 javax.servlet.Filter#doFilter()

**22. Template method让子类重载部分而不需要全部重写。**
  
—— (recognizeable by behavioral methods which already have a &#8220;default&#8221; behaviour definied by an abstract type)
  
 All non-abstract methods of java.io.InputStream, java.io.OutputStream, java.io.Reader and java.io.Writer.
  
 All non-abstract methods of java.util.AbstractList, java.util.AbstractSet and java.util.AbstractMap.
  
 javax.servlet.http.HttpServlet, all the doXXX() methods by default sends a HTTP 405 &#8220;Method Not Allowed&#8221; error to the response. You&#8217;re free to implement none or any of them.

**23. Visitor不改变对象本身的情况下改变作用于该对象的新操作。**
  
——(recognizeable by two different abstract/interface types which has methods definied which takes each the other abstract/interface type; the one actually calls the method of the other and the other executes the desired strategy on it)
  
 javax.lang.model.element.AnnotationValue and javax.lang.model.element.AnnotationValueVisitor
  
 javax.lang.model.element.Element and javax.lang.model.element.ElementVisitor
  
 javax.lang.model.type.TypeMirror and javax.lang.model.type.TypeVisitor
