---
id: 1472
title: php中数组array_merge和运算符加号(+)的区别
date: 2012-03-01T22:58:22+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1472
duoshuo_thread_id:
  - 1351844048792453340
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 经验技巧
tags:
  - PHP
---
今天看到群里在讨论php中的array_merge()和+的区别。以前没注意过，今天自己写个例子测试了下，在此备注一下。
  
看php中的文档中也明确说明了。

> array_merge() 将一个或多个数组的单元合并起来，一个数组中的值附加在前一个数组的后面。返回作为结果的数组。 
> 
> 如果输入的数组中有相同的字符串键名，则该键名后面的值将覆盖前一个值。然而，如果数组包含数字键名，后面的值将不会覆盖原来的值，而是附加到后面。 
> 
> 如果只给了一个数组并且该数组是数字索引的，则键名会以连续方式重新索引。
  
> 数字键名将会被重新编号！保留原有数组并只想新的数组附加到后面，用 + 运算符 

效果如下，注释中是运行结果。

```php

<?
/**
  *array_merge() 将一个或多个数组的单元合并起来，一个数组中的值附加在前一个数组的后面。
  *返回作为结果的数组。 如果输入的数组中有相同的字符串键名，则该键名后面的值将覆盖前一个值。
  *然而，如果数组包含数字键名，后面的值将不会覆盖原来的值，而是附加到后面。 
  *如果只给了一个数组并且该数组是数字索引的，则键名会以连续方式重新索引。
  */
	
	$array1 = array("color" => "red", 2, 4);
	$array2 = array("a", "b", "color" => "green", "shape" => "trapezoid", 4);
	$result = array_merge($array1, $array2);
	print_r($result);
	/*
	[color] => green
	[0] => 2
	[1] => 4
	[2] => a
	[3] => b
	[shape] => trapezoid
	[4] => 4
	*/
	$array1 = array("array1");
	$array2 = array(0 => "array2");
	$result = $array1 + $array2;
var_dump($result);//0=>array1     数字key不替换

	$array1 = array("array1");
	$array2 = array(0 => "array2");
	$result = array_merge($array1,$array2);//merge key重新编号
var_dump($result);//0=>array1,1=>array2


	$array1 = array('1'=>'array1');
	$array2 = array('1' => "array2");
	$result = $array1 + $array2;
var_dump($result);//1=>array1 也被当作数字

	$array1 = array('1'=>'array1');
	$array2 = array('1' => "array2");
	$result = array_merge($array1,$array2);
var_dump($result);//0=>array1  1=>array2

	$array1 = array('2'=>'array1');
	$array2 = array('3' => "array2");
	$array3 = array('3' => "array3");
	$result = array_merge($array1,$array2,$array3);
var_dump($result);//0=>array1  1=>array2  2=>array2

	$array1 = array('2'=>'array1');
	$array2 = array('3' => "array2");
	$array3 = array("3" => "array3");
	$result = ($array1+$array2+$array3);
var_dump($result);//2=>array1  3=>array2

	$array1 = array('str1'=>'array1');
	$array2 = array('str1' => "array2");
	$result = array_merge($array1,$array2);
var_dump($result);//str1=>array2   字符串key替换

?>
```

注意上例中，就算加了引号(不管单引号还是双引号)的key,外表看是字符串，当是数字字符串也被当作数字处理了
