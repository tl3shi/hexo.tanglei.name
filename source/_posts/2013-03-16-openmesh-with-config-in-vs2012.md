---
id: 2058
title: OpenMesh Windows(Visual Studio 2012) 配置
date: 2013-03-16T01:21:06+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2058
duoshuo_thread_id:
  - 1351844048792453198
categories:
  - 计算机图形学
tags:
  - 计算几何
---
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; 最近听了数学中心孙剑老师的几何处理一门课，讲了openmesh，于是试了试。实验室项目一直在windows+VS2012下开发，于是也想着openmesh在win下结合vs2012.环境搞了好久没搞定。网上的方法也都试过了。

&#160;&#160;&#160;&#160;&#160;&#160; 官网提供的Openmesh2.3支持32/64位下vs2010，开始想着2012兼容，安装了多次没搞定。比如网上所说的copy lib/include目录，添加OpenMeshTools和OpenMeshCore的lib文件依赖，添加预定义宏\_USE\_MATH_DEFINES和NOMINMAX……都搞不定。   
最后解决方案：下源码，在vs2012下重新编译生成。需要用到cmake，这里有步骤的介绍。通过Cmake的build和generate一个vs2012的工程之后，打开solution文件，能看到不少工程，直接build一个叫all_build的project即可。最后再将相应的include、lib等文件copy下即可。   
老师布置的hello world的一个作业，大概是熟悉下环境，然后读取一个off格式的文件，处理是Color-coded mesh based on valences.效果如下图所示，off文件中标明了点信息和整个拓扑结果，图中颜色异样的地方就是该点周围直接相连的点比其他多(图中是8个，其他的为6)。   
&#160; [<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="/wp-content/uploads/2013/03/image_thumb.png"  />](/wp-content/uploads/2013/03/image.png)[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="/wp-content/uploads/2013/03/image_thumb1.png"  />](/wp-content/uploads/2013/03/image1.png)   
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Openmesh实现很简单，直接read进来，OpenMesh::IO::read\_mesh(mesh, " eight.off"))，然后遍历一下顶点，直接通过mesh.valence(vertexHandler)就能得到valence值，再直接用mesh.set\_color(vertexHandler, MyMesh::Color(r,g,b,a))就可以针对valence值对每个点设置相应的颜色信息，最后write_mesh()的时候就能将点信息保存好。保存好后可以用其他的geometry view tools打开看到效果。上图右是用[OpenFlipper](http://www.openflipper.org/)打开效果.
