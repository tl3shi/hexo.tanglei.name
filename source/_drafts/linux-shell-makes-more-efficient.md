---
title: Shell 助力开发效率提升
layout: post
categories: 
  - 经验技巧
tags: 
  - Shell
  - Mac
  - 工具
---

本文主要来源于小组内部的一个小的分享, 这里整理成一篇文章po出来.  题目叫 "Shell 助力开发效率提升", 更切题的应该是叫 "命令行" 提升开发效率, 这里并没有讲到Shell编程, 而是主要介绍Linux 或者 Mac下常用的一些基本工具命令来帮助处理一些日常事务.  (其实之前这篇文章[Mac 软件推荐(续)之程序猿篇](https://www.tanglei.name/blog/app-in-mac-for-dev.html)也大致提到了本文中的大部分内容)

通过本文的介绍, 你应该对相关命令有一个初步的了解, 知道比如用什么命令可以完成怎样的操作, 
至于具体的参数, 你不用去刻意地记, 等到你用到的时候, 你再去 `cmd --help ` 或者 `man cmd`去看, 用熟悉了, 常用的你也就记住了. 

本文首先介绍了Linux/Mac下一些常用的命令行工具, 然后介绍了一些常用的命令, 最后通过一两个案例来说明这些工具的强大之处: 
比如给定一个nginx日志文件, 能够找出HTTP 404 请求最多的top 10 是什么?  比如能找到请求耗时最多的top 10是什么?  再比如能够简单的得到每小时的"PV"是多少?
再比如拿到一篇文章, 能否简单统计一下这篇文章单次词频最高的10个词语是什么?

## Mac 环境

- zsh
- on-my-zsh
- plugin 
    - git
    - autojump
    - osx(man-preview/quick-look/pfd(print Finder director)/cdf(cd Finder))
- 常用快捷键(`bindkey`)
- 演示: 高亮/git/智能补全/跳转(j,d)...

关于Mac相关的技巧, 更多的可以参考以下三篇文章: [Mac 软件推荐(序)](https://www.tanglei.name/blog/app-in-mac-preface.html), [Mac 软件推荐续(!程序猿篇)](https://www.tanglei.name/blog/app-in-mac-for-common.html), 和 [Mac 软件推荐(续)之程序猿篇](https://www.tanglei.name/blog/app-in-mac-for-dev.html)

## Shell 基础命令

- which/whereis, 常用 `whatis`, `man`, `--help`

    ```bash
    ➜  .oh-my-zsh git:(master) whereis ls
    /bin/ls
    ➜  .oh-my-zsh git:(master) which ls
    ls: aliased to ls -G
    ```

- 基本文件目录操作

    ```bash
    rm, mkdir, mv, cp, cd, ls, ln, file, stat, wc(-l/w/c), head, more, tail, cat...
    ```

- 利器 管道: `|`

## Shell 文本处理

这里就是通过案例讲了一下12个命令的大致用法和参数, 可以通过点击右边的目录直达你想要了解的命令. 

```
find, grep, xargs, cut, paste, comm
join, sort, uniq, tr, sed, awk
```

### find

- 常用参数
	- 文件名 `-name`, 文件类型`-type`, 查找最大深度`-maxdepth`
    - 时间过滤(create/access/modify) `-[cam]time`
    - 执行动作 `-exec`
- 示例

    ```bash
    find ./ -name "*.json"
    find . -maxdepth 7 -name "*.json" -type f
    find . -name "*.log.gz" -ctime +7 -size +1M -delete (atime/ctime/mtime)
    find . -name "*.scala" -atime -7 -exec du -h {} \;
    ```

### grep

- 常用参数

	- -v(invert-match), 
	- -c(count), 
	- -n(line-number), 
	- -i(ignore-case), 
	- -l, -L, -R(-r, --recursive), -e

- 示例

    ```bash
    grep 'partner' ./*.scala -l
    grep -e 'World' -e 'first' -i -R ./  (-e: or)
    ```

- 相关命令: `grep -z / zgrep / zcat xx | grep`

### xargs 

- 常用参数
    - -n(每行列数), 
	- -I(变量替换)
	- -d(分隔符), Mac 不支持, 注意与GNU版本的区别

- 示例    

    ```bash
    find . -type f -name "*.jpg" | xargs -n1 -I {} du -sh {}
    ```

### cut

-  常用参数
    - -b(字节)
    - -c(字符)
    - -f(第几列), -d(分隔符), f范围: `n, n-, -m, n-m`

-  示例    

    ```bash
    echo "helloworldhellp" | cut -c1-10
    cut -d, -f2-8 csu.db.export.csv
    ```

### paste

-  常用参数

    - -d 分隔符
    - -s 列转行

-  示例

    ```bash
    ➜  Documents cat file1
    1 11
    2 22
    3 33
    4 44
    ➜  Documents cat file2
    one     1
    two     2
    three   3
    one1    4

    ➜  Documents paste -d, file1 file2
    1 11,one     1
    2 22,two     2
    3 33,three   3
    4 44,one1    4
    ➜  Documents paste -s -d: file1 file2
    a 11:b bb:3 33:4 44
    one     1:two     2:three   3:one1    4
    ```

### join 

类似sql中的 `...inner join ...on ...`, `-t` 分隔符, 默认为空格或tab

```bash
➜  Documents cat j1
1 11
2 22
3 33
4 44
5 55
➜  Documents cat j2
one     1   0
one     2   1
two     4   2
three   5   3
one1    5   4
➜  Documents join -1 1 -2 3 j1 j2
1 11 one 2
2 22 two 4
3 33 three 5
4 44 one1 5
```


### comm

- 常用参数
	- 用法 `comm [-123i] file1 file2`
	- **字典序列**, 3列: 只在file1/file2/both
	- `-` 去掉某列, `i` 忽略大小写

- 示例

    ```bash
    ➜  Documents seq 1 5 >file11
    ➜  Documents seq 2 6 >file22
    ➜  Documents cat file11
    1
    2
    3
    4
    5
    ➜  Documents cat file22
    2
    3
    4
    5
    6
    ➜  Documents comm file11 file22
    1
            2
            3
            4
            5
        6
    ➜  Documents comm -1 file11 file22
        2
        3
        4
        5
    6
    ➜  Documents comm -2 file11 file22
    1
        2
        3
        4
        5
    ➜  Documents comm -23 file11 file22
    1
    ```

相关命令 **diff**(类似*git diff*)

### sort 

-  常用参数
    - -d, --dictionary-order
    - -n, --numeric-sort
    - -r, --reverse
    - -b, --ignore-leading-blanks
    - -k, --key
-  示例

    ```bash
    ➜  Documents cat file2
    one     1
    two     2
    three   3
    one1    4
    ➜  Documents sort file2
    one     1
    one1    4
    three   3
    two     2
    ➜  Documents sort -b -k2 -r file2
    one1    4
    three   3
    two     2
    one     1
    ```

### uniq

-  常用参数
	- -c 重复次数
	- -d 重复的
	- -u 没重复的
	- -f 忽略前几列
-  示例

    ```bash
    ➜  Documents cat file4
    11
    22
    33
    11
    11
    ➜  Documents sort file4 | uniq -c
       3 11
       1 22
       1 33
    ➜  Documents sort file4 | uniq -d
    11
    ➜  Documents sort file4 | uniq -u
    22
    33
    ➜  Documents cat file3
    one     1
    two     1
    three   3
    one1    4
    ➜  Documents uniq -c -f 1 file3
       2 one     1
       1 three   3
       1 one1    4
    ```

注意: uniq比较相邻的是否重复, 一般与sort联用

### tr

-  常用参数
    - -c 补集
    - -d 删除
    - -s 压缩相邻重复的

-  示例

    ```bash
    ➜  Documents echo '1111234444533hello' | tr  '[1-3]' '[a-c]'
    aaaabc44445cchello
    ➜  Documents echo '1111234444533hello' | tr -d '[1-3]'
    44445hello
    ➜  Documents echo '1111234444533hello' | tr -dc '[1-3]'
    11112333
    ➜  Documents echo '1111234444533hello' | tr -s '[0-9]'
    123453hello
    ➜  Documents echo 'helloworld' | tr '[:lower:]' '[:upper:]'
    HELLOWORLD
    ```

### sed

-  常用参数
    - -d 删除
    - -s 替换, g 全局
    - -e 多个命令叠加
    - -i 修改原文件(Mac下加参数 "", 备份)
-  示例

    ```bash
    ➜  Documents cat file2
    one     1
    two     2
    three   3
    one1    4
    ➜  Documents sed "2,3d" file2
    one     1
    one1    4
    ➜  Documents sed '/one/d' file2
    two     2
    three   3
    ➜  Documents sed 's/one/111/g' file2
    111     1
    two     2
    three   3
    1111    4
    #将one替换成111 并将含有two的行删除
    ➜  Documents sed -e 's/one/111/g' -e '/two/d' file2
    111     1
    three   3
    1111    4
    # ()标记(转义), \1 引用
    ➜  Documents sed 's/\([0-9]\)/\1.html/g' file2
    one     1.html
    two     2.html
    three   3.html
    one1.html    4.html
    # 与上面一样 & 标记匹配的字符
    ➜  Documents sed 's/[0-9]/&.html/g' file2
    one     1.html
    two     2.html
    three   3.html
    one1.html    4.html
    ➜  Documents cat mobile.csv
    "13090246026"
    "18020278026"
    "18520261021"
    "13110221022"
    ➜  Documents sed 's/\([0-9]\{3\}\)[0-9]\{4\}/\1xxxx/g' mobile.csv
    "130xxxx6026"
    "180xxxx8026"
    "185xxxx1021"
    "131xxxx1022"
    ```

### awk

-  基本参数和语法
    - NR 行号, NF 列数量
    - `$1` 第1列, `$2, $3`...
    - -F fs  fs分隔符，字符串或正则
	- 语法:  `awk 'BEGIN{ commands } pattern{ commands } END{ commands }'`, 流程如下:
		1. 执行begin
		2. 对输入每一行执行 `pattern{ commands } `, pattern 可以是 正则`/reg exp/`, 关系运算等
		3. 处理完毕, 执行 end

-  示例

    ```bash
    ➜  Documents cat file5
    11  11 aa cc
    22  22 bb
    33  33 d
    11  11
    11  11
    #行号, 列数量, 第3列
    ➜  Documents awk '{print NR"("NF"):", $3}' file5
    1(4): aa
    2(3): bb
    3(3): d
    4(2):
    5(2):
    #字符串分割, 打印1，2列
    ➜  Documents awk -F"xxxx" '{print $1, $2}' mobile.csv
    "130 6026"
    "180 8026"
    "185 1021"
    "131 1022"
    #添加表达式
    ➜  Documents awk '$1>=22 {print NR":", $3}' file5
    2: bb
    3: d
    #累加1到36，奇数，偶数
    ➜  Documents seq 36 | awk 'BEGIN{sum=0; print "question:"} {print $1" +"; sum+=$1} END{print "="; print sum}' | xargs | sed 's/+ =/=/'
    question: 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10 + 11 + 12 + 13 + 14 + 15 + 16 + 17 + 18 + 19 + 20 + 21 + 22 + 23 + 24 + 25 + 26 + 27 + 28 + 29 + 30 + 31 + 32 + 33 + 34 + 35 + 36 = 666
    ➜  Documents seq 36 | awk 'BEGIN{sum=0; print "question:"} $1 % 2 ==1 {print $1" +"; sum+=$1} END{print "="; print sum}' | xargs | sed 's/+ =/=/'
    question: 1 + 3 + 5 + 7 + 9 + 11 + 13 + 15 + 17 + 19 + 21 + 23 + 25 + 27 + 29 + 31 + 33 + 35 = 324
    ➜  Documents seq 36 | awk 'BEGIN{sum=0; print "question:"} $1 % 2 !=1 {print $1" +"; sum+=$1} END{print "="; print sum}' | xargs | sed 's/+ =/=/'
    question: 2 + 4 + 6 + 8 + 10 + 12 + 14 + 16 + 18 + 20 + 22 + 24 + 26 + 28 + 30 + 32 + 34 + 36 = 342
    ```

其他高级语法: `for, while` 等, 各种函数等, 本身`awk`是一个强大的语言, 可以掌握一些基本的用法.

## 实际应用

### 日志统计分析

例如拿到一个nginx日志文件, 可以做很多事情, 比如看哪些请求是耗时最久的进而进行优化, 比如看每小时的"PV"数 等等.

```bash
➜  Documents head -n5 std.nginx.log
106.38.187.225 - - [20/Feb/2017:03:31:01 +0800] www.tanglei.name "GET /baike/208344.html HTTP/1.0" 301 486 "-" "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322) 360JK yunjiankong 975382" "106.38.187.225, 106.38.187.225" - 0.000
106.38.187.225 - - [20/Feb/2017:03:31:02 +0800] www.tanglei.name "GET /baike/208344.html HTTP/1.0" 301 486 "-" "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322) 360JK yunjiankong 975382" "106.38.187.225, 106.38.187.225" - 0.000
10.130.64.143 - - [20/Feb/2017:03:31:02 +0800] stdbaike.bdp.cc "POST /baike/wp-cron.php?doing_wp_cron=1487532662.2058920860290527343750 HTTP/1.1" 200 182 "-" "WordPress/4.5.6; http://www.tanglei.name/baike" "10.130.64.143" 0.205 0.205
10.130.64.143 - - [20/Feb/2017:03:31:02 +0800] www.tanglei.name "GET /external/api/login-status HTTP/1.0" 200 478 "-" "-" "10.130.64.143" 0.003 0.004
10.130.64.143 - - [20/Feb/2017:03:31:02 +0800] www.tanglei.name "GET /content_util/authorcontents?count=5&offset=0&israndom=1&author=9 HTTP/1.0" 200 11972 "-" "-" "10.130.64.143" 0.013 0.013
```

上面是nginx的一个案例, 例如希望找到top 10 请求的path:

```bash
head -n 10000 std.nginx.log | awk '{print $8 "," $10}' | grep ',404' | sort | uniq -c | sort -nr -k1 | head -n 10
#or
head -n 10000 std.nginx.log | awk '$10==404 {print $8}' |sort | uniq -c | sort -nr -k1 | head -n 10
```

当然, 你可能一次不会直接处理成功, 一般会先少拿一部分数据进行处理看逻辑是否正常, 或者你可以缓存一些中间结果. 

```bash
cat std.nginx.log | awk '{print $8 "," $10}' | grep ',404' >404.log
sort 404.log | uniq -c | sort -nr -k1 | head -n 10
```

再比如每小时请求数量, 请求耗时等等

```bash
➜  Documents head -n 100000 std.nginx.log | awk -F: '{print $1 $2}' | cut -f3 -d/ | uniq -c
8237 201703
15051 201704
16083 201705
18561 201706
22723 201707
19345 201708
```

其他实际案例 ip block

### 案例: db数据批处理

背景: 因为某服务bug, 导致插入到db的图片路径不对, 需要将形如(安全需要已经将敏感数据替换)
`https://www.tanglei.name/upload/photos/129630//internal-public/shangtongdai/2017-02-19-abcdefg-eb85-4c24-883e-hijklmn.jpg`
替换成
`http://www.tanglei.me/internal-public/shangtongdai/2017-02-19-abcdefg-eb85-4c24-883e-hijklmn.jpg`, 因为mysql等db貌似不支持直接正则的替换, 所以不能够很方便的进行写sql进行替换. 
当然将数据导出, 然后写python等脚本处理也是一种解决方案, 但如果用上面的命令行处理, 只需要几十秒即可完成. 

步骤:

1. 准备数据

	```sql
	select id, photo_url_1, photo_url_2, photo_url_3 from somedb.sometable where 
	photo_url_1 like 'https://www.tanglei.name/upload/photos/%//internal-public/%' or
	photo_url_2 like 'https://www.tanglei.name/upload/photos/%//internal-public/%' or
	photo_url_3 like 'https://www.tanglei.name/upload/photos/%//internal-public/%';
	```
2. 替换原文件 
    一般在用sed替换的时候, 先测试一下是否正常替换. 

	```bash
# 测试是否OK
	head -n 5 customers.csv | sed 's|https://www.tanglei.name/upload/photos/[0-9]\{1,\}/|http://www.tanglei.me|g'
# 直接替换原文件, 可以sed -i ".bak" 替换时保留原始备份文件
	sed -i "" 's|https://www.tanglei.name/upload/photos/[0-9]\{1,\}/|http://www.tanglei.me|g' customers.csv
	```
3. 拼接sql, 然后执行

	```bash
	awk -F, '{print "update sometable set photo_url_1 = " $2, ", photo_url_2 = " $3, ", photo_url_3 = " $4, " where id = " $1 ";" }' customers.csv > customer.sql
#然后执行sql 即可
	```

### 其他

- play framework session

    - 老方式: 需要启play环境, 慢
 
	```scala
	sbt "project site" consoleQuick
	import play.api.libs._
	val sec = "secret...secret"
	var uid = "97522"
	Crypto.sign(s"uid=$uid", sec.getBytes("UTF-8")) + s"-uid=$uid"
	```
	- 新方式: 

	```bash
	➜  Documents  ~/stdcookie.sh 97522
	918xxxxdf64abcfcxxxxc465xx7554dxxxx21e-uid=97522
	➜  Documents cat ~/stdcookie.sh
	#!/bin/bash ##  cannot remove this line
	uid=$1
	hash=`echo -n "uid=$uid" | openssl dgst -sha1 -hmac "secret...secret"`
	echo "$hash-uid=$uid"
	```

- 统计文章单词频率: 下面案例统计了川普就职演讲原文中词频最高的10个词.

	```bash
	➜  Documents head -n3 chuanpu.txt
	Chief Justice Roberts, President Carter, President Clinton, President Bush, President Obama, fellow Americans and people of the world, thank you.
	
	We, the citizens of America, are now joined in a great national effort to rebuild our country and restore its promise for all of our people. Together we will determine the course of America and the world for many, many years to come.
	➜  Documents cat chuanpu.txt | tr -dc 'a-zA-Z ' | xargs -n 1 | sort | uniq -c | sort -nr -k1 | head -n 20
	  65 the
	  63 and
	  48 of
	  46 our
	  42 will
	  37 to
	  21 We
	  20 is
	  18 we
	  17 America
	  15 a
	  14 all
	  13 in
	  13 for
	  13 be
	  13 are
	  10 your
	  10 not
	  10 And
	  10 American
	```

	
- 随机数  

	```bash
	➜  Documents cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 5
	cpBnvC0niwTybSSJhUUiZwIz6ykJxBvu
	VDP56NlHnugAt2yDySAB9HU2Nd0LlYCW
	0WEDzpjPop32T5STvR6K6SfZMyT6KvAI
	a9xBwBat7tJVaad279fOPdA9fEuDEqUd
	hTLrOiTH5FNP2nU3uflsjPUXJmfleI5c
	➜  Documents cat /dev/urandom | head -c32 | base64
	WoCqUye9mSXI/WhHODHDjzLaSb09xrOtbrJagG7Kfqc=
	```

- 图片处理压缩, 可批量改图片大小等等 `sips`
	
	```bash
	➜  linux-shell-more-effiency sips -g all which-whereis.png
	/Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	  pixelWidth: 280
	  pixelHeight: 81
	  typeIdentifier: public.png
	  format: png
	  formatOptions: default
	  dpiWidth: 72.000
	  dpiHeight: 72.000
	  samplesPerPixel: 4
	  bitsPerSample: 8
	  hasAlpha: yes
	  space: RGB
	  profile: DELL U2412M
	➜  linux-shell-more-effiency sips -Z 250 which-whereis.png
	/Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	  /Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	➜  linux-shell-more-effiency sips -g all which-whereis.png
	/Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	  pixelWidth: 250
	  pixelHeight: 72
	  typeIdentifier: public.png
	  format: png
	  formatOptions: default
	  dpiWidth: 72.000
	  dpiHeight: 72.000
	  samplesPerPixel: 4
	  bitsPerSample: 8
	  hasAlpha: yes
	  space: RGB
	  profile: DELL U2412M
	➜  linux-shell-more-effiency man sips
	➜  linux-shell-more-effiency sips -z 100 30 which-whereis.png
	/Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	  /Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	➜  linux-shell-more-effiency sips -g pixelWidth -g pixelHeight which-whereis.png
	/Users/tanglei/Documents/linux-shell-more-effiency/which-whereis.png
	  pixelWidth: 30
	  pixelHeight: 100
	```


## Reference

- [Linux工具快速教程](http://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html)
- [Linux命令大全](http://man.linuxde.net/)
- [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/)
- [UNIX环境高级编程](https://book.douban.com/subject/25900403/)
