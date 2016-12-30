---
id: 1286
title: php图片加文字水印(中文乱码解法方案)
date: 2011-11-17T19:41:58+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1286
duoshuo_thread_id:
  - 1351844048792453420
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 工作那些事儿
tags:
  - PHP
---
昨天接到一个新需求，给图片加文字。用于感恩节还是圣诞节之类的哦。也就是图片加文字水印。网上查了下，很多相关的内容。英文是很好解决滴，不过中文可搞死我了。

大致就是：

```php
$name='郁闷aaaaaa';//要加的水印文字
$font = './simhei.ttf';//水印字体，Windows\Fonts有，乱码跟这个也有关系
$im = imagecreatefrompng("./1.png");//载入图片（类似的jpeg/gif方法）
$red = imagecolorallocate($im, 255, 0, 0);//设置颜色 rgb
imagettftext($im, 12, 0, 320, 84, $red, $font, $name);//打印水印
imagepng($im,'test2.png');//输出图片,如果要保存加个保存路径和文件名
imagedestroy($im);//释放资源
```

然后就会发现乱码。

网上再查，类似$text = iconv(&#8220;GB2312&#8221;, &#8220;UTF-8&#8221;, $name);GBK啊等等，我都试过，结果一样，还是乱码。再有的说因为php文件本身的编码不是UTF8啊等等。我特意记事本，另存为<span style="font-family: Arial;">UTF-8</span><span style="font-family: 宋体;">，再</span><span style="font-family: Arial;">try</span><span style="font-family: 宋体;">，仍然乱码。还有的说加什么</span><span style="font-family: Arial;">header( &#8220;Content-Type:text/html; charset=UTF-8 &#8220;);</span><span style="font-family: 宋体;">仍然乱码。</span><span style="font-family: Arial;"><br /> </span>

还有的说用<span style="font-size: 10pt;"><span style="color: black; font-family: Courier New;">mb_convert_encoding(</span><span style="color: #660000; font-family: Courier New;">$content</span><span style="color: black; font-family: Courier New;">, </span><span style="color: #008200; font-family: Courier New;">&#8220;html-entities&#8221;</span><span style="color: black; font-family: Courier New;">,</span><span style="color: #008200; font-family: Courier New;">&#8220;utf-8&#8221; </span><span style="color: black;"><span style="font-family: Courier New;">);</span><span style="font-family: 宋体;">最后终于</span><span style="font-family: Courier New;">OK</span><span style="font-family: 宋体;">了，不过这个函数还得对应的字体库才行。不然仍然会乱码的。</span><span style="font-family: Courier New;"><br /> </span></span></span>

<span style="color: black; font-family: 宋体; font-size: 10pt;">还得注意有可能会报这个错误</span>imagettftext() [function.imagettftext]: any2euc<span style="color: black;"><span style="font-family: Arial;">jp(): something happen in XXX.php on line XX</span><span style="font-family: 宋体;">。这个就是可能字库里面木有，换个字库。</span></span>

<span class="Apple-style-span" style="font-family: 宋体;">下面给出我测试的几个典型。</span>

```php
function test1()
{
	$content="唐磊leitang";
	$content = mb_convert_encoding($content, "html-entities","utf-8" );
	$t = setTextWater('./1.png',$content,"0,0,255",7,18);//这个方法见后面
	echo $t;
}
function test2(){
$name='郁闷aaaaaa';
$name = mb_convert_encoding($name, "html-entities","utf-8" ); 
$font = './simhei.ttf';//水印字体   
$im = imagecreatefrompng("./1.png");//载入图片   
$black = imagecolorallocate($im, 0, 0, 0);//设置颜色   
imagettftext($im, 12, 0, 320, 84, $black, $font, $name);//打印水印   
imagepng($im,'test2.png'); 
imagedestroy($im);//清空缓存  
}
//这个其实是图片水印了
function test3(){
	$pic=imagecreate(250,30);
	$black=imagecolorallocate($pic,0,0,0);
	$white=imagecolorallocate($pic,255,255,255);
	$font="./simhei.ttf";
	$str = '中华人民共和国';
	$str = mb_convert_encoding($str, "html-entities","utf-8" );//结果:&#21738;&#19968;&#38431;&#20248;&#20808;&#24320;&#29699;

	imagettftext($pic,10,0,10,20,$white,$font,$str);

	$filename='./1.png';
	$im=imagecreatefrompng($filename);
	imagecopymerge($im,$pic,0,0,0,0,250,30,50);
	imagepng($im,'test3.png');
}
```

<span style="color: black; font-size: 10pt;"><span style="font-family: 宋体;">效果如图：</span><span style="font-family: Courier New;"><br /> </span></span>

<span style="color: black; font-family: Courier New; font-size: 10pt;">Test1<br /> </span>

![](/wp-content/uploads/2011/11/111711_1141_Php1.png)

Test2                                                            Test3

<img class="alignleft" title="php中文水印乱码" src="/wp-content/uploads/2011/11/111711_1141_Php2.png" alt="php中文水印乱码"  />

![](/wp-content/uploads/2011/11/111711_1141_Php3.png)

&nbsp;

&nbsp;

&nbsp;

&nbsp;

把每一次试的结果都保存了。

  *  <span style="color: #660000; background-color: yellow;">$name </span><span style="color: black; background-color: yellow;">= iconv(</span><span style="color: #008200; background-color: yellow;">&#8216;UTF-8&#8217;</span><span style="color: black; background-color: yellow;">, </span><span style="color: #008200; background-color: yellow;">&#8216;GB18030//IGNORE&#8217;</span><span style="color: black; background-color: yellow;">, </span><span style="color: #660000; background-color: yellow;">$name</span><span style="color: black; background-color: yellow;">);</span>

![](/wp-content/uploads/2011/11/111711_1141_Php4.png)

&nbsp;

  * <div style="text-align: justify;">
      <span style="font-family: Courier New; font-size: 10pt;"><span style="color: #660000; background-color: yellow;">$name </span><span style="color: black; background-color: yellow;">= iconv(</span><span style="color: #008200; background-color: yellow;">&#8216;UTF-8&#8217;</span><span style="color: black; background-color: yellow;">, </span><span style="color: #008200; background-color: yellow;">&#8216;GB2312&#8217;</span><span style="color: black; background-color: yellow;">, </span><span style="color: #660000; background-color: yellow;">$name</span><span style="color: black; background-color: yellow;">);<br /> </span></span>
    </div>

<span style="font-family: Courier New; font-size: 10pt;"><span style="color: #660000; background-color: yellow;">$font</span><span style="color: black; background-color: yellow;">=</span><span style="color: #008200; background-color: yellow;">&#8220;./simhei.ttf&#8221;</span><span style="color: black; background-color: yellow;">;</span></span>

![](/wp-content/uploads/2011/11/111711_1141_Php5.png)

  *   <span style="color: #660000; font-family: Courier New;">$name</span><span style="color: black; font-family: Courier New;">=</span><span style="color: #008200;"><span style="font-family: Courier New;">&#8216;</span><span style="font-family: 宋体;">唐磊</span><span style="font-family: Courier New;">leitang&#8217;</span></span><span style="font-family: Courier New;"><span>;</span></span>

<span style="font-family: Courier New; font-size: 10pt;"><span style="color: #660000;">$name </span><span style="color: black;">= mb_convert_encoding(</span><span style="color: #660000;">$name</span><span style="color: black;">, </span><span style="color: #008200;">&#8220;html-entities&#8221;</span><span style="color: black;">,</span><span style="color: #008200;">&#8220;utf-8&#8221; </span><span style="color: black;">);</span><br /> </span>

<span style="font-size: 10pt;"><span style="color: #660000; font-family: Courier New;">$font </span><span style="color: black; font-family: Courier New;">= </span><span style="color: #008200; font-family: Courier New;">&#8216;./arial.ttf&#8217;</span><span style="color: black; font-family: Courier New;">;</span><span style="color: gray;"><span style="font-family: Courier New;">//</span><span style="font-family: 宋体;">水印字体</span><span style="font-family: Courier New;"><br /> </span></span></span>

![](/wp-content/uploads/2011/11/111711_1141_Php6.png)

&nbsp;

  * <span style="font-size: 10pt;"><span style="color: #660000; font-family: Courier New;">$name</span><span style="color: black; font-family: Courier New;">=</span><span style="color: #008200;"><span style="font-family: Courier New;">&#8216;</span><span style="font-family: 宋体;">唐磊</span><span style="font-family: Courier New;">leitang&#8217;</span></span><span style="font-family: Courier New;"><span style="color: black;">;</span><br /> </span></span>

<span style="font-family: Courier New; font-size: 10pt;"><span style="color: #660000;">$name </span><span style="color: black;">= mb_convert_encoding(</span><span style="color: #660000;">$name</span><span style="color: black;">, </span><span style="color: #008200;">&#8220;html-entities&#8221;</span><span style="color: black;">,</span><span style="color: #008200;">&#8220;utf-8&#8221; </span><span style="color: black;">);</span><br /> </span>

<span style="font-size: 10pt;"><span style="color: #660000; font-family: Courier New;">$font </span><span style="color: black; font-family: Courier New;">= </span><span style="color: #008200; font-family: Courier New;">&#8216;./simhei.ttf&#8217;</span><span style="color: black; font-family: Courier New;">;</span><span style="color: gray;"><span style="font-family: Courier New;">//</span><span style="font-family: 宋体;">水印字体</span><span style="font-family: Courier New;"><br /> </span></span></span>

![](/wp-content/uploads/2011/11/111711_1141_Php7.png)

  *  <span style="color: #660000; font-family: Courier New;">$name</span><span style="color: black; font-family: Courier New;">=</span><span style="color: #008200;"><span style="font-family: Courier New;">&#8216;</span><span style="font-family: 宋体;">唐磊</span><span style="font-family: Courier New;">leitang&#8217;</span></span><span style="font-family: Courier New;"><span>;</span></span>

<span style="font-family: Courier New; font-size: 10pt;"><span style="color: #660000;">$name </span><span style="color: black;">= mb_convert_encoding(</span><span style="color: #660000;">$name</span><span style="color: black;">, </span><span style="color: #008200;">&#8220;UTF-8&#8221;</span><span style="color: black;">, </span><span style="color: #008200;">&#8220;GBK&#8221;</span><span style="color: black;">);</span><br /> </span>

<span style="font-size: 10pt;"><span style="color: #660000; font-family: Courier New;">$font </span><span style="color: black; font-family: Courier New;">= </span><span style="color: #008200; font-family: Courier New;">&#8216;./simhei.ttf&#8217;</span><span style="color: black; font-family: Courier New;">;</span><span style="color: gray;"><span style="font-family: Courier New;">//</span><span style="font-family: 宋体;">水印字体</span><span style="font-family: Courier New;"><br /> </span></span></span>

![](/wp-content/uploads/2011/11/111711_1141_Php8.png)

&nbsp;

附上详细方法(参考网上滴)：

```php
/**
 * 文字水印
 */
function setTextWater($imgSrc,$markText,$TextColor,$markPos,$fontSize = 30)
{
	$fontType="./simhei.ttf";
    $srcInfo = @getimagesize($imgSrc);
    $srcImg_w    = $srcInfo[0];
    $srcImg_h    = $srcInfo[1];
    $markText = mb_convert_encoding($markText, "html-entities","utf-8" );
    $markedfilename="tmp/".time();
    switch ($srcInfo[2]) 
    { 
        case 1: 
            $srcim =imagecreatefromgif($imgSrc);
            $markedfilename.=".gif";
            break; 
        case 2: 
            $srcim =imagecreatefromjpeg($imgSrc); 
            $markedfilename.=".jpg";
            break; 
        case 3: 
            $srcim =imagecreatefrompng($imgSrc); 
            $markedfilename.=".png";
            break; 
        default: 
            echo "不支持的图片文件类型"; 
			return false;
    }
    {
        
        if(!empty($markText))
        {
            if(!file_exists($fontType))
            {
               echo '字体文件不存在'; 
			   return false;
            }
        }
        else {
            echo '没有水印文字'; 
			return false;
        }
		//此函数返回一个含有8个单元的数组表示文本外框的四个角，索引值含义：0代表左下角 X 位置，1代表坐下角 Y 位置，
		//2代表右下角 X 位置，3代表右下角 Y 位置，4代表右上角 X 位置，5代表右上角 Y 位置，6代表左上角 X 位置，7代表左上角 Y 位置
		$box = @imagettfbbox($fontSize, 0, $fontType,$markText);
		//var_dump($box);exit;
        $logow = max($box[2], $box[4]) - min($box[0], $box[6]);
        $logoh = max($box[1], $box[3]) - min($box[5], $box[7]);
    }
        
     
    switch($markPos)
    {
        case 1:
            $x = 5;
            $y = $fontSize;
            break;
        case 2:
            $x = ($srcImg_w - $logow) / 2;
            $y = $fontSize;
            break;
        case 3:
            $x = $srcImg_w - $logow - 5;
            $y = $fontSize;
            break;
        case 4:
            $x = $fontSize;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 5:
            $x = ($srcImg_w - $logow) / 2;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 6:
            $x = $srcImg_w - $logow - 5;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 7:
            $x = $fontSize;
            $y = $srcImg_h - $logoh - 5;
            break;
        case 8:
            $x = ($srcImg_w - $logow) / 2;
            $y = $srcImg_h - $logoh - 5;
            break;
        case 9:
            $x = $srcImg_w - $logow - 5;
            $y = $srcImg_h - $logoh -5;
            break;
        default: 
			$x = rand ( 0, ($srcImg_w - $logow) );
			$y = rand ( 0, ($srcImg_h - $logoh) );
    }
        
    $dst_img = @imagecreatetruecolor($srcImg_w, $srcImg_h);
        
    imagecopy ( $dst_img, $srcim, 0, 0, 0, 0, $srcImg_w, $srcImg_h);
        
        
    {
        $rgb = explode(',', $TextColor);
      
        $color = imagecolorallocate($dst_img, intval($rgb[0]), intval($rgb[1]), intval($rgb[2]));
        imagettftext($dst_img, $fontSize, 0, $x, $y, $color, $fontType,$markText);
    }
    

    switch ($srcInfo[2]) 
    { 
        case 1:
            imagegif($dst_img,$markedfilename); 
            break; 
        case 2: 
            imagejpeg($dst_img,$markedfilename); 
            break; 
        case 3: 
            imagepng($dst_img,$markedfilename); 
            break;
        default: 
            echo ("不支持的水印图片文件类型"); 
            return false; 
    }
        
    imagedestroy($dst_img);
    imagedestroy($srcim);
	
	return $markedfilename;
}
```

顺便把图片水印的也贴出来：

```php
/**
 * 图片水印
 */
function  setImgWater($imgSrc,$markImg,$markPos)
{
    $srcInfo = @getimagesize($imgSrc);
    $srcImg_w    = $srcInfo[0];
    $srcImg_h    = $srcInfo[1];
    $img_water = "./waterpic";   //生成的图片文件名 
    switch ($srcInfo[2]) 
    { 
        case 1: 
            $srcim =imagecreatefromgif($imgSrc);
			$img_water.=".gif";
            break; 
        case 2: 
            $srcim =imagecreatefromjpeg($imgSrc); 
			$img_water.=".jpg";
            break; 
        case 3: 
            $srcim =imagecreatefrompng($imgSrc); 
			$img_water.=".png";
            break; 
        default: 
            echo "不支持的图片文件类型"; 
			return false;
    }
    {
        if(!file_exists($markImg) || empty($markImg))
        {
        	echo '水印文件不存在';
            return false;
        }
            
        $markImgInfo = @getimagesize($markImg);
        $markImg_w    = $markImgInfo[0];
        $markImg_h    = $markImgInfo[1];
            
        if($srcImg_w < $markImg_w || $srcImg_h < $markImg_h)
        {
        	echo '水印文件比源图片文件都还大';
            return false;
        }
            
        switch ($markImgInfo[2]) 
        { 
            case 1: 
                $markim =imagecreatefromgif($markImg); 
                break; 
            case 2: 
                $markim =imagecreatefromjpeg($markImg); 
                break; 
            case 3: 
                $markim =imagecreatefrompng($markImg); 
                break; 
            default: 
                echo ("不支持的水印图片文件类型"); 
            	return false; 
        }
            
        $logow = $markImg_w;
        $logoh = $markImg_h;
    }
        
     
    switch($markPos)
    {
        case 1:
            $x = 5;
            $y = 5;
            break;
        case 2:
            $x = ($srcImg_w - $logow) / 2;
            $y = 5;
            break;
        case 3:
            $x = $srcImg_w - $logow - 5;
            $y = 5;
            break;
        case 4:
            $x = 5;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 5:
            $x = ($srcImg_w - $logow) / 2;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 6:
            $x = $srcImg_w - $logow - 5;
            $y = ($srcImg_h - $logoh) / 2;
            break;
        case 7:
            $x = 5;
            $y = $srcImg_h - $logoh - 5;
            break;
        case 8:
            $x = ($srcImg_w - $logow) / 2;
            $y = $srcImg_h - $logoh - 5;
            break;
        case 9:
            $x = $srcImg_w - $logow - 5;
            $y = $srcImg_h - $logoh -5;
            break;
        default: 
			$x = rand ( 0, ($srcImg_w - $logow) );
			$y = rand ( 0, ($srcImg_h - $logoh) );
    }
        
    $dst_img = @imagecreatetruecolor($srcImg_w, $srcImg_h);
        
    imagecopy ( $dst_img, $srcim, 0, 0, 0, 0, $srcImg_w, $srcImg_h);
        
    {
        imagecopy($dst_img, $markim, $x, $y, 0, 0, $logow, $logoh);
        imagedestroy($markim);
    }
        
    switch ($srcInfo[2]) 
    { 
        case 1:
            imagegif($dst_img, $img_water ); 
            break; 
        case 2: 
            imagejpeg($dst_img, $img_water ); 
            break; 
        case 3: 
            imagepng($dst_img, $img_water ); 
            break;
        default: 
            echo ("不支持的水印图片文件类型"); 
            return false; 
    }
        
    imagedestroy($dst_img);
    imagedestroy($srcim);
	
	echo 'success,the watermarked picture is '.$img_water."\n";
	return true;
}
```

btw,codecolorer这个插件的那个bug还没解决啊。后台写blog时，只要切换一下html到可视化，代码缩进就木有了……
