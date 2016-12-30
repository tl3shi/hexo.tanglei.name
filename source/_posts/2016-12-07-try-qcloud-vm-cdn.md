---
title: 腾讯云服务器, 域名备案及 CDN 服务体验
layout: post
categories: 
  - 经验技巧
tags: 
  - 经验技巧
  - 云服务
  - Linux
---


以下原因促使我要用腾讯云服务器以及将裸奔了6~7年的域名进行ICP备案: 

![非微信官方网页,继续访问将转换手机预览模式](/resources/qcloud/wechat-encode-tanglei.name.jpg)

1. 刚开通的微信公众号, 积极性高涨, 然而每次微信里面跳转到我的 blog, 都会出现上图所示的跳转中间页. 默认继续访问还是看到微信转码后的效果, 影响用户体验. 我尝试申请恢复了几次没有效果. 申请页面提示备案域名可能性增大, 另外微信后台可以设置安全 JS 域, 域名也必须是通过备案的域名. 
2. 之前用的国外的 VPS, 陆陆续续写过几个工具, 前端时间朋友圈有个求助正好是我之前工具能够解决的. (这个工具是根据关键字自动去 Google scholar 将文章的 bibtex 信息导出, 方便写 paper ) 然而, 之前工具用 PHP 写的, 跑在 VPS 上, 由于后来我 [彻底放弃了 wordpress](http://www.tanglei.me/blog/give-up-wordpress-to-jekyll.html), 直接用 github pages 提供的服务 host 我的 blog, 因此 此工具也不能 work 了. 之前的 VPS 很慢. 
3. 微信公众号后台的一些开发工具等也必须是通过备案的域名. 

另外, 程序猿有个自己稳定的网络开发环境(程序猿开发不都是 copy from stackoverflow/Google 么, 哈哈 🙃)也是极好的. 所以最终决定购买了腾讯云服务器, 另外还赠送了半年的 CDN 服务, 这对于加快我那个无人问津(最近还是平均有个4~500 PV)的 Blog 也是极好的.

于是就购买了~  CPU 1核, 1G Mem, 1Mbps, 20G 硬盘, 这个最低端的配置. 
搭载了CentOS 7系统. 

服务器到手后, 首先就是环境配置. 先搞个 LAMP 环境吧, 有两个方法比较快. 

## 云服务器环境

### 一键安装工具

类似之前搭建清华笛协(THUFlute)环境用过的XAMPP. Linux 下也有类似的. 可参考[Linux服务器一键安装LAMP/LNMP/LANMP环境 ](http://bbs.qcloud.com/thread-8480-1-1.html)

```shell
wget http://mirrors.linuxeye.com/oneinstack-full.tar.gz  
tar -xvf oneinstack-full.tar.gz
cd oneinstack && ./install.sh
```

不一会就安装了 *Nginx,Apache,Mysql,PHP* 环境, 

![qcloud-lamp-oneinstack](/resources/qcloud/qcloud-lamp-oneinstack.jpg)

注意, 云服务器初始化好之后, 要配置安全策略, 对外开放的端口等. 

### Docker

Docker 这么火, 也应该凑凑热闹. 安装好 docker 环境后, 搜索一下镜像. 

```bash
[root@VM_3_4_centos ~]# docker search lamp
NAME                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
reinblau/lamp                     Dockerfile for PHP-Projects with MySql client   25                   [OK]
nickistre/ubuntu-lamp             LAMP server on Ubuntu                           12                   [OK]
greyltc/lamp                      a super secure, up-to-date and lightweight...   10                   [OK]
nickistre/centos-lamp             LAMP on centos setup                            8                    [OK]
nickistre/ubuntu-lamp-wordpress   LAMP on Ubuntu with wp-cli installed            7                    [OK]
nickistre/centos-lamp-wordpress   LAMP on CentOS setups with wp-cli installed     3                    [OK]
nickistre/centos-lamp-xdebug      LAMP on centos with xDebug                      2                    [OK]
...
```

看名字有 wordpress 就直接 pull, 并安装. `docker pull nickistre/centos-lamp-wordpress`

```bash
[root@VM_3_4_centos ~]# docker images
REPOSITORY                        TAG                 IMAGE ID            CREATED             SIZE
hello-world                       latest              c54a2cc56cbb        5 months ago        1.848 kB
nickistre/centos-lamp-wordpress   latest              14331568cd2f        6 months ago        547.4 MB
```

`docker run -d -p 1024:80 nickistre/centos-lamp-wordpress` 然后 `curl localhost:1024 ` check 一下能够 work. 

![qcloud-docker-lamp-wordpress](/resources/qcloud/docker-lamp-wordpress.png)

事后才发现, 上面的那个环境果然仅仅是一个 wp-client, 并不是我想要的 wordpress, 不过另外再下一个 wordpress 源码包就可以了. 

对, 目前这台主机上就跑了一个 wordpress, 博主不是我, 是自称北邮最美女博士, 站点是 [论如何get博士成就 -- 北邮不会码代码的博士生中最不会码代码的博士生的博士生活](http://www.dr-sun.cn/), 网址是 [dr-sun.cn](http://www.dr-sun.cn), 没错, 就是 孙博士, 欢迎大家关注. 

其实, docker 官网就有相应的 [wordpress 镜像](https://hub.docker.com/_/wordpress/), 可以直接拉取, 或者直接从 [CentOS github](https://github.com/CentOS/CentOS-Dockerfiles/tree/master/wordpress/centos7)拉去也行. 

docker 其实, 我并不太会, 只是之前从白老板, 胖子那里学了两招而已. 如果你要采用基于 Docker 的方案可以参考这篇文章[如何在 Docker 容器中架设一个完整的 WordPress 站点](https://linux.cn/article-5560-1.html). 

说到这里, 可以来一发广告. 我们部门(宜信大数据创新中心)有个团队在**@洪教授(洪强宁)** 的带领下开发了一套**基于 docker 的 PaaS 系统** -- Lain, 早已经开源啦, [Github 地址](https://github.com/laincloud/lain), **Lain** 是一个其面向技术栈多样寻求高效运维方案的高速发展中的组织，devops 人力缺乏的 startup ，个人开发者。统一高效的开发工作流，降低应用运维复杂度；在 IaaS / 私有 IDC 裸机的基础上直接提供应用开发，集成，部署，运维的一揽子解决方案。


## 域名备案及 CDN

提起域名备案还是有心理阴影的, 回想本科的时候有过的第一个域名(i3zhai.com, 爱山寨, 求别笑这个域名, 现在已经不属于我了), 花了近2个月时间去工信部申请 ICP 备案, 最后还拒了. 以至于后来的五六年里都没曾想过再去申请备案. 

结果这次通过腾讯云去申请备案, 没想到还刚过一周还就给通过了, 果然还是要找个强有力的后盾(代理商)去办事才行啊. 
由于备案期间要求网站要关闭, 我就没用我正在用的域名 tanglei.name 去申请备案, 而是通过 tanglei.me 去申请的. 
备案限制还蛮多的, 比如你是北京身份证, 只能备案一些常见的后缀如`.com/.cn/` 之类的, 有的省市限制了域名注册代理商只能是国内的等等. 还是很 DT 的. 反正, 最后通过曲曲折折的方法最后备下来了. 

对了, 腾讯提供的 CDN 服务也只支持给已经备案的域名使用. 

先看一下 CDN 大概怎么配置和使用吧, 原理就是你添加一个域名的 CNAME, 指向腾讯的 host, 所以用户发起请求的时候实际是解析到腾讯的 CDN 服务器的, CDN 后台配置一个源站点, 如 `www.tanglei.name`, 用户请求到 CDN 服务器时, 如果没有命中, 就去源站点请求并将内容缓存至 CDN 服务器. 

![腾讯云 CDN 配置](/resources/qcloud/www.tanglei.me-cdn-config.png)

配置后约几分钟生效, `ping` 一下发现已经生效了, `931.tc.sp.cdntip.com` 就是腾讯对应的 CDN 节点, 不同地方 ping 这个节点对应的实际 IP 地址也可能不一致. 

```
➜  ~ ping www.tanglei.me
PING 931.tc.sp.cdntip.com (123.125.46.43): 56 data bytes
64 bytes from 123.125.46.43: icmp_seq=0 ttl=44 time=7.089 ms
64 bytes from 123.125.46.43: icmp_seq=1 ttl=44 time=6.863 ms
64 bytes from 123.125.46.43: icmp_seq=2 ttl=44 time=9.846 ms
^C
--- 931.tc.sp.cdntip.com ping statistics ---
3 packets transmitted, 3 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 6.863/7.933/9.846/1.356 ms
```

![腾讯云 CDN 配置效果](/resources/qcloud/www.tanglei.me-ping-cdn.png)

能看到 CDN 已经生效了, 再找个工具看下各地的延时情况. [ping.chinaz.com](http://ping.chinaz.com/www.tanglei.me), 一片绿啊, 各个地方线路 ping 到的 IP 已经不一样了. 极大提高了速度, \* 32倍都不止啊. 

目前我仍然用 github host 我的blog文件, 需要在 CDN 设置里将 host 设置为回源host 设置为 `www.tanglei.name`, 如果不设置, 请求 `www.tanglei.me `会到 github pages 拉页面, github pages 里面不认 `www.tanglei.me` 这个 host, 就会出现 404. 

回源 host 配置成 `www.tanglei.name`, 会直接去 `www.tanglei.name` 这里去拉文件进行缓存, 现在就 OK 了. 

现在直接请求 `www.tanglei.name` 会取 github pages 的文件, 通过 `www.tanglei.me` 取会走腾讯云的 CDN, 来个对比结果. 
前面说的提升32倍稍微有些夸张, 提升个五六倍还是正常的. 对比的是 [这个含有一些图片的页面](http://www.tanglei.me/blog/app-in-mac-for-common.html), 测速还有一些如 USA的节点, 还拉低了平均值, 国外的一些节点还是走 github 更快. 

![腾讯云CDN 对比效果](/resources/qcloud/tanglei.name-vs-tanglei.me-cdn-.png)

接入 CDN 后台看到的差不多1天后的效果, 没骗你吧, 一天也就400~500 PV. 

![腾讯云CDN 对比效果](/resources/qcloud/qcloud-cdn-status.png)

## TODO

现在是两个域名生效, 下一步得做一个301跳转, 不然两个站内容一样, 在 SEO 肯定不友好, 还拉低两个站的权重. 貌似用 github 直接 host 还不太好做, 所以准备自己 host. 

计划仍然通过 [travis-ci](http://travis-ci.org/), 直接 `git commit ` *.md* 文件后, CI 负责帮忙自动从 github 中 pull 代码进行 build 并部署到腾讯云, 进而更新站点. **travis-ci** 这个工具, 程序猿也应该了解下. 

后续还可以做的就是全站 HTTPS 的支持, 虽然对于本 blog 来说并没有什么卵用, 然而我就想试试, 哈哈哈哈. 其实还是有用的, 比如有利于 SEO, 然后自己也可以练练手. 

对了, Last but not the least,  如果你还是**在校学生**的话, 去腾讯云有惊喜哦~ 看到这个消息的并受益的同学别忘了回来分享, 并给我点赞. 

---

p.s 如果你觉得这文章对你有那么一点点收获, 请不要犹豫扫描下面二维码关注我的公众号, 如果你再能帮忙转发一下就更好了. 么么哒.

![tanglei 微信号](/resources/wechat-tangleithu.jpg)
