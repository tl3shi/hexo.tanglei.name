---
id: 2005
title: Bezier曲线曲面算法
date: 2012-10-24T19:40:38+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2005
duoshuo_thread_id:
  - 1351844048792453338
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 计算机图形学
tags:
  - opengl
  - 计算机图形学
---
将按照如下目录记录在学习bezier曲线曲面的相关知识.

  1. Bezier曲线 
      * 定义
      * Bernstein基函数的性质
      * Bezier曲线性质
      * de Casteljau算法
      * 直接法
  2. Bezier曲面 
      * 定义
      * Bezier曲面性质
      * 算法

### 一. Bezier曲线

#### 1. 定义

[<img title="clip_image002" src="/wp-content/uploads/2012/10/clip_image002_thumb.png" alt="clip_image002"  />](/wp-content/uploads/2012/10/clip_image002.png)

[<img title="clip_image004" src="/wp-content/uploads/2012/10/clip_image004_thumb.png" alt="clip_image004"  />](/wp-content/uploads/2012/10/clip_image004.png)其中**,C__(_t_)** 称为Bezier曲线,**_B<sub>i</sub>_<sub>,<em>n</em></sub>(_t_)** 称为Bernstein基函数,**P_<sub>i</sub>_** 称为控制顶点;

#### 2 . Bernstein基函数的性质

1) **非负性**

[<img title="clip_image002[5]" src="/wp-content/uploads/2012/10/clip_image0025_thumb.png" alt="clip_image002[5]"  />](/wp-content/uploads/2012/10/clip_image0025.png)

2) **权性(1****的1****个划分)**

[<img title="clip_image002[8]" src="/wp-content/uploads/2012/10/clip_image0028_thumb.png" alt="clip_image002[8]"  />](/wp-content/uploads/2012/10/clip_image0028.png)

[<img title="clip_image002[10]" src="/wp-content/uploads/2012/10/clip_image00210_thumb.png" alt="clip_image002[10]"  />](/wp-content/uploads/2012/10/clip_image00210.png)(**根据二项式定理**)

3) **对称性**

[<img title="clip_image002[12]" src="/wp-content/uploads/2012/10/clip_image00212_thumb.png" alt="clip_image002[12]"  />](/wp-content/uploads/2012/10/clip_image00212.png)

4) **最大值**

对于i=1,2,…, (n-1), B<sub>i,n</sub>(t)在区间[0, 1]上的最大值只能在一点处取得, 即: [<img title="clip_image002[14]" src="/wp-content/uploads/2012/10/clip_image00214_thumb.png" alt="clip_image002[14]"  />](/wp-content/uploads/2012/10/clip_image00214.png)

5) **收敛性 (Weierstrass****第一定理, 1885)**

对于任意的函数f(t) ∈C1[0,1],

[<img title="clip_image002[16]" src="/wp-content/uploads/2012/10/clip_image00216_thumb.png" alt="clip_image002[16]"  />](/wp-content/uploads/2012/10/clip_image00216.png)

6) **递推性**

_B<sub>i</sub>_<sub>,<em>n</em></sub>(_t_)=(1-_t_)_B<sub>i</sub>_<sub>,<em>n</em>-1</sub>(_t_)+_tB<sub>i</sub>_<sub>-1,<em>n</em>-1</sub>(_t_)

即高一次的Bernstein基函数可由两个低一次的Bernstein调和函数线性组合而成。

#### 3. Bezier曲线性质

1) **端点插值性**

[<img title="clip_image002[18]" src="/wp-content/uploads/2012/10/clip_image00218_thumb.png" alt="clip_image002[18]"  />](/wp-content/uploads/2012/10/clip_image00218.png)****

2) **端点切向量**

[<img title="clip_image004[5]" src="/wp-content/uploads/2012/10/clip_image0045_thumb.png" alt="clip_image004[5]"  />](/wp-content/uploads/2012/10/clip_image0045.png)

Bezier曲线在起点处的切线位于前两个控制点的连线上，而终点处的切线位于最后两个控制点的连线上，即曲线起点和终点处的切线方向与起始折线段和终止折线段的切线方向一致.

3) **导数性质**

[<img title="clip_image006" src="/wp-content/uploads/2012/10/clip_image006_thumb.png" alt="clip_image006"  />](/wp-content/uploads/2012/10/clip_image006.png) 其中: ΔP_<sub>i</sub>_=P_<sub>i</sub>_<sub>+1</sub>-P_<sub>i</sub>_

导数可以通过差分表示

4) **对称性**

Bernstein基函数的对称性

5) **凸包性**

Bezier曲线各点均落在控制多边形各顶点构成的凸包之中，这里的凸包指的是包含所有顶点的最小凸多边形。Bezier曲线的凸包性保证了曲线随控制点平稳前进而不会振荡。****

6) **几何不变性**

Bezier曲线的形状仅与控制多边形各顶点的相对位置有关，而与坐标系的选择无关，即具有几何不变性。

7) **变差缩减性**

Bezier曲线的变差减少性是指如果控制多边形是一个平面图形，则该平面内的任意直线与该Bezier曲线的交点个数不多于该直线与控制多边形的交点个数；如果控制多边形不是平面图形，则任意平面与Bezier曲线的交点个数不会超过它与控制多边形的交点个数。变差减少性反映了Bezier曲线比控制多边形波动得少，即比控制多边形更加光滑。

#### 4. de Casteljau算法

计算Bezier曲线上一点C(t<sub></sub>)
  
[<img title="decasteljau算法" src="/wp-content/uploads/2012/10/clip_image002_thumb.jpg" alt="decasteljau算法"  />](/wp-content/uploads/2012/10/clip_image002.jpg)

具体而言，实现可以用递归如下：

```cpp
CP_Vector2D getBezierPoint(vector<CP_Vector2D> controlPoints, double t, int i, int j)
{
	if (j == 0)
	{
		return controlPoints[i];
	}
	return getBezierPoint(controlPoints, t, i-1, j-1) * (1-t)+ getBezierPoint(controlPoints, t, i, j-1) * t;
}
```

后来实验发现，递归算法太慢，换成非递归，效果明显好转。

```cpp
CP_Vector2D getBezierPointNotRecurrent(vector<CP_Vector2D> controlPoints, double t)
{
	vector<CP_Vector2D> tempPoints(controlPoints);
	for (unsigned int i = 1; i <= tempPoints.size(); i++){
		for (unsigned int j = 0; j < tempPoints.size()-i; j++)
			tempPoints[j] = tempPoints[j] * (1-t) + tempPoints[j+1] * t; 
	}
	return tempPoints[0];
}
```

代码见<https://github.com/tl3shi/cagd/tree/master/task3>(说明，配图为当前代码演示结果，你现在看到的代码运行结果不是下面展示得到图片)效果如图.

[<img title="bezier曲线,控制点" src="/wp-content/uploads/2012/10/clip_image0026_thumb.jpg" alt="bezier曲线,控制点"  />](/wp-content/uploads/2012/10/clip_image0026.jpg)

#### 5. 直接法

直接通过上面的定义计算出每个点，然后再画出来。如下所示：

```cpp
const int maxControlPoint = 4;
	CP_Vector2D controlPoints[maxControlPoint];
	controlPoints[0] = CP_Vector2D(0.0, 0.0);
	controlPoints[1] = CP_Vector2D(1.0, 3.0);
	controlPoints[2] = CP_Vector2D(2.0, 1.0);
	controlPoints[3] = CP_Vector2D(3.0, 3.0);
	
	glColor3d(1.0, 0, 0);
	glBegin(GL_LINE_STRIP);
	double t = 0;
	for (unsigned int i = 0; i < besierSegment; i++)
	{
		t += 1.0/besierSegment;
		CP_Vector2D p = getBezierPoint(controlPoints, t, 3, 3);
		glVertex2d(p.m_x / 10, p.m_y / 10);
	}
	glEnd();
	
	glLoadIdentity();
	glTranslated(-0.5, 0.0, 0.0);   
	glColor3d(1.0, 0, 1.0);
	glBegin(GL_LINE_STRIP);
	t = 0;
	for (unsigned int i = 0; i < besierSegment; i++)
	{
		t += 1.0/besierSegment;
		CP_Vector2D p;
		for (unsigned kk = 0 ; kk < maxControlPoint; kk++) 
		{
			p += controlPoints[kk] * B(kk, 3, t);
		}

		glVertex2d(p.m_x / 10, p.m_y / 10);
	}

	glEnd();
	glFlush();
```

结果如图：

[<img title="bezier curve" src="/wp-content/uploads/2012/10/clip_image001_thumb.png" alt="bezier curve"  />](/wp-content/uploads/2012/10/clip_image001.png)

### 二、Bezier曲面

#### 1、定义

[<img title="clip_image002[20]" src="/wp-content/uploads/2012/10/clip_image00220_thumb.png" alt="clip_image002[20]"  />](/wp-content/uploads/2012/10/clip_image00220.png)

其中，[<img title="clip_image004[7]" src="/wp-content/uploads/2012/10/clip_image0047_thumb.png" alt="clip_image004[7]"  />](/wp-content/uploads/2012/10/clip_image0047.png) ****,S(_u_,_v_)称为Bezier曲面，_B<sub>i</sub>_<sub>,<em>n</em></sub>(_t_)称为Bernstein基函数，P_<sub>i</sub>_<sub>,<em>j</em></sub>称为控制顶点。

#### 2. bezier曲面性质

1) **角点性质**

Bezier曲面特征网格的四个角点正好是Bezier曲面的四个角点。S(0,0)=P<sub>0,0,</sub>S(0,1)=P<sub>0,<em>n,</em></sub>S(1,0)=P_<sub>m</sub>_<sub>,0,</sub>S(1,1)=P_<sub>m</sub>_<sub>,<em>n.</em></sub>

2) **边界线**

Bezier曲面特征网格最外一圈顶点定义Bezier曲面的四条边界：S(0,v),S(1,v),S(u,0)S(u,1)

3) **凸包性、对称性、几何不变性等**

#### **3. Bezier曲面算法**

可以对定义的公式进行如下的变化

[<img title="Bezier曲面算法" src="/wp-content/uploads/2012/10/clip_image00222_thumb.png" alt="Bezier曲面算法"  />](/wp-content/uploads/2012/10/clip_image00222.png)

[<img title="clip_image004[9]" src="/wp-content/uploads/2012/10/clip_image0049_thumb.png" alt="clip_image004[9]"  />](/wp-content/uploads/2012/10/clip_image0049.png)

[<img title="Bezier曲面算法" src="/wp-content/uploads/2012/10/clip_image0066_thumb.png" alt="Bezier曲面算法"  />](/wp-content/uploads/2012/10/clip_image0066.png)

[<img title="Bezier曲面算法" src="/wp-content/uploads/2012/10/clip_image008_thumb.png" alt="Bezier曲面算法"  />](/wp-content/uploads/2012/10/clip_image008.png)

de Casteljau算法：参考<http://www.cs.mtu.edu/~shene/COURSES/cs3621/NOTES/surface/bezier-de-casteljau.html>

```pascal
Input: a m+1 rows and n+1 columns of control points and (u,v). 
Output: point on surface p(u,v) 
Algorithm: 
for i := 0 to m do 
begin 
    Apply de Casteljau's algorithm to the i-th row of control points with v; 
    Let the point obtained be qi(v); 
end
Apply de Casteljau's algorithm to q0(v), q1(v), ..., qm(v) with u; 
The point obtained is p(u,v);
```

想像Bezier曲面由bezier曲线拼接而成，可以先把点给求出来。

```cpp
besierSegment = 30;
	const int uNum = 30, vNum = 30;
	CP_Vector3D bezierPoints [uNum][vNum];

	for (unsigned int u = 0; u < uNum; u++)
	{
		t = u * 1.0 / besierSegment;
		vector<CP_Vector3D> newControl;
		for (unsigned int k = 0; k < 4; k++)
		{
			CP_Vector3D p = getBezierPointNotRecurrent(controlPoints[k], t);
			newControl.push_back(p);
		}
		
		glBegin(GL_LINE_STRIP);
		for (unsigned int v = 0; v < vNum; v++)
		{
			t = v * 1.0 / besierSegment;
			CP_Vector3D p = getBezierPointNotRecurrent(newControl, t);
			glVertex3d(p.m_x / 1.0, p.m_y / 1.0, p.m_z / 1.0);
			bezierPoints[u][v] = p;
		}
		glEnd();
	}
```

上面把一条条bezier曲线给画出来了，并求出bezier曲面上的点。然后通过**四边形**(三角形也可以)拼接出来即可，如下图：

[<img title="bezier曲面拼接" src="/wp-content/uploads/2012/10/clip_image0016_thumb.png" alt="bezier曲面拼接"  />](/wp-content/uploads/2012/10/clip_image0016.png)

相邻的4个点构成四边形，分别是bezierPoints\[u\]\[v\]，\[u+1\]\[v\]，\[u+1\]\[v+1\]，\[u\]\[v+1\]，遍历即可得到。

```cpp
for (unsigned u = 0; u < uNum -1; u++)
	{
		for(unsigned v = 0; v < vNum - 1; v++ )
		{  
			glBegin(GL_QUADS);
			CP_Vector3D p = bezierPoints[u][v];
			glVertex3d(p.m_x / 1.0, p.m_y / 1.0, p.m_z / 1.0);
			p = bezierPoints[u+1][v];
			glVertex3d(p.m_x / 1.0, p.m_y / 1.0, p.m_z / 1.0);
			p = bezierPoints[u+1][v+1];
			glVertex3d(p.m_x / 1.0, p.m_y / 1.0, p.m_z / 1.0);
			p = bezierPoints[u][v+1];
			glVertex3d(p.m_x / 1.0, p.m_y / 1.0, p.m_z / 1.0);
			glEnd();
		}
	}
```

优化的话，求法向量，加点颜色之类的可以更好看。

[<img title="bezier曲面" src="/wp-content/uploads/2012/10/clip_image0028_thumb.jpg" alt="bezier曲面"  />](/wp-content/uploads/2012/10/clip_image0028.jpg)

本例结果如上图所示，左边是最后画出的bezier曲面，右边红色的是由控制顶点连线构成的，灰色的是多条bezier曲线构成。参考程序见<https://github.com/tl3shi/cagd/tree/master/task4> (说明，程序可能会修改，记录本文时结果如上图所示)。
