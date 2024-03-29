---
title: 磁盘又双叒叕满了~
layout: post
categories: 
  - 除臭虫
tags: 
  - 经验技巧
  - Linux
---

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247497629&amp;idx=1&amp;sn=d293f09e031d8eac89092ae4be91e05a&amp;chksm=eb44f679dc337f6f67582611c140ef00a5971a71da458d503fd54d8a0ae836f14c81f559373c&token=1503745258&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

大家好，我是石头哥。 

题目你可能读不全（没事，俺也一样），特此补充拼音！

```
yòu shuāng ruò zhuó
又双叒叕
```

最近有读者遇到本文提到的坑，来询问我为什么。我看了下，确实是非常经典的坑，我在刚毕业那会也遇到过，之前文章也分享过，这次重新整理下，再分享给大家。

![difference-between-du-and-ls](http://www.tanglei.name/resources/difference-between-du-and-ls/du-ls.jpg)

知道为什么会有上面的结果吗？什么又是稀疏文件？这篇文章将为你揭秘。

可以评论区说说，你有遇到过这个坑吗？ 

## 磁盘满告警

某天收到的自动告警短信或者邮件告诉我某机器上的磁盘满了，赶紧登录机器查看。

> 其实，这都应该定时巡检自动化处理的。

第一次出现该问题时， 我的处理方式是: 先删了 `/tmp/` 目录， 空闲出部分空间， 然后检查下几个常用的用户目录。

最终发现某服务A的日志文件（`contentutil.log`）占用了好几个十个大G，询问相关开发人员后确定该日志文件不需要压缩备份， 可直接删除，于是 `rm contentutil.log` 之后就天真地认为万事大吉了...

**rm 文件后，磁盘空间就释放了吗？**

## 磁盘满告警，又来了

然而，大约xx天后，发现该机器磁盘又满了，惊呼奇怪咋这么快又满了。

最终发现是上次 `rm contentutil.log` 后， 占用好几十大G的 `contentutil.log` 一直被服务A的进程打开了，`rm` 后空间并没有释放。

`rm` 其实是删除该文件名到文件真正保存到磁盘位置的链接，此时该文件句柄还被服务A打开，因此对应的磁盘空间并没有被系统回收。

其实可以理解为 GC 里面的引用计数， `rm` 只是减少了引用计数，并没有真正的进行释放，当引用计数为0的时候，OS 内核才会释放空间，供其他进程使用。

所以当A进程停止（文件句柄的引用计数会变为0）或者重启后，占用的存储空间才被释放（从某种程度上讲说明该服务一直很稳定， 可以连续跑很久不出故障~ 微笑脸）。

tip: 如果不知道具体进程或文件名的话：`lsof | grep deleted`，这样会查找所有被删除的但是文件句柄没有释放的文件和相应的进程，然后再kill掉进程或者重启进程即可。

后来，白老板告知可以用修改文件内容的方式在不用重启进程的情况下释放空间。

下面这个技巧，划重点：

>echo "" > filename.log

## du vs ls

前两天该问题又出现了，该服务A的日志文件（contentutil.log）占用了约7.6G。

>应该对服务日志做 log rotate。

这一次学聪明了，直接用`echo 'hello' > contentutil.log`， 然后 `df` 确认磁盘空间确实已经释放，心想着这次可以 Happy 了，突然手贱执行了下 `ls` 和 `du`， 有了以下结果: 

```bash
[root@xxx shangtongdai-content-util]# ls -lah contentutil.log
-rw-r--r--. 1 root root 7.6G Nov  7 19:36 contentutil.log
[root@xxx shangtongdai-content-util]# du -h contentutil.log
2.3M    contentutil.log
```

反正我看到这样的结果是百思不得其解， 如果你已经明确为什么会产生这样的结果呢？

可以明确的是， 这里的 `ls` 和 `du` 结果肯定代表不同的含义，在查阅相关资料和咨询强大的票圈后了解到， 这大概与文件空洞和稀疏文件（holes in 'sparse' files）相关. 

`ls` 的结果是 apparent sizes， 我的理解是文件长度，就类似文件系统中 file 这个数据结构中的定义文件长度的这个字段；

`du` 的结果 disk usage，即真正占用存储空间的大小，且默认度量单位是 block。

>apparent sizes 和 disk usage 说法摘自 `man du` 中的 `--apparent-size` 部分。

给出一个具体的示例: 

```bash
// Mac OS 10.11.6 (15G1004)
➜  _drafts git:(source) ✗ echo -n a >1B.log
➜  _drafts git:(source) ✗ ls -las 1B.log
8 -rw-r--r--  1 tanglei  staff  1 11  9 00:06 1B.log
➜  _drafts git:(source) ✗ du 1B.log
8	1B.log
➜  _drafts git:(source) ✗ du -h 1B.log
4.0K	1B.log
```

上面示例中， 文件 1B.log 内容仅仅包含一个字母"a"， 文件长度为1个字节， 前面的 8 为占用的存储空间 8 个 block， （ls -s 的结果跟 du 的结果等价， 都是实际占用磁盘的空间）。

为什么1个字节的文件需要占用8个 block 呢， 可以这样理解， *block* 为磁盘存储的基本的单位，方便磁盘寻址等（这里说的基本单位应该是磁盘物理结构单位例如一个扇区/柱面等，对应一个物理单位）。

而此处的block可以理解为一个逻辑单位， 且一个文件除了包括数据外， 还需要存储描述此文件的其他信息， 因此包含1个字节的文件实际在磁盘中占用的存储空间不止1个字节。

这里借用最近超火的一篇文章的图示来解释：
>不得不说，这篇 “0.2 秒居然复制了100G文件？” 文章这动图画得真好，火是有原因的。不过，遗憾（讽刺）的是最开始的原文竟然找不到了，（后补充：源自奇伢云存储，链接见评论），各个文章转载的时候，都没注原文。

![磁盘文件管理基本单位-block](https://inews.gtimg.com/newsapp_match/0/14048391133/0)

然后读写的时候，都用另外一个结构来存储对应的 block 信息。 

![文件系统inode 和 block 区](https://inews.gtimg.com/newsapp_match/0/14048391864/0)

默认情况下， Mac中1个逻辑 block 中是 512 字节， 因此 `du -h` 结果是 `8 * 512 = 4096 = 4.0K`.  

>If the environment variable BLOCKSIZE is set， and the -k option is not specified， the block counts will be displayed in units of that size block.  If BLOCKSIZE is not set， and the -k option is not specified， the block counts will be displayed in 512-byte blocks. (`man du`)

因此， 通常情况下， `ls` 的结果应该比 `du` 的结果更小（都指用默认的参数执行， 调整参数可使其表达含义相同）， 然而上面跑服务 A 的机器上 contentutil.log 的对比结果是 `7.6G vs. 2.3M`， 仍然无法理解了。

## 稀疏文件

沿着 [man du](https://linux.die.net/man/1/du) 可以看到: 

>although the apparent size is usually smaller， it may be larger due to holes in ('sparse') files， internal fragmentation， indirect blocks， and the like

即因contentutil.log是一个稀疏文件， 虽然其文件长度很大， 到7.6G了， 然而其中包含大量的`holes`并不占用实际的存储空间。

下面用一个具体的例子来复现以上遇到的问题。注意以下例子为 Linux version 2.6.32 (Red Hat 4.4.7)中运行结果， 且在 Mac 中并不能复现（后文有指出为什么我的Mac不能复现）。

```bash
// 从标准输入中读取 count=0 个block， 输出到 sparse-file 中， 
// 一个 block 的大小为1k(bs=1k)， 输出时先将写指针移动到 seek 位置的地方
[root@localhost ~]# dd of=sparse-file bs=1k seek=5120 count=0
0+0 records in
0+0 records out
0 bytes (0 B) copied， 1.6329e-05 s， 0.0 kB/s
// 所以此时的文件长度为: 5M = 5120*1k(1024) = 5242880
[root@localhost ~]# ls -l sparse-file
-rw-r--r--. 1 root root 5242880 Nov  8 11:32 sparse-file
[root@localhost ~]# ls -ls sparse-file
0 -rw-r--r--. 1 root root 5242880 Nov  8 11:32 sparse-file
// 而 sparse-file 占用的存储空间为 0 个 block
[root@localhost ~]# du sparse-file
0	sparse-file
[root@localhost ~]# du -h sparse-file
0	sparse-file
```

此时若用 vim 打开该文件， 用二进制形式查看 （tip `:%!xxd` 可以更改当前文件显示为2进制形式）， 能看到里面的内容全是`0`. 或者直接用`od`命令查看2进制. 

```bash
// vim 二进制查看
0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
....
//od -b sparse-file
0000000   000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000
*
24000000
```

实际上， Sparse 文件是并不占用磁盘存储空间的， 那为什么能看到文件里面包含很多0? 因为当在读取稀疏文件的时候， 文件系统根据文件的 metadata（就是前面所指描述文件的这个数据结构）自动用`0`填充[ref Wiki]; 

Wiki上还说，现代的不少文件系统都支持 Sparse 文件， 包括 Unix 及其变种和 NTFS， 然而Apple File System(APFS)不支持， 因此我在我的 Mac 上用 `du` 查看占用空间与 `ls` 的结果一致。

```bash
// In Mac
➜  ~ dd of=sparse-file bs=1k seek=5120 count=0
0+0 records in
0+0 records out
0 bytes transferred in 0.000024 secs (0 bytes/sec)
➜  ~ ls -ls sparse-file
10240 -rw-r--r--  1 tanglei  staff  5242880 11  9 09:44 sparse-file
➜  ~ du sparse-file
10240	sparse-file
```

以上是用 `dd` 等命令创建稀疏文件， 也有同学用 c 代码实现了相同的功能。

其实就是写文件的时候， 改变下当前文件写指针，前面遇到的问题就应该类似。

```c
#include <stdio.h>
#include <fcntl.h>
#include <string.h>

int main() {
    int fd， result;
    char wbuf[] = "hello";

    if ((fd = open("./filetest.log"， O_RDWR|O_CREAT|O_EXCL， S_IRUSR|S_IWUSR))
)  {
            perror("open");
            return -1;
    }
    if ((result = write(fd， wbuf， strlen(wbuf)+1)) < 0) {
            perror("write");
            return -1;
    }
    if ((result = lseek(fd， 1024*1024*10， SEEK_END)) < 0) {
            perror("lseek");
            return -1;
    }
    if ((result = write(fd， wbuf， strlen(wbuf)+1)) < 0) {
            perror("write");
            return -1;
    }

    close(fd);
    return 0;
}
```

以上先将"hello"写入 filetest.log， 然后改变文件指针到`1024*1024*10`（相当于文件长度这个字段变大了）， gcc 编译后运行结果文件详情如下: 

```bash
[root@localhost ~]# ls -ls filetest.log
8 -rw-------. 1 root root 10485772 Nov  9 17:45 filetest.log
[root@localhost ~]# du  filetest.log
8	filetest.log
[root@localhost ~]# du -h filetest.log
8.0K	filetest.log
[root@localhost ~]# ls -lh filetest.log
-rw-------. 1 root root 11M Nov  9 17:45 filetest.log
[root@localhost ~]# od -c filetest.log
0000000   h   e   l   l   o  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000020  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
50000000  \0  \0  \0  \0  \0  \0   h   e   l   l   o  \0
50000014
```

解释下结果: 文件长度应该是 "hello" 加上 "\n" 共6个字节`*2 = 12`， 再加上`1024*1024*10`个字节， 即为`ls`产生的结果10485772个字节约11M。

而`du`的结果为8个block也为8k（这台机器上的block大小与前面的Mac不一样， 这里是1024）。

>Display values are in units of the first available SIZE from --block-size， and the DU_BLOCK_SIZE， BLOCK_SIZE and BLOCKSIZE environment variables.  Otherwise， units default to 1024 bytes (or 512 if POSIXLY_CORRECT is set. (`du --help`)

## 总结

总结一下: 出现以上问题说明自己对一些基础掌握得尚不牢固， 比如 

1. rm 某文件后， 文件占用的磁盘空间并不是立即释放，而是其句柄没有被任意一个进程引用时才回收；
2. ls/du 命令结果的具体含义；
3. 稀疏文件。

然而这些知识点都在《UNIX环境高级编程》这本书中有讲（之前走马观花看过不少， 咋对稀疏文件等一点印象都木有!），需要这本电子书的同学可后台联系我获取。

以上内容若有不清楚或不正确的地方，还望大家指出，感谢。

有收获请记得下方点赞、在看、分享，这对我很重要，感谢。 

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。