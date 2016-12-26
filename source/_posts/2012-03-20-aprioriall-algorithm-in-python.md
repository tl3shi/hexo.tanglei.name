---
id: 1584
title: 序列模式挖掘-AprioriAll算法详解(附python源码)
date: 2012-03-20T19:24:25+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1584
duoshuo_thread_id:
  - 1351844048792453318
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - python
  - 我不会算法
  - 数据挖掘
tags:
  - python
  - 数据挖掘
---
&#160;&#160;&#160;&#160;&#160; 序列数据是非常重要的一种，在很多领域里面都频繁出现，例如：医药，商业，财政，客户行为，教育，安全等等。相关研究可以大致将序列数据的挖掘分为两类，发现序列模式和挖掘周期模式。Agrawal 等人<sup>[1]</sup>首次提出了挖掘频繁序列模式，利用支持度的概念来发现频繁模式，AprioriALL算法也是一种基于Apriori性质的算法，采用逐层搜索的算法来挖掘模式。<a href="http://rakesh.agrawal-family.com/papers/icde95seq.pdf" target="_blank">这篇论文</a>本身还讲了另外基于Apriori的变种序列模式挖掘算法，AprioriSome和DynamicSome。下面将根据这篇论文和结合自己的理解来说明下AprioriAll算法。总体来说，自我感觉这个AprioriAll算法相当于利用了两次前面提到的<a href="/blog/apriori-algorithm-in-python.html" target="_blank">Apriori算法</a>，中间包含一个频繁项的映射Map。区别在于其**支持度的定义有所区分**：本文所述的序列模式的支持度是指支持某特定某次的**custom数量**，而前面提到的关联规则Apriori算法中的支持度是在项集的交易数量上（就是下面的**baskets数量**）。

&#160;&#160;&#160;&#160;&#160; AprioriAll算法大致分为5个步骤：

  1. **Sort Phase**：排序阶段，这个过程将根据客户ID和交易时间排序。在本文中，这一步在初始化读取交易数据文件时完成。
  2. **Litemset Phase**：频繁项集挖掘阶段，这个过程相当于利用了一次Apriori算法，找出所有大于给定支持度的频繁项集。为后面的转换成map阶段做准备工作。
  3. **Transformation Phase**：转化阶段，利用上面生成的频繁项集，扫描原交易序列数据，根据构造出的Map进行映射得到新的序列。
  4. **Sequence Phase**：序列阶段，根据上一步得到的新序列数据集，再进行一次Apriori算法，得到新的"频繁项集"。
  5. **Maximal Phase**：最大化序列阶段，经过以上步骤后将得到所有满足条件的序列模式，然后找出‘最大长度’的序列模式，即删除其父模式也在这个集合里的模式。

举个例子：

[<img title="AprioriAll算法" border="0" alt="AprioriAll算法" src="/wp-content/uploads/2012/03/image2.png" />](/wp-content/uploads/2012/03/image2.png) 

以上为输入序列数据文件，此文件代表5个custom的购买记录，每行代表一个basket，用空行将custom间隔开。表示成的序列seqences为：

  * seq1:<(30)(90)>,
  * seq2:<(10,20)(30)(40,60,70)>
  * seq3:<(30,50,70)>
  * seq4<(30),(40,70),(90)>
  * seq5<(90)>

然后就是**LitemPhase(频繁项集挖掘阶段)：**假设给定支持度阈值0.4，则项集计算最小的重复次数应该为supportCount=0.4\*len(sequcences)=0.4\*5=2。同样首先得到频繁1项集，为\[&#8217;30&#8217;], [&#8217;40&#8217;], [&#8217;70&#8217;], [&#8217;90&#8217;] （因为10只在seq2中出现一次，<supportCount,排除掉，其他以此类推），然后再根据频繁1项集生成候选2项集，这个过程可以利用Apriori性质，为[[&#8217;30&#8217;, &#8217;40&#8217;], [&#8217;30&#8217;, &#8217;70&#8217;], [&#8217;30&#8217;, &#8217;90&#8217;], [&#8217;40&#8217;, &#8217;70&#8217;], [&#8217;40&#8217;, &#8217;90&#8217;], [&#8217;70&#8217;, &#8217;90&#8217;]]，再次扫描原交易序列数据，得到频繁2项集[&#8217;40&#8217;, &#8217;70&#8217;\](分别在seq2和seq4中出现)。重复这个过程<del datetime="2013-01-12T07:57:43+00:00">知道</del>直到不能产生候选项集为止。本例中得到的频繁项集为4个频繁1-itemset和1个频繁2-itemset：[[&#8217;30&#8217;], [&#8217;40&#8217;], [&#8217;70&#8217;], [&#8217;90&#8217;], [&#8217;40&#8217;, &#8217;70&#8217;]]。

接下来是**Mapping转换阶段**，构造一个Map，例如本例中transformation map :{1: [&#8217;30&#8217;], 2: [&#8217;40&#8217;], 3: [&#8217;70&#8217;], 4: [&#8217;90&#8217;], 5: [&#8217;40&#8217;, &#8217;70&#8217;]}，然后再次扫描交易序列数据，得到新的序列数据集【<font color="red">update:此转换阶段有误，详见文末的解释</font>】：

  * newseq1:{1, 4}
  * newseq2: {1, 2, 3, 5},
  * newseq3: {1, 3}
  * newseq4:{1, 2, 3, 4, 5},
  * newseq5: {4}

然后， **Sequence Phase**：序列阶段，采取同样的方式计数，子集在newseq中则count++,最后count数量大于supportCount保留下来，先得到频繁

  * 1-itemset：[1], [2], [3], [4], [5]，进而得到
  * 2-itemset：[1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 5], [3, 5]；
  * 3-itemset：[1, 2, 3], [1, 2, 5], [1, 3, 5], [2, 3, 5]
  * 4-itemset：\[1, 2, 3, 5\] (这个很明显，在newseq2和newseq4中出现两次刚好等于给定的阈值)

最后就是**Maximal Phase**最大化序列阶段，例如在本例中，一个频繁3-itemset:[1, 2, 3],就包含了频繁1-itemset3个，频繁2-itemset也是3个（[1, 2], [1, 3],[2, 3], ）那么这些被包含的也都将被删除，悲剧的是它自己也被那个频繁4-itemset：[1, 2, 3, 5]包含，所以也删除掉。最后就剩下一个频繁2-itemset，和一个频繁4-itemset：[[1, 4], [1, 2, 3, 5]]，已经得到最大化的序列了，最后只需要根据前面用到的map，转换一下即可，即得到序列模式两个<[&#8217;30&#8217;], [&#8217;90&#8217;]> 和<[&#8217;30&#8217;], [&#8217;40&#8217;], [&#8217;70&#8217;], [&#8217;40&#8217;, &#8217;70&#8217;]>

整个过程完成了。近期学python，还是用python实现了，python中的列表多了几层，我就容易搞混淆，所以另外弄了几个类，使代码好看些。哈哈。

参考代码如下。

```python
'''
Created on Mar 15, 2012
@author: tanglei|www.tanglei.name
'''
import copy
import math
import re

class Basket():
    items=[]#Apple,orange,....
    def __init__(self,items):
        self.items = items
    def setItems(self,items):
        self.items = items
    def __str__(self):
        mystr='Basket[ '
        for i in self.items:
            mystr = mystr + i +' , '
        mystr += ']'
        return mystr
            
class Custom():
    baskets=[]#basket1,basket2
    mapNums=set()#maped num
    def __init__(self,baskets):
        self.baskets = baskets
    def setBaskets(self,baskets):
        self.baskets = baskets
    def setMapedNums(self,mapNums):
        self.mapNums = mapNums
    def  __str__(self):
        mystr='Custom[ '
        for i in self.baskets:
            mystr = mystr + i.__str__() +' , '
        mystr += ']'
        return mystr
    def getMapedNums(self):
        return self.mapNums
        
class AprioriAll():
    customs=[]
    minSuppCount = 0#count  number ,considering the min_supp and the num of transactions
    allBaskets=[]
    transMap={}
    def __init__(self,min_supp=0.4,datafile='aprioriall.txt'):
        inputfile = open(datafile,"r")
        self.min_supp = min_supp
        baskets=[]
        self.customs=[]
        for line in inputfile.readlines():
            if(line != "\n"):
                items = re.compile(r"\w+").findall(line)
                basket = Basket(items)
                baskets.append(basket)
            else:
                custom = Custom((baskets))
                self.customs.append(custom)
                baskets=[] 
        #add the last custom         
        custom = Custom((baskets))
        self.customs.append(custom)
        
        self.minSuppCount = math.ceil(min_supp * len(self.customs))
        
    def sortPhase(self):
        '''sort the transaction db :with  customer-id as the major key and 
        transaction-time as the minor key. '''
        #has been done in the constructor
        pass
    
    def litemsetPhase(self):
        ''' find all the fequent-itemsets whose support is above the threshold'''
        litemset = []
        items = []
        allBaskets = []
        for custom in self.customs:
            for basket in custom.baskets:
                allBaskets.append(basket)
                for item in basket.items:
                    if [item] not in items:
                        items.append([item])
                    
        items.sort()
        
        #remove who blow the threshold
        candidates=items
        while True:
            temp=[]
            for item1 in candidates:
                count = 0
                for basket in allBaskets:
                    set1 = set(item1)
                    if set1.issubset(basket.items):
                        count += 1
                if count >= self.minSuppCount:
                    print("Frequent %d-itemset : %s" %(len(item1),item1))
                    temp.append(item1)
                    litemset.append(item1)
            
            candidates = self.__genCandidate(temp)
            if len(candidates) == 0 :
                break
        self.allBaskets = allBaskets
        return litemset
    
    def transformationPhase(self,transmap):
        for custom in self.customs:
            mapNums=set()#store the maped numbers of each custom
            for basket in custom.baskets:
                for k in transmap.keys():
                    s1 = set(transmap[k])
                    s2 = set(basket.items)
                    if s1.issubset(s2):
                        mapNums.add(k)
            custom.setMapedNums(mapNums)   
            
    def sequencePhase(self,mapNums):
        
        item1set = set()#
        for num in mapNums :
            item1set=item1set.union(num)
                      
        item1list=list(item1set)
        item1list.sort()
        
        seqresult=[]
        candidates=[]
        for item in item1list:
            candidates.append([item])
        while True:
            for item in candidates:
                count = 0 
                for seq in mapNums:
                    s1 = set(item)
                    if s1.issubset(seq):
                        count += 1
                if count >= self.minSuppCount:
                    print("Frequent %-itemsets : %s" %(len(item),item))
                    seqresult.append(item)       
            candidates = self.__genCandidate(candidates) 
            if len(candidates) == 0 :
                break
        return seqresult
    def maxSeq(self,seqs):
        maxSeq=copy.deepcopy(seqs)
        for seq in seqs:
            t_set = set(seq)
            for seq1 in seqs:
                t_set1 = set(seq1)
                if t_set1 != t_set and t_set1.issuperset(t_set):
                    maxSeq.remove(seq)
                    break
        return self.__map2seq(maxSeq)          
    def createTransMap(self,litemset):
        transmap = {}
        value = 1
        for each in litemset:
            transmap[value]=each
            value += 1
        self.transMap = transmap
        return transmap
    
    def __map2seq(self,seqs):
        #transform numseq to original seq
        origSeqs = []
        for seq in seqs:
            origSeq=[]
            for item in seq:    
                origSeq.append(self.transMap[item])
            origSeqs.append(origSeq)
        return origSeqs    
    def __genCandidate(self,frequentItems):    
        #gen new canidate
        length = len(frequentItems) 
        result = []#add one item   
        for i in range(length):
            for j in range(i+1,length):
                if self.__lastDiff(frequentItems[i],frequentItems[j]):
                    item = copy.deepcopy(frequentItems[i])
                    item.insert(len(frequentItems[i]),frequentItems[j][len(frequentItems[j])-1])
                    if False == self.__has_inFrequentItemsets(frequentItems, item):
                        result.append(item)
        return result
    #check if there is none  subsets of item in the frequentItems 
    def __has_inFrequentItemsets(self,frequentItems,item):
        import SetTool
        subs = SetTool.getSubSets(item,len(item)-1) 
        for each in subs:
            flag=False
            for i in frequentItems:
                if i == each:
                    flag=True
                    break 
            if flag==False:
                return True  
        return False #there is at least one subset in the freq-items
        
    def __lastDiff(self,items1,items2):
        if len(items2) != len(items1):#length should be the same
            return False
        if items1 == items2:#if all the same,return false
            return False
        return items1[:-1] == items2[:-1]    

if __name__ == '__main__':
    aa = AprioriAll(min_supp=0.4,datafile='aprioriall2.txt')
    litemset = aa.litemsetPhase()
    print("litemset:");print(litemset)
    transmap = aa.createTransMap(litemset);
    print("transformation map :");print(transmap)
    aa.transformationPhase(transmap)
    customs = aa.customs
    mapNums = []
    for each in customs:
        mapNums.append(each.getMapedNums())
    seqNums = aa.sequencePhase(mapNums)
    maxSeqs= aa.maxSeq(seqNums)
    print("The sequential patterns :");print(maxSeqs)
```

利用例子中的数据，运行结果如下：
  
[cc lang=&#8221;python&#8221;]
  
Frequent 1-itemset : [&#8217;30&#8217;]
  
Frequent 1-itemset : [&#8217;40&#8217;]
  
Frequent 1-itemset : [&#8217;70&#8217;]
  
Frequent 1-itemset : [&#8217;90&#8217;]
  
Frequent 2-itemset : [&#8217;40&#8217;, &#8217;70&#8217;]
  
litemset:
  
[[&#8217;30&#8217;], [&#8217;40&#8217;], [&#8217;70&#8217;], [&#8217;90&#8217;], [&#8217;40&#8217;, &#8217;70&#8217;]]
  
transformation map :
  
{1: [&#8217;30&#8217;], 2: [&#8217;40&#8217;], 3: [&#8217;70&#8217;], 4: [&#8217;90&#8217;], 5: [&#8217;40&#8217;, &#8217;70&#8217;]}
  
Frequent 1temsets : [1]
  
Frequent 1temsets : [2]
  
Frequent 1temsets : [3]
  
Frequent 1temsets : [4]
  
Frequent 1temsets : [5]
  
Frequent 2temsets : [1, 2]
  
Frequent 2temsets : [1, 3]
  
Frequent 2temsets : [1, 4]
  
Frequent 2temsets : [1, 5]
  
Frequent 2temsets : [2, 3]
  
Frequent 2temsets : [2, 5]
  
Frequent 2temsets : [3, 5]
  
Frequent 3temsets : [1, 2, 3]
  
Frequent 3temsets : [1, 2, 5]
  
Frequent 3temsets : [1, 3, 5]
  
Frequent 3temsets : [2, 3, 5]
  
Frequent 4temsets : [1, 2, 3, 5]
  
The sequential patterns :
  
[[[&#8217;30&#8217;], [&#8217;90&#8217;]], [[&#8217;30&#8217;], [&#8217;40&#8217;], [&#8217;70&#8217;], [&#8217;40&#8217;, &#8217;70&#8217;]]]
  
```

&#160;

<font size="5" color="red">【update,2013-1-12】</font>
  
以上文章是大四时写的，之前有读者指出了错误之处。后发现确实有误，在mapping阶段，本来第一个cusomer的序列是[<30>,<90>]是两次购物数据，不能笼统的合并成[30,90]即上述本文中的newseq1：{1,4}，同理newseq2也应该是[(1),(2,3,5)]&#8230;&#8230;这影响了后面子集的计算，举个例子而言比如 [(3) (5)]不是[(3 5)]的子集，因为前者代表先买了3，再买的5，而后者是3，5一起买的……因此上述算法逻辑有问题。
  
【BUT】在参考文献提到的原论文中也有没有理解到的地方，后面再找时间向高手咨询咨询。例如文章中的
  
[<img src="/wp-content/uploads/2012/03/aprioriall_in_paper.jpg" alt="aprioriall算法例子" title="aprioriall_in_paper"  class="aligncenter size-full wp-image-2027" />](/wp-content/uploads/2012/03/aprioriall_in_paper.jpg)
  
从中可以看出，明显[{1}{2,3,4}]和[{1}{5}]是最大的频繁序列，如果这个时候再根据mapping后跟我得到的结果应该是一样的。不知道是不是再根据map返回原始的数据的时候得经过处理，即将得到的[[&#8217;30 &#8216;], [&#8217;40&#8217;], [&#8217;70 &#8216;], [&#8217;40&#8217;, &#8217;70 &#8216;]]直接合并成 [[&#8217;30 &#8216;], [&#8217;40&#8217;, &#8217;70 &#8216;]]，这样就比较符合预期的结果。但是……这个过程在原文中也并没有讲呀。。。还不知道怎么解释比较合理，期待哪位高手帮忙解释下……
  
网上查找相关资料也仅仅是参考这个论文，并没有详细完整的把那个例子讲完……
  
<font size="5" color="red">【/update】</font>

参考文献 

<hr align="left" size="1" width="33%" />

[1]Agrawal,R.,Srikant,R.,Institute of Electric and Electronic Engineer et al.**Mining sequential patterns**[C].Proceedings of the Eleventh International Conference on Data Engineering, Washington DC, USA: IEEE Computer Society,1995:3-14.
