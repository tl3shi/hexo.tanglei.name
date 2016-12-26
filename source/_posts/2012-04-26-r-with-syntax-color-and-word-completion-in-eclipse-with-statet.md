---
id: 1754
title: R语言开发eclipse插件statET-代码高亮和代码提示自动补全
date: 2012-04-26T23:03:14+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1754
duoshuo_thread_id:
  - 1351844048792453313
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 敲敲代码
  - 经验技巧
tags:
  - eclipse
  - eclipse插件
  - R语言
---
前面讲过<a href="/blog/how-to-use-eclipse-to-program-in-r.html" target="_blank">如何在eclipse中配置R语言的开发环境插件</a>，这两天写了几句代码发现一些自带的函数没有高亮显示，也没有自动补全，对于经常用eclipse做开发的童鞋来说很不习惯啊。于是网上搜了下+自己研究了下，搞定。

### 代码高亮问题

> 找到你设置的工作空间文件夹，然后依次打开workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings\，找到de.walware.statet.r.ui.prefs这个文件（如果没有这个文件，见最后），在里面找找看有没有以&#8221;text\_R\_rDefault.Custom2.items=&#8221;为开头的语句，如果有的话，只需把你准备实现高亮的词语加到等号后面就可以了**(用逗号把这些词语隔开)**。保存之后进入Eclipse，选择Winow菜单中的Preferences对话框，顺次展开StatET->Source Editors->R Identifier Groups，在右边的框中选中Custom 1（注意，配置文件中对应的是Custom2，**确实**是个bug），如果下面的列表框中出现了你刚才添加进去的词语，就说明配置成功了。接下来，只要在R Syntax Coloring对话框中找到Custom 1这一项，然后应用你自定义的高亮方式就可以了。需要注意的是新加入的词语不能与StatET中已有的重复，否则可能会出错。

[<img title="de.walware.statet.r.ui.prefs.-bug" border="0" alt="de.walware.statet.r.ui.prefs.-bug" src="/wp-content/uploads/2012/04/de.walware.statet.r.ui_.prefs_.bug_thumb.jpg"  />](/wp-content/uploads/2012/04/de.walware.statet.r.ui_.prefs_.bug_.jpg) 

添加之后，还得设置这些添加的词语以哪种方式展示，如果默认的话就没有效果。如下图设置，StatET->Source Editors->R Syntax Coloring,展开你添加的Custom 1，右边自定义格式，例如颜色加粗等。

[<img title="R syntax color" border="0" alt="R syntax color" src="/wp-content/uploads/2012/04/Rsyntaxcolor_thumb.jpg"  />](/wp-content/uploads/2012/04/Rsyntaxcolor.jpg) 

手动一个一个添加肯定是比较麻烦的。下面这段代码是搜索所有安装的包的函数，并将这些函数输出到out.txt,就可以自己添加到相应的文本(如上配置文件)里面以实现高亮。

```python
# date:2012-4-26
# Author: tanglei|http://www.tanglei.name
###############################################################################

setwd('S:/R/workspace/testR/')
findfuns <- function(x) {
	
	if(require(x, character.only=TRUE)) {
		env <- paste("package", x, sep=":")
		nm <- ls(env, all=TRUE)
		nm[unlist(lapply(nm, function(n) exists(n, where=env,
											mode="function",
											inherits=FALSE)))]
	} else character(0)
}
z <-  lapply(.packages(all.available = FALSE), findfuns)
z=unique(sort(unlist(z)))
cat(z,file='out.txt',sep=',')
```

### 代码提示自动补全问题

> 首先依然是打开Winow菜单中的Preferences对话框，然后顺次展开StatET->Source Editors->R Templates，右边框中的列表就是在编辑窗口中按&#8221;Alt+/&#8221;会出现的提示模板。点击New可以输入自定义的函数，如果只是要实现单词补全的话，就在Name和Pattern中填入函数名就行了，Description就是在出现的下拉供选择的提示函数中相应的描述，例如在Java中会显示API Doc。

[<img title="R word completion" border="0" alt="R word completion" src="/wp-content/uploads/2012/04/Rwordcompletion_thumb.jpg"  />](/wp-content/uploads/2012/04/Rwordcompletion.jpg) 

看到图中可以导入导出，试着添加一个然后导出发现先其模版是按照这样的模式

```xml
<?xml version=”1.0″ encoding=”UTF-8″ standalone=”no”?><templates>
<template autoinsert=”true” context=”r-code” deleted=”false” description=”apply” enabled=”true” name=”apply”>apply</template> 
<template autoinsert=”true” context=”r-code” deleted=”false” description=”" enabled=”true” name=”cbind”>cbind</template>
</templates>
```

现在需要的就是将所有的函数按照这样的格式写下来即可，导入之后就可以了。用python写个脚本简单完成此功能。

```python
# coding=UTF-8
'''
Created on Apr 26, 2012
@author: tanglei|www.tanglei.name
'''

rfunctions = open('out.txt',mode='r')
functions = []
for line in rfunctions.readlines():
    functions.extend(line.split(','))
    
print(len(functions))
rout = open('r.functions.templetes.xml','w')
rfuns = open('r.fun.txt','w')
rout.write('''<?xml version="1.0" encoding="UTF-8" standalone="no"?><templates>''')
rout.write('\n')
for fun in functions:
    if len(fun)<3 :continue#太短了
    if fun[0] in ('!','$','.','-','%','&','*','[','+','<','|',':','/','@','<','>') :continue#生成的函数可能以这些开头，过滤掉
    if fun.count('<')>0:continue#非法字符，xml中解析可能出错
    strFunc = "<template autoinsert=\"true\" context=\"r-code\" deleted=\"false\" description=\""+str(fun)+"   http://www.tanglei.name,You can modify this sentence by replacing them in the templetes.xml\" enabled=\"true\" name=\""+str(fun)+"\">"+str(fun)+"</template>\n"
    rout.write(strFunc)
    rfuns.write(fun)
    rfuns.write('\n')
rout.write('''</templates>''')
print('done')
```

以上代码将之前安装的包中的函数以固定的格式输出到r.functions.templetes.xml，然后在上图中StatET->Source Editors->R Templates,导入即可实现。效果如下图  
[<img title="R word completion-1" border="0" alt="R word completion-1" src="/wp-content/uploads/2012/04/Rwordcompletion1_thumb.jpg"  />](/wp-content/uploads/2012/04/Rwordcompletion1.jpg) 

其实这样导入后，eclipse自动将这些配置写到了上面的那个配置文件de.walware.statet.r.ui.prefs(直接在这里添加也可以,不过建议不使用这种方式)。注意导入的时候可能会出错，原因是因为templetes.xml中一些函数包含类似”<-“这样的符号，得去掉，或者转义吧。我直接去掉。上面python中前面几句就是过滤到之类的函数。

在这里可以<a href="/wp-content/blogresources/r.functions.templetes.xml" target="_blank">下载</a>我的环境中生成的自动补全的函数列表。最好是你自己用上面的R script和python代码跑一遍得到你要用到的函数。

参考资料：<a href="http://cos.name/cn/topic/12136" target="_blank">COS论坛Eclipse+StatET真的不错</a>
