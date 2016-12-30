---
id: 539
title: 软件度量考点答案
date: 2011-04-26T23:25:49+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=539
duoshuo_thread_id:
  - 1351844048792453187
categories:
  - 课程学习
tags:
  - 软件度量
---
经过了答疑，去掉了一些不考的点。最后版本出来了……

1、 **概念**：

测量的定义：用数字或符号来表示真实世界中实体属性从而根据定义的规则来表示实体的过程。

度量的定义：由用户设想设计出来，用可信和有意义的方式来展示选择特性。

Metrics are conceived by the user and designed to reveal a chosen characteristic in a reliable and meaningful manner.

**软件度量的定义**：用来量化软件产品，软件开发资源和软件开发过程的度量。包括可直接测量的对象如代码行，也包括通过测量计算得到的对象如软件质量。

Why Use Software Metrics：

Without metrics there is no way to determine if the process is improving.

Metrics allow the establishment of meaningful goals for improvement. A baseline from which improvements can be measured

When metrics are applied to a product they help identify:

which user requirements are likely to change

which modules are most error prone

how much testing should be planned for each module.

**为什么要用软件度量**：

没有软件度量，就没有一种方法去决定过程是否在改进。

软件度量为改进建立起有意义的目标，建立一个可以测量改进的基线。

当度量应用到产品时，帮助识别用户需求可能的改变，很可能出错的模块，以及计划测试每个模块的花费。

(需要软件度量的原因： 任何工程化的工作都需要度量，软件工程也不例外;准确了解工程的实施情况项目实施之前: 辅助制定软件项目的计划, 估算成本和工作量，以便制定计划

项目实施过程中: 提供软件开发的可视性,跟踪和控制软件项目的开发,评估软件开发质量，进行质量控制,加强风险管理项目实施之后:对项目的实施情况进行评估,为后续项目的积累经验数据)

2、 **测量有哪些尺度类型？他们之间有什么区别？测量作为过程，有哪些阶段？**

<table>
  <tr>
    <td width="678" valign="top">
      标定尺度、类型尺度、序列尺度、间隔尺度、比例尺度、绝对尺度。
    </td>
  </tr>
  
  <tr>
    <td width="678" valign="top">
      标定和类型尺度属于语言尺度(Linguistic)。</p> 
      
      <table>
        <tr>
          <td width="662" valign="top">
            标定尺度：为了识别出名词性的尺度度量，用语义性表达表示实体。标定尺度给出了唯一且不含糊的概念名称并且定义技术也属于标定尺度；</p> 
            
            <p>
              特点：由经验关系系统只包含不同的类;这些类中没有顺序的概念。
            </p>
            
            <p>
              描述类的数值或符号都是合理的度量，但是数值或符号之间却没有相互结合的重要性的概念。</td> </tr> 
              
              <tr>
                <td width="662" valign="top">
                  类型尺度识别实体中已经定义且命名的类型或种类（categories），也叫绝对标定尺度。
                </td>
              </tr>
              
              <tr>
                <td width="662" valign="top">
                  序列尺度估计已测量的实体的值并将他们按顺序重组排列，值和顺序均表达为字符或符号。</p> 
                  
                  <p>
                    特点：关系系统中包含的类会以类的属性特征去排列。
                  </p>
                  
                  <p>
                    排序相对应的映射都是合理的。
                  </p>
                  
                  <p>
                    序列号只是代表一个秩，所以类似于加法，减法等运算符都没有具体的含义。</td> </tr> </tbody> </table> 
                    
                    <p>
                      间隔尺度、比例尺度和绝对尺度属于定量尺度。
                    </p>
                    
                    <p>
                      间隔尺度用于发现增长间隔而不是比例，没有不合理的0间隔（后半句话翻译不好）；
                    </p>
                    
                    <p>
                      比例尺度允许比例的计算并且允许合理的0参考点；
                    </p>
                    
                    <p>
                      绝对尺度用于计数(count)，只有一种可能的绝对属性测量。
                    </p>
                    
                    <p>
                      区别：
                    </p>
                    
                    <table>
                      <tr>
                        <td width="77" valign="top">
                          度量类型
                        </td>
                        
                        <td width="585" valign="top">
                          特点
                        </td>
                      </tr>
                      
                      <tr>
                        <td width="77" valign="top">
                          标定尺度
                        </td>
                        
                        <td width="585" valign="top">
                          实体被分类，所有算术都没意义
                        </td>
                      </tr>
                      
                      <tr>
                        <td width="77" valign="top">
                          序列尺度
                        </td>
                        
                        <td width="585" valign="top">
                          实体被分类并排序，不能使用加减法
                        </td>
                      </tr>
                      
                      <tr>
                        <td width="77" valign="top">
                          间隔尺度
                        </td>
                        
                        <td width="585" valign="top">
                          实体被分类，排序，两个实体间有单位的区别，没有0基准点，可以使用一般的加减法（温度）
                        </td>
                      </tr>
                      
                      <tr>
                        <td width="77" valign="top">
                          比例尺度
                        </td>
                        
                        <td width="585" valign="top">
                          有0基准点，单位，各实体间有倍率的关系，所有算术都能用
                        </td>
                      </tr>
                      
                      <tr>
                        <td width="77" valign="top">
                          绝对尺度
                        </td>
                        
                        <td width="585" valign="top">
                          计数，只有一种可能的度量，所有算术都能用
                        </td>
                      </tr>
                    </table></td> </tr> 
                    
                    <tr>
                      <td width="678" valign="top">
                        测量作为过程，有3个阶段：感知(Cognitive)、语义(Semantic)、数字化(Quantitative)。
                      </td>
                    </tr></tbody> </table> 
                    
                    <p>
                      3、<strong> 软件度量有哪些实体类型？</strong>
                    </p>
                    
                    <p>
                      软件度量的实体类型：
                    </p>
                    
                    <p>
                      ①过程（process）：软件开发中活动的集合。不同的软件开发模式中，所采用的流程和活动也不一样；<br /> ②产品（product）：软件过程活动的结果，可以是一个程序、一个软件文档或其他任何交付物；<br /> ③资源（resource）：实施这些活动所需要的对象，可能是人力、设备、时间等。
                    </p>
                    
                    <p>
                      4、 <strong>什么是功能点分析？特征点、对象点和功能点有什么不同？</strong>
                    </p>
                    
                    <table>
                      <tr>
                        <td width="668" valign="top">
                          The function point of a software is the product of Unadjusted Function Count (UFC) and Value Adjustment Factor (VAF).软件的功能点是未调节功能计数与值调节因子的乘积。UFC</p> 
                          
                          <p>
                            Calculation of UFC involves physical counting of structural elements (on absolute scale) and choosing the weighting factors (on ordinal scale) according to the complexity level. The count and the weighting factor are multiplied to determine the function count.计算UFC涉及到结构元素的物理计数(绝对尺度)，和根据复杂程度选择权重因子(序列尺度)，计数和权重的乘积决定了功能的计数。
                          </p>
                          
                          <p>
                            VAF：These factors are evaluated on a scale (ordinal scale) that runs from 0 to 5。共涉及14个方面的问题，序列尺度从0-5选值。
                          </p>
                          
                          <p>
                            UFC:用户输入、用户输出、查询、文件、外部接口
                          </p>
                          
                          <p>
                            功能点分析是对产品中未调整的函数数量(UFC)及值调整因子(VAF)的分析计算。
                          </p>
                          
                          <p>
                            FP=UFC*VAF。
                          </p>
                          
                          <p>
                            生产率=FP/人月。
                          </p>
                          
                          <p>
                            文档=文档页数/FP。</td> </tr> 
                            
                            <tr>
                              <td width="668" valign="top">
                                <table>
                                  <tr>
                                    <td width="648" valign="top">
                                      特征点计算方式：UfeC = 4Ni+5No+4Nq+7Nef+7Nif + 3Na.分别是No. Of 外部输入，外部输出，外部查询，外部接口文件，内部文件，算法。</p> 
                                      
                                      <p>
                                        特征点分析扩展了功能点计数到实时和TLC环境(MIS&RT&SC)。
                                      </p>
                                      
                                      <p>
                                        当应用的算法数量及逻辑数据文件数相同时，功能点和特征点产生相同的结果；
                                      </p>
                                      
                                      <p>
                                        应用于RT项目时，特征点会比功能点高出20%~35%；
                                      </p>
                                      
                                      <p>
                                        应用于MIS项目时，结果几乎完全相同；
                                      </p>
                                      
                                      <p>
                                        当应用于更复杂的系统软件形态时，特征点的计数要高的显著的多。</td> </tr> 
                                        
                                        <tr>
                                          <td width="648" valign="top">
                                            对象点是应用于开发循环早期的一种初始规模度量技术。每个对象被分成简单、中等、困难3个等级。度量由使用的窗口(screen)、报告(reports)、组件(components)的计数来决定。功能点则是对产品中使用的功能函数的计数来度量程序。
                                          </td>
                                        </tr></tbody> </table> </td> </tr> </tbody> </table> 
                                        
                                        <p>
                                          <strong>5、 什么是用例点分析？</strong>
                                        </p>
                                        
                                        <table>
                                          <tr>
                                            <td width="668" valign="top">
                                              Use Case Point: in 1993, Gustav Karner，Use-Case is a method to develop requirements in object-oriented analysis and design. 93年，GK这家伙提出滴，用面向对象分析和设计思想来提高需求的一种方法。</p> 
                                              
                                              <p>
                                                Step 1: the total unadjusted actor weights (UAW) 未平衡用例角色数(UAW) 分3个等级，简单-平均-复杂。分别取值123.
                                              </p>
                                              
                                              <p>
                                                Simpler：另一个已经定义的API ；
                                              </p>
                                              
                                              <p>
                                                Average：通过协议(eg TCP/IP)跟另外的系统交互，或者通过控制台跟人交互；
                                              </p>
                                              
                                              <p>
                                                Complex：人通过GUI交互.
                                              </p>
                                              
                                              <p>
                                                Step 2: the total unadjusted use case weights (UUCW) 未平衡用例数(UUCW) 分3个等级，也是简单-平均-复杂。分别取值5-10-15。
                                              </p>
                                              
                                              <p>
                                                事务型：4-7个事务为平均；
                                              </p>
                                              
                                              <p>
                                                分析型：5-10个分析类为平均。
                                              </p>
                                              
                                              <p>
                                                Step 3: the unadjusted use case points (UUCP) UUCP = UAW + UUCW，未平衡用例点(UUCP，其中：UUCP = UAW + UUCW) Step 4: technical Complexity Factor (TCF) ，TCF=0.6+(0.01*TFactor) 技术复杂度因子(TCF其中：TCF=0.6+(0.01*TFactor)) Step 5: the Environmental Factor (EF)，EF= 1.4+(-0.03*EFactor) 环境因子(EF其中：EF =1.4+(-0.03*EFactor)) Step 6: the adjusted use case points (UPC)，UPC= UUCP*TCF*EF。平衡用例点(UCP其中：UCP= UUCP*TCF*EF)</td> </tr> </tbody> </table> 
                                                
                                                <p>
                                                  <strong>6、 Halstead方法是如何进行软件度量？</strong>
                                                </p>
                                                
                                                <p>
                                                  Halstead方法是一种程序复杂度度量方法。Halstead度量方法不仅仅度量了程序长度，还描述了程序的最小实现和实际实现之间的关系，并据此阐释程序语言的等级高低。它以程序中出现的操作符和操作数为计数对象，以它们的出现次数作为计数目标来测算程序容量和工作量。
                                                </p>
                                                
                                                <p>
                                                  Halstead理论：程序是一组记号，由两种基本的元素组成：操作数，操作符。
                                                </p>
                                                
                                                <p>
                                                  操作数：变量，常量，地址空间           操作符：编程语言中定义的操作
                                                </p>
                                                
                                                <p>
                                                  μ1: 不同操作符的数量 μ2: 不同操作数的数量 N1：操作符出现的总数量 N2=操作数出现的总数量
                                                </p>
                                                
                                                <p>
                                                  Halstead方法与代码行相比，拥有合理的理论和实际基础，并且定义清晰，语义可靠，对具体的编程语言依赖性小，能为早期的设计提供支持，并且对开发人员技术的依赖性较小。
                                                </p>
                                                
                                                <p>
                                                  <strong>7、 代码行LoC 度量</strong>
                                                </p>
                                                
                                                <p>
                                                  SLOC/NCLOC:non-commented source line of code or effective lines of code.不带注释的代码行数。
                                                </p>
                                                
                                                <p>
                                                  CLOC：comented source line of code。注释代码行数
                                                </p>
                                                
                                                <p>
                                                  Total length LoC = SLOC + CLOC
                                                </p>
                                                
                                                <p>
                                                  Advantages of LoC 优点<br /> Simple and automatically measurable 测试简单可以自动化测试 Correlates with programming effort (& cost) 可以跟编程人力和成本关联起来Disadvantage of LoC 缺点 Vague definition 模糊的定义 Language dependability 依赖与语言类型 Not available for early planning 早期不适用 Developers’ skill dependability 依赖于开发者技术经验
                                                </p>
                                                
                                                <p>
                                                  <strong>8、 什么是COCOMO模型？如何采用COCOMO模型进行成本估计？</strong>
                                                </p>
                                                
                                                <table>
                                                  <tr>
                                                    <td width="671" valign="top">
                                                      概念</p> 
                                                      
                                                      <p>
                                                        COCoMo是指Constructive Cost Model，构造性成本模型，Boehm于1981年提出，用于对软件开发项目的规模、成本、进度等方面进行估算
                                                      </p>
                                                      
                                                      <p>
                                                        CoCoMo模型是一个综合经验模型，模型中的参数取值来至于经验值，并且综合了诸多的因素、比较全面的估算模型
                                                      </p>
                                                      
                                                      <p>
                                                        比较实用、可操作，在欧盟国家应用较为广泛
                                                      </p>
                                                      
                                                      <p>
                                                        CoCoMo模型的层次 － 支持不同的阶段
                                                      </p>
                                                      
                                                      <p>
                                                        基本COCoMo模型
                                                      </p>
                                                      
                                                      <p>
                                                        系统开发的初期，估算整个系统的工作量(包括维护)和软件开发和维护所需的时间
                                                      </p>
                                                      
                                                      <p>
                                                        中间COCoMo模型
                                                      </p>
                                                      
                                                      <p>
                                                        估算各个子系统的工作量和开发时间
                                                      </p>
                                                      
                                                      <p>
                                                        详细COCoMo模型
                                                      </p>
                                                      
                                                      <p>
                                                        估算独立的软构件，如各个子系统的各个模块的工作量和开发时间.(详细COCOMO模型：将软件系统模型分为系统、子系统和模块三个层次)
                                                      </p>
                                                      
                                                      <p>
                                                        根据不同应用软件的不同应用领域,COCOMO模型划分为如下3种软件应用开发模式:
                                                      </p>
                                                      
                                                      <p>
                                                        组织模式(Organic Mode).这种应用开发模式的主要特点是在一个熟悉稳定的环境种进行项目开发,盖项目与最近开发的<a>其他</a>项目有很多相似点,项目相对较小,而且并不需要许多创新.
                                                      </p>
                                                      
                                                      <p>
                                                        嵌入式应用开发模式 (Embedded Mode).在这种应用开发模式种,项目受到接口要求的限制.接口对整个应用的开发要求非常搞,而且要求项目有很大的创新,例如开发一种全新的游戏.
                                                      </p>
                                                      
                                                      <p>
                                                        中间应用开发模式(也叫半独立型) (Semidetached Mode).这时介于组织模式和嵌入式应用开发模式之间的类型.
                                                      </p>
                                                      
                                                      <p>
                                                        基本CoCoMo模型
                                                      </p>
                                                      
                                                      <p>
                                                        E = a (kLOC)b ;E是工作量(人月) ，a和b是经验常数
                                                      </p>
                                                      
                                                      <p>
                                                        D = c Ed ;D是开发时间(月) ，c和d是经验常数
                                                      </p>
                                                      
                                                      <p>
                                                        中间CoCoMo模型
                                                      </p>
                                                      
                                                      <p>
                                                        E = a (kLOC)b *EAF
                                                      </p>
                                                      
                                                      <p>
                                                        其中，E表示工作量(人月)，EAF表示工作量调节因子，a,b为经验常数
                                                      </p>
                                                      
                                                      <p>
                                                        EAF的取值(考虑15个因素)
                                                      </p>
                                                      
                                                      <p>
                                                        软件产品属性(3)：软件可靠性，软件复杂性，数据库的规模
                                                      </p>
                                                      
                                                      <p>
                                                        计算机属性(4)：程序执行时间，程序占用内存大小，软件开发环境的变化，软件开发环境的响应速度
                                                      </p>
                                                      
                                                      <p>
                                                        人员属性(5)：分析员能力，程序员能力，领域经验，开发环境的经验，程序设计语言的经验
                                                      </p>
                                                      
                                                      <p>
                                                        项目属性(3)：软件开发方法的能力，软件工具的数量和质量，软件开发的进度要求
                                                      </p>
                                                      
                                                      <p>
                                                        EAF的取值(范围)
                                                      </p>
                                                      
                                                      <p>
                                                        很低、低、正常、高、很高、极高，正常情况下 Fi=1
                                                      </p>
                                                      
                                                      <p>
                                                        Boehm建议取值范围[0.70-1.66]
                                                      </p>
                                                      
                                                      <p>
                                                        EAF的计算＝ΠFi  ( i=1..15)
                                                      </p>
                                                      
                                                      <p>
                                                        调节因子及其取值由统计结果和经验决定，不同的软件开发组织在不同的时期可能会有不同的取值
                                                      </p>
                                                      
                                                      <p>
                                                        使用中间CoCoMo模型可以估算开发软件产品的工作量，比较各种开发方案的工作量。
                                                      </p>
                                                      
                                                      <p>
                                                        案例分析：用基本CoCoMo模型估算项目的工作量、开发时间和参加项目开发的人数
                                                      </p>
                                                      
                                                      <p>
                                                        CAD软件：目标代码行33.2kLOC，属于中等规模，半独立型，因而a = 3.0, b = 1.12, c = 2.5, d = 0.35
                                                      </p>
                                                      
                                                      <p>
                                                        E = 3.0*(33.2)1.12 =152 PM
                                                      </p>
                                                      
                                                      <p>
                                                        D = 2.5*(152)0.35 = 14.5 (月)
                                                      </p>
                                                      
                                                      <p>
                                                        参加项目人数N = E/D = 152/14.5 = 11(人)</td> </tr> </tbody> </table> 
                                                        
                                                        <p>
                                                          <strong>9、 什么是程序的环形复杂度？如何度量？</strong>
                                                        </p>
                                                        
                                                        <table>
                                                          <tr>
                                                            <td width="668" valign="top">
                                                              用McCabe方法度量得出的结果称为程序的环形复杂度。它等于强连通的程序控制结构图中线性无关的有向环的个数。所谓强连通图是指从图中任一个节点出发都可以到达所有其它节点。程序控制结构图通常不是强连通的，因为从图中较低的（即较靠近出口点的）节点往往不能到达较高的节点。然而，如果从出口点到入口点画一条虚弧．则程序控制结构图必然成为强连通的。
                                                            </td>
                                                          </tr>
                                                          
                                                          <tr>
                                                            <td width="668" valign="top">
                                                              McCabe方法的计算步骤分如下三步：</p> 
                                                              
                                                              <p>
                                                                步骤1：将程序流程图退化成有向图，即将程序流程图的每个处理框看作一个节点，将流线看作连接各节点的有向弧。
                                                              </p>
                                                              
                                                              <p>
                                                                步骤2：在有向图中，由程序出口到入口连接一条虚有向弧。
                                                              </p>
                                                              
                                                              <p>
                                                                步骤3：计算V（G）=m-n＋1
                                                              </p>
                                                              
                                                              <p>
                                                                其中，V（G）是有向图G中环数，m是有向图G中的弧数，n是有向图G中的节点数。
                                                              </p>
                                                              
                                                              <p>
                                                                实践表明，模块规模以V(G)≤10为宜，也就是说，V(G)=10是模块规模的一个更科学更精确的上限。</td> </tr> </tbody> </table> 
                                                                
                                                                <p>
                                                                  <strong>10、 面向对象度量中，CK方法和LK方法各提供了哪些度量指标？</strong>
                                                                </p>
                                                                
                                                                <table>
                                                                  <tr>
                                                                    <td width="668" valign="top">
                                                                      CK方法提供了：</p> 
                                                                      
                                                                      <p>
                                                                        WMC（Weighted Methods per Class，方法的权重和复杂性。方法数越大，对其潜在子类的影响越大，同时限制了重用的可能性）
                                                                      </p>
                                                                      
                                                                      <p>
                                                                        DIT（Depth of Inheritance，继承树深度，值越大，复杂度越大）
                                                                      </p>
                                                                      
                                                                      <p>
                                                                        NOC（Number of Children，子类数，直接继承于某个类的个数，指示一个类可能对系统和设计存在的潜在影响）
                                                                      </p>
                                                                      
                                                                      <p>
                                                                        CBO（Coupling Between Objects，类耦合度，过大说明类关系较多，维护困难）
                                                                      </p>
                                                                      
                                                                      <p>
                                                                        RFC（Response for a Class，类响应度，所有可以用于对一个对象的消息做出响应的方法个数）
                                                                      </p>
                                                                      
                                                                      <p>
                                                                        LCOM（Lack of Cohension，内聚度的缺乏，不同的方法用同样的变量实例集做出不同的表象叫存在内聚度）</td> </tr> 
                                                                        
                                                                        <tr>
                                                                          <td width="668" valign="top">
                                                                            LK方法提供了：</p> 
                                                                            
                                                                            <p>
                                                                              LOC（程序大小）
                                                                            </p>
                                                                            
                                                                            <p>
                                                                              CS（Class Size类大小，包含属性和操作的总数。过大可能说明类职责过多）
                                                                            </p>
                                                                            
                                                                            <p>
                                                                              NOO（重载类个数，NOO过大说明设计有问题，继承层次抽象度低）
                                                                            </p>
                                                                            
                                                                            <p>
                                                                              NOA（新增方法个数，说明设计漂移）
                                                                            </p>
                                                                            
                                                                            <p>
                                                                              SI（特殊的索引。过高说明层次中的类不符合抽象定义）
                                                                            </p>
                                                                            
                                                                            <p>
                                                                              DIT（继承树深度）等</td> </tr> </tbody> </table> 
                                                                              
                                                                              <p>
                                                                                <strong>11、 基于信息的度量中，Shepperd方法与Henry|Kafura方法有何不同？</strong>
                                                                              </p>
                                                                              
                                                                              <table>
                                                                                <tr>
                                                                                  <td width="668" valign="top">
                                                                                    基于信息的度量使用的是扇入扇出度量。</p> 
                                                                                    
                                                                                    <p>
                                                                                      1．Shepperd方法认为信息流复杂度M=((fan-in(M)*(fan-out(M))2，shepperd强调这方法是在初始阶段度量的改进。Henry|Kafura方法认为信息流复杂度M=length(M)*((fan-in(M)*(fan-out(M))2。
                                                                                    </p>
                                                                                    
                                                                                    <p>
                                                                                      2．Shepperd方法是一种较原始的改善，我们的指标特征是它们消除信息和控制流的模糊性，集中在信息流的度量上，而henry和kafura度量是不能做到的。</td> </tr> </tbody> </table> 
                                                                                      
                                                                                      <p>
                                                                                        <strong>12、 度量软件产品结构时，一般考虑哪三类结构？每个结构度量中考虑哪些因素?</strong>
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        测量产品内部属性：结构
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        The structure of requirements, design, and code may help the developers to understand the difficulty they sometimes have in converting one product to another, in testing a product, or in predicting external software attributes from early internal product measures, such as maintainability, testability, reusability, and reliability. 需求，设计，编码的结构可能有助于开发者明白把一个产品转换成另一个，测试一个产品，或者从一个早期内部产品的测试，预测软件外部属性，如可维护性，可测试性，可重用性，和可靠性，是有难度滴。-翻译得有点水。The structure of a product plays a part, not only in requiring development effort but also in how the product is maintained. 产品的结构不仅在开发时对人力的需求，而且在产品的维护上也扮演了重要作用。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Types of structural measures 结构度量分类
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Control-flow structure: the sequence in which instructions are executed in a program.控制流结构：指令在程序中执行的顺序。 Data-flow structure: the trail of a data item created or handled by a program. 数据流结构：一个程序中的数据项从创建到处理的轨迹。 Data structure: the organization of the data itself, independent of the program. 数据结构：数据本身的组织，独立于程序。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Control-flow structure: McCabe环路复杂度测量
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Data-flow structure:
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Data structure:halstead？
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        The overall “complexity” of a system can not be depicted completely without measures of data stucture.总体来说的一个系统的复杂度不能被完成的描述，要是没有数据结构的度量的话。 Control-flow measures can fail to identify complexity when it is hidden in the data structure.控制流测量对鉴别隐藏在数据结构中的复杂度时会失效。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        <strong>13、 ISO 9126质量模型，Bohem质量模型，McCall’s质量模型考虑了软件哪些主要质量因素？</strong>
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        ISO9126: 6个特性( 功能性、效率、易用性、 可靠性、 维护性、 可移植性)，27个子特性
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        Boehm模型的三层次式框架：可移植、可用、效率、人体工程、可维护（可测试、易理解、可修改）
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        McCall 正确性、可靠性、效率、完整性、可用性
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        <strong>14、 软件能力成熟度模型CMM.</strong>
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        A framework to determine process maturity。过程成熟度Initial: Few defined processes; success depends on individual effort.Repeatable: Cost, schedule, and product tracking processes in place.Defined: Standard processes are defined and used.Managed: Defined processes and product qualities are meaningfully measured.Optimizing: Measures used to improve process/product.
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        初始级：很少的定义过程，通过个人努力能够成功。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        可重复级：成本，进度和产品过程。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        已定义级：定义和遵循了标准过程。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        可管理级：良好定义的过程，产品质量可以良好测试。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        优化级：持续改进过程/产品。
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        <strong>15、 能够根据数据流图进行功能点计算，根据用例图进行用例点计算，根据类图进行面向对象度量.</strong>
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        LK:CS、NOO、NOA、SI = [NOO * L] / Mtotal
                                                                                      </p>
                                                                                      
                                                                                      <p>
                                                                                        CK:WMC[类中方法数量之和]、DIT、NOC、CBO[与此类关联的类的数量]、RFC[类中涉及到的方法，包括调用其他类滴]、LCOM[方法之间的含的成员变量。LCOM=没有交集的-有交集的]
                                                                                      </p>
