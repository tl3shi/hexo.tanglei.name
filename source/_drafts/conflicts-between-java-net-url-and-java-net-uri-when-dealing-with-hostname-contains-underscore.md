---
title: a "bug" in java.net.URL?
layout: post
categories: 
  - 经验技巧
tags: 
  - Java
  - Bug
---

这其实是去年就踩的一个坑了, 最近几天又踩到一个类似的, 于是想起在这里来分享一下. 背景是这样的: 

我们的项目依赖于一个外部服务, 该外部服务提供 REST 接口供我方调用, 本地测试和测试环境都没有问题, 但是一上生产环境就发现网络不通. (本地测试/测试环境, 生产环境网络通过不通的域名访问该外部服务), 且在生产环境通过 `curl` 等命令能够正常调用对方接口. **TODO 验证示例**  最终排查原因出现在域名上, 在生产环境中通过 java 的 httpclient 调用未发出请求. 该域名形如  `http://test_1.tanglei.name`

TODO 示例, 
go 提供服务, 

java.net.URL.openConnection ? 

URI? 

python 等调用OK ? 


Conflicts between java.net.URL and java.net.URI when dealing with hostname contains underscore(_), is it a bug ?

    Someone has submiited a bug to JDK, saying that hostname contains underscore(_) is not valid url. [reference link](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=8132508)
    "RFC 952 disallows _ underscores in hostnames." was the response. 

    I am wondering, if hostname with underscore is not valid, why the result is differrent between java.net.URI and java.net.URL? Here is the example.

        java.net.URL url = new java.net.URL("http://test_1.tanglei.name");
        System.out.println(url.getHost()); //test_1.tanglei.name
        java.net.URI uri = new java.net.URI("http://test_1.tanglei.name");
        System.out.println(uri.getHost()); //null    

stackoverflow 上提问: https://stackoverflow.com/questions/44226003/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-conta
发现, 自己在1年前已经向OpenJDK提交了BUG: https://bugs.openjdk.java.net/browse/JDK-8170265
被人认同为P4的bug, 然而又被人认为not an issue. 因为说是URL的构造函数中说了本来也不会做验证 "No validation of the inputs is performed by this constructor." (https://docs.oracle.com/javase/8/docs/api/java/net/URL.html)

这里有java.net.URL的源码 http://www.docjar.com/html/api/java/net/URL.java.html

