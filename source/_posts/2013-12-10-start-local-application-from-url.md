---
id: 2256
title: 通过浏览器输入url启动本地应用程序
date: 2013-12-10T23:03:57+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2256
duoshuo_thread_id:
  - 1351844048792453494
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Windows
  - 敲敲代码
tags:
  - Windows
---
常见的诸如网页点击某个链接启动了本地的迅雷、Q旋风等下载工具，亦或者是在某网页点击某QQ头像弹出本地QQ。其实方法比较简单，就是windows下注册表里面写好了，如果浏览器的开头（协议标识符）是tencent://之类的就打开QQ，其他也类似。下面给一个例子。

本地应用程序如下：

```cpp
#include <iostream>
int main(int argc, char** argv)
{
	std::cout << "Hello world." << std::endl;
    std::cout << "argc: " << argc << std::endl;
    for(int i = 0; i < argc; i++)
        std::cout << argv[i] << std::endl;
    int t;
    std::cin >> t;
    return 0;
}
```

功能是简单输出helloworld，并打印启动时的参数（参数有文章可做哦，比如QQ的标明某QQ号，应用程序解析出QQ号，就打开与该QQ号聊天的窗口）。后面的等待输入t，只是为了方便看结果。

注册表：

```csharp
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\foo]
"URL Protocol"="d:\\a.exe"
@="fooProtocol"
[HKEY_CLASSES_ROOT\foo\shell]
[HKEY_CLASSES_ROOT\foo\shell\open]
[HKEY_CLASSES_ROOT\foo\shell\open\command]
@="\"d:\\a.exe\" \"%1\"" 
```

HKEY…ROOT后的foo就是协议，其中a.exe为上面应用程序的路径。浏览器输入这样的地址就可以启动“[foo://xxx](foo://hello/?helo "foo://hello/?helo") ”就可以启动，比如输入“[foo://hello/?helo](foo://hello/?helo "foo://hello/?helo")” 回车，会有是否允许网站打开本地程序的安全提示，允许后就是这样的结果。

[<img title="image" src="/wp-content/uploads/2013/12/image_thumb1.png" alt="image"  />](/wp-content/uploads/2013/12/image1.png)
  
以上针对Windows、IE可行，其他平台或者浏览器应该有类似的方案，可以参考以下参考资料。
  
参考：
  
[1] <http://kb.mozillazine.org/Register_protocol>
  
[2] <http://geeklu.com/2011/01/start-application-from-url-talk-about-wangwang/>
