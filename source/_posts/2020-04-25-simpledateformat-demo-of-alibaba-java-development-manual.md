---
title: 开发规范真的很重要
layout: post
categories: 
  - MyLife 
tags: 
  - 经验技巧
---

最近阿里巴巴的 Java 开发手册出了新版（可直接到 [github alibaba-p3c](https://github.com/alibaba/p3c) 上获取相关资源哦），我就跟着这个事情说一下我对开发规范的理解吧。 

提起开发规范，我印象中最深的就是读研究生期间，带我的大牛师兄某导对我的要求。当时是开发一款 B/S 的 3D 渲染引擎，其中 Web 部分由我负责，在大师兄在对我进行 code review 的过程中，对我提出了“严厉”的批评（也一直很感谢他当时的严格要求），原因不是别的，就是我开发的网页中有一部分是文字介绍，里面的标点符号是中英文混用，且代码也不规范，比如缩进不一致、该有的空格没有等等问题。就是从那个时候起，我对代码规范非常重视。这对后来自己写毕业论文等等方面也起到了良好的促进作用，因为导师对这块要求也相对严格。 

回到代码规范这件事情上，好的代码读起来真的是赏心悦目，当然自己也一直在追求写出好的代码。代码规范中的 code style 只是其中最简单的一种，上述提到的 Java 开发手册也对这部分做出了严格的说明，但实际上能做到的人也不多。按道理，这部分也是最容易做到的一种，因为有模板，直接遵守即可。记得有一部电视剧（叫啥来着？）讲的就是一堆情侣因为纠结到底是用空格还是 tab 键（或者是 Vim 和 Emacs）分手，哈哈这当然是一个笑话。不过在一个 team 里保持统一的代码风格还是有必要的，毕竟你写的代码不是只有你一个人看，在不同的终端，不同的编辑器来讲空格和 tab 可能显示效果都不一样，也就影响了阅读体验。

![](/resources/simpledateformat-demo-of-alibaba-java-development-manual/chaoyang-qunzong1.jpg)

对于代码规范来讲，我也希望通过自己的努力去感染身边的人。比如之前在宜信的 hackthon，我就组队发起了一个叫 “code review advisor” 项目，实现的目的其实也很简单，就是让大家在预先统一的规范下编码，如果有违反规范的，直接以 Comment 形式告诉代码提交者需要修改。

![hackthon code review advisor截图](/resources/simpledateformat-demo-of-alibaba-java-development-manual/chaoyang-qunzong2.jpg)

后来，我到了大疆，又要求 team 同学严格遵守规范，并且使用了一些技术手段完全规范大家提交的代码，对于违反相应规则的代码直接不让提交和打包，当时其实就是利用了 alibaba 对外开源的工具支持。不得不说，还是很佩服阿里巴巴对社区做的相应贡献的。

现在，我在阿里，发现现实就是规范其实也是一个美好的愿景，因为各种历史等原因，其实大家的代码并没有按照预期的规范去执行和实施。这应该也是普遍的现状吧。就像在其中一次交流会上，孤尽大佬说的那样，美好愿景肯定是需要的，实现她，是需要大家花时间和精力去推进的。

![孤尽大佬签名版开发手册](/resources/simpledateformat-demo-of-alibaba-java-development-manual/java-manual.jpg)

上图是在那次交流会上，得到孤尽大佬签名版的开发手册（原谅我没文化，认不出）。下面我就以其中的一个例子来说明一下规范的好处。

```java
public class SimpleDateFormatTest {
    public static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static void main(String[] args) {
        Date now = new Date();
        String printedDate = simpleDateFormat.format(now);
        System.out.println(printedDate);
        for (int i = 0; i < 10; i++) {
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Date date = simpleDateFormat.parse(printedDate);
                        System.out.println(simpleDateFormat.format(date));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        }
    }
}
```

上面代码片段就是规范中提到的 `SimpleDateFormat` 使用场景中一个错误的示例，其实就是一个线程安全的问题，跑上面代码片段，预期输出应该是一个正确的字符串表达（例如 `2020-04-25 15:41:34`），实际过程有可能会抛异常（例如 `java.lang.NumberFormatException`），也可能会输出一些奇奇怪怪的时间（例如 `0015-03-25 15:41:34`），这其实都还好，因为毕竟要么异常了，要么“时间不正常”，最要命的是可能会输出一个正确格式的时间，只不过不是预期的，这种问题就相对很难排查了。

还有比如前面刚跨年的时候各个系统都爆出的时间跨年问题（`yyyy` 和 `YYYY` 的问题），在此手册中其实也都有说明。所以，其实类似的规范多多了解更好。