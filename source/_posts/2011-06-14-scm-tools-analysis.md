---
id: 848
title: 软件配置管理工具比较分析
date: 2011-06-14T18:32:34+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=848
duoshuo_thread_id:
  - 1351844048792453437
categories:
  - 软件配置管理
tags:
  - 软件配置管理工具
---
软件配置管理的重要性已被大多数软件及相关企业所认识，而配置管理工具的使用是实施配置管理的重要部分。本文对目前较为流行的配置管理工具VSS,CVS,ClearCase,StarTeam做出比较分析。

一、Visual Source Safe(简称VSS）

VSS是美国微软公司的产品，目前常用的版本为6.0版。VSS是配置管理的一种很好的入门级的工具。
  
评价如下：

易用性：★★★★★
  
易学易用是VSS的强项，VSS采用标准的windows操作界面，只要对微软的产品熟悉，就能很快上手。VSS的安装和配置非常简单，对于该产品，不需要外部的培训（可以为公司省去一笔不菲的费用）。只要参考微软完备的随机文档，就可以很快的用到实际的工程当中。

功能：★★★
  
VSS的配置管理的功能比较基本，提供文件的版本跟踪功能，对于build和基线的管理，VSS的打标签的功能可以提供支持。VSS提供share（共享)、branch(分支）和合并（merge)的功能，对于团队的开发进行支持。VSS不提供对流程的管理功能，如对变更的流程进行控制。VSS不能提供对异地团队开发的支持。此外VSS只能在windows平台上运行，不能运行在其他操作系统上。

安全性：★★★
  
VSS的安全性不高，对于VSS的用户，可以在文件夹上设置不可读，可读，可读/写,可完全控制四级权限。但由于VSS的文件夹是要完全共享给用户后，用户才能进入，所以用户对VSS的文件夹都可以删除。这一点也是VSS的一个比较大的缺点。

总体成本：★★★★
  
VSS没有采用对许可证进行收费的方式，只要安装了VSS，对用户的数目是没有限制的。因此使用VSS的费用是较低的。

技术支持：★★★★★
  
由于VSS是微软的产品，可以得到稳定的技术支持。

二、Concurrent Version System(简称CVS)

CVS是开发源代码的配置管理工具，其源代码和安装文件都可以免费下载。

易用性:★★★
  
CVS是源于unix的版本控制工具，对于CVS的安装和使用最好对unix的系统有所了解能更容易学习，CVS的服务器管理需要进行各种命令行操作。目前，CVS的客户端有winCVS的图形化界面，服务器端也有CVSNT的版本，易用性正在提高。

功能：★★★★
  
CVS的功能除具备VSS的功能外，还具有：
  
它的客户机/服务器存取方法使得开发者可以从任何因特网的接入点存取最新的代码；它的无限制的版本管理检出(checkout：注1)的模式避免了通常的因为排它检出模式而引起的人工冲突；它的客户端工具可以在绝大多数的平台上使用。同样，CVS也不提供对变更流程的自动管理功能。

安全性：★★★★
  
一般来说，CVS的权限设置单一，通常只能通过CVSROOT/passwd, CVSROOT/readers,
  
CVSROOT/writers文件，同时还要设置CVS REPOS的物理目录权限来完成权限设置，无法完成复杂的权限控制；但是CVS通过CVS
  
ROOT目录下的脚本，提供了相应功能扩充的接口，不但可以完成精细的权限控制，还能完成更加个性化的功能。

总体成本：★★★★★
  
CVS是开发源码软件，无需支付购买费用。

技术支持：★★★
  
同样因为CVS是开发源码软件，没有生产厂家为其提供技术的支持。如发现问题，通常只能靠自己查找网上的资料进行解决。

三、StarTeam

StarTeam是Borland公司的配置管理工具，StarTeam属于高端的工具，在易用性，功能和安全性等方面都很不错。

易用性：★★★★★
  
StarTeam的用户界面同VSS的类似，它的所有的操作都可通过图形用户界面来完成，同时，对于习惯使用命令方式的用户，StarTeam也提供命令集进行支持。同时，StarTeam的随机文档也非常详细。

功能：★★★★★
  
除了具备VSS，CVS所具有功能外，StarTeam还提供了对基于数据库的变更管理功能，是相应工具中独树一帜的。StarTeam还提供了流程定制的工具，用户可跟据自己的需求灵活的定制流程。与VSS和CVS不同，VSS和CVS是基于文件系统的配置管理工具，而StarTeam是基于数据库的。StarTeam的用户可根据项目的规模，选取多种数据库系统。

安全性：★★★★★
  
STARTEAM无需通过物理路径的权限设置，而是通过自己的数据库管理，实现了类似WINDOWSNT的域用户管理和目录文件ACL控制。StarTeam完全是域独立的。这个优势可以为用户模型提供灵活性，而不会影响到现有的安全设置。StarTeam的访问控制非常灵活并且系统。您可以对工程，视图，文件夹一直向下到每一个小的item设置权限。对于高级别的视图（view），访问控制可以与用户组、用户、项目甚至视图等链接起来。

总体成本：★★★
  
StarTeam是按license来收费的，比起VSS，CVS来，企业在启动StarTeam进行配置管理需要投入一定资金。

技术支持：★★★★★
  
Borland公司将对用户进行培训，并协作用户建立配置管理系统。并对用户提供技术升级等完善的支持。

四、ClearCase

ClearCase是Rational公司的产品，也是目前使用较多的配置管理工具。

易用性：★★★
  
ClearCase的安装和维护远比StarTeam复杂，要成为一个合格的ClearCase的系统管理员，需要接收专门的培训。ClearCase提供命令行和图形界面的操作方式，但从ClearCase的图形界面不能实现命令行的所有功能。

功能：★★★★★
  
ClearCase提供VSS,CVS，StarTeam所支持的功能，但不提供变更管理的功能。Rational另提供了ClearQuest工具提供对变更管理的功能，与StarTeam不同，ClearCase后台的数据库是专有的结构。ClearCase对于windows和unix平台都提供支持。ClearCase通过多点复制支持多个服务器和多个点的可扩展性，并擅长设置复杂的开发过程。

安全性：★★★★
  
ClearCase的权限设置功能与StarTeam相比，StarTeam有独立的安全管理机制，ClearCase没有专用的安全性管理机制，依赖于操作系统。

总体成本：★★
  
要选用ClearCase，需要考虑的费用除购买license的费用外，还有必不可少的技术服务费用，没有Rational公司的专门的技术服务，很难发挥出ClearCase的威力。如现在网上虽有ClearCase的破解软件，但尝试应用的公司大多失败的缘故。另外，对于web访问的支持，对于变更管理的支持功能都要另行购买相应的软件。

技术支持：★★★★★
  
Rational公司已被IBM公司收购，所以有可靠的售后服务保证。

五、总结

工具对比一览表

<table border="0" cellspacing="1" cellpadding="1" width="90%" align="center" bgcolor="#333333">
  <tr class="content" bgcolor="#ffffff">
    <td width="14%">
      特性
    </td>
    
    <td width="19%">
      VSS
    </td>
    
    <td width="17%">
      CVS
    </td>
    
    <td width="20%">
      StarTeam
    </td>
    
    <td width="30%">
      ClearCase
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      易用性
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      功能
    </td>
    
    <td>
      ★★★
    </td>
    
    <td>
      ★★★★
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★★★
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      安全性
    </td>
    
    <td>
      ★★★
    </td>
    
    <td>
      ★★★★
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★★
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      总体成本
    </td>
    
    <td>
      ★★★★
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★
    </td>
    
    <td>
      ★★
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      技术支持
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★
    </td>
    
    <td>
      ★★★★★
    </td>
    
    <td>
      ★★★★★
    </td>
  </tr>
</table>

以上几种工具的总结如下：VSS的使用简便易学，但VSS的功能和安全性较弱，且只对windows平台进行支持，建议作为项目配置管理的入门时采用的工具；CVS的安全性和版本管理功能较强，可以实现异地开发的支持，但CVS安装和使用多采用命令行方式，学习曲线高，同时不提供对变更管理的功能，对于小型团队，可以采用CVS进行管理。ClearCase功能完善，安全性好，可以支持复杂的管理，但学习曲线和学习成本高，需要集成ClearQuest才能完成完整的配置管理功能；StarTeam很好地平衡了功能性、易用性和安全性，同时集成了版本管理、变更管理和缺陷管理。对大型的团队开发和建立组织级的配置管理体系，建议采用ClearCase和StarTeam作为配置管理工具。

Microsoft Visual Source Safe（VSS）

优点：操作简单，容易掌握；权限划分可到文件夹级，有Read、CheckOut&&CheckIn、Add/Rename/Delete、Destroy四种权限级别。

缺点：权限管理基于文件共享形式，只能从文件夹共享的权限设定对整个库文件夹的权限，而且必须要有可写权限；版本管理和分支管理只能靠人为的手工设置；版本发行时，只能手工挑选对应的版本文件进行发布。
  
注一：checkout是指从配置库中取出配置项，相对应的动作为checkin,及将配置项放入配置库中。

表一、并行开发支持比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      Copy-Modify-Merge 模式
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      Copy-Modify-Merge 模式
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      Copy-Modify-Merge 模式
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      Check out-Modify-Check in 模式
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      Check out-Modify-Check in 模式
    </td>
  </tr>
</table>

表二异地开发支持比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      提供MultiSite 模块，通过自动或手动同步位于不同开发地点的存储库的方式，支持异地开发
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      提供ServerSync 模块，通过自动或手动同步位于不同开发地点的存储库的方式，支持异地开发
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      无专门支持的模块
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      无专门支持的模块
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      无专门支持的模块
    </td>
  </tr>
</table>

表三跨平台开发支持比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      支持常见的平台
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      软件本身基于Java开发，可在Windows、Linux、Solaris、HP-UX、AIX等常见平台上使用，平台之间的移植也非常方便
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      支持几乎所有的操作系统
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      软件本身基于Java 开发，能够支持常见的平台
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      仅支持Windows 操作系统
    </td>
  </tr>
</table>

表四与开发工具集成性比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      直接与资源管理器集成，十分易用
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      与常见开发工具无缝集成
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      对开发工具集成性较差
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      仅支持Windows 操作系统
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      与Visual Studio开发工具包无缝连接，其它开发工具集成性差
    </td>
  </tr>
</table>

表五运行性能比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      服务器采用多进程机制，使用自带多版本文件系统MVFS，对性能有较大负面影响。做为一款企业级、全面的开发配置管理工具，适用于大型开发团队
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      服务器采用了多线程的应用服务器，性能表现优秀，做为一款企业级、全面的开发配置管理，能适用于50人到上千人的团队
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      较高的运行性能，适用于各种级别的开发团队
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      服务器采用文件系统共享方式，对CPU、内存及网络要求较高，性能一般，仅适用于中小型项目团队，不适合于企业级应用
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      相对功能单一、简陋，适用于几个人的小型团队，在数据量不大的情况下，性能可以接受
    </td>
  </tr>
</table>

表六易用性比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      安装、配置、使用相对较复杂，需要进行团队培训
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      在提供全面配置管理功能的情况下，安装、配置、使用较为简单，包括安装、配置、培训在内的整个实施周期一般不会超过一个月。
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      安装、配置较复杂，但使用比较简单，只需对配置管理做简单培训即可
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      使用比较简单，只需对配置管理做简单培训即可
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      安装、配置、使用均较简单，很容易上手使用
    </td>
  </tr>
</table>

表七安全性比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      采用C/S模式，需要共享服务器上的存储目录以供客户端访问，这将带来一定安全隐患
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      服务器上的存储目录不用共享，对客户端不透明，客户端不可直接访问存储目录，使系统更安全可靠
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      采用C/S 模式，不需要共享服务器上的存储目录，安全性较好
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      基于文件系统共享，而且需要以&#8221;可写&#8221;的权限共享存储目录，存在较大的安全隐患
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      基于文件系统共享实现对服务器的访问，需要共享存储目录，这将带来一定安全隐患
    </td>
  </tr>
</table>

费用是否可以接受

Rational ClearCase、Hansky Firefly 两款均属于企业级配置管理工具软件,ClearCase价格较贵，，相比之下Hansky
  
Firefly 是一款不错的选择。

而PVCS其价格大约是每客户端几百美元的水平，对于国内企业来说，性价比不太划算。VSS 是微软打包在Visual
  
Studio开发工具包之中的，显然花费的精力不大，价格也比较便宜，可以做为个人、小项目团队版本控制之用。

而CVS则是一款完全免费的开源软件，性能较之企业级配置管理工具差距不大，也是一种不错的选择。

表八售后服务比较表

<table border="0" cellspacing="1" cellpadding="1" width="90%" bgcolor="#000000">
  <tr class="content" bgcolor="#ffffff">
    <td width="22%">
      工具名称
    </td>
    
    <td width="78%">
      说明
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      ClearCase
    </td>
    
    <td>
      大型商用软件，已被IBM公司收购，但国内市场拓展有限，因此服务支持会受到限制。现在中国用户的支持是由位于澳大利亚悉尼的支持中心联系
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      Firefly
    </td>
    
    <td>
      大型商用软件，已在中国成立分公司，全面拓展市场之中，在北京设有支持中心
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      CVS
    </td>
    
    <td>
      做为开源软件，无官方支持，需要用户自己查找资料解决技术问题，现在也出现专门为CVS做技术支持的公司
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      PVCS
    </td>
    
    <td>
      在中国市场开拓有限，国内没有支持中心
    </td>
  </tr>
  
  <tr class="content" bgcolor="#ffffff">
    <td>
      VSS
    </td>
    
    <td>
      做为微软的非核心产品，技术支持有限。在其网站上有提供一些常见问题，只有对正式购买的用户提供一定的技术支持
    </td>
  </tr>
</table>

本文转自：http://www.uml.org.cn/pzgl/200704061.asp
