---
id: 1332
title: Wordpress纯代码实现相关文章
date: 2011-12-24T01:19:08+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1332
duoshuo_thread_id:
  - 1351844048792453177
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - Wordpress
tags:
  - Wordpress
---
看其他人的Wordpress站点等都有相关文章，所以自己也弄了个。之前装了个插件，不过感觉不怎么样，如图。<a href="http://s1123.photobucket.com/albums/l549/tl3shi/?action=view&current=1.jpg" target="_blank"><img src="http://i1123.photobucket.com/albums/l549/tl3shi/1.jpg" alt="Photobucket" border="0" /></a>
  
用户体验不好，放在侧边栏去了。于是网上找代码实现相关文章的。本文也是参照[这篇文章](http://www.92app.com/related-posts-Wordpress.html)的，

<img class="alignnone" title="代码实现相关文章" src="http://i1123.photobucket.com/albums/l549/tl3shi/1-2.jpg" alt=""  />

访问[支教第十天-感恩的心](/blog/volenteer-teaching-day10.html),效果上图1，因其标签比较丰富,可以提取到相同tag的,但遇到这种情况例如:之前发过的一篇:

[技术贴-把妹高手谈如何跟刚搭讪认识的妹子发短信](/blog/tell-you-how-to-get-a-girl.html)时,因为tag没有没有设置或者其他没有相关的tag于此匹配,此时就只能展示随机文章了,上图2.

曾想,这里的随机是有点不爽,此时展示同分类目录下的文章要比这个好吧. 于是想法取出当前文章所在同分类下的文章,开始是试图找一个sql语句把所有的文章的tag中都将本文所在的分类目录加进去,但这样似乎有点不符合逻辑.看之前用代码实现的相关文章的源代码:查看随机文章时调用如下的函数

```php
function wp_get_random_posts ($limitclause="") {
 global $wpdb, $post;

 $q = "SELECT ID, post_title, post_content,post_excerpt, post_date, comment_count FROM $wpdb->posts WHERE post_status = 'publish' AND post_type = 'post' AND ID != $post->ID ORDER BY RAND() $limitclause";
 return $wpdb->get_results($q);
}
```

首先要获取当前文章所在的分类目录的ID,为了方便管理调试Wordpress,我的机子上也配好了Wordpress环境了.随时配置下host就能正常访问本地的博客.通过各种关键字试图搜索(Wordpress下所有文件递归关键字，eg: wp\_get\_post_category啊之类)显示分类目录的ID,最后找到这个函数

```php
/**
 * Return or Print Category ID.
 *
 * @since 0.71
 * @deprecated 0.71
 * @deprecated use get_the_category()
 * @see get_the_category()
 *
 * @param bool $echo
 * @return null|int
 */
function the_category_ID($echo = true) {
	_deprecated_function( __FUNCTION__, '0.71', 'get_the_category()' );

	// Grab the first cat in the list.
	$categories = get_the_category();
	$cat = $categories[0]->term_id;

	if ( $echo )
		echo $cat;

	return $cat;
}
```

不过意思好像是废弃了，就直接调用这个函数吧

```
$categories = get_the_category();
$cat = $categories[0]->term_id;
```

就得到当前分类目录的ID，然后就是调试sql了。先打印出来试试，正确的。
  
分类目录保存在wp\_terms 表中，select * from wp\_terms where term_id = 56;
  
然后就慢慢一层一层找，如下sql能找到对应分类下的文章：再然后就改掉之前的代码就OK了。<a href="http://s1123.photobucket.com/albums/l549/tl3shi/?action=view&current=1-1.jpg" target="_blank"><img src="http://i1123.photobucket.com/albums/l549/tl3shi/1-1.jpg" alt="Photobucket" border="0" /></a>

本地sql数据库调试出来结果来再改。写成一个函数

```php
function wp_get_category_posts ($limitclause="") { 
 global $wpdb, $post; 

//$cid = the_category_ID(false);
$categories = get_the_category();
$cid = $categories[0]->term_id;
		 
 $q = "SELECT ID, post_title, post_content,post_excerpt, post_date, comment_count FROM $wpdb->posts WHERE post_status = 'publish' AND post_type = 'post' AND ID != $post->ID AND ID in (select object_id  from wp_term_relationships where term_taxonomy_id = ( select term_taxonomy_id from wp_term_taxonomy where term_id = $cid )) ORDER BY RAND() $limitclause"; 
 return $wpdb->get_results($q); 
}
```

下面的显示

```php
//不存在相关日志则显示随机日志 
 if (!$related_posts) 
 {
	 //tag搜索不到，再通过目录搜
	 $related_posts =  wp_get_category_posts($limitclause); 
	 if (!$related_posts)
	 {
		 if($wp_rp['wp_no_rp'] == "text") 
		 { 
			 $output  .= '

<li>
  木有相关文章
</li>';            //无相关文章时显示标题 
		 } 
		 else 
		{ 
			 if($wp_rp['wp_no_rp'] == "random") 
		 { 
			 $wp_no_rp_text= '随机文章';                                        //随机文显示标题 
			 $related_posts = wp_get_random_posts($limitclause);
		 }   
	 
		$wp_rp_title = $wp_no_rp_text; 
		 }
	 } 
 }

```

然后得到的效果就是现在这个样子了。
