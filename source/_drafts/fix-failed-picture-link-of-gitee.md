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

![image-20220405114818417](/Users/tanglei/github/hexo.tanglei.name/resources/fix-gitee-pictures-link/image-20220405114818417.png)



sed -i "" 's|https://gitee\.com/tangleithu/blog-resources/raw/master|/resources/gitee-blog-resources|g' 2022-01-18-experience-with-work-at-amazon-II.md 





sed -i "" 's|https://gitee\.com/tangleithu/blog-resources/raw/master|/resources/gitee-blog-resources|g' 

2010-12-18-java_data.md
2021-09-21-the-experience-of-universal-studios-of-peking.md
2021-10-11-9-years-of-experience-at-alibaba.md
2021-10-28-tour-at-alibaba-data-center.md
2021-11-08-the-boss-of-gym-run-away.md
2021-11-19-talk-about-the-welfare-of-alibaba.md
2021-11-21-receive-a-fraud-call-by-fake-alipay.md
2021-11-27-talk-about-after-writing-100-posts-in-weixin.md
2021-11-30-experience-of-campus-recruitment-of-2022.md
2021-12-09-award-cause-of-code.md
2021-12-21-call-the-police-after-the-boss-of-gym-run-away.md
2021-12-30-happy-cause-of-bonus-tax-policy.md
2022-01-09-summary-of-2021.md
2022-01-12-experience-of-campus-recruitment-of-2022-II.md
2022-01-18-experience-with-work-at-amazon-I.md