---
id: 1667
title: python Libsvm实例讲解
date: 2012-03-29T23:01:16+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1667
duoshuo_thread_id:
  - 1351844048792453254
categories:
  - 数据挖掘
tags:
  - libsvm
  - python
  - SVM
---
前面说了[windows命令行使用libsvm](/blog/an-example-for-beginning-to-learn-libsvm.html)，现在需要用python去调用。一种方法是用python去进行系统调用windows的exe程序。另外一种方法就是通过libsvm的python接口去调用。这里说的是第二种方法，即通过调用libsvm的python接口。

配置好环境后，这里就是说把dll文件(libsvm-3.11\windows\ libsvm.dll)copy到WINDOWS\system32\中。分为以下几个步骤，跟之前相比貌似少了scale阶段。这里利用libsvm-3.11\python下的svm.py和svmutil.py两个模块，其实其目录下有个README也讲了用法了。

  1. **准备数据**：一种方法是通过**svm\_read\_problem**方法直接读取libsvm格式的文件，返回分类标签([])和数据([[]])。如：labels, datas = **svm\_read\_problem**(&#8216;filename&#8217;) ,还有一种方法是直接python格式的，这种方法适用于在程序执行过程中动态产生的data，我要用到的就是这种，没必要把大量的数据都写入文件(这两天搞infominer算法挖掘序列数据模式并看预测效果是个苦力活呀)。python的libsvm处理数据也分为两种，一种是特征值连续的不用手动去表明各个属性值的index,即是说声调了 label index1:value1 index2:value2……中的index值，例如labels, datas = [1,-1], [[1,0,1], [-1,0,-1]],还有一种就是带index的，适合处理那些数据比较稀疏的，即好多特征值木有。labels, datas = [{1:1, 3:1}, {1:-1,3:-1}]
  2. **通过训练集training得到模型**：用到**svm_train**方法，传入labels，datas必要的参数，返回model。也有两三种方案，一是直接调用model = **svm_train**(labels,data, &#8216;-h 0&#8217;)，将必要的参数’-h 0’传入(这个参数-h shrinking 默认为1，我开始跑的时候时间太久了，程序提示我better设置0，说是可以跑faster)。另外的一/两种是先labels和data作为一个整体prob传入，整体构成通过**svm_problem**(labels, datas)得到，然后再调用**svm_train**(prob, param)训练得到model，这里的param可以直接以’-h 0’字符串的形式，也可以通过param = svm_parameter(&#8216;-c 4 -b 1&#8217;)得到，因此说这是第二或者三种方案。通过调用此方法，在svmutil内部会将部分信息直接打印到控制台，跟前面说的用windows命令行train时的信息一样，效果可以看<a href="/wp-content/uploads/2012/03/clip_image0061.jpg" target="_blank">这个图片</a>。
  3. **利用model进行预测：**这里的model可以是上一步返回的model，或者从外部文件载入的model。预测的方法是**svm_predict**(testClassfier,testSeqVector,model),参数分别是测试集的实际labels，测试数据特征向量，训练模型，当然还有一个可选的参数就是predict的是否需要评估概率的参数-b 0 or 1,默认为0，还说对于一类的SVM(**可能**用于检测outlier吧)，只能用默认的0。例如p\_label, p\_acc, p_val = **svm_predict**(y, x, m, &#8216;-b 1&#8217;)，这里返回了3个值，分别是预测的label列表([]),准确率p\_acc(三元组())用于分类的准确率,回归的mean-squared error和squared correlation coefficient,具体的我还得补充下统计学相关知识,p\_val的值是概率估计值(如果传入了参数-b 1)，否则就决策值([[]])，注意返回的其中每一个元素是一个包含k*(k-1)/2个float的数组[],k代表label的类别，其中每一个float就是预测属于哪一类的概率(其下标顺序与传入的labels数组一样)。官方里还介绍了ACC, MSE, SCC = **svmutil.evaluations**(true\_val, predict\_val)这个方法，说是计算准确率啊啥啥的(跟前面提到的svm_predict返回结果的第二个值的三元组**不一样**哦)，猜测是用于回归的吧，我就没研究过了。注意这里的predict是个一维数组[]，不能利用上面svm_predict产生的结果第三个值。

遗留问题是，前面提到的model可以从外部文件载入和保存训练得到的model至本地硬盘，但我用python调用时总是出错。通过svmutil.svm\_save\_model(modelfilename, model),不是说将train得到的model通过此方法保存在modelfilename中的文件里吗？然后再通过model = **svm\_load\_model**(modelfilename)得到模型文件用于另外的数据测试。官方下到的svmutil就是这样子滴呀，我又木有改，另外<a href="http://csie.ntu.edu.tw/~cjlin/libsvm/faq.html#/Q8:_Python_interface" target="_blank">libsvm的faq上</a>也是这样说的吧(svm.**svm\_save\_model**(&#8220;test.model&#8221;,model))？但为啥我运行总是异常说参数类型错误，这句svmutil：
  
<span style="color: #ff0000;"><strong>libsvm.svm_save_model</strong>(model_file_name, model)<br /> ctypes.ArgumentError: argument 1: <class &#8216;TypeError&#8217;>: wrong type</span>

<span style="color: #000000;">就搞不懂了。待解决……</span>

**问题已经解决**,详情参考：[libsvm(v3.11)中的一个bug(python3兼容性引擎的)](/blog/a-bug-in-libsvm-3.11.html)
  
另外，[附python的libsvm的helloworld级别入门实例](/wp-content/blogresources/libsvmtest.rar)(解压密码:www.tanglei.name)。
  
&#8212;update:2012/4/10
