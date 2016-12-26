---
id: 2343
title: Mac/Windows Wireshark/tcpdump抓包TCP 3次握手,4次挥手实例
date: 2014-03-11T21:15:15+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2343
duoshuo_thread_id:
  - 1351844048792453499
categories:
  - 'Linux'
  - SoftwareEngineering
  - Windows
tags:
  - TCP/IP
  - 计算机网络
---
Mac OS系统10.9.1，安装[Wireshark](http://www.wireshark.org/download.html)，后不能跑，提示安装X11，到这里安装[XQuartz](http://xquartz.macosforge.org/landing/)即可。

TIPS：安装XQuartz 后，重新启动Wireshark，让选择X11，这是去选/Applications/Utilities/XQuartz.app（默认位置），启动得比较久，得有点耐心，若不懂可参考这里[installing wireshark on mac osx10.8 mountainlion](http://blog.israeltorres.org/home/write-ups/installingwiresharkonmacosx108mountainlion) 和 [cannot run wireshark in mac os x moutain-loin](http://ask.wireshark.org/questions/12140/cant-run-wireshark-in-mac-os-x-mountain-lion).

然后抓包～跟windows一样了。下图是访问[tanglei.me](http://tanglei.me/)抓包，用的github pages搭建的博客，访问IP是192.30.252.153(or 154)，看到这个IP，为了看得更清楚，可以利用下Filter。Wireshark功能很强大的说。

[<img title="Image" src="/wp-content/uploads/2014/03/Image_thumb.png" alt="Image"  />](/wp-content/uploads/2014/03/Image.png)

如下图是建立连接时的3次握手～其中,SYN=Synchronize Sequence Numbers, ACK=Acknowledgement Number

[<img title="Image(1)" src="/wp-content/uploads/2014/03/Image1_thumb.png" alt="Image(1)"  />](/wp-content/uploads/2014/03/Image1.png)

  1. Client(本机192.168.1.100)发起TCP请求, 发送序号为x(=0)的SYN包;  ——SYN(x)
  2. Server(Github 192.30.252.153)收到连接请求，给出响应ACK(x+1=1),同时携带一个序号Seq,y(=0);  —— SYN(y)+ACK(x+1)
  3. Client(本机192.168.1.100)对响应做出回复，返回Ack(y+1=1),同时自己序号自增Seq＝1;  ——ACK(y+1)

文后画了下3次/4次握手的示意图。

3次握手完成，TCP连接建立起来了～随后就直接通信，上图可以看到Client就直接去Get请求了(注意http是应用层的协议，底层传输还是走TCP哦~). 安全的连接就是这样建立起来滴，通过检验序号是否合法，Client端/Server端分别做出相应的机制，比如自己序号y包发出去了，没有收到y+1的响应，对方可能没有收到，然后可能一定时间后 ，会重发这个y包～

再来看看断开连接的4次握手(挥手)。

[<img title="Image(3)" src="/wp-content/uploads/2014/03/Image3_thumb.png" alt="Image(3)"  />](/wp-content/uploads/2014/03/Image3.png)

这里是Github作为Client主动发起关闭连接的请求，这里的FIN=FINish

  1. Github 发Fin(x=6831)包;  ——FIN(X)
  2. 本机收到上面的包后，做出ACK(x+1=6832)响应,跟Github说我收到了～，你别再发了;  ——ACK(X+1)
  3. 你要关了，那我也准备关吧～ 于是发Fin(y=1054)包,你准备好了么？;  ——FIN(Y)
  4. Github准备好了，给出响应ACK(y+1=1055)，告诉本机准备好了;  ——ACK(Y+1)

双方确认都要关闭了，然后断开TCP连接。

此过程用tcpdump也是可以清晰的看到滴~下面以windows情况为例,windows上的**tcpdump**叫**windump**,用法跟tcpdump一样~详细的可以[查看下其文档](http://www.tcpdump.org/manpages/tcpdump.1.html)

本机IP打下码~ 如下166.111.X.X是本机IP.查看同样的例子~

TIPS：用tcpdump/windump时注意选指定的网卡，若安装虚拟机等可能默认的选不到正确的那块，就抓不到包。(windump -D 查看网卡) 下面命令是-i 2 (选择监控第2块网卡)， -n (不转换名字，以实际IP地址显示结果), -S (大写的S，打印绝对的序号号，如果没有这个选项的话，非SYN包如ack就是相对的，不方便查看，如果没有这个选项下面第3行ack可能就是1)， host通信的地址为192.30.252.153，后面的就不用解释了分别是tcp协议，80端口，然后结果输出到文件。

另外，不同的浏览器可能会对你访问页面发起多次请求，为了更好的看结果，你得注意看某一个端口，如下是与57245端口的请求。实际过程中可能还有其他端口的请求，下面的例子把其他端口的请求给去掉了滴。

```cpp
C:\Users\tanglei>windump -i 2 -n -S host 192.30.252.153 and tcp port 80>tcpdump.log
windump: listening on \Device\NPF_{84E79A70-5025-44D2-AB45-24F3203D00D6}
16:17:58.813323 IP 166.111.X.X.57245 > 192.30.252.153.80: S 1337949936:1337949936(0) win 65535 
16:17:59.103384 IP 192.30.252.153.80 > 166.111.X.X.57245: S 3859825850:3859825850(0) ack 1337949937 win 14360 
16:17:59.103465 IP 166.111.X.X.57245 > 192.30.252.153.80: . ack 3859825851 win 1024
16:17:59.103634 IP 166.111.X.X.57245 > 192.30.252.153.80: P 1337949937:1337950298(361) ack 3859825851 win 1024
16:17:59.393901 IP 192.30.252.153.80 > 166.111.X.X.57245: P 3859825851:3859826074(223) ack 1337950298 win 16
16:17:59.444259 IP 166.111.X.X.57245 > 192.30.252.153.80: . ack 3859826074 win 1023
16:18:09.393241 IP 192.30.252.153.80 > 166.111.X.X.57245: F 3859826074:3859826074(0) ack 1337950298 win 16
16:18:09.393290 IP 166.111.X.X.57245 > 192.30.252.153.80: . ack 3859826075 win 1023
16:18:32.768012 IP 166.111.X.X.57245 > 192.30.252.153.80: F 1337950298:1337950298(0) ack 3859826075 win 1023
16:18:33.057948 IP 192.30.252.153.80 > 166.111.X.X.57245: . ack 1337950299 win 16
```

前面3行，正是连tanglei.me时发起的TCP请求的3次握手，末尾4行是要断开的4次握手(挥手).</span>
  
下面的解释用C代表最先主动发起请求的1方，S代表接受到请求的方.

  * 第1行：(C —>S) SYN包，序号1337949936
  * 第2行：(S —>C) SYN+ACK，ACK为1337949936+1=1337949937，序号为3859825850
  * 第3行：(C —>S) ACK，ACK为3859825850+1=3859825851

再看末尾四行的4次握手。

  * 末4行：(C —>S) FIN包，序号3859826074
  * 末3行：(S —>C) ACK包，序号3859826074+1=3859826075
  * 末2行：(S —>C) FIN包，序号1337950298
  * 末1行：(C —>S) ACK包，序号1337950298+1=1337950299

画个图描述下3/4次握手是什么样的.

[<img title="image" src="/wp-content/uploads/2014/03/image.png" alt="image"  />](/wp-content/uploads/2014/03/image.png)

以前计算机网络课还详细学了下TCP/UDP的协议，这些数据包是怎么组织放在某个位之类的，时间久了都忘了啊～
