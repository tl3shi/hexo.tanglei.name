---
id: 2164
title: Android 打包Jar(发布SDK)常见问题及解决方案
date: 2013-05-11T00:50:45+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2164
duoshuo_thread_id:
  - 1351844048792453485
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Android
  - Java
---
在Android开发过程中，我们经常会有这种需求，需要将自己开发一个类库打包成jar包以供他人(其他人一般指开发者)调用，而不是直接打包apk文件供最终用户使用。在打包成jar后，你往往会自己先测试一下看jar包能不能直接使用，这时就会常常有如下的几个问题：

1) Error…..Found duplicate file for APK:res/drawable-xxx/xxx.xx

2) res.Resources$NotFoundException:XXX ID#0x7f090015

3) java.lang.NullPointerException

4) java.lang.NoClassDefFoundError: com.xxx.xxx.R$layout

几个问题常见的原因是因为**资源文件**在作怪。

在第一个问你中，**资源文件**被打包进jar，在目标使用project中，也有相同id的资源文件，引起了冲突，解决方案是别打包资源文件啦，打包进去也不用的，后面会提到。或许你提到可能改变src project(提供jar包的project)里面的资源id可以表面上解决这个问题。

不打包资源文件，但src project中又引用了res的资源文件，即便你把相应的layout的xml啊String.xml啊等copy到目标project中，也会造成如res.Resources$NotFoundException或者java.lang.NullPointerException，原因是在src中的一些activity调用xml中的资源时，控件id找不到，例如一个btn = findViewById(R.id.btnXXX);这个btn为空，就会NullPointerException.这个问题原因还是在stackoverflow上有人给出了合理的解释.

> As you want to import the resources,Since Android makes R class automatically with resources files under /res folder, using R class as final static is impossible.in your source code which will be exported in jar file, DON&#8217;T USE R variable because it will be replaced with final static memory address in compile time. Instead of using R use method below……

src项目中导出src文件夹成jar，不包含资源文件，资源文件copy到要引用的的其他项目中，但src中不能通过R.id.XXX 获取xml中的布局等。因为打包成class的时候，final int 等死了(具体可以看看gen/xxx.xx.R.java)，在新项目中是不对应的。解决方案就是用**反射**的方法.代码如下.

```java
public static int getResourseIdByName(String packageName, String className,
			String name)
	{
		Class r = null;
		int id = 0;
		try
		{
			r = Class.forName(packageName + ".R");

			Class[] classes = r.getClasses();
			Class desireClass = null;

			for (int i = 0; i < classes.length; i++)
			{
				if (classes[i].getName().split("\\$")[1].equals(className))
				{
					desireClass = classes[i];
					break;
				}
			}

			if (desireClass != null)
				id = desireClass.getField(name).getInt(desireClass);
		} catch (ClassNotFoundException e)
		{
			e.printStackTrace();
		} catch (IllegalArgumentException e)
		{
			e.printStackTrace();
		} catch (SecurityException e)
		{
			e.printStackTrace();
		} catch (IllegalAccessException e)
		{
			e.printStackTrace();
		} catch (NoSuchFieldException e)
		{
			e.printStackTrace();
		}

		return id;

	}
```

然后利用int id = getResourceIdByName(context.getPackageName(), &#8220;layout&#8221;, &#8220;main&#8221;);获取layout文件夹下main.xml的配置layout，通过int id = getResourceIdByName(context.getPackageName(), &#8220;string&#8221;, &#8220;text1&#8221;);获取string.xml下key为text1的字符串，通过int id = getResourceIdByName(context.getPackageName(), &#8220;id&#8221;, &#8220;btn&#8221;)获得id为btn的控件等。这个代码利用反射运行时找的。
  
当然具体应用过程中你可以根据上面的这个方法重构一下去掉循环找配置而修改成单独的一些id(key),dimen(key),color(key)之类的方法.这里就不便(工作需要)将源码给出当然也没必要给出了.

网上说使用library方法加载资源文件可以解决,即将src project作为library,目标project引用src project.然后说这个方法解决了通过R.XX.XX获取资源的问题，但还有一个问题是不可能把这个源码发布出去让其他人使用。我试了试，在我的项目中貌似通过R.XX.XX获取的控件仍然为null，让人会报空指针异常。

但这个给我提供了一个思路解决了一个比较方便的提供SDK的方式。因为上面的提到的那种需要手动copy layout等xml文件.如果利用library的话可以避免copy这个操作。具体方案就是，同样src project打包成lib.jar，然后自己手动建一个library project作为中间project，这个project添加lib.jar并将相应的xml文件copy到此project.如下图中的nebula\_sdk,然后再发布nebula\_sdk这个项目给其他人用，这样既满足了功能需求同样也使代码不易泄漏(打包过程仍然可以使用一定的代码混淆技术).

新建一个类库项目，如命名nebula_sdk.

[<img title="clip_image002" src="/wp-content/uploads/2013/05/clip_image002_thumb.jpg" alt="clip_image002"  />](/wp-content/uploads/2013/05/clip_image002.jpg)[<img title="clip_image004" src="/wp-content/uploads/2013/05/clip_image004_thumb.jpg" alt="clip_image004"  />](/wp-content/uploads/2013/05/clip_image004.jpg)

发布出去后，开发者需要将上面提到的nebula_sdk作为library引用进来。如下图.

[<img title="clip_image006" src="/wp-content/uploads/2013/05/clip_image006_thumb.jpg" alt="clip_image006"  />](/wp-content/uploads/2013/05/clip_image006.jpg)

因此得到了**两种android下发布sdk方案**：

  1. 生成jar,发布jar包同时提供layout xml等配置资源文件.这也是现在很多sdk发布的方式，比如一下广告的SDKdomob\_android\_sdk，统计分析的SDK等.
  2. 生成jar包，先将library project并将此library project发布出去.这个方法可以省了让开发者copy 资源文件这一个过程.

当然如果src project中**只**涉及图片之类的(R.drawable.xx)文件（不涉及通过R.ID.xxx得到布局等控件）的话也可以按照网上所说的方法把图片copy到assert目录下然后通过File IO的方式获取原本应该放在drawable下的资源文件.当然如果涉及布局等控件外，还有另外一个解决方案然后布局的话可以用硬coding的方式编码(不读取xml布局)，不过这个应该比较繁琐吧。

参考资料：

[1] android中级之Android类库打包方法探究<http://blog.csdn.net/zp522123428/article/details/7437027>

[2] android 关于生成jar包的问题 <http://blog.sina.com.cn/s/blog_5da93c8f010108df.html>

[3] java.lang.NoClassDefFoundError: com.facebook.android.R$layout error when using facebook sdk jar

<http://stackoverflow.com/questions/14373004/java-lang-noclassdeffounderror-com-facebook-android-rlayout-error-when-using-f>

[4] Android 中jar包封装及调用<http://blog.csdn.net/huangyic1986/article/details/7452177>
