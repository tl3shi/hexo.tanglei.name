---
id: 2519
title: 围住神经猫1步玩法-"作弊"
date: 2014-07-24T23:15:26+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2519
duoshuo_thread_id:
  - 1351844048792453510
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - Javascript
---
**update: 微信升级了JS的API，目前此方法已经生效，要修改还很麻烦，必须满足的条件是：微信认证公众号+ICP备案的域名+后台服务，懒得折腾了。**
  

  
今天被“围住神经猫”的游戏在微信朋友圈刷票了~ 自己也试了试，运气好能在10步左右OK。然后点击别人分享的页面直接进入游戏状态，发现分享的时候仅仅是分享网页的title不一样而已，且击败的对手百分比=(100-步数)%。于是“作弊”了下，仅仅“娱乐”罢了。

原理很简单，分享的是一个网页url，于是自己生成一个html页面即可， title自己设置，当然想多少步就多少步，把原来网页的图片引用一份放到自己页面里，好让weixin抓取这个图片生成缩略图。为了让对方点这个url后跳转到原始游戏的url，可以让浏览器在onload时直接通过location.href跳转至原始游戏的url。然后分享这个网页的url出去即可。于是也就有了如下效果~  不知为何缩略图没生成。

<p style="text-align: center;">
  <a href="/wp-content/uploads/2014/07/shenjingmao-0.png"><img class="size-full wp-image-2520 aligncenter" title="shenjingmao-0" src="/wp-content/uploads/2014/07/shenjingmao-0.png" alt=""  /></a>
</p>

后来发现微信有自己的分享时的API，就更简单了。随便一个给一个网页，设置好缩略图url，title和描述，以及点击后跳转的url，然后weixin内置浏览器打开的时候就会去调用相应的事件，比如分享给朋友、分享到朋友圈等。

```javascript
<script>
var imgUrl = "http://1251001823.cdn.myqcloud.com/1251001823/wechat/mao80.jpg";
var lineLink = "http://1251001823.cdn.myqcloud.com/1251001823/wechat/sjm/launcher";
var descContent = '在9×9范围内的格子中，使用色块围住白色神经猫。';
var shareTitle = '我用了1步围住神经猫，击败99%的人，你能超过我吗？';
var appid = '';
function shareFriend() {
    WeixinJSBridge.invoke('sendAppMessage',{
        "appid": appid,
        "img_url": imgUrl,
        "img_width": "200",
        "img_height": "200",
        "link": lineLink,
        "desc": descContent,
        "title": shareTitle
    }, function(res) {
    })
}
function shareTimeline() {
    WeixinJSBridge.invoke('shareTimeline',{
        "img_url": imgUrl,
        "img_width": "200",
        "img_height": "200",
        "link": lineLink,
        "desc": descContent,
        "title": shareTitle
    }, function(res) {
    });
}
function shareWeibo() {
    WeixinJSBridge.invoke('shareWeibo',{
        "content": descContent,
        "url": lineLink,
    }, function(res) {
    });
}
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    WeixinJSBridge.on('menu:share:appmessage', function(argv){
        shareFriend();
    });
    WeixinJSBridge.on('menu:share:timeline', function(argv){
        shareTimeline();
    });
    WeixinJSBridge.on('menu:share:weibo', function(argv){
        shareWeibo();
    });
}, false);
</script>
```

api里面有一个appid，以为要向TX申请后才OK，后来发现暂时不填也暂时能OK。效果如下：

[<img class="aligncenter size-full wp-image-2521" title="shenjingmao-1" src="/wp-content/uploads/2014/07/shenjingmao-1.png" alt=""  />](/wp-content/uploads/2014/07/shenjingmao-1.png)

<a href="http://tanglei.me/resource/shenjingmao.html" target="_blank">这里写了一个你可以自定义的网页，有兴趣玩玩</a>~ 要用微信的内置浏览器打开才可以分享哦(可以copy此链接，在微信中，发送给任意好友或通讯录中的“文件传输助手”，然后能看到链接了，点击进去就OK。):)
