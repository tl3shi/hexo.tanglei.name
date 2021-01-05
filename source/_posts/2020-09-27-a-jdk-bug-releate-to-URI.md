---
title: 给 JDK 报了一个 P4 的 Bug，结果居然……
layout: post
categories:
  - 经验技巧
tags:
  - Java
  - 经验技巧
---

>关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。以每篇文章都让人有收获为目的，欢迎关注，交流和指导！文章首发于[微信公众号](https://mp.weixin.qq.com/s?src=11&timestamp=1604109394&ver=2677&signature=lA-7iYDNTu3m0Is66BL5L5*sINruP5woH9d7PrRTIv0K-9fsVesO6oMA8wzTooPMm2uQqI1lfDkD9MXJMZskn2k*KqvdMyAlTjO9sJwJDRwCOe4Olx4zG-t8qIBrSz-W&new=1)，欢迎关注。后台回复关键字 “1024” 获取程序员大厂面试指南。

分享一下之前踩的一个坑，背景是这样的： 

我们的项目依赖于一个外部服务，该外部服务提供 REST 接口供我方调用，这是很常见的一个场景。本地和测试环境测试都没有问题，一切就绪上了生产后，程序调用接口就总是网络不通。

需要说明的是本地、测试环境、生产环境通过不同的域名访问该外部服务。生产程序调用不通，神奇的是在生产环境通过 `curl` 等命令却能够正常调用对方接口。

![img](https://www.tanglei.name/resources/a-jdk-bug-releate-to-URI/whatjpg.png)



这 TM 就神奇了，唯一不同的就是发起 HTTP 请求的客户端了，估计就是 http客户端有问题了？ 通过最后排查发现，居然发现了一枚 “ JDK 的 bug”……

下面我们就来重现一下这个问题。 


## server 端准备 

这里用 Nginx 模拟了一下 上文提到的 REST 服务, 假设调用正常返回 `"Hello, World\n" `，Nginx 配置如下：

```
server {
    listen    80;
    server_name test_1.tanglei.name;
    location /testurl {
        add_header Content-Type 'text/plain; charset=utf-8';
        return 200 "Hello, World\n";
    }
}
```


## 不同的 client 请求

下面用不同的 Http client （分别用命令行`curl`，python的 `requests`包，和 Java 的 URL 等尝试）去请求。

- `curl` 请求，正常。

```bash
[root@VM_77_245_centos vhost]# curl -i "http://test_1.tanglei.name/testurl"
HTTP/1.1 200 OK
Server: nginx
Date: Wed, 31 May 2017 09:53:01 GMT
Content-Length: 13
Connection: keep-alive
Content-Type: text/plain; charset=utf-8

Hello, World
[root@VM_77_245_centos vhost]#
```

- `python requests`  正常。

```python
>>> import requests
>>> r = requests.get("http://test_1.tanglei.name/testurl")
>>> r.text
u'Hello, World\n'
```

- Java 的  ` java.net.URLConnection` 同样正常。

我们来看一下通过 Java 调用。

```java
static String getContent(java.net.URL url) throws Exception {
    java.net.URLConnection conn = url.openConnection();
    java.io.InputStreamReader in = new java.io.InputStreamReader(conn.getInputStream(), "utf-8");
    java.io.BufferedReader reader = new java.io.BufferedReader(in);    
    StringBuilder sb = new StringBuilder();
    int c = -1;
    while ((c = reader.read()) != -1) {
        sb.append((char)c);
    }
    reader.close();
    in.close();
    String response = sb.toString();
    return response;
}
```

上面的这个方法 `String getContent(java.net.URL url)` 传入一个构造好的 `java.net.URL` 然后 get 请求，并以 `String` 方式返回 response。

```java
String srcUrl = "http://test_1.tanglei.name/testurl";
java.net.URL url = new java.net.URL(srcUrl);
System.out.println("\nurl result:\n" + getContent(url)); // OK
```

上面的语句输出正常，结果如下：

```
url result:
Hello, World
```

这就尼玛神奇了吧。看看我们程序中用的 httpclient 的实现，结果发现是有用 `java.net.URI`，心想，这不至于吧，用 URI 就不行了么。 

![img](https://www.tanglei.name/resources/a-jdk-bug-releate-to-URI/buzhiyu.png)

换 `java.net.URI` 试试?  （这里不展开讲URL和URI的区别联系了，可以简单的认为URL是URI的一个子集，详细的可参考 [URI、URL 和 URN](https://www.ibm.com/developerworks/cn/xml/x-urlni.html), [wiki URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)）

直接通过`java.net.URI`构造，再调用 `URI.toURL` 得到 `URL`，调用同样正常。

关键的来了，httpclient 源码中用的构造函数是另外一个：

```java
URI(String scheme, String host, String path, String fragment)
Constructs a hierarchical URI from the given components.
```

我用这个方法构造`URI`，会构造失败： 

```java
new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null) error: protocol = http host = null
new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null) error: Illegal character in hostname at index 11: http://test_1.tanglei.name/testurl
```

所以问题发现了，我们的项目中依赖的第三方 httpclient包底层用到了 `java.net.URI`，恰好在 `java.net.URI` 中是不允许以下划线(`_`)作为 `hostname` 字段的。

即 `uri.getHost()` 和 `uri.toURL().getHost()` 居然能不相等。



## 这是 JDK 的 Bug 吧？

有理由怀疑，这是 JDK 的 Bug 吗？

![image-20200919102937998](https://www.tanglei.name/resources/a-jdk-bug-releate-to-URI/bug.png)

从官网上还真找到了关于包含下划线作为hostname的bug提交issue，戳这里 [JDK-8132508 : Bug JDK-8029354 reproduces with underscore in hostname](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=8132508)，然后发现该 "bug" reporter 的情况貌似跟我的差不多，只不过引爆bug的点不一样。

该 "bug" reviewer 最后以 "Not an Issue" 关闭，给出的理由是：

>RFC 952 disallows _ underscores in hostnames. So, this is not a bug. 

确实，[rfc952](https://tools.ietf.org/html/rfc952) 明确说了域名只能由 字母 `(A-Z)`、 数字` (0-9)`、 减号 `(-)` 和 点 `(.)` 组成。

那 OK 吧，既然明确规定了 hostname 不能包含下划线，为啥 `java.net.URL` 确允许呢？

造成 `java.net.URI` 和 `java.net.URL` 在处理 hostname 时的标准不一致，且本身 `java.net.URI` 在构造的时候也带了 "有色"眼镜，同一个url字符串 通过静态方法 `java.net.URI.create(String)` 或者通过带1个参数的构造方法 `java.net.URI(String)` 都能成功构造出 URI 的实例，但通过带4个参数的构造方法就不能构造了。 

要知道，在 coding 过程中，**尽早**反馈异常信息更有利于软件开发持续迭代的过程。我们在开发过程中也应该遵循这一点原则。 

于是我就去 JDK 官网提交了一个 bug，大意是说 `java.net.URI` 和 `java.net.URL` 在处理hostname的时候标准不一致，容易使开发人员埋藏一些潜在的bug，同时也还把这个问题反馈到  [stackoverflow](https://stackoverflow.com/questions/44226003/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-conta) 了。

>I am wondering, if hostname with underscore is not valid, why the result is differrent between java.net.URI and java.net.URL? Is it a bug or a feature? Here is the example.
>
>java.net.URL url = new java.net.URL("http://test_1.tanglei.name");
>System.out.println(url.getHost()); //test_1.tanglei.name
>java.net.URI uri = new java.net.URI("http://test_1.tanglei.name");
>System.out.println(uri.getHost()); //null 
这个 JDK bug issue 详细信息见 [JDK-8170265 : underscore is allowed in java.net.URL while not in java.net.URI](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=8170265), ([openjdk JDK-8170265](https://bugs.openjdk.java.net/browse/JDK-8170265) 更详细）。

![](https://www.tanglei.name/resources/a-jdk-bug-releate-to-URI/jdk-bug.png)

经过初步 Review，被认为是一个 P4 的 Bug，说的是 `java.net.URL` 遵循的是 `RFC 2396` 规范，确实不允许含有下划线的 hostname，`java.net.URI` 做到了， 而 `java.net.URL` 没有做到。

> As per RFC 2396:
> "Hostnames take the form described in Section 3 of [RFC1034] and
> Section 2.1 of [RFC1123]: a sequence of domain labels separated by
> ".", each domain label starting and ending with an alphanumeric
> character and possibly also containing "-" characters.  The rightmost
> domain label of a fully qualified domain name will never start with a
> digit, thus syntactically distinguishing domain names from IPv4
> addresses, and may be followed by a single "." if it is necessary to
> distinguish between the complete domain name and any local domain.
> To actually be "Uniform" as a resource locator, a URL hostname should
> be a fully qualified domain name.  In practice, however, the host
> component may be a local domain literal."

>URI class is following the above, but URL class doesn't seem to follow the same rules.

>To reproduce the issue , run the attached test case.
>Following is the output on various JDK versions:
>JDK 8 - Fail
>JDK 8u112 - Fail
>JDK 8u122-ea - Fail
>JDK 9-ea + 141 - Fail

重点来了，然后，却被另外一个 Reviewer 直接个毙了。给出的原因是 `java.net.URL` 构造方法中，API 文档中说了本来也不会做验证即 `No validation of the inputs is performed by this constructor.` [在线 api doc 戳这里](https://docs.oracle.com/javase/8/docs/api/java/net/URL.html) (可以点连接，进去搜索关键字 "No validation")

>The constructors of URL class (e.g., http://download.java.net/java/jdk9/docs/api/java/net/URL.html#URL-java.lang.String-java.lang.String-java.lang.String-) specifically mention about the validation: 

>"No validation of the inputs is performed by this constructor." 

>So not throwing an exception isn't an issue here.

![](https://www.tanglei.name/resources/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-contains-underscore/nonsense.jpg)

当初没有收到及时反馈，就没有来得及怼回去。

其实就算 "No validation of the inputs is performed by this constructor." 是合理的，里面也只有3个构造函数有这样的说明，按照这样的逻辑是不是说另外的构造函数有验证呢..... (示例中的默认的构造函数都没有说呀)

[这里有java.net.URL 的源码](http://www.docjar.com/html/api/java/net/URL.java.html)，看兴趣的同学可以看看。

恩，以上就是结论了。

不过，反正我自己感觉目前Java API 关于这里的设计不太合理，欢迎大家讨论。

[我在SO提问的这个回答](https://stackoverflow.com/questions/44226003/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-conta?answertab=active#tab-top)比较有意思，哈哈。

>The review is somewhat terse, but the reviewer's point is the URL constructor is behaving in accordance with its specification. Since the specification explicitly states that no validation is performed, this is not a bug in the code. This is indisputable.

>What he didn't spell out is that fixing this inconsistency (by changing the URL class specification) would break lots of peoples' 20+ year old code Java code. That would be a really bad idea. It can't happen.

>So ... this inconsistency is a "feature".



> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

