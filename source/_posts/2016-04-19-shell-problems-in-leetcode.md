---
title: leetcode中的shell问题
layout: post
categories: 
  - Linux
tags: 
  - Linux 
  - Shell
  - Leetcode
  - 命令行
---

最近重温了一下 ``awk, sed, tr`` 等命令，然后发现leetcode中还有几道专门关于shell的题目[shell in leetcode](https://leetcode.com/problemset/shell/)， 于是就也做了一下。下面是几道题目的解决方案。

* TOC
{:toc}

### tenth-line [ref](https://leetcode.com/problems/tenth-line/)

>How would you print just the 10th line of a file?
>For example, assume that file.txt has the following content:
>
	Line 1
	Line 2
	Line 3
	Line 4
	Line 5
	Line 6
	Line 7
	Line 8
	Line 9
	Line 10
>	Your script should output the tenth line, which is:
>
	Line 10

即打印一个文件中的第10行。
我刚开始就写了``head -n 10 file.txt | tail -n 1 `` 这个错, 这个是10行内的最后一行，不足10行的就不要打印了。

AC的解决方案有3个如下： 

- ``head -n 10 file.txt | tail -n +10 `` 这个是OK的, 先取出前10行, 再从内容中从前往后取第10行及其以后的
- ``sed -n '10p' file.txt `` `-n` 去除本来要echo file.txt中的内容
- ``awk 'NR==10' file.txt ``  或者 ``awk 'NR==10{print $0}' file.txt``, awk参考[AWK简明教程](http://coolshell.cn/articles/9070.html)


### valid-phone-numbers [ref](https://leetcode.com/problems/valid-phone-numbers/)

>Given a text file file.txt that contains list of phone numbers (one per line), write a one liner bash script to print all valid phone numbers.
>
You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)
>
You may also assume each line in the text file must not contain leading or trailing white spaces.
For example, assume that file.txt has the following content:
>
	987-123-4567
	123 456 7890
	(123) 456-7890
>	Your script should output the following valid phone numbers:
>
	987-123-4567
	(123) 456-7890
	
需要从文件中提取满足特定条件的行，用正则表达式即可。可用``grep, sed, awk``实现。

``awk '$0 ~ /^\([0-9]{3}\) [0-9]{3}-[0-9]{4}$|^[0-9]{3}-[0-9]{3}-[0-9]{4}$/' file.txt	``

awk, `$0`表示整行, `/reg1|reg2/` reg1满足或者reg2满足, 或者省略"$0 ~" 然后将两个reg共同部分提取出来. 


```bash
awk '/^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$/' file.txt
# Mac sed, -E 正则  GNU/Linux也OK
sed -n -E '/^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$/p' file.txt
# GNU/Linux sed  -r 正则
sed -n -r '/^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$/p' file.txt
# both GNU/Linux and Mac, --extended-regexp (或者直接 egrep '^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$' file.txt)
grep -E '^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$' file.txt 
# only GNU/Linux --perl-regexp
grep -P '^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$' file.txt 
```

Max OS X上的`sed`是BSD的版本(BSD的``\n, \t`` 等都得注意)，Linux上的是GNU的版本, 
例如在**Mac中空格替换换行符**用
``sed -E 's/ /\'$'\n/g' words.txt``
而Linux下只需要
``sed 's/ /\n/g' words.txt``

Reference

- [\n in bsd sed](http://unix.stackexchange.com/questions/42321/how-can-i-instruct-bsd-sed-to-interpret-escape-sequences-like-n-and-t)
- [newlines-in-sed-on-mac](http://nlfiedler.github.io/2010/12/05/newlines-in-sed-on-mac.html)

### transpose-file [ref](https://leetcode.com/problems/transpose-file/)
>Given a text file file.txt, transpose its content.
>
You may assume that each row has the same number of columns and each field is separated by the ' ' character.
>
For example, if file.txt has the following content:
>
	name age
	alice 21
	ryan 30
>
Output the following:
>
	name alice ryan
	age 21 30

类似shell版本的矩阵转置问题。


```bash
ncol=`head -n1 file.txt | wc -w`
for i in `seq 1 $ncol`
do
    echo `cut -d' ' -f$i file.txt`
done
```
把每一列用`cut`取出来，然后`echo`成一行。`echo`会去掉换行符, 不过[ref这个方案](https://leetcode.com/discuss/31308/simple-bash-solution-that-oj-hates)超内存了.

最后方案用`awk`实现。

```bash
awk '{for(i=1;i<=NF;i++){ a[i]=a[i] sprintf("%s ", $i); }} END { for (i=1;i<=NF;i++) print a[i]; }' file.txt | sed 's/ $//'
```

解释一下得

- 第一行处理后: ``a[1]=name , a[2]=age ``
- 第二行处理后: ``a[1]=name alice , a[2]=age 21 ``
- ...
- 都处理完后, 打印a[1]中的得到``name alice ryan ``, 最后再删除最后一列跟着的空格即可。

注意最后替换掉换行符前面的空格, 这个方案在GNU/Linux下OK,  Mac下貌似还需要逆序一下, 主要区别是``for (i in a)``, Mac下逆序了

```bash
# GNU/Linux下OK
awk '{ for(i=1;i<=NF;i++){ a[i]=a[i] sprintf("%s ", $i); } } END { for (i in a) print a[i]; }' file.txt | sed 's/ $//'  
#这个需要逆序for (i in a) Mac下是逆序的index
awk  '{ for(i=1;i<=NF;i++){ a[i]=a[i] sprintf("%s ", $i); } } END { for (i in a) print a[i]; }' file.txt | sed 's/ $//' | tail -r  
```

或者这样也行, 把空格拿到开头, 最后替换掉即可.

```bash
awk  '{for(i=1;i<=NF;i++){ a[i]=a[i] " " $i; }} END { for (i=1;i<=NF;i++) print a[i]; }' file.txt | sed 's/^ //'
```

这个参考了[ref SO](http://unix.stackexchange.com/questions/79642/transposing-rows-and-columns)


### Word Frequency [ref](https://leetcode.com/problems/word-frequency/)

>Write a bash script to calculate the frequency of each word in a text file words.txt.
>
For simplicity sake, you may assume:
>
- words.txt contains only lowercase characters and space ' ' characters.
- Each word must consist of lowercase characters only.
- Words are separated by one or more whitespace characters.
>
For example, assume that words.txt has the following content:
>
	the day is sunny the the
	the sunny is is
>
Your script should output the following, sorted by descending frequency:
>
	the 4
	is 3
	sunny 2
	day 1
>
Note: Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.

计算每个单词出现的次数，并按照次数从多到少排列。这个功能简单， 结合``sort, uniq``就可以实现。

Mac下换行注意``" \'$'\n"``, `sort`参数 `-n`(number排序, -d字典序), `-r`(reverse), `-k`(第几列), `-t`(分隔符), 结果为"number string" 再调换一下列位置, 还得去掉空格的行.

```bash
sed -E 's/[[:space:]]+/\'$'\n/g' words.txt | sort | uniq -c | sort -n -r -k1 | awk '{print $2 " "$1}'
```

最后答案:

```bash
sed -E 's/[[:space:]]+/\n/g' words.txt | grep -v "^$" | sort | uniq -c | sort -n -r -k1 | awk '{print $2 " "$1}'
#用grep -v或者awk进行去空行
sed -E 's/\s+/\n/g' words.txt | sort | uniq -c | sort -nr | awk '$2!=""{print $2 " "$1}'
```
