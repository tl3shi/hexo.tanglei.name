---
title: 公司新人培训 Boot Camp 分享 -- CI (git) 
layout: post
categories: 
  - 经验技巧
tags: 
  - Git
  - 总结
  - 工具
---

![宜信大数据创新中心Bootcamp 2017](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/bootcamp-welcome.png)

今年受公司大佬们的委托给本次Boot camp新兵训练营的培训学员(入职公司的应届生新人)做关于 CI 的分享, 主题是 "CI: Git + Jenkins + Jira", 往年的分享一般都是围绕 Git 展开, 今年虽然题目上加了 Jenkins 和 Jira, 感觉重点仍然是 Git, 1个小时的时间讲不了太多的东西. 

下面将分享的内容大致以文字的形式记录分享一下. 

## CI 概念

CI, 即 "Continuous integration" 持续集成的意思, 为什么要"持续"集成呢, 就是为了防止时间久了集成引起多的各种问题, 因此就频繁地, 一直持续的集成, 早出现问题早解决. 

一般关于 CI 可能会有以下几个好的实践方案, 内容摘自 [wiki](https://en.wikipedia.org/wiki/Continuous_integration)

- Maintain a code repository
- Automate the build
- Make the build self-testing
- Everyone commits to the baseline every day
- Every commit (to baseline) should be built
- Keep the build fast
- Test in a clone of the production environment
- Make it easy to get the latest deliverables
- Everyone can see the results of the latest build
- Automate deployment

就不一一翻译了, 大致意思就是: 利用 git/svn 等各种版本控制工具维护一个代码库, 开发人员每天/次提交的代码都可以自动编译, 自动测试, 自动部署. 

常见的 CI Server 有, 如 Jenkins, Travis 等工具. 

## Git

### 产生背景

在git出来之前, 常见的版本控制工具软件有 SVN/CVS 等, 这种工具有很多弊端, 比如必须得联网, 代码库太大了, 不太方便进行交互等. Linus 当初为了解决 Linux 源码的管理问题(Linux最开始是用一个商业软件 BitKeeper 进行版本管理, 后来因为终止合作了), 于是就花了几周搞出了最初版本的 Git. 

![集中式和分布式版本控制系统的区别](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/vcs-centralized-vs-distributed.png)

- 集中式: SVN等就是这种方式, 有一个中央Server保存所有代码, 大家都依赖于这个集中的Server, 如果集中的Server挂了, 就没法搞了. 
- 分布式: 分布式版本控制系统根本没有“中央服务器”，每个人的电脑上都是一个完整的版本库.  分布式版本控制系统通常也有一台充当“中央服务器”的电脑(Remote Server)，但这个服务器的作用仅仅是用来方便“交换”大家的修改，没有它大家也一样干活，只是交换修改不方便而已。

### 基本概念

Git 中的几个基本概念比较重要, 理解这几个概念能够更好的掌握后面的 git 常见命令及作用.

#### 工作区域划分

![git工作区域划分](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/git-space.png)

- 工作目录/工作区(working directory): 就是当前工作的目录, 实实在在操作的文件
- 暂存区/索引区 (staging area): 通过 `git add` 之后, 会把文件保存到暂存区域里面
- 版本库: `commit` 之后, 文件就存在了版本库里面了

#### 文件的生命周期

![git文件生命周期](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/git-file-lifecycle.png)

- untracked: 还没有被版本库所track, 与版本库还没有产生任何关联
- unmodified: 已经添加到版本控制里面了, 版本库里面保存的文件的状态
- modified: 与版本库里面的文件版本不一致了, 处于被修改后的状态
- staged: 修改了文件, 经过`add`后, 就保存在暂存区(staged)里面, 此时经过 commit, 文件就会又变成 unmodified 状态

Commit 之后到版本库, commit之前在staging区(add后), add前working区. 

### 常见配置

git 配置文件一般有3个地方:

- System 系统配置, 对整个OS的所有用户都一样, 一般可能的配置文件位置在 `/etc/gitconfig`, 一般个人用的话, 可能不会配置这个. 对多人共享的 Server 可能会配. 
- User 配置, 配置文件位置在 `~/.gitconfig`, 比如配置一些行位换行符策略(`core.autocrlf`, 项目中有人采用不同的OS的时候要注意), push 的策略, 当前用户等. `~/.git-credentials` 这个文件存储了授权登录的信息, 注意此文件的保密(可能有明文存储了用户名密码信息), 还可以配置一些 命令 的 alias, 节省输入命令时的时间.  
- Project 配置, 就在当前项目的目录下 `currentProduct/.git/config` , 当然优先级就是越 specific 越优先. 

推荐大家都设置一下 alias, 比如我就设置了 `alias gfom='git fetch origin master'` , 键盘输入4个字符就相当于完成的 `'git fetch origin master'`. 当然, 如果你是用的 zsh 的话, 可以直接用 zsh 的 git 插件, 里面配置了不少 alias, 例如

```bash
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch --remote'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
```
### 常见命令

在培训中, 我主要介绍了以下命令的用法.  其实就是希望大家对相应的命令有一个印象, 就与之前分享过的[Shell 助力开发效率提升](https://www.tanglei.name/blog/linux-shell-makes-more-efficient.html) 一样, 知道每个命令的试用场景, 能够了解某个场景下可以用某个命令来解决实际问题就行, 具体命令的参数, 可以到时候再 `git commond --help` 一下即可, 当然最基本的参数需要掌握, 用得多了就自动熟悉了. 

```bash
git init     git remote   git rebase   git submodule
git status   git push     git reset    git revert
git add      git stash    git tag      git reflog
git commit   git merge    git blame    git cherry-pick
```

我这里就不列举所有命令了, 挑几个重点讲一下. 培训中讲完整命令列表及案例可以在这里找到 [bootcamp-git](https://github.com/tl3shi/bootcamp/blob/master/bootcamp-git-leitang.md). 

#### git checkout v.s git reset

- `git checkout --fileName `: 丢弃工作区对文件`fileName`的修改, 注意一下, 执行此命令, 对fileName的修改就没了.
- `git reset HEAD file`: 将提交到暂存区的修改撤销掉(unstage), 回到 `git add` 前的状态, 文件从 staging 区 到 working 区, 文件内容没有变化(已修改未暂存状态). 

#### git rebase v.s git merge

- `git merge`: Merge takes all the changes in one branch and merges them into another branch in one commit. 一次性合并, 若有冲突解决完冲突后, 再 `add, commit` 会产生新的一个commit.  `git merge --no-ff`: 保留被合并的分支的commits, 默认 fast-forward
- `git rebase`: Rebase says I want the point at which I branched to move to a new starting point. 交互式的, 把在一个分支里提交的改变commits移到另一个分支里重放一遍。一个 commit 一个commit的进行, 当前冲突需要解决完之后, 再 `git rebase --continue`, 直到所有commits合并完毕, 使得 commit history 美观, 缺点是可能要多次进行冲突解决. 

![git merge和rebase的区别](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/git-merge-rebase.png)

这部分内容详细可以参考 [atlassian merging-vs-rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing) 和 [cnblogs merge-vs-rebase](http://www.cnblogs.com/irocker/p/merge-vs-rebase.html)

所以 rebase 和 merge 后的 log history 顺序可能不一样, 如果有冲突, rebase 可能会多次对同一个文件进行冲突fix.  自己单独的开发的分支, 用 `rebase` 保持干净整洁的 commits,  可能多人开发等分支有多种冲突的(特别是已经push到remote供其他人使用时) 用 `merge`. 

#### git rebase -i 重建提交历史

另外, 还可以用 `git rebase -i hash` 重新修改提交的历史. 可以对commits信息进行整理重新排列, 删除和合并等操作, 使得更佳美观. 

其实一般**开发人员应该使每一个commit都有意义**, 而现实当中一般的开发团队可能比较难以做到.  如果严格要求的话, 可能不少同学都需要用 rebase 对历史提交进行重新整理. 

![git rebase重新整理commits历史](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/git-rebase-500ms.gif)

例如上面例子中, 已经提交了10个commits, 现在需要删除其中的第6个, 然后合并其他所有的commits为一个commit. (做了一次git动图进行演示, 不知道效果怎么样). 

#### 其他

其他还有下面两个命令可能用得较多. 

- `git cherry-pick`: 可以跨分支得提取commit, 类似`rebase -i` 后的 `pick`, 从 branchA 的 `commit hasha` 提取出来, 放到 branchB 中. 
- `git stash`: 临时保存工作区的状态. 常用于这样的场景, 比如 当前在 featureA 中开发, 还未开发完成, 这个时候线上可能有个紧急 bug 需要修复, 需要暂存一下当前的状态, 从 master 分支切 hotfix 分支进行开发, 于是就可以先 git stash 将当前的修改暂存一下 (不会提交到暂存区, 另外有个类似栈的结构保存), 然后 hotfix 改完之后, 再切到 featureA 分支, 然后 `git stash pop` 就可以恢复当时的状态. 
- `git submodule`: 项目太大, 子项目相对独立, 父项目含有一个子项目的指针而已. 这样更加方便管理. 举个例子, 我自己的vim配置, 所有的插件都是一个子项目. 

其他, 可能还有用的是

- `hooks`: 可以设置 hooks, 在  `.git/hooks/` 目录中, 该目录有一些示例, 改文件名就可以生效. 比如设置 commit 之前 跑一下 `pre-commit` 的hook, 该 hook 可以跑一下比如 静态的coding style check, 如果不通过就不让commit. 
- `commit.template`:  `git config commit.template commit-template-file.config`. 可以给团队配置相同的模板, 这样大家的commit 的 comments 都统一, 方便管理和track. 

### 常见 Workflow

#### git flow

![git flow](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/git-workflow.png)

[这篇文章](http://nvie.com/posts/a-successful-git-branching-model) 对 git flow 有较为详细的阐述. 

简单来说, 就是team里的成员都在一个repo里面开发, 基于不同的 branch 去完成. 
一点建议就是, 如果team里用的是这种workflow, merge MR/PR 的时候, 别忘了勾选删除原分支. 不然会造成一个repo里面太多分支且杂乱无章. 

#### github flow

![github flow](https://www.tanglei.name/resources/share-CI-git-in-bootcamp-2017/github-workflow.png)

github flow 详见[官网](https://guides.github.com/introduction/flow/) 对其的阐述. 简而言之, 就是大家在不同的repo进行开发, 往一个主repo里去 merge.  

## CI Server

其实 CI Server 可以直接简单的理解为, 存在这样一台机器, 当你push 代码的时候(当然这个动作可以类似git hooks一样可以配置), 会自动帮你顺序执行一系列的程序命令, 然后将执行结果以某种方式通知你. 

最常见的就是下面这两种: Jenkins 和 Travis.

- Jenkins: [Jenkins](https://jenkins.io/doc/) 是一款主流的 CI Server 吧, 优点是开源免费, 含有丰富的插件系统.  本文就不做多的介绍了, 一般中小型公司也都会用这个吧? 

- Travis CI: [travis-ci](https://travis-ci.org/), 我第一次接触这个玩意还是很久前发现可以直接用它[帮我编译我的博客程序jekyll](https://travis-ci.org/tl3shi/hexo.tanglei.name/jobs/261312275/config ), 然后把生成好的html直接push到github, 这样就省得我自己去build了, 每次新写一篇blog, 直接push 到 master 即可, travis 就会默默地进行工作, 还还挺方便的, 不需要自己买VPS等Server, 就可以动态build 程序.  (不需要后台动态语言支持, 全静态博客(hexo/jekyll/octopress等)作者推荐使用, 关键免费呀)

不少开源的程序都会借助 travis, 与 github 无缝链接, 实时标记 build状态等. 

## Jira

[Jira](https://www.atlassian.com/software/jira/features) 用于项目管理, issue trakcing 等等. 

类似的还有 [trello](https://trello.com) 等等. 

## References

- [Wiki Continuous_integration](https://en.wikipedia.org/wiki/Continuous_integration)
- [progit](http://iissnan.com/progit/)
- [Git教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)
- [git docs](https://git-scm.com/docs)
- [Jenkins入门](http://files.cnblogs.com/files/itech/Jenkins入门.pdf)

