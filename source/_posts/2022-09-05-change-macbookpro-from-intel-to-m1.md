---
title: macbookpro 从 intel 迁移到 M1 
layout: post
categories:
  - MyLife
tags:
  - MyLife
  - 经验技巧
---

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247501553&idx=1&sn=e2426c90f93c7ba4284e6b7061a9dbed&chksm=eb44c715dc334e0328612fb394f53c566f2f956cca89b1431ee763580aacf6e6a4fec0bba9b0&token=136490974&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。 

![](/resources/transfer-to-m1-macbookpro/640.png)

## 背景 

大家好，我是石头哥。 

前面公司用的电脑到期可以 0 元自购了，因此申请更换新电脑。

申请的时候，提示有新款 M1 MacBookPro，自然而然就更换新款电脑啦。标配版有现货，升级版（比如 从 16G 升级到 32G 内存，或者 512 SSD 升级到 1T）无库存，需要等一个月左右。

考虑到现在的电脑能继续用，因此就等新款吧，毕竟若不出意外的话（假设没毕业的话 ：）），这吃饭的家伙得跟着用 4 年呢！

因此就用这篇文章来记录一下从型号选择以及电脑更换、系统迁移，兼容（毕竟芯片都换了）等方面的一些经验和技巧，当然还有踩坑的教训。

## 型号选择

当然这里的型号，作为开发同学的话，公司这篇选购的主要涉及两款，即 14 寸和 16 寸。

![尺寸重量对比](/resources/transfer-to-m1-macbookpro/2f8d7066-8b01-4c82-8c68-ae9592fc9bb5.png)

之前用的 13 寸，感觉大小还行，也比较习惯。刚开始想的是，这次就选 14 寸的吧。

然后考虑到续航，咋 14 的边最低了？

![](/resources/transfer-to-m1-macbookpro/8b9d5414-f318-4b34-8780-c435776140f4.png)

然后再考虑到公司配置的 16 寸的 GPU 比 14 寸的好（16核 v.s 14核），且重量重了 0.5kg，想一想，也就多了一瓶矿泉水的重量。

于是就直接考虑用 16 了，续航 21 个小时，周末都不用拿电源回家了！（事实上刚开始还有点嘘，发现电源带回家也没用过，于是后面考虑真不用带了）。

刚开始没考虑到升降桌，16 寸还是有点稍稍偏大，笔记本显示器和外接显示器有点掐架的感觉。 

![工位](/resources/transfer-to-m1-macbookpro/51743438-3fe0-46bb-b36d-26f13616d8d9.png)

这电脑去官网看看对应配置，好家伙，2万2... 

![](/resources/transfer-to-m1-macbookpro/56025872-bc56-49b2-ba7e-e340c3483878.png)

不知道用着这样的电脑写代码，bug 会不会少一些呢？

## 系统迁移

接下来就来说说如何快速将旧电脑的东西迁移到新电脑。

如果是自己电脑的话，一般而言，其实用 time machine 即可。

![](/resources/transfer-to-m1-macbookpro/a38088ef-7ac3-4e54-a123-1cd72bd0b734.png)

但公司电脑，肯定不能随便插硬盘备份啊等等之类的。况且，这次系统迁移，芯片从 Intel 更换到 M1 了，肯定很多应用软件迁移过来没办法直接用的。

当然一种办法就不管了，直接把一些自己的文件 copy 过来即可，软件重新下载 M1 版本的，然后各种环境重新配置，等等。注意信息安全哦，遵守自己公司相关规范。

当然，这种方法肯定效率太低了，整天啥事儿不用干了就。

这里就推荐另外一种方式，直接用苹果提供的 Migration Assistant 工具进行迁移。

![](/resources/transfer-to-m1-macbookpro/63e31947-8bc3-41af-9936-26664e7355ab.png)

也别通过网络了，直接用 Type-C 线连接两台电脑即可，即便是局域网也没 Type-C 直连快。按照网络经验，用连接显示请的 Type-C 的线会更快一些。

![type-c-connect](/source/_posts/transfer-to-m1-macbookpro/type-c-connect.jpg)

![speed-select](/source/_posts/transfer-to-m1-macbookpro/speed-select.jpg)

其实，Mac 自己也会检测哪种速度更快，比如上面的是雷电Type-C 传输，245M/s，下面的 P2P（我猜是蓝牙，毕竟 WiFi 没连）才 10M。

![select-files](/source/_posts/transfer-to-m1-macbookpro/select-files.jpg)

选择要迁移的文件，应用文件夹我感觉不用选，因为大概率迁移过来不能直接用。

![time-remains](/source/_posts/transfer-to-m1-macbookpro/time-remains.jpg)

如上图所示，速度还挺快的，我 200+G 也就 2 个小时？迁完了。

迁移完了之后，文件路径等等各种和之前一样，各种软件配置等都还在。连 IDEA 打的断点等等都还在！

## 兼容踩坑

接下来就是软件的兼容性了。 

![](/resources/transfer-to-m1-macbookpro/86f7c773-0da4-49cf-855d-1edc348b254f.png)

不过，没有专门针对 M1 优化的软件，就会以 Intel 的方式进行跑？据说是苹果为了兼容 Intel，专门有一层翻译技术，Rosetta2，据说会导致启动速度变慢，不影响正常使用，可能有一定性能影响。

![](/resources/transfer-to-m1-macbookpro/54aeb2fa-77f0-41a7-958c-9e842ef01497.png)

一般而言，其实不会有太大的问题。我这边遇到的问题是，之前[分享过高效率的 Alfred](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485871&idx=1&sn=c877775df684d8ab8c90bf2d38eee98a&chksm=eb47084bdc30815d19182c51571b096a20b79bdee0956f68167ebc8ed3117364ac0602f83658&token=551126633&lang=zh_CN&scene=21#wechat_redirect)，搬过来不太好使了，索引好像不认识，重建了几次也不好使。

现象就是：这个文件你直接搜索，是搜不到的，但你把这个文件打开一下，或者重新复制一遍，就又能搜索到了。

![新 copy 文件，或者打开一次文件就能搜到](/resources/transfer-to-m1-macbookpro/image-20220904225953695.png)

问题解决就是：删除，重建索引，然后也同时修改自带的 Spotlight 的配置（勾选或者去掉要索引的文件夹），如果一次不行，那就多来几次。

![](/resources/transfer-to-m1-macbookpro/7cbcaf2d-c017-40b4-9d99-5aaf777dfc8c.png)

还可以尝试黑屏清除（实际上估计效果是一样的）。

`/Applications/Alfred\ 4.app/Contents/Frameworks/Alfred\ Framework.framework/Versions/A/Resources/reindexdel.sh`

然后记得中途尝试重启电脑。我开始就是重建索引不好使。

索引重建过程中， 用 Spotlight 会有 “Indexing” 这样的提示：
![](/resources/transfer-to-m1-macbookpro/2da3e2c7-174b-454e-91b6-893c1b5e0d0e.png)

然后一些用的 python/php 写得插件写得也比较垃圾，python 解释器等写死路径的，Alfred 本身有不让改（这里也很垃圾）然后就没办法直接用。

开始想着插件依赖 `/usr/bin/python` 这样的绝对路径，直接写一个软链到新的 python 路径即可，结果各种没权限。

![](/resources/transfer-to-m1-macbookpro/2bbd2efc-f85a-4293-aa18-4017f28d2f4b.png)

```
显示Read-only file system
unable to copy extended attributes to /usr/bin/...: Read-only file system

2.1 第一种解决方法:（对Mac M1无效）重新以可读可写的方式挂载文件系统

sudo mount -uw /

若出现：
mount_apfs: volume could not be mounted: Permission denied
mount: / failed with 66

注：在 macOS Catalina 及之前版本中，可以通过关闭 SIP 并在终端中更改 system 文件夹为可写入。但是，这一后门在2020年6月发布的 Big Sur 中被关闭了。

2.2 第二种解决方法: 修改 /etc/synthetic.conf（对 Mac M1，创建可读写的目录只能在根目录下建立，在/usr/bin下建立无效）
2.3 第三种解决方法: 解决思路是:将系统重新挂载在到一个有读写权限的新目录下，在该目录下操作即可。（我没继续尝试了）

详细参考资料：
https://www.zhihu.com/question/403361335 
https://discussionschinese.apple.com/thread/252037700 
```

这里花了好多时间去折腾，结论就是，放弃！实测下来，网上搜到的各种方案在 M1 下都不太行。 最终放弃了，万一尝试过程中，途系统搞崩了重装等等还麻烦，还是去批量修改插件源码中的 hardcode 的路径来得更快。

## 新电脑杠杠的

现在电脑用起来还是效果杠杠的。开几个 IDE 都没啥问题，Chrome 网页也可以随便开了，再也听不到风扇呼呼转的声响了。 一般开开网页之类的，CPU 很多核都在摸鱼打酱油。

![](/resources/transfer-to-m1-macbookpro/0763f413-74d3-41b3-8603-43fe6958c8ba.png)

关于程序员效率神器，推荐大家可以看看我之前整理的这几篇文章：

- [优秀的程序员是如何利用工具来提升工作效率的？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247487786&idx=1&sn=842202cc524477ec1546b4747bdbf1a8&chksm=eb4710cedc3099d86953451729c7f569866e6e58abbbec5c7ebe7423d12e1f11e189bb417f80&scene=178&cur_album_id=1514114646939648003#rd)
- [有了这几个神器，瞬间逼格就上去了](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=1&sn=b574d3f2a6af4544ceab48aadaa0a726&chksm=eb470d27dc308431e8789a87e32a597c72cc0f2fe02d6fc80424aec11e41e712326b62603f27&scene=178&cur_album_id=1514114646939648003#rd)
- [开发效率专辑](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1514114646939648003&scene=173&from_msgid=2247486659&from_itemidx=1&count=3&nolastread=1#wechat_redirect)

好了，全文完，大家点赞、收藏备用吧！ 

后面的文字，其实是模板每次带上的，一方面为了引流，另外一个方面，确实如果能帮助到读者，就再好不过了。记住我说的，如果有心进大厂，搞头文末资料，基本问题不会太大。

看到这里，真心希望你能帮忙点赞、分享支持一下，😝这将是我持续输出优质文章的最强动力！

我是石头哥，咱们下期再见！

推荐阅读：

- [Google 工程师面试指南.pdf-免费下载](https://mp.weixin.qq.com/s/OGJhxM7FdeoIkAL2-uUI_Q)

- [清华计算机系王牌课程——《数据结构》课件及源码包下载](https://mp.weixin.qq.com/s/iRcyW1dEeCxleTfOTyr2Lw)

- [BAT大佬写的 1300 页 Leetcode刷题笔记，必须收藏！](https://mp.weixin.qq.com/s/7T9R9kFXke986vSoPNzC8g)

  

> 关于程序员石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。
