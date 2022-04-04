很多年前就用过图床~ 被压缩，加广告等等，早有打算，图片掌握在自己手中才是硬道理。



本来开始一直用 github 图床，然后后来考虑网络更快，改到 gitee，没想到没用多久，就挂了。



![picture-load-failed](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/picture-load-failed.png)![]()



解决方法：

![image-20220405004126237](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004126237.png)



批量替换图片即可。 

https://gitee.com/tangleithu/blog-resources/raw/master/2022-1-15/1642252071210-image.png



![image-20220405004625844](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004625844.png)

一条简单的命令行即可搞定~

``````shell
sed -i "" 's|https://gitee\.com/tangleithu/blog-resources/raw/master|/resources/gitee-blog-resources|g' 2022-01-18-experience-with-work-at-amazon-II.md
``````

再 `git diff ` 一下，已经 ok 了。 

![image-20220405004856721](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405004856721.png)

然后 `git push` 一把，看看效果如何？



