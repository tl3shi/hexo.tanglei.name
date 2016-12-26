---
id: 748
title: Java泛型教程
date: 2011-06-03T14:30:14+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=748
duoshuo_thread_id:
  - 1351844048792453390
categories:
  - JAVA
tags:
  - Java
  - Java基础
---
转自：<span style="font-weight: bold;"><a href="http://www.jobbole.com/entry.php/885-Java%E6%B3%9B%E5%9E%8B%E7%AE%80%E6%98%8E%E6%95%99%E7%A8%8B">Java泛型简明教程</a></span>
  
泛型是Java SE5.0中引入的一项特征，自从这项语言特征出现多年来，我相信，几乎所有的Java程序员不仅听说过，而且使用过它。关于Java泛型的教程，免费的，不免费的，有很多。我遇到的最好的教材有：

  * <a href="http://download.oracle.com/javase/tutorial/" rel="nofollow" target="_blank">The Java Tutorial</a>
  * <a href="http://www.amazon.cn/mn/detailApp/ref=as_li_qf_sp_asin_tl?_encoding=UTF8&tag=vastwork-23&linkCode=as2&asin=0596527756&camp=536&creative=3200&creativeASIN=0596527756" rel="nofollow" target="_blank">Java Generics and Collections</a>, by Maurice Naftalin and Philip Wadler
  * <a href="http://www.amazon.cn/mn/detailApp/ref=as_li_qf_sp_asin_tl?_encoding=UTF8&tag=vastwork-23&linkCode=as2&asin=B001PTGR52&camp=536&creative=3200&creativeASIN=B001PTGR52" rel="nofollow" target="_blank">Effective Java中文版(第2版)</a>, by Joshua Bloch.

尽管有这么多丰富的资料，有时我感觉，有很多的程序员仍然不太明白Java泛型的功用和意义。这就是为什么我想使用一种最简单的形式来总结一下程序员需要知道的关于Java泛型的最基本的知识。

**Java泛型由来的动机**

理解Java泛型最简单的方法是把它看成一种便捷语法，能节省你某些Java类型转换(casting)上的操作：
  
List<Apple> box = &#8230;;
  
Apple apple =box.get(0);

上面的代码自身已表达的很清楚：box是一个装有Apple对象的List。get方法返回一个Apple对象实例，这个过程不需要进行类型转换。没有泛型，上面的代码需要写成这样：

List  box = &#8230;;
  
Apple apple = (Apple)box.get(0);

很明显，泛型的主要好处就是让编译器保留参数的类型信息，执行类型检查，执行类型转换操作：编译器保证了这些类型转换的绝对无误。

相对于依赖程序员来记住对象类型、执行类型转换——这会导致程序运行时的失败，很难调试和解决，而编译器能够帮助程序员在编译时强制进行大量的类型检查，发现其中的错误。

**泛型的构成**

由泛型的构成引出了一个类型变量的概念。根据Java语言规范，类型变量是一种没有限制的标志符，产生于以下几种情况：

  * 泛型类声明
  * 泛型接口声明
  * 泛型方法声明
  * 泛型构造器(constructor)声明

**泛型类和接口**

如果一个类或接口上有一个或多个类型变量，那它就是泛型。类型变量由尖括号界定，放在类或接口名的后面：

public  interface List<T> extends Collection<T>
  
{

……

}

简单的说，类型变量扮演的角色就如同一个参数，它提供给编译器用来类型检查的信息。

Java类库里的很多类，例如整个Collection框架都做了泛型化的修改。例如，我们在上面的第一段代码里用到的List接口就是一个泛型类。在那段代码里，box是一个List<Apple>对象，它是一个带有一个Apple类型变量的List接口的类实现的实例。编译器使用这个类型变量参数在get方法被调用、返回一个Apple对象时自动对其进行类型转换。

实际上，这新出现的泛型标记，或者说这个List接口里的get方法是这样的：

T get(int index);

get方法实际返回的是一个类型为T的对象，T是在List<T>声明中的类型变量。

**泛型方法和构造器(Constructor)**

非常的相似，如果方法和构造器上声明了一个或多个类型变量，它们也可以泛型化。

public static <t> T getFirst(List<T> list)

这个方法将会接受一个List<T>类型的参数，返回一个T类型的对象。

你既可以使用Java类库里提供的泛型类，也可以使用自己的泛型类。

**类型安全的写入数据…**

下面的这段代码是个例子，我们创建了一个List<String>实例，然后装入一些数据：

List<String> str = new ArrayList<String>();

str.add(&#8220;Hello&#8221;);

str.add(&#8220;World.&#8221;);

如果我们试图在List<String>装入另外一种对象，编译器就会提示错误：

str.add(1);//不能编译

类型安全的读取数据…

当我们在使用List<String>对象时，它总能保证我们得到的是一个String对象：

String myString = str.get(0);

**遍历**

类库中的很多类，诸如Iterator<T>，功能都有所增强，被泛型化。List<T>接口里的 iterator()方法现在返回的是Iterator<T>，由它的T next()方法返回的对象不需要再进行类型转换，你直接得到正确的类型。

for (Iterator<String> iter = str.iterator(); iter.hasNext();){

String s =
  
iter.next();

System.out.print(s);

}

**使用foreach **

“for each”语法同样受益于泛型。前面的代码可以写出这样：

for (String s: str){

System.out.print(s);

}

这样既容易阅读也容易维护。

**自动封装(Autoboxing)和自动拆封(Autounboxing)**

在使用Java泛型时，autoboxing/autounboxing这两个特征会被自动的用到，就像下面的这段代码：

List<Integer> ints = new ArrayList<Integer>();

ints.add(0);

ints.add(1);

int sum = 0;

for (int i : ints){

sum += i;

}

然而，你要明白的一点是，封装和解封会带来性能上的损失，所有，通用要谨慎的使用。

**子类型**

在Java中，跟其它具有面向对象类型的语言一样，类型的层级可以被设计成这样：

<div>
  <p>
    <img class="thumbnail" style="border-style: initial; border-color: initial; border-image: initial; border-width: 0px;" title="Java泛型简明教程" src="http://wkee.net/qee/Wordpress/wp-content/uploads/2011/06/type-hierarchy.png" alt="Java泛型简明教程" border="0" />
  </p>
</div>

在Java中，类型T的子类型既可以是类型T的一个扩展，也可以是类型T的一个直接或非直接实现(如果T是一个接口的话)。因为“成为某类型的子类型”是一个具有传递性质的关系，如果类型A是B的一个子类型，B是C的子类型，那么A也是C的子类型。在上面的图中：

  * FujiApple(富士苹果)是Apple的子类型
  * Apple是Fruit(水果)的子类型
  * FujiApple(富士苹果)是Fruit(水果)的子类型

所有Java类型都是Object类型的子类型。

B类型的任何一个子类型A都可以被赋给一个类型B的声明：

Apple a = &#8230;;
  
Fruit f = a;

**泛型类型的子类型**

如果一个Apple对象的实例可以被赋给一个Fruit对象的声明，就像上面看到的，那么，List<Apple>
  
和 a List<Fruit>之间又是个什么关系呢？更通用些，如果类型A是类型B的子类型，那C<A> 和
  
C<B>之间是什么关系？

答案会出乎你的意料：没有任何关系。用更通俗的话，泛型类型跟其是否子类型没有任何关系。

这意味着下面的这段代码是无效的：

List<Apple> apples = &#8230;;
  
List<Fruit> fruits = apples;

下面的同样也不允许：
  
List<Apple> apples;
  
List<Fruit> fruits = &#8230;;
  
apples = fruits;

为什么？一个苹果是一个水果，为什么一箱苹果不能是一箱水果？

在某些事情上，这种说法可以成立，但在类型(类)封装的状态和操作上不成立。如果把一箱苹果当成一箱水果会发生什么情况？

List<Apple> apples = &#8230;;
  
List<Fruit> fruits = apples;
  
fruits.add(new Strawberry());

如果可以这样的话，我们就可以在list里装入各种不同的水果子类型，这是绝对不允许的。

另外一种方式会让你有更直观的理解：一箱水果不是一箱苹果，因为它有可能是一箱另外一种水果，比如草莓(子类型)。

**这是一个需要注意的问题吗？**

应该不是个大问题。而程序员对此感到意外的最大原因是数组和泛型类型上用法的不一致。对于泛型类型，它们和类型的子类型之间是没什么关系的。而对于数组，它们和子类型是相关的：如果类型A是类型B的子类型，那么A[]是B[]的子类型：
  
Apple[] apples = &#8230;;
  
Fruit[] fruits = apples;

可是稍等一下！如果我们把前面的那个议论中暴露出的问题放在这里，我们仍然能够在一个apple类型的数组中加入strawberrie(草莓)对象：
  
Apple[] apples = new Apple[1];
  
Fruit[] fruits = apples;
  
fruits[0] = new Strawberry();

这样写真的可以编译，但是在运行时抛出ArrayStoreException异常。因为数组的这特点，在存储数据的操作上，Java运行时需要检查类型的兼容性。这种检查，很显然，会带来一定的性能问题，你需要明白这一点。

重申一下，泛型使用起来更安全，能“纠正”Java数组中这种类型上的缺陷。

现在估计你会感到很奇怪，为什么在数组上会有这种类型和子类型的关系，我来给你一个《<a href="http://www.amazon.cn/mn/detailApp/ref=as_li_qf_sp_asin_tl?_encoding=UTF8&tag=vastwork-23&linkCode=as2&asin=0596527756&camp=536&creative=3200&creativeASIN=0596527756" rel="nofollow" target="_blank">Java Generics and Collections</a>》这本书上给出的答案：如果它们不相关，你就没有办法把一个未知类型的对象数组传入一个方法里(不经过每次都封装成Object[])，就像下面的：
  
void sort(Object[] o);

泛型出现后，数组的这个个性已经不再有使用上的必要了(下面一部分我们会谈到这个)，实际上是应该避免使用。

**通配符**

在本文的前面的部分里已经说过了泛型类型的子类型的不相关性。但有些时候，我们希望能够像使用普通类型那样使用泛型类型：

  * 向上造型一个泛型对象的引用
  * 向下造型一个泛型对象的引用

**向上造型一个泛型对象的引用**

例如，假设我们有很多箱子，每个箱子里都装有不同的水果，我们需要找到一种方法能够通用的处理任何一箱水果。更通俗的说法，A是B的子类型，我们需要找到一种方法能够将C<A>类型的实例赋给一个C<B>类型的声明。

为了完成这种操作，我们需要使用带有通配符的扩展声明，就像下面的例子里那样：
  
List<Apple> apples = new ArrayList<Apple>();
  
List<? extends Fruit> fruits = apples;

“? extends”是泛型类型的子类型相关性成为现实：Apple是Fruit的子类型，List<Apple> 是
  
List<? extends Fruit> 的子类型。

**向下造型一个泛型对象的引用**

现在我来介绍另外一种通配符：? super。如果类型B是类型A的超类型(父类型)，那么C<B> 是 C<? super A> 的子类型：
  
List<Fruit> fruits = new ArrayList<Fruit>();
  
List<?super Apple> = fruits;

为什么使用通配符标记能行得通？

原理现在已经很明白：我们如何利用这种新的语法结构？**? extends**

让我们重新看看这第二部分使用的一个例子，其中谈到了Java数组的子类型相关性：
  
Apple[] apples = new Apple[1];
  
Fruit[] fruits = apples;
  
fruits[0] = new Strawberry();

就像我们看到的，当你往一个声明为Fruit数组的Apple对象数组里加入Strawberry对象后，代码可以编译，但在运行时抛出异常。

现在我们可以使用通配符把相关的代码转换成泛型：因为Apple是Fruit的一个子类，我们使用?
  
extends 通配符，这样就能将一个List<Apple>对象的定义赋到一个List<? extends Fruit>的声明上：
  
List<Apple> apples = new ArrayList<Apple>();
  
List<? extends Fruit> fruits = apples;
  
fruits.add(new Strawberry());

这次，代码就编译不过去了！Java编译器会阻止你往一个Fruit list里加入strawberry。在编译时我们就能检测到错误，在运行时就不需要进行检查来确保往列表里加入不兼容的类型了。即使你往list里加入Fruit对象也不行：

fruits.add(new Fruit());

你没有办法做到这些。事实上你不能够往一个使用了? extends的数据结构里写入任何的值。

原因非常的简单，你可以这样想：这个? extends T 通配符告诉编译器我们在处理一个类型T的子类型，但我们不知道这个子类型究竟是什么。因为没法确定，为了保证类型安全，我们就不允许往里面加入任何这种类型的数据。另一方面，因为我们知道，不论它是什么类型，它总是类型T的子类型，当我们在读取数据时，能确保得到的数据是一个T类型的实例：
  
Fruit get = fruits.get(0);

**? super**

使用 ? super
  
通配符一般是什么情况？让我们先看看这个：
  
List<Fruit> fruits = new ArrayList<Fruit>();
  
List<? super Apple> = fruits;

我们看到fruits指向的是一个装有Apple的某种超类(supertype)的List。同样的，我们不知道究竟是什么超类，但我们知道
  
Apple和任何Apple的子类都跟它的类型兼容。既然这个未知的类型即是Apple，也是GreenApple的超类，我们就可以写入：
  
fruits.add(new Apple());
  
fruits.add(new GreenApple());

如果我们想往里面加入Apple的超类，编译器就会警告你：
  
fruits.add(new Fruit());
  
fruits.add(new Object());

因为我们不知道它是怎样的超类，所有这样的实例就不允许加入。

从这种形式的类型里获取数据又是怎么样的呢？结果表明，你只能取出Object实例：因为我们不知道超类究竟是什么，编译器唯一能保证的只是它是个Object，因为Object是任何Java类型的超类。

**存取原则和PECS法则**

总结 ? extends 和 the ? super 通配符的特征，我们可以得出以下结论：

  * 如果你想从一个数据类型里获取数据，使用 ? extends 通配符
  * 如果你想把对象写入一个数据结构里，使用 ? super 通配符
  * 如果你既想存，又想取，那就别用通配符。

这就是Maurice Naftalin在他的《<a href="http://www.amazon.cn/mn/detailApp/ref=as_li_qf_sp_asin_tl?_encoding=UTF8&tag=vastwork-23&linkCode=as2&asin=0596527756&camp=536&creative=3200&creativeASIN=0596527756" rel="nofollow" target="_blank">Java Generics and Collections</a>》这本书中所说的存取原则，以及Joshua Bloch在他的《<a href="http://www.amazon.cn/mn/detailApp/ref=as_li_qf_sp_asin_tl?_encoding=UTF8&tag=vastwork-23&linkCode=as2&asin=B001PTGR52&camp=536&creative=3200&creativeASIN=B001PTGR52" rel="nofollow" target="_blank">Effective Java中文版(第2版)</a>》这本书中所说的PECS法则。

Bloch提醒说，这PECS是指”Producer Extends,Consumer Super”，这个更容易记忆和运用。

原文：<a href="http://www.javacodegeeks.com/2011/04/java-generics-quick-tutorial.html" rel="nofollow" target="_blank">Java code geek</a>
  
译文：<a href="http://news.csdn.net/a/20110602/299186.html" rel="nofollow" target="_blank">外刊IT评论<br /> </a>
