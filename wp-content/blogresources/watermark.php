<?php
    $refere = "http://www.tanglei.name/";
    if(isset($_SERVER['HTTP_REFERER']))
        $refere = $_SERVER["HTTP_REFERER"];
    //RecordLog("tanglei", $refere);
    
    $qq = getQQ($refere);
    
    $url = "http://base.qzone.qq.com/fcg-bin/cgi_get_portrait.fcg?uins=".$qq;
    $result = file_get_contents($url);
    $info = explode(',',$result);
    if(count($info) >=7 )
    {
        $pic = explode("[", $info[0]);
        $picurl = substr($pic[1], 1, strlen($pic[1])-2);
        $nickname = iconv("GBK", "UTF-8//IGNORE", $info[6]);
        $imglocal = $qq.".local";
        if(!file_exists($imglocal))
            file_put_contents($imglocal, file_get_contents($picurl));
        
        setImgAndTextWater("1.png", $imglocal, -1, $nickname, $qq);
    }
    
    exit();
    
    function getQQ($referer)
    {
        $pattern = "/http:\/\/user.qzone.qq.com\/(\d+)\/infocenter/";
        $pattern2 = "/http:\/\/user.qzone.qq.com\/(\d+)\\?/";
        $pattern3 = "/http:\/\/user.qzone.qq.com\/(\d+)\//";
        $pattern4 = "/(\d+)/";
        $qq = NULL;        
        if(preg_match($pattern, $referer, $matches))
            $qq = $matches[1];
        if($qq == NULL)
        {
            if(preg_match($pattern2, $referer, $matches))
                $qq = $matches[1];
            if($qq == NULL)
            {
                if(preg_match($pattern3, $referer, $matches))
                    $qq = $matches[1];
                if($qq == NULL)
                {
                    if(preg_match($pattern4, $referer, $matches))
                        $qq = $matches[1];
                }
            }
            
        }
        if($qq == NULL)
        {
            if($_GET["qq"] != NULL)
                $qq = $_GET["qq"];
            else
                $qq = 410454274;
            
        }
        return $qq;
    }
    
    function RecordLog($uname,$text) {
        if(getenv('HTTP_CLIENT_IP')) {
            $onlineip= getenv('HTTP_CLIENT_IP');
        }elseif(getenv('HTTP_X_FORWARDED_FOR')) {
            $onlineip= getenv('HTTP_X_FORWARDED_FOR');
        }elseif(getenv('REMOTE_ADDR')) {
            $onlineip= getenv('REMOTE_ADDR');
        } else{
            $onlineip= $HTTP_SERVER_VARS['REMOTE_ADDR'];
        }
        $date_time= date("Y年m月d H:i:s");
        $LOG_FILE ="/Library/WebServer/Documents/log/".date("Ymd").$uname.".txt";
        $text ="$date_time  ".$text." IP地址:$onlineip";
        if(!file_exists($LOG_FILE)) {
            touch($LOG_FILE);
            //chmod($LOG_FILE,"744");
        }
        $fd =@fopen($LOG_FILE, "a");
        @fwrite($fd,$text."\r\n");
        @fclose($fd);
    }
    
    function  setImgAndTextWater($imgSrc, $markImg, $markPos, $name, $qq)
    {
        $srcInfo = getimagesize($imgSrc);
        $srcImg_w    = $srcInfo[0];
        $srcImg_h    = $srcInfo[1];
        $img_water = NULL;//"./waterpic";   //生成的图片文件名
        switch ($srcInfo[2])
        {
            case 1:
                $srcim =imagecreatefromgif($imgSrc);
                if($img_water != NULL) $img_water.=".gif";
                break;
            case 2:
                $srcim =imagecreatefromjpeg($imgSrc);
                if($img_water != NULL) $img_water.=".jpg";
                break;
            case 3:
                $srcim =imagecreatefrompng($imgSrc);
                if($img_water != NULL) $img_water.=".png";
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
                $x = 360;
                $y = 50;
        }
        
        $dst_img = imagecreatetruecolor($srcImg_w, $srcImg_h);
        
        if($srcim != NULL)
            imagecopy ( $dst_img, $srcim, 0, 0, 0, 0, $srcImg_w, $srcImg_h);
        
        {
            imagecopy($dst_img, $markim, $x, $y, 0, 0, $logow, $logoh);
            imagedestroy($markim);
        }
        
        
        $name = mb_convert_encoding($name, "html-entities","utf-8" );
        $font = './simhei.ttf';
        $namecolor = imagecolorallocate($dst_img, 155, 30, 0);
        $qqcolor = imagecolorallocate($dst_img, 255, 30, 0);
        //array imagettftext ( resource $image , float $size , float $angle , int $x , int $y , int $color , string $fontfile , string $text )
        imagettftext($dst_img, 12, 0, 300, 37, $namecolor, $font, $name); 
        imagettftext($dst_img, 12, 0, 275, 72, $qqcolor, $font, $qq); 
        
        switch ($srcInfo[2])
        {
            case 1:
                if($img_water == NULL)
                {
                    header("Content-type:image/gif");
                    imagegif($dst_img);
                }else
                {
                    imagegif($dst_img, $img_water );
                }
                break;
            case 2:
                if($img_water == NULL)
                {
                    header("Content-type:image/jpeg");
                    imagejpeg($dst_img);
                }else
                {    imagejpeg($dst_img, $img_water );
                }
                break;
            case 3:
                if($img_water == NULL)
                {
                    header("Content-type:image/png");
                    imagepng($dst_img );
                }else
                {   imagepng($dst_img, $img_water );
                }
                break;
            default:
                echo ("不支持的水印图片文件类型");
                return false;
        }
        
        
        imagedestroy($dst_img);
        
        if($srcim != NULL)
            imagedestroy($srcim);
        
        if($img_water != NULL)
            echo 'success,the watermarked picture is '.$img_water."\n";
        
        return true;
    }
    
    /*
     $imgSrc = "./1.png";
     $markImg = "100.jpeg";
     $markPos = 4;
     $name='郁闷aaaaaa';
     
     setImgAndTextWater($imgSrc, $markImg, $markPos, $name);
     */
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
    ?>
