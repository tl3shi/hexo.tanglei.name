---
title: 性能测试工具 - ab 简单应用
layout: post
categories: 
  - 经验技巧
tags: 
  - 工具
  - Shell
  - 软件测试
---

之前知道一般网站性能可以通过 LoadRunner, JMeter, QTP 等相应的软件进行测试, 印象中本科学习 "软件测试" 这门课程时安装并使用过, LoadRunner等不是一个小软件, 安装不是那么的容易.  

最近发现Apache还有一款小巧玲珑的工具可以直接用来做压力测试, 相关文档可以参见 Apache [ab 官网](https://httpd.apache.org/docs/2.4/programs/ab.html). 

Mac 下自带(具体记不清是因为我安装了Apache还是系统自带的了)了这个 `ab` 工具(Apache HTTP server benchmarking tool), ab 我猜应该就是 `Apache Benchmarking` 的缩写吧? 


## ab 用法

ab 命令参数如下, 

```
ab  [ -A auth-username:password ] [ -b windowsize ] [ -B local-address ] [ -c concurrency ] [ -C cookie-name=value
] [ -d ] [ -e csv-file ] [ -f protocol ] [ -g gnuplot-file ] [ -h ] [ -H custom-header ] [ -i ] [ -k ] [ -l ] [ -m
HTTP-method  ] [ -n requests ] [ -p POST-file ] [ -P proxy-auth-username:password ] [ -q ] [ -r ] [ -s timeout ] [
-S ] [ -t timelimit ] [ -T content-type ] [ -u PUT-file ] [ -v verbosity] [ -V ] [ -w ] [ -x <table>-attributes  ]
[  -X  proxy[:port]  ]  [  -y  <tr>-attributes  ]  [  -z  <td>-attributes  ]  [ -Z ciphersuite ] [http[s]://]host-
name[:port]/path
```

不过常用的, 也就是, `-n ` 跟请求数, `-c` 跟并发数. 

```
-n requests     Number of requests to perform
-c concurrency  Number of multiple requests to make at a time
```

在对网站进行测试的时候, 可能需要登录态进行测试, 可以通过 `-C ` 加 Cookie的方式进行测试, 测试之前, 最好确认这个命令用法是否正确, 只用1个请求看看响应的长度是否一致(可以通过 与 `curl` 命令的结果进行对比). 

例如, 通过 `ab -c 1 -n 1 -C 'cookiedata=xxx' "http://shangtongdai.yxapp.xyz/loans" ` 得到的 `Document Length:        53218 bytes` 和用 `curl -b 'cookiedata=xxx' "http://shangtongdai.yxapp.xyz/loans"` 得到的`Content-Length: 53218` 一致.

然后进行完整的测试, 可以得到详细的结果报告. 

```
# 200并发，一共10000请求

ab -c 200 -n 10000 -C 'cookiedata=xxx' "http://shangtongdai.yxapp.xyz/loans"

# 结果
This is ApacheBench, Version 2.3 <$Revision: 1663405 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking shangtongdai.yxapp.xyz (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        Tengine/2.1.1
Server Hostname:        shangtongdai.yxapp.xyz
Server Port:            80

Document Path:          /loans
Document Length:        53218 bytes

Concurrency Level:      200
Time taken for tests:   53.098 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      534570000 bytes
HTML transferred:       532180000 bytes
Requests per second:    188.33 [#/sec] (mean)
Time per request:       1061.967 [ms] (mean)
Time per request:       5.310 [ms] (mean, across all concurrent requests)
Transfer rate:          9831.59 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.8      1      39
Processing:    38 1055 344.1   1046    2964
Waiting:       37 1051 345.5   1043    2959
Total:         39 1056 344.4   1047    2969

Percentage of the requests served within a certain time (ms)
  50%   1047
  66%   1170
  75%   1252
  80%   1311
  90%   1477
  95%   1657
  98%   1860
  99%   1986
 100%   2969 (longest request)
```

## ab post "bug"

在某个场景下, 我需要对其中一个post的接口进行测试. 
根据 ab 的 mannual 看到 post 时候, 需要将post的data用文件保存, 然后通过参数 `-p postdata.file` 传输. 

但在实际ab进行测试时, 发现返回的结果异常, 正常情况下 response 的size比通过ab返回的response size大得多, 说明通过ab发送的http请求失败了. 

经过tcpdump抓包最后发现 `ab` 请求无效的原因是: postdata 文件会多一个字符(文件末尾的换行符), 导致server端的 form 解析失败, 因而返回异常的response. 

这个坑是vim的默认配置导致的, vim默认会在文件末尾添加一个文件结束符, vim 默认配置 `'endofline' 'eol'       boolean (default on)` , 可以通过 `set noendofline` 解决. 

实际过程中，(去掉文件末尾的换行符可以解决), 或者将postdata多添加一个参数可以解决(这个参数server端没有用到时多余的, form可以正常解析, 因此 response 正常了).  
 
 
下面来重现一下这个过程, 拿百度为例吧. 

```
➜  com~apple~CloudDocs$ cat postdata.txt
a=65&b=66
```

用 curl 执行, `curl -i -H "Content-Type: application/x-www-form-urlencoded" -d "a=65&b=66" "http://www.baidu.com"`. 

用 ab 执行,  `ab -c 1 -n 1 -T 'application/x-www-form-urlencoded;' -p postdata.txt 'http://www.baidu.com/'`

抓包得到以下结果

```
➜  ~ sudo tcpdump -X host www.baidu.com
Password:
tcpdump: data link type PKTAP
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on pktap, link-type PKTAP (Packet Tap), capture size 262144 bytes
...
21:15:56.572716 IP tanglei.64239 > 119.75.217.109.http: Flags [P.], seq 1:163, ack 1, win 8192, length 162: HTTP: POST / HTTP/1.0
	0x0000:  8482 f428 5e08 4c8d 79f2 7bbe 0800 4500  ...(^.L.y.{...E.
	0x0010:  00ca a995 4000 4006 40e9 c0a8 3e4e 774b  ....@.@.@...>NwK
	0x0020:  d96d faef 0050 8ce1 d0f2 cce7 21ec 5018  .m...P......!.P.
	0x0030:  2000 8a6e 0000 504f 5354 202f 2048 5454  ...n..POST./.HTT
	0x0040:  502f 312e 300d 0a43 6f6e 7465 6e74 2d6c  P/1.0..Content-l
	0x0050:  656e 6774 683a 2031 300d 0a43 6f6e 7465  ength:.10..Conte
	0x0060:  6e74 2d74 7970 653a 2061 7070 6c69 6361  nt-type:.applica
	0x0070:  7469 6f6e 2f78 2d77 7777 2d66 6f72 6d2d  tion/x-www-form-
	0x0080:  7572 6c65 6e63 6f64 6564 3b0d 0a48 6f73  urlencoded;..Hos
	0x0090:  743a 2077 7777 2e62 6169 6475 2e63 6f6d  t:.www.baidu.com
	0x00a0:  0d0a 5573 6572 2d41 6765 6e74 3a20 4170  ..User-Agent:.Ap
	0x00b0:  6163 6865 4265 6e63 682f 322e 330d 0a41  acheBench/2.3..A
	0x00c0:  6363 6570 743a 202a 2f2a 0d0a 0d0a 613d  ccept:.*/*....a=
	0x00d0:  3635 2662 3d36 360a                      65&b=66.
21:15:56.578006 IP 119.75.217.109.http > tanglei.64239: Flags [.], ack 163, win 808, length 0
...
```

用 curl 执行并抓包的结果是: 

```
...
21:34:44.106605 IP tanglei.65237 > 119.75.218.70.http: Flags [P.], seq 1:156, ack 1, win 8192, length 155: HTTP: POST / HTTP/1.1
	0x0000:  8482 f428 5e08 4c8d 79f2 7bbe 0800 4500  ...(^.L.y.{...E.
	0x0010:  00c3 070c 4000 4006 e2a0 c0a8 3e4e 774b  ....@.@.....>NwK
	0x0020:  da46 fed5 0050 ca8a 2f16 4294 caba 5018  .F...P../.B...P.
	0x0030:  2000 5c61 0000 504f 5354 202f 2048 5454  ..\a..POST./.HTT
	0x0040:  502f 312e 310d 0a48 6f73 743a 2077 7777  P/1.1..Host:.www
	0x0050:  2e62 6169 6475 2e63 6f6d 0d0a 5573 6572  .baidu.com..User
	0x0060:  2d41 6765 6e74 3a20 6375 726c 2f37 2e34  -Agent:.curl/7.4
	0x0070:  332e 300d 0a41 6363 6570 743a 202a 2f2a  3.0..Accept:.*/*
	0x0080:  0d0a 436f 6e74 656e 742d 5479 7065 3a20  ..Content-Type:.
	0x0090:  6170 706c 6963 6174 696f 6e2f 782d 7777  application/x-ww
	0x00a0:  772d 666f 726d 2d75 726c 656e 636f 6465  w-form-urlencode
	0x00b0:  640d 0a43 6f6e 7465 6e74 2d4c 656e 6774  d..Content-Lengt
	0x00c0:  683a 2039 0d0a 0d0a 613d 3635 2662 3d36  h:.9....a=65&b=6
	0x00d0:  36                                       6
21:34:44.112972 IP 119.75.218.70.http > tanglei.65237: Flags [.], ack 156, win 808, length 0
...
```

发现HTTP协议版本号不同, UA不同, Content-Length不同. 
刚开始还以为是ab的bug, 最后发现确实是 `Content-Length` 相差1, 而多的这个字符换行符导致了 server 段的 form 填充失败(上例中体现不了, 反正post百度无效的请求). 

```
➜  com~apple~CloudDocs$ wc -c postdata.txt
      10 postdata.txt
➜  com~apple~CloudDocs$ ll postdata.txt
-rw-r--r--@ 1 tanglei  staff    10B  4 11 21:26 postdata.txt
➜  com~apple~CloudDocs$ cat postdata1.txt
a=65&b=66%                                                                                                                             ➜  com~apple~CloudDocs$ wc -c postdata1.txt
       9 postdata1.txt
➜  com~apple~CloudDocs$ ll postdata1.txt
-rw-r--r--@ 1 tanglei  staff     9B  4 11 21:26 postdata1.txt
```

最后去掉postdata文件末尾的结束符后, 得以成功. 