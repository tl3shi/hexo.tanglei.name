---
id: 1948
title: VIM编写OpenGL环境配置(MinGW)
date: 2012-09-29T14:28:41+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1948
duoshuo_thread_id:
  - 1351844048792453149
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 计算机图形学
tags:
  - OpenGL
  - 计算机图形学
  - Vim
---
一般的OpenGL教程都没有用VS等开发环境，直接用glut.h中相关定义来实现窗口显示、事件绑定等操作。之前用配置了环境VIM编写C、C++等程序，直接写OpenGL程序编译运行等不能直接操作，还需一定的配置。<a href="http://www.mingw.org/wiki/HOWTO_Use_Mark_J_Kilgards_OpenGL_Utility_Toolkit_GLUT_with_MinGW" target="_blank">MinGW官网也给出了解决方案</a>，参照此结合其他资源给出了自己的解决方法，记录以供查阅。(cygwin应该也是类似的配置)

1、下载<a href="http://www.opengl.org/resources/libraries/glut/glutdlls37beta.zip" target="_blank">相应glut库</a>，目前windows版本3.7beta，<a href="http://www.opengl.org/resources/libraries/glut/glut_downloads.php#windows" target="_blank">官网</a>见此。

2、解压后得到如下文件，分别copy至mingw目录。

  * *.lib(glut32.lib,glut.lib)&#8212;&#8211;>C:\MinGW\lib\（至你的MinGW安装目录lib下）
  * glut.h&#8212;->C:\MinGW\include\GL\（没有的话，mkdir gl）
  * *.dll(glut.dll,glut32.dll)&#8212;&#8211;>C:\windows\system32\（系统sysem32路径）

3、写个例子.

```cpp
#include <gl/glut.h>
#define WIDTH 400
#define HEIGHT 400

void myDisplay(void)
{
    glClear(GL_COLOR_BUFFER_BIT);  
    glColor3d(1.0, 0, 0);
    glRectf(-0.5f, -0.5f, 0.5f, 0.5f);  
    glFlush();   
}

int main(int argc, char* argv[])
{
     glutInit(&argc, argv);
     glutInitDisplayMode(GLUT_RGBA | GLUT_SINGLE);
     glutInitWindowSize(WIDTH, HEIGHT);
     glutCreateWindow("OpenGL-HelloWorld");
     glutDisplayFunc(&myDisplay);
     glutMainLoop();
     return 0;
}
```

4、编译&运行.
  
直接通过默认的GCC编译参数通不过，报“undefined references”等错误，得加相关参数。GLUT\_DISABLE\_ATEXIT_HACK貌似说的是在glut编译时保证用一样的C run-time libraries (CRTs).

``gcc t.cpp -D_STDCALL_SUPPORTED -DGLUT_DISABLE_ATEXIT_HACK -lopengl32 -lglu32 -lglut32 -o t.exe ``

运行t.exe即可。
  
可以配置到VIMRC文件中，map到键盘就方便了，跟一般的C++/C程序区分下，另外加个编译的映射，比如ctrl+alt+F5，运行还是不变。

```bash
func CompileOpenGLRun()
    exec "!gcc % -g -o %<.exe -D_STDCALL_SUPPORTED -DGLUT_DISABLE_ATEXIT_HACK -lopengl32 -lglu32 -lglut32 "
endfunc
"定义Run函数
func Run()
  if &filetype == 'c' || &filetype == 'cpp'
    exec "!%<.exe"
  elseif &filetype == 'java'
    exec "!java %<"
  endif
endfun
map <C-A-F5> :call CompileOpenGLRun()<CR>
map <F9> :call Run()<CR>
```

现在就是ctrl+alt+f5编译，f9运行即可。如果你还不行，试着在文件开始 include <windows.h>,define 一些常量等，详细情况可以参考后面的参考文章。
  
参考文章:
  

  
1、[HOWTO Use Mark J. Kilgard&#8217;s OpenGL Utility Toolkit (GLUT) with MinGW](http://www.mingw.org/wiki/HOWTO_Use_Mark_J_Kilgards_OpenGL_Utility_Toolkit_GLUT_with_MinGW)
  
2、[How to use Glut with MinGW G++](http://objectmix.com/graphics/136156-how-use-glut-mingw-g.html)
