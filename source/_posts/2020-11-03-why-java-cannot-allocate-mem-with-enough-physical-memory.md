---
title: 内存充足，但是为什么 Java 总申请不到内存呢？
layout: post
categories:
  - 经验技巧
tags:
  - 程序员
  - 编程
  - Java
---


>本文作者：杨牧原（花名牧原），阿里云技术专家，多年操作系统和应用调试经验，理论功底深厚，实践经验丰富。目前专注Linux性能调优，容器集群和系统网络。
>
>本文经原作者授权发于公众号【程序猿石头】，原文基础上稍作措辞改动。[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247490048&idx=1&sn=868a6eed7b199023429c26f2a1b2abea&chksm=eb471be4dc3092f24c284dce9e76765d68ea9b4dc345c3bb45f2e29d5cc02da7136ebc7f68ad&token=60521723&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “**1024**” 获取程序员大厂面试指南。



## 背景

某次遇到一个客户尝试用 Java （其实跟具体用什么语言没关系）申请使用 4G 的内存申请，机器（ECS）总内存是 8G，free 的内存也超过 4G，按道理是 OK 的，但总是直接 OOM。

于是便找上门来说，“你们这玩意有问题啊？”

![img](/resources/why-java-cannot-allocate-mem-with-enough-physical-memory/bug.png)

内心 ：“bug 是不可能有的，一定是你的打开姿势不对”，恩，不行，本着“客户第一”的原则，还是要来帮客户解锁姿势的。

![img](/resources/why-java-cannot-allocate-mem-with-enough-physical-memory/nobug.png)

本文就详细记录了这个 case 的排查过程。


## 具体过程

![申请4g内存失败](/resources/why-java-cannot-allocate-mem-with-enough-physical-memory/1.png)

如上图所示，记录显示为申请 4G 内存失败（`4294967296 B / 1024 / 1024 = 4096 M`）。

### 是否是 `min_free_kbytes & nr_hugepage` 配置错误？

1. 第一反应是想起来之前的 `vm.min_free_kbytes & nr_hugepage` 导致的free大于available案例有关

`memfree` 统计的是所有内存的 `free` 内存，而 `memavailable` 统计的是可以拿来给程序用的内存，而客户设置了 `vm.min_free_kbytes（2.5G）`，这个内存在 `free` 统计，但是不在 `memavailable` 统计，`nr_hugepage` 也会有这个问题。

二者的统计方式不一样， 具体参考 [Documentation/filesystems/proc.txt](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773)

- MemFree: The sum of LowFree+HighFree
- MemAvailable: An estimate of how much memory is available for starting new applications, without swapping. Calculated from MemFree, SReclaimable, the size of the file LRU lists, and the low watermarks in each zone. The estimate takes into account that the system needs some page cache to function well, and that not all reclaimable slab will be reclaimable, due to items being in use. The impact of those factors will vary from system to system.

2. 跟客户要 `free -m && sysctl -p && /proc/meminfo` 等信息分析问题。

- `HugePages_Total` 为0，说明没有设置 `nr_hugepage`。
- `MemAvailable: 7418172 kB`， 说明这么多内存可用。

```bash
# sysctl -p
net.ipv4.ip_forward = 0
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 1
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
...
net.ipv4.tcp_tw_recycle=1
net.ipv4.tcp_max_syn_backlog=4096
net.core.netdev_max_backlog=10000
vm.overcommit_memory=2
...
```

```bash
#cat /proc/meminfo
MemTotal:        8009416 kB
MemFree:         7347684 kB
MemAvailable:    7418172 kB
Buffers:           18924 kB
Cached:           262836 kB
SwapCached:            0 kB
Active:           315188 kB
Inactive:         222364 kB
Active(anon):     256120 kB
Inactive(anon):      552 kB
Active(file):      59068 kB
Inactive(file):   221812 kB
....
HugePages_Total:       0  
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      114560 kB
DirectMap2M:     4079616 kB
DirectMap1G:     6291456 kB
```

### 尝试重现

3. 尝试自行测试使用`java`命令，去申请超出我的测试机物理内存，拿到报错。

实际上面的meminfo已经说明了问题，但是由于经验不足，一时没有看明白怎么回事。

下面测试证明正常申请内存不会有问题，超额的内存才会 OOM。

```bash
[root@test ~]# java -Xms4096M -version
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b08)
OpenJDK 64-Bit Server VM (build 25.242-b08, mixed mode)
[root@test ~]# java -Xms5000M -version
OpenJDK 64-Bit Server VM warning: INFO: os::commit_memory(0x0000000687800000, 3495428096, 0) failed; error='Cannot allocate memory' (errno=12)
......
```

系统信息如下：

```bash
---------------  S Y S T E M  ---------------
OS:CentOS Linux release 7.4.1708 (Core)
uname:Linux 3.10.0-693.2.2.el7.x86_64 #1 SMP Tue Sep 12 22:26:13 UTC 2017 x86_64
libc:glibc 2.17 NPTL 2.17
rlimit: STACK 8192k, CORE 0k, NPROC 15088, NOFILE 65535, AS infinity
load average:0.05 0.05 0.05
/proc/meminfo:
MemTotal:        3881692 kB
MemFree:         2567724 kB
MemAvailable:    2968640 kB
Buffers:           69016 kB
Cached:           536116 kB
SwapCached:            0 kB
Active:           355280 kB
Inactive:         326020 kB
...
VmallocTotal:   34359738367 kB
VmallocUsed:       14280 kB
VmallocChunk:   34359715580 kB
HardwareCorrupted:     0 kB
AnonHugePages:     30720 kB
HugePages_Total:     256
HugePages_Free:      256
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:       57216 kB
DirectMap2M:     3088384 kB
DirectMap1G:     3145728 kB
....
Memory: 4k page, physical 3881692k(2567600k free), swap 0k(0k free)
vm_info: OpenJDK 64-Bit Server VM (25.242-b08) for linux-amd64 JRE (1.8.0_242-b08), built on Jan 28 2020 14:28:22 by "mockbuild" with gcc 4.8.5 20150623 (Red Hat 4.8.5-39)
time: Thu Feb 20 15:13:30 2020
timezone: CST
elapsed time: 0 seconds (0d 0h 0m 0s)
```

### 重现失败，继续分析

4. `Java` 测试证明正常申请内存不会有问题，超额的内存才会 OOM，那么为什么超额呢，视线回归到 `sysctl -p` 有所发现。

`vm.overcommit_memory=2`

关于 `overcommit_memory` 设置项：

#### overcommit_memory=0

默认设置，当应用进程尝试申请内存时，内核会做一个检测。内核将检查是否有足够的可用内存供应用进程使用；

如果有足够的可用内存，内存申请允许；否则，内存申请失败，并把错误返回给应用进程。

举个例子，比如1G的机器，A进程已经使用了500M，当有另外进程尝试malloc 500M的内存时，内核就会进行check，发现超出剩余可用内存，就会提示失败。

#### overcommit_memory=1

对于内存的申请请求，内核不会做任何check，直到物理内存用完，触发 OOM 杀用户态进程。

同样是上面的例子，1G 的机器，A进程500M，B进程尝试 malloc 500M，会成功，但是一旦kernel发现内存使用率接近1个G(内核有策略)，就触发OOM，杀掉一些用户态的进程(有策略的杀)。

#### overcommit_memory=2

当请求申请的内存 >= SWAP内存大小 + 物理内存 * N，则拒绝此次内存申请。解释下这个N：N是一个百分比，根据`overcommit_ratio/100`来确定，比如`overcommit_ratio=50`（我的测试机默认50%），那么N就是50%。
`vm.overcommit_ratio` 只有当 `vm.overcommit_memory = 2` 的时候才会生效，内存可申请内存为 `SWAP内存大小 + 物理内存 * overcommit_ratio/100`。 

看看上面日志的 `overcommit` 信息： 

- CommitLimit:     4004708 kB  （小于客户申请的4096M）
- Committed_AS:    2061568 kB

具体而言： 
- CommitLimit：最大能分配的内存（测试下来在`vm.overcommit_memory=2`时候生效），具体的值是：SWAP内存大小（ecs均未开启） + 物理内存 * overcommit_ratio / 100；
- Committed_AS：当前已经分配的内存大小；


5，两相对照，说明客户设置的 `vm.overcommit_memory`在生效，建议改回 `0` 再试试。

- 用 `vm.overcommit_memory = 2` 测试，分配内存失败；

```
[root@test ~]# grep -i commit /proc/meminfo
CommitLimit:     1940844 kB
Committed_AS:     480352 kB
# java -Xms2048M -version 失败了
OpenJDK 64-Bit Server VM warning: INFO: os::commit_memory(0x0000000080000000, 1431830528, 0) failed; error='Cannot allocate memory' (errno=12)
#
# There is insufficient memory for the Java Runtime Environment to continue.
# Native memory allocation (mmap) failed to map 1431830528 bytes for committing reserved memory.
# An error report file with more information is saved as:
# /root/hs_err_pid1267.log
```

- 用如下配置，即可恢复： `vm.overcommit_memory = 0, vm.overcommit_ratio = 50` 

```
#vm.overcommit_memory = 0
#vm.overcommit_ratio = 50
[root@test ~]# java -Xms2048M -version
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b08)
OpenJDK 64-Bit Server VM (build 25.242-b08, mixed mode)
```

## 最后

可以看出，这其实跟具体的编程语言没有关系，用 Java 申请不到，用 c++/c 也一样。一个容易忽略的小知识点，你 get 到了吗？

![ECS运维指南之Linux系统诊断](/resources/architecture-evolution-of-HA-system-of-buy-facemask/ECS运维指南之Linux系统诊断.png)

本文节选自《ECS运维指南之Linux系统诊断》，《ECS运维指南之Linux系统诊断》是牧原呕心沥血之作，不仅内容精益求精，代码的编排作者也花了不少心思。你也可以直接登录阿里云开发者社区下载本书——[《ECS运维指南之Linux系统诊断》](https://developer.aliyun.com/article/763939)，或者直接在公众号后台回复关键字**“ecs”**获取本合集。

阿里云开发者社区有不少高质量技术文章，大家可以去观摩学习，有很多书籍都是可以直接免费下载的。 



> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

