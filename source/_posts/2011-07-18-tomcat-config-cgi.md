---
id: 1024
title: Tomcat配置CGI实例
date: 2011-07-18T17:36:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1024
permalink: /tomcat-config-cgi/
duoshuo_thread_id:
  - 1351844048792453202
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - JAVA
  - 实习那些事儿
tags:
  - cgi
  - java
  - java支持CGI
  - tomcat
  - TOMCAT配置CGI
---
腾讯实习的培训布置的作用中需要用Qzhttp+FastCGI+TTC架构写demo.网上参照了下,最后成功在Tomcat下配置CGI并实现简单例子.
  
Tomcat提供了对CGI的支持，但默认情况下，Tomcat对CGI的支持被禁止了。开启支持要采取如下配置:
  
将文件 $CATALINA\_BASE/server/lib/servlets-cgi.renametojar 的名称修改为$CATALINA\_BASE/server/lib/servlets-cgi.jar。有的还说要将此目录下servlets-ssi.renametojar改成servlets-ssi.jar. 如果想让Tomcat下所有的Application支持支持CGI，可以修改 $CATALINA_BASE/conf/web.xml；如果只希望某些Application支持CGI，那么只需要修改这些应用root目录下的/WEB-INF/web.xml文件。
  
使用batch命令编写CGI脚本，可以将以下几行配置代码添加到web.xml就可完成对web.xml文件的修改(具体见下)：其中的参数: 配置CGI servlet的行为，涉及到以下几个servlet的初始化参数。
  
cgiPathPrefix &#8211; CGI程序所在的目录，CGI servlet将按照以下路径搜索CGI程序：应用程序root目录 + 路径分割符 + cgiPathPrefix。其默认值为 WEB-INF/cgi。CGI程序应该放在WEB-INF下面的目录以防止程序被当作普通文件被下载或其脚本内容被查看。
  
debug &#8211; 设置servlet在日志中记录调试信息的级别，其值越大，信息越详细。默认值为0。
  
executable &#8211; 用来运行脚本的可执行程序，默认为perl。
  
parameterEncoding &#8211; CGI servlet使用的编码类型名称。默认值取 System.getProperty(&#8220;file.encoding&#8221;,&#8221;UTF-8&#8243;)。
  
passShellEnvironment &#8211; 是否将shell的环境变量传递给CGI脚本。默认值为false。
  
举例：
  
myeclipse新建一个web项目。web.xml内容如下

<pre>&lt;cc lang="xml">
<?xml version="1.0" encoding="UTF-8"?>
&lt;web-app version="2.4" 
	xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
	http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">



<!-- CGI servlet configuration -->
&lt;servlet>
&lt;servlet-name>cgi&lt;/servlet-name>
&lt;servlet-class>org.apache.catalina.servlets.CGIServlet&lt;/servlet-class>
    &lt;init-param>
      

<param-name />
debug&lt;/param-name>
      

<param-value />
100&lt;/param-value>
    &lt;/init-param>
    &lt;init-param>
      

<param-name />
cgiPathPrefix&lt;/param-name>
      

<param-value />
WEB-INF/cgi&lt;/param-value>
    &lt;/init-param>
    &lt;init-param>
      

<param-name />
executable&lt;/param-name>
      

<param-value />
cmd.exe /c&lt;/param-value>
    &lt;/init-param>
    &lt;init-param>
      

<param-name />
passShellEnvironment&lt;/param-name>
      

<param-value />
true&lt;/param-value>
    &lt;/init-param>
    &lt;load-on-startup>5&lt;/load-on-startup>
&lt;/servlet>


<!-- CGI servlet mapping --> 
&lt;servlet-mapping>
    &lt;servlet-name>cgi&lt;/servlet-name>
    &lt;url-pattern>/cgi-bin/*&lt;/url-pattern>
&lt;/servlet-mapping>

&lt;/web-app>
&lt;/cc></pre>

然后构造如下目录：[<img class="aligncenter size-full wp-image-1025" title="tomcat-cgi-directory" src="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-directory.jpg" alt="TOMCAT配置CGI目录结构" width="400" height="480" data-pinit="registered" />](http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-directory.jpg)
  
注意结构，web-inf下面有个CGI，在web.xml配置的目录结构，当然也可以改相应的配置文件与目录结构对应即可。
  
其中test.bat

<pre>&lt;cc class="xml">
echo OFF
echo Content-type: text/html
echo.
echo.
echo ^
echo ^
echo ^CGI Test Demo^
echo ^Time is:
time /t
echo ^
echo ^Location is:
chdir
echo ^
echo ^
echo ^
&lt;/cc></pre>

启动tomcat，然后浏览器访问：http://localhost/cgiDemo/cgi-bin/test.bat 看到如下图说明配置成功了
  
[<img class="aligncenter size-medium wp-image-1026" title="tomcat-cgi-demo" src="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-demo.jpg" alt="TOmcat配置CGI" width="600" height="334" data-pinit="registered" />](http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-demo.jpg)
  

  
再写个C语言的程序：add.cpp

<pre><cc class="C">
#include <stdio.h> 
#include <stdlib.h> 

int main(void) 
{ 
	char *data; 
	long m,n; 
 	 
     printf("%s","Content-Type:text/html;charset=gb2312\n\n");
	printf("

<TITLE>
  乘法结果
</TITLE> "); 
	printf("

<H3>
  乘法结果
</H3> "); 

	data = getenv("QUERY_STRING"); 

	if(data == NULL) 
		printf("

<P>
  错误！数据没有被输入或者数据传输有问题"); 
  	//sscanf 类似正则表达式 以固定的格式为输入源，而scanf从标准输入获得输入源 
  	//成功则返回参数数目 
  	else if( sscanf(data,"m=%ld&#038;n=%ld",&#038;m,&#038;n) != 2) 
  		printf("
  
  <P>
    错误！输入数据非法。表单中输入的必须是数字。"); 	
    	else 
    		printf("
    
    <P>
      %ld * %ld = %ld。<br />",m,n,m*n); 
      	return 0; 
      }
      
      </cc></pre>
      
      
      <p>
        编译连接成可执行文件。在上图中已经显示出来。<br />
        有个html的表单：
      </p>
      
      
      <pre>&lt;cc class="html">


<FORM ACTION="cgi-bin/add.exe" method="get">
  <P>
    请在下面填入乘数和被乘数，按下确定后可以看到结果。 
    		<INPUT NAME="m" SIZE="5" /> 
    		<INPUT NAME="n" SIZE="5" />
  </P>&lt;/BR> 
  		
  
  <INPUT TYPE="SUBMIT" VALUE="确定" />
  
</form>
&lt;/cc></pre>
      
      
      <p>
        我的首页是为了测get post两种情况写的代码如下：
      </p>
      
      
      <pre><cc class="java">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


  
  
  
  <%=basePath%>
 	 

<center>
  get:
    	
</center>
  	

<hr size="4" color="red" />

<center>
  post  得通过另外的方式才行  先得到Content-length:
    	
</center>
  		
  		

<hr size="4" color="red" />

<center>
  <FORM ACTION="cgi-bin/add.exe" method="get">
    <P>
      请在下面填入乘数和被乘数，按下确定后可以看到结果。 
      		<INPUT NAME="m" SIZE="5" /> 
      		<INPUT NAME="n" SIZE="5" />
    </P></BR> 
    		
    
    <INPUT TYPE="SUBMIT" VALUE="确定" /> 
    		
    
    <center>
      </FORM > 
        </body>
      </html>
      </cc></pre>
      
      
      <p>
        效果：
      </p>
      
      
      <p>
        <a href="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-config-cgi-run-cpp.jpg"><img class="aligncenter size-medium wp-image-1027" title="tomcat-config-cgi-run-cpp" src="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-config-cgi-run-cpp.jpg" alt="Tomcat配置CGI运行C程序" width="600" height="266" data-pinit="registered" /></a>
        
      </p>
      
      
      <p>
        输入数据结果现实:<br />
        <a href="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-cpp-result.jpg"><img class="aligncenter size-medium wp-image-1028" title="tomcat-cgi-cpp-result" src="http://www.tanglei.name/wp-content/uploads/2011/07/tomcat-cgi-cpp-result.jpg" alt="Tomcat配置CGI运行Exe文件"   data-pinit="registered" /></a>
      </p>
      
      
      <p>
        差不多了。现在我又有一种方法通过java等运行C可执行文件了。之前用<a href="http://www.tanglei.name/java-native-demo/">native也写过helloworld的例子</a>。
      </p>