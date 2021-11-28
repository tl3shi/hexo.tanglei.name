---
title: certificate-expired-on-macOS-when-brew-install
layout: post
categories: 
  - 经验技巧 
tags: 
  - 经验技巧
---

在使用 MacOS 过程中，用 `brew install` 或者 `git clone https://xxx` 遇到下面这个问题：

> LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443

![image-20211024172456063](/Users/tanglei/github/hexo.tanglei.name/source/resources/certificate-expired-on-macOS-when-brew-install/image-20211024172456063.png)

网上查了下，各种解决方案都尝试了一遍，没解决。搞了好久才解决，现在整理下方案。

因为往往 `brew install /update` 也直接用 `git clone/pull` 等命令实现，本质上讲一个问题。

### 确认下是不是代理的问题 

有说是git 配置了代理，可能有问题的，先确认下，去掉代理再试。 

```bash
cat ~/.gitconfig
```

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 确认是不是本地CA证书过期的问题。

![image-20211024171234149](/Users/tanglei/github/hexo.tanglei.name/source/resources/certificate-expired-on-macOS-when-brew-install/image-20211024171234149.png)

这个比较明显，会说证书过期。

```
curl: (60) SSL certificate problem: certificate has expired
```

解决问题当然是更新证书：

```bash
#mac证书文件路径
ls  -l /etc/ssl/cert.pem 
-rw-r--r-- 1  /etc/ssl/cert.pem
sudo cp /etc/ssl/cert.pem /etc/ssl/cert.bak.pem //备份原文件
curl -o ./cacert.pem "https://curl.haxx.se/ca/cacert.pem"  -L -v --insecure //下载最新的证书。-L是为了跟踪重定向，--insecure 忽略证书校验
sudo cp ./cacert.pem /etc/ssl/cert.pem   
```

### 还有的说是 ipv6 的问题 

[stackoverflow](https://stackoverflow.com/questions/48987512/ssl-connect-ssl-error-syscall-in-connection-to-github-com443) 上有人说是 ipv6 的问题。 

It comes due to IP6 in Mac's wi-fi/ hotspot. So, whenever you'll get IP4 it'll work. So the solution is : networksetup -setv6off Wi-Fi and then git push Hope it'll work

I had this similar error when using `wget ...`, and after much unfruitful searching in the Internet, I discovered that it was happening when hostnames were being resolved to IPv6 addresses. I discovered this by comparing the outputs of `wget ...` in two machines, one was resolving to IPv4 and it worked there, the other was resolving to IPv6 and it failed there.

So the solution in my case was to run **`networksetup -setv6off Wi-Fi`** on macOS High Sierra 10.13.6. (I discovered this command in this [page](http://osxdaily.com/2014/04/18/disable-ipv6-mac-os-x/)).

### github 从 https 更换 git 就 ok 了

说到底，这个报错还是 SSL 握手有问题（HTTPS 有问题），其实就是网络有问题， HTTPS 更换 git 协议就直接 OK 了。 



![image-20211024202551335](/Users/tanglei/github/hexo.tanglei.name/source/resources/certificate-expired-on-macOS-when-brew-install/image-20211024202551335.png)



因为国内有 wall，确实访问 github 不稳定。

### 直接给 shell 加个代理解决 

```shell
# 自定义代理: 开启/关闭 XXX 网络加速
setproxy() {
export http_proxy=socks5h://127.0.0.1:13659;
export https_proxy=socks5h://127.0.0.1:13659;
curl cip.cc;
echo "更新http_proxy/https_proxy, 代理到socks5h://127.0.0.1:13659"
}
unsetproxy() {
unset http_proxy;
unset https_proxy;
curl cip.cc
echo "关闭http_proxy/https_proxy"
}
```

然后使用代理前，执行下 `setproxy` 即可，效果贼快，再 `git clone` 或者 `brew install xxx`  就好了。

![image-20211024210806517](/Users/tanglei/github/hexo.tanglei.name/source/resources/certificate-expired-on-macOS-when-brew-install/image-20211024210806517.png)

