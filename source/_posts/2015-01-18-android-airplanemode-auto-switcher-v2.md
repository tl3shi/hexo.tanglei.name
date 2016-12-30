---
id: 2583
title: 飞行模式助手
date: 2015-01-18T23:06:30+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2583
duoshuo_thread_id:
  - 1351844048792453515
categories:
  - coding小工具
tags:
  - 敲敲代码
  - Android
  - 飞行模式
---
原来时隔上次这篇\[Android 4.2 自动定时切换飞行模式\]([/blog/android-airplanemode-auto-switcher.html](/blog/android-airplanemode-auto-switcher.html "/blog/android-airplanemode-auto-switcher.html"))已经1年了, 惭愧惭愧~ 根据之前的版本说的是要加入多个时间段的设置, 重新 “设计”（其实是山寨了别人的）了UI, 今天终于发布出来了。**注意,** 该程序针对Android4.2及其以上的版本，手机需要ROOT才OK，且建议添加到信任程序列表。4.2之前的版本是木有问题的。

点击<a href="https://github.com/tl3shi/AirPlaneModeSwitcher/raw/master/mainModule/mainModule-release.apk" target="_blank">这里下载最新</a>的应用。该版本(V1.0)注意更新的内容是:

  * 重新设计UI;
  * 支持多个任务;
  * 增加操作日志的功能;
  * 增加Umeng统计/自动更新/反馈;

下面对界面及相应的功能进行说明：

  * 主界面：模仿了某闹钟的界面,将所有任务列表展现出来，默认添加两个任务，凌晨零点打开飞行模式，清晨六点半关闭飞行模式。右上角有一个“添加”新任务按钮，然后就是菜单。菜单第二项是立即开启/关闭飞行模式，当前状态为正常时，点击则跳转至文末(图5中)5s倒计时切换提示，当前为飞行模式时，点击回到正常模式。

<a href="/wp-content/uploads/2015/01/1-main.jpg" target="_blank"><img  title="图1" src="/wp-content/uploads/2015/01/1-main_thumb.jpg" alt="android自动切换飞行模式"  /></a>

  * 任务详情：从主界面点“添加”按钮或者长按某个任务“编辑”“查看”按钮进入任务详情界面，点击“时间”可调整任务执行的时间，可设置任务名称，任务类型“打开”表示该任务到期后会执行飞行模式，“关闭”表示任务到时候会关闭飞行模式，下面的重复表示该任务以怎样的方式进行重复，点亮表示选择（示例中表示每周2和周4重复），设置好后点击左上角“保存任务”，右上角菜单“放弃”。

<a href="/wp-content/uploads/2015/01/2-taskdetail.png" target="_blank"><img  title="图2" src="/wp-content/uploads/2015/01/2-taskdetail_thumb.png" alt="Android自动切换飞行模式"  /></a>

  * 开启/关闭及删除任务：在主界面中，点击每个任务右边的button可以切换选中任务的状态，状态为开启时，会提示该任务下次执行的时间；需要删除某个任务时长按该任务，在弹出菜单中(图1-右)中选中删除，点击确定即可。主界面菜单中点击“查看运行日志”可以查看只应用安装以来软件运行的每个任务状态，当记录太多时，可以选择从菜单中清除日志(图中有英文是我测试国际化的东东，原谅丑了点)。

<a href="/wp-content/uploads/2015/01/3-enable-delete-log.png" target="_blank"><img  title="图3" src="/wp-content/uploads/2015/01/3-enable-delete-log_thumb.png" alt="Android自动切换飞行模式"  /></a>

  * 反馈/更新：从主页面菜单中“意见反馈”可进入“意见反馈”界面，你可以填写联系信息让我更方便与你取得联系，输入“吐槽意见”后发送，我在UMeng后台就可以看到并给予回复，最快的话其实你是可以跟上一个版本中一样直接给我发邮件，“关于”样子如下图(中)，懒得写直接用了上个版本的About, 但加了版本信息，可以直接点连接给我邮件。每次启动的时候，你在**Wifi状态**下的话，程序会自动检测是否有更新的版本，有的话会提示你更新。//其实这几个功能把整个App的大小扩大了不少，原来只有几十k的应用现在变成了1.5M. 只是试着用用[之前东家](/blog/aop-in-python.html)的产品。

[<img  title="4-umeng-tools" src="/wp-content/uploads/2015/01/4-umeng-tools_thumb.png" alt="4-umeng-tools"  />](/wp-content/uploads/2015/01/4-umeng-tools.png)

  * 其他：还是跟前一个版本一样，因为>4.2 要Root权限，所以当下图左出现时，得点“授权”, 用户在操作手机时，时间到了会有5s的犹豫时间，可以直接确定或者取消当前当次的任务。最右边那个是一个简单的帮助内容，其实本文还是更详细啦。

<a href="/wp-content/uploads/2015/01/others.png" target="_blank"><img  title="图4" src="/wp-content/uploads/2015/01/others_thumb.png" alt="Android定时切换飞行模式"  /></a>

<div>
</div>

<div>
  FAQ：
</div>

  1. 我设置了11:30开启飞行模式，怎么到11:31了都还没有跳出5秒倒计时的窗口或没有自动开启飞行模式 ? 
      * 根据设备(手机或pad)当前的运行状态，可能会有不同时间(0-5min)的延迟，这跟很多闹钟应用一样,设置了11:30会给设备发送一个开启飞行模式的请求，至于设备什么时候响应这个请求，就听设备自己的了。不过这个应该没关系，几分钟的延迟并无大碍。
  2. 我的Android手机版本>=4.2了，但我没有Root, 我可以用这个App吗? 
      * 抱歉，Android 在4.2更新后，对权限管理更加严格了，像切换飞行模式这样的系统级别操作普通应用程序控制不了，除非重新打包在Android系统里面编程系统应用。所以>=4.2的Android 版本无Root权限不能用。
  3. 我能否获得该App的代码, 在已有的基础上进行改进？ 
      * 当然可以。我已经将此App的代码托管在<a href="https://github.com/tl3shi/AirPlanModeSwitcher" target="_blank">github</a>. 你可以直接fork, 欢迎你fix bug或将新的功能实现后发PR. 若你只需要用到其中的部分代码，也希望你注明来源。
