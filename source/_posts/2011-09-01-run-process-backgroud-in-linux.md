---
id: 1145
title: Linux后台运行进程
date: 2011-09-01T21:45:47+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1145
duoshuo_thread_id:
  - 1351844048792453381
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Linux
  - 实习那些事儿
tags:
  - Linux
---
今天导师分了一个任务，让我算1000个QQ号的所有好友和可能认识的人的相册数量和照片数量，并把相册的封面信息等输出到文件，每个Q号一个文件。结果写出来了，跑了9个多小时了，还没跑完，因为想看到实时输出文件名数量等的状态，是前台运行的，要回家了，不能就一直前台嘛，于是查了下后台运行，且退出当前shell，进程不死，下面这篇文章是搜出来滴，转载了。注意，刚开始转后台进程时，我居然一个不小心按了 ctrl+c，于是挺掉了。还好输入的文件列表能知道当前处理到哪个QQ号码了，重新把剩下的跑一次。
  

  
以下内容转自：[Linux](http://www.ningoo.net/html/2008/how_to_run_processes_on_background_in_linux.html)[中如何让进程在后台运行](http://www.ningoo.net/html/2008/how_to_run_processes_on_background_in_linux.html).
  

  
在Linux中，如果要让进程在后台运行，一般情况下，我们在命令后面加上&即可，实际上，这样是将命令放入到一个作业队列中了：

```bash
$ ./test.sh &
[1] 17208

$ jobs -l
[1]+ 17208 Running                 ./test.sh &
```

对于已经在前台执行的命令，也可以重新放到后台执行，首先按ctrl+z(**千万要注意Not ctrl+c**)暂停已经运行的进程，然后使用bg命令将停止的作业放到后台运行：

```bash
$ ./test.sh
[1]+  Stopped                 ./test.sh

$ bg %1
[1]+ ./test.sh &

$ jobs -l
[1]+ 22794 Running                 ./test.sh &
```

但是如上方到后台执行的进程，其父进程还是当前终端shell的进程，而一旦父进程退出，则会发送hangup信号给所有子进程，子进程收到hangup以后也会退出。如果我们要在退出shell的时候继续运行进程，则需要使用nohup忽略hangup信号，或者setsid将将父进程设为init进程(进程号为1)

```bash
$ echo $$
21734

$ nohup ./test.sh &
[1] 29016

$ ps -ef | grep test
515      29710 21734  0 11:47 pts/12   00:00:00 /bin/sh ./test.sh
515      29713 21734  0 11:47 pts/12   00:00:00 grep test
$ setsid ./test.sh &
[1] 409

$ ps -ef | grep test
515        410     1  0 11:49 ?        00:00:00 /bin/sh ./test.sh
515        413 21734  0 11:49 pts/12   00:00:00 grep test
```

上面的试验演示了使用nohup/setsid加上&使进程在后台运行，同时不受当前shell退出的影响。那么对于已经在后台运行的进程，该怎么办呢？可以使用disown命令： 

```bash
$ ./test.sh &
[1] 2539

$ jobs -l
[1]+  2539 Running                 ./test.sh &

$ disown -h %1

$ ps -ef | grep test
515        410     1  0 11:49 ?        00:00:00 /bin/sh ./test.sh
515       2542 21734  0 11:52 pts/12   00:00:00 grep test
```

另外还有一种方法，即使将进程在一个subshell中执行，其实这和setsid异曲同工。方法很简单，将命令用括号() 括起来即可： 

```bash
$ (./test.sh &)

$ ps -ef | grep test
515        410     1  0 11:49 ?        00:00:00 /bin/sh ./test.sh
515      12483 21734  0 11:59 pts/12   00:00:00 grep test
```

注：本文试验环境为Red Hat Enterprise Linux AS release 4 (Nahant Update 5),shell为/bin/bash，不同的OS和shell可能命令有些不一样。例如AIX的ksh，没有disown，但是可以使用nohup -p PID来获得disown同样的效果。
  
还有一种更加强大的方式是使用screen，首先创建一个断开模式的虚拟终端，然后用-r选项重新连接这个虚拟终端，在其中执行的任何命令，都能达到nohup的效果，这在有多个命令需要在后台连续执行的时候比较方便：

```bash
$ screen -dmS screen_test

$ screen -list
There is a screen on:
        27963.screen_test       (Detached)
1 Socket in /tmp/uscreens/S-jiangfeng.

$ screen -r screen_test
```
