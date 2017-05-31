---
title: a "bug" in java.net.URL?
layout: post
categories: 
  - 经验技巧
tags: 
  - Java
  - Bug
---

这其实是去年就踩的一个坑了, 之前又踩到一个类似的, 于是想起在这里来分享一下. 背景是这样的: 

我们的项目依赖于一个外部服务, 该外部服务提供 REST 接口供我方调用, 本地测试和测试环境都没有问题, 但是一上生产环境就发现网络不通. (本地测试/测试环境, 生产环境网络通过不通的域名访问该外部服务), 且在生产环境通过 `curl` 等命令能够正常调用对方接口. 最终排查原因出现在域名上, 在生产环境中通过 java 的 httpclient (该第三方包依赖`java.net.URI`) 调用未发出请求. 该域名形如  `http://test_1.tanglei.name` 

下面来重现一下该案例. 

## 重现步骤 

## server 端准备 

这里用 nginx 模拟了一下 上文提到的 REST 服务, 假设调用正常返回 `"Hello, World\n" `, nginx 配置如下: 

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


## client 

### curl 命令

`curl` 请求

```bash
[root@VM_77_245_centos vhost]# curl -i "http://test_1.tanglei.name/testurl"
HTTP/1.1 200 OK
Server: nginx
Date: Wed, 31 May 2017 09:53:01 GMT
Content-Type: application/octet-stream
Content-Length: 13
Connection: keep-alive
Content-Type: text/plain; charset=utf-8

Hello, World
[root@VM_77_245_centos vhost]#
```

请忽略上面的两个重复的header(nginx 默认有一个header, 上面的配置又加了一个), 可以点击这里查看效果 [http://test_1.tanglei.name/testurl](http://test_1.tanglei.name/testurl). （对，我解析了这个域名）

### python requests

python 也是调用OK

```python
>>> import requests
>>> r = requests.get("http://test_1.tanglei.name/testurl")
>>> r.text
u'Hello, World\n'
```

### java

我们来看一下通过 Java 调用. 

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

上面的这个方法 `String getContent(java.net.URL url)` 传入一个构造好的 `java.net.URL` 然后 get 请求, 并以 `String` 方式返回 response.

```java
String srcUrl = "http://test_1.tanglei.name/testurl";
java.net.URL url = new java.net.URL(srcUrl);
System.out.println("\nurl result:\n" + getContent(url)); // OK
```

上面的语句输出正常, 结果如下 

```
url result:
Hello, World
```

换 `java.net.URI` 试试? (这里不展开讲URL和URI的区别联系了, 可以简单的认为URL是URI的一个子集, 详细的可参考 [URI、URL 和 URN](https://www.ibm.com/developerworks/cn/xml/x-urlni.html), [wiki URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier))
直接通过`java.net.URI`构造, 再调用 `URI.toURL` 得到URL，调用同样正常。关键的来了

```java
URI(String scheme, String host, String path, String fragment)
Constructs a hierarchical URI from the given components.
```

我用这个方法构造`URI`, 会构造失败(详细异常信息见文末)。 

```java
new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null) error: protocol = http host = null
new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null) error: Illegal character in hostname at index 11: http://test_1.tanglei.name/testurl
```


所以问题发现了, 我们的项目中依赖的第三方httpclient包底层用到了 `java.net.URI`, 恰好在 `java.net.URI` 中是不允许以下划线(`_`)作为 `hostname` 字段的。 即这个表达式 `uri.getHost() == uri.toURL().getHost() ` 不一定成立。这是 JDK 的 Bug 吗？

从官网上还真找到了关于包含下划线作为hostname的bug提交ticket, 戳这里 [JDK-8132508 : Bug JDK-8029354 reproduces with underscore in hostname](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=8132508) ， 然后发现该 "bug" reporter 的情况貌似跟我的差不多，只不过引爆bug的点不一样. 

该 "bug" reviewer 最后以 "Not an Issue" 关闭，给出的理由是

>RFC 952 disallows _ underscores in hostnames. So, this is not a bug. 

确实, [rfc952](https://tools.ietf.org/html/rfc952) 明确说了域名只能由 字母 `(A-Z)`, 数字` (0-9)`, 减号 `(-)`, 和 点 `(.)` 组成。

那 OK 吧, 既然明确规定了 hostname 不能包含下划线, 为啥 `java.net.URL` 确允许呢? 造成 `java.net.URI` 和 `java.net.URL` 在处理 hostname 时的标准不一致, 且本身 `java.net.URI` 在构造的时候也带了 "有色"眼镜, 通过静态方法 `java.net.URI.create(String)` 或者通过带1个参数的构造方法 `java.net.URI(String)` 都能成功构造出 URI 的实例，通过带4个参数的构造方法就不能构造了. (同一个url字符串). 

要知道, 在 coding 过程中，**尽早**反馈异常信息更有利于软件开发持续迭代的过程. 我们在开发过程中也应该遵循这一点原则。 

我记得去年我就到JDK官网提交了一个 bug, 大意是说 `java.net.URI` 和 `java.net.URL` 在处理hostname的时候标准不一致, 容易使开发人员埋藏一些潜在的bug. 不过当初提交之后就没有反应了。 (为啥没有收到相应的邮件通知 report 状态? 也bug了?)

直到前两天, 又把该问题提交到 [stackoverflow](https://stackoverflow.com/questions/44226003/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-conta).

>I am wondering, if hostname with underscore is not valid, why the result is differrent between java.net.URI and java.net.URL? Is it a bug or a feature? Here is the example.
>
```
java.net.URL url = new java.net.URL("http://test_1.tanglei.name");
System.out.println(url.getHost()); //test_1.tanglei.name
java.net.URI uri = new java.net.URI("http://test_1.tanglei.name");
System.out.println(uri.getHost()); //null   
```

过了1天才发现原来我去年提交的bug有更新状态了. bug 详细信息见 [JDK-8170265 : underscore is allowed in java.net.URL while not in java.net.URI](http://bugs.java.com/bugdatabase/view_bug.do?bug_id=8170265), ([openjdk JDK-8170265](https://bugs.openjdk.java.net/browse/JDK-8170265) 更详细）。 然而该 bug 状态也以 "Not an Issue" 告终. 
不过其中一个reviewer还是承认了这个问题, 说的是 `java.net.URL` 遵循的是 `RFC 2396` 规范, 确实不允许含有下划线的hostname，`java.net.URI` 做到了， 而 `java.net.URL` 没有做到。

> As per RFC 2396:
"Hostnames take the form described in Section 3 of [RFC1034] and
   Section 2.1 of [RFC1123]: a sequence of domain labels separated by
   ".", each domain label starting and ending with an alphanumeric
   character and possibly also containing "-" characters.  The rightmost
   domain label of a fully qualified domain name will never start with a
   digit, thus syntactically distinguishing domain names from IPv4
   addresses, and may be followed by a single "." if it is necessary to
   distinguish between the complete domain name and any local domain.
   To actually be "Uniform" as a resource locator, a URL hostname should
   be a fully qualified domain name.  In practice, however, the host
   component may be a local domain literal."

>URI class is following the above, but URL class doesn't seem to follow the same rules.

>To reproduce the issue , run the attached test case.
Following is the output on various JDK versions:
JDK 8 - Fail
JDK 8u112 - Fail
JDK 8u122-ea - Fail
JDK 9-ea + 141 - Fail

重点来了, 然后, 被上一级 reviewer 直接个毙了. 原因是 `java.net.URL` 构造方法中，api文档中说了本来也不会做验证即 `No validation of the inputs is performed by this constructor.` [在线 api doc 戳这里](https://docs.oracle.com/javase/8/docs/api/java/net/URL.html) (可以点连接，进去搜索关键字 "No validation")

>The constructors of URL class (e.g., http://download.java.net/java/jdk9/docs/api/java/net/URL.html#URL-java.lang.String-java.lang.String-java.lang.String-) specifically mention about the validation: 

>"No validation of the inputs is performed by this constructor." 

>So not throwing an exception isn't an issue here.
 
![](/resources/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-contains-underscore/nonsense.jpg)

其实就算 "No validation of the inputs is performed by this constructor." 是合理的, 里面也只有3个构造函数有这样的说明，按照这样的逻辑是不是说另外的构造函数有验证呢..... (示例中的默认的构造函数都没有说呀)

[这里有java.net.URL 的源码](http://www.docjar.com/html/api/java/net/URL.java.html), 看兴趣的同学可以看看.  

恩，以上就是结论了。
不过，反正我自己感觉目前Java API 关于这里的设计不太合理, 欢迎大家讨论。

附上本文示例代码 

```java
public class TestURL {
    static void conflicts() throws Exception {
        java.net.URL url = new java.net.URL("http://test_1.tanglei.name/testurl");
        System.out.println(url.getHost()); //test_1.tanglei.name
        System.out.println(url.getProtocol()); //http
        System.out.println(url.getPath()); // /testurl
        java.net.URI uri = new java.net.URI("http://test_1.tanglei.name/testurl");
        System.err.println("uri.getHost() == uri.toURL().getHost() is: " + (uri.getHost() == uri.toURL().getHost()));
        System.out.println(uri.getHost()); //null    
    }

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

    public static void main(String[] args) throws Exception {
        conflicts();
        String srcUrl = "http://test_1.tanglei.name/testurl";
        java.net.URL url = new java.net.URL(srcUrl);
        System.out.println("\nurl result:\n" + getContent(url)); // OK
        System.out.println("\nurl.toURI.toURL result: \n" + getContent(url.toURI().toURL())); // OK
        java.net.URI uri = new java.net.URI(srcUrl);
        System.out.println("\nuri.toURL result: \n" + getContent(uri.toURL())); // OK
        java.net.URI uri2 = null;
        try {
            uri2 = new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null); //throw Exception: java.lang.IllegalArgumentException: protocol = http host = null
            System.out.println("\nuri2.toURL result:\n" + getContent(uri2.toURL())); 
        } catch (Exception ex) {
            System.err.println("new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null) error: " + ex.getMessage());
            ex.printStackTrace();
        }

        try {
            uri2 = new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null); //throw Exception: java.lang.IllegalArgumentException: protocol = http host = null
            System.out.println("\nuri2.toURL result:\n" + getContent(uri2.toURL())); 
        } catch (Exception ex) {
            System.err.println("new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null) error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
```

输出

```java
test_1.tanglei.name
http
/testurl
uri.getHost() == uri.toURL().getHost() is: false
null

url result:
Hello, World


url.toURI.toURL result:
Hello, World


uri.toURL result:
Hello, World

new java.net.URI(uri.getScheme(), uri.getHost(), uri.getPath(), null) error: protocol = http host = null
java.lang.IllegalArgumentException: protocol = http host = null
	at sun.net.spi.DefaultProxySelector.select(DefaultProxySelector.java:176)
	at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1097)
	at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:997)
	at sun.net.www.protocol.http.HttpURLConnection.connect(HttpURLConnection.java:931)
	at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1511)
	at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1439)
	at TestURL.getContent(TestURL.java:14)
	at TestURL.main(TestURL.java:38)
new java.net.URI(url.getProtocol(), url.getHost(), url.getPath(), null) error: Illegal character in hostname at index 11: http://test_1.tanglei.name/testurl
java.net.URISyntaxException: Illegal character in hostname at index 11: http://test_1.tanglei.name/testurl
	at java.net.URI$Parser.fail(URI.java:2848)
	at java.net.URI$Parser.parseHostname(URI.java:3387)
	at java.net.URI$Parser.parseServer(URI.java:3236)
	at java.net.URI$Parser.parseAuthority(URI.java:3155)
	at java.net.URI$Parser.parseHierarchical(URI.java:3097)
	at java.net.URI$Parser.parse(URI.java:3053)
	at java.net.URI.<init>(URI.java:673)
	at java.net.URI.<init>(URI.java:774)
	at TestURL.main(TestURL.java:45)
```

[点这里下载本文示例代码](/resources/conflicts-between-java-net-url-and-java-net-uri-when-dealing-with-hostname-contains-underscore/TestURL.java)
