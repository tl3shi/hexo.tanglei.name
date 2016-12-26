---
id: 2072
title: 点集的凸包问题
date: 2013-03-28T23:06:07+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2072
duoshuo_thread_id:
  - 1351844048792453272
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 计算机图形学
tags:
  - 计算几何
---
凸的意思就是，点集当中任意两个点的连线仍然在这个集合当中。凸包就是说用一个足够大的橡皮筋把这些点包围住，这个最小的橡皮筋就构成了这些点集的凸包。

求出凸包是计算几何当中一个经典的问题，也是贯穿这整个计算几何的学科。如下图所示，最外层的那个圈就是这些点集的凸包。凸包上的那些点称为极点，如果找出了所有的极点，那么，凸包也就求出来了。极点的可以用这种方式来进行判断，点集P中任意一个点s，如果存在另外的三个不同的点p,q,r构成的三角形将s包围住，那么这个点s就不是极点，反之就是极点。于是也就有了第一个算法：
  
<img src="/wp-content/uploads/2013/03/032813_1505_1.png" alt="凸包" align="left"/>

```pascal
Mark All points in Set P as extreme;
For each triangle (p,q,r):
   For each k in Set P and k ! = (p,q,r):
       If k in triangle(p,q,r)
          Mark k as NON-extreme.
```

判断一个点k是否在点p,q,r构成的三角形中可以用toleft测试。如上图中的例子，如果k在有向线段pq的左边 and k 在 qr的左边and k在rp的左边，那么k就在pqr构成的的三角形里面了。核心代码如下：

```cpp
//O(n^4)
vector<CP_Vector2D> cal_extreme_points()
{
    vector<CP_Vector2D> extreme_points;
    vector<MyPoint> my_points;
    unsigned int size = points.size();
    //inital all points to extreme
    for (unsigned int i = 0; i < size; i++)
        my_points.push_back(MyPoint(points[i], true));

    for (unsigned int p = 0; p < size; p++)
    {
        for (unsigned int q = p+1 ; q < size; q++)
        {
            for (unsigned int r = q+1; r < size; r++)
            {
                for (unsigned int k = 0; k < size; k++)
                {
                    if (k == p || k == q || k == r || !my_points[k].isExtreme) 
                        continue;
                    if (in_triangle(my_points[k].point, my_points[p].point, my_points[q].point, my_points[r].point))
                        my_points[k].isExtreme = false;
                }
            }
        }
    }

    for (unsigned int i = 0; i < size; i++)
    {
        if(my_points[i].isExtreme)
            extreme_points.push_back(my_points[i].point);
    }
    //sort the extrme_points
    sort(extreme_points.begin(), extreme_points.end(), compare);
    leftest_and_lowest = extreme_points[0];
    //sort the extrme_points by left_and_lowest polar
    sort(extreme_points.begin()+1, extreme_points.end(), compareByAngle);
    return extreme_points;
}
```

这是一个O(n<sup>4</sup>)的算法，找出所有极点之后，还得用O(nlgn)排一下序将所有的极点连接起来(可以按照极点与最左下角的点和沿水平X轴的夹角排序)。

稍微有些改进的方法是找出所有的极边(构成凸包的多边形的每一条边都是极边)，可以这么来计算极边，除了极边两个点外，其他的点都在这个边的同一侧。如下算法：

```pascal
let EE = null
for each directed segment pq
if points in P\{p,q} lie to the SAME side of pq then let EE = EE+{pq}
```

找出所有的极边需要<a name="OLE_LINK1"></a>O(n<sup>3</sup>)，然后再连接起来，整个算法复杂度为O(n<sup>3</sup>).

```cpp
//O(n^3)
vector<CP_Vector2D> cal_extreme_edges()
{
    vector<ExtremeEdge> edgs;
    
    unsigned int size = points.size();

    for (unsigned int p = 0; p < size; p++)
    {
        for (unsigned int q = p+1 ; q < size; q++)
        {
            bool all_left = true, all_right = true;
            for (unsigned int k = 0; k < size; k++)
            {
                if (k == p || k == q || p == q)
                    continue;
                if(to_left(points[k], points[p], points[q]))
                    all_left = false;
                else
                    all_right = false;
            }
            //let the direction be all the same
            if (all_left)
                edgs.push_back(ExtremeEdge(points[p], points[q]));
            if (all_right)
                edgs.push_back(ExtremeEdge(points[q], points[p]));
        }
    }
    
    vector<CP_Vector2D> convexPoints;

    ////O(n^2), should better sort the edges by angle.
    //convexPoints.push_back(edgs[0].end);
    //while(convexPoints.size() != edgs.size())
    //{
    //    for (unsigned int i = 0; i < edgs.size(); i++)
    //    {
    //        if (convexPoints[convexPoints.size() - 1] == edgs[i].start)
    //            convexPoints.push_back(edgs[i].end);
    //    }
    //}

    //O(nlogn)
    sort(edgs.begin(), edgs.end(), compareEdgeByAngle);
    for (unsigned int i=0; i < edgs.size(); i++)
    {
        convexPoints.push_back(edgs[i].start);
    }

    return convexPoints;
}
```

再说一下<span style="font-size: 10pt;">Gift Wrapping算法</span>，算法思路如下：因为所有的极边都通过端点连接而成围成一个圈，一旦找到第一条极边，可以通过利用O(n)搜索剩下的点构成接下来的极边，圈围成后，凸包即计算出来。整个算法复杂度O(n<sup>2</sup>)。其中第一个点可以通过O(n)的时间找到最左下角的点。就像其名字一样，整个算法就像在包装gift。

```pascal
find an arbitrary EP, denoted as p0
let i = 0
repeat
 find the EE pipi+1
 i++
until pi = p0
```

分析下GiftWrapping算法，每条极边的确定需要O(N)的时间，算法所耗费的时间依赖与极边的数量，因此GiftWrapping算法在最坏的情况下需要O(n<sup>2</sup>)，最好的情况下仅仅需要O(N)，更确切地讲，需要O(n*h)，h是凸包包含的点数量，这个算法是一个output sensitive的算法。

```cpp
//O(n^2),in fact O(n*h),h = convex hull.size, output sensitive
vector<CP_Vector2D> giftwraping()
{
    int ltl = 0;//find the lowest-and-leftmost point
    for (unsigned int i = 1; i < points.size(); i++)
    {
        if(points[i].m_y < points[ltl].m_y || 
           (points[i].m_y == points[ltl].m_y && points[i].m_x < points[ltl].m_x))
           ltl = i;
    }
    vector<CP_Vector2D> convexPoints;
    convexPoints.push_back(points[ltl]);
    for(int p = ltl; ;)
    {
        int q = -1;
        for(unsigned int k = 0; k < points.size(); k++)
        {
            if( (k != p) &&  (q < 0 || !to_left(points[k], points[p], points[q])))
                q = k;//update q if k lies in right of pq
        }
        if(ltl == q)
            break;// has find out the convex hull circle
        //find q
        convexPoints.push_back(points[q]);
        p = q;
    }
     return convexPoints;
}
```

是否能够继续优化下去，将算法复杂度再次提高？或者Convex Hull的解法是否有一个下界?下面的算法就是一个总体复杂度O(nlgn)的算法，已经有人证明，这个是凸包问题的下界。不能再继续优化了。下面就看看著名的O(nlgn)的Graham Scan算法。

![](/wp-content/uploads/2013/03/032813_1505_2.png)
![](/wp-content/uploads/2013/03/032813_1505_3.png)

算法思路如下：首先仍然是找到最左下角的点，然后按照极角排序，如上图所示，编上号1——n，然后从第三个点开始，依次看该点是否在前两个点构成的直线的左边(3是否在有向线段12的左边,4是否在有向线段23的左边，依次类推),上例中，到第5个点时，发现5不在34的左边，则回退一个，连接35，到第6个点时，发现6也不在前两个点35(此时4已经被排除)构成的有向线段的左边,再回退，看6仍然不在23的左边，继续回退，直到发现6在12的左边，此时连接26……就按照这样走下去，完成了整个凸包的构成。从具体实现上可以用两个栈来实现，算法如下所示：

```pascal
find the LTL point p1
sort all points w.r.t. p1 by polar angle: {p2, p3, ..., pn}
create stack S; S.push(p1) and S.push(p2)
create stack T; for i = n down to 3 do T.push(pi)
while (!T.empty()) do
   while (!toLeft(S[1], S[0], T[0])) do
        S.pop() 
   S.push(T.pop())
```

最后S中的点就是凸包上的极点，并且是有序的。注意上述算法中，每一个从S中pop出来的点都不是极点，因为会被其他三角形包围住。而所有的点都会在p1和p2的左边。这个代码用stl的stack有些别扭啊。因为stack不能直接查看栈顶的第二个元素&#8230;.不要紧，意思意思即可。:)

```cpp
//O(nlgn)
vector<CP_Vector2D> graham_scan()
{
    int ltl = 0;//find the lowest-and-leftmost point
    for (unsigned int i = 1; i < points.size(); i++)
    {
        if(points[i].m_y < points[ltl].m_y || 
            (points[i].m_y == points[ltl].m_y && points[i].m_x < points[ltl].m_x))
            ltl = i;
    }

    leftest_and_lowest = points[ltl];
    //compareByAngle should use the ltl point
    sort(points.begin(), points.end(), compareByAngle);

    vector<CP_Vector2D> convexPoints;
    stack<CP_Vector2D> S, T;
    S.push(points[0]);S.push(points[1]);
    for (int i = points.size()-1; i >= 2;i--)
    {
        T.push(points[i]);
    }
    CP_Vector2D s0, s1;
    while (!T.empty())
    {
        s0 = S.top();
        S.pop();//s0 is gone
        if(S.empty())
        {
            S.push(T.top());
            break;
        }
        s1 = S.top();//get s1
        S.push(s0);
        while (!to_left(T.top(), s1, s0))
        { 
            S.pop(); 
            s0 = S.top();
            S.pop();//s0 is gone
            s1 = S.top();//get s1
            S.push(s0);
        }
        S.push(T.top());
        T.pop();
    }
    int size = S.size();
    for(int i = 0; i < size; i++)
    {
        convexPoints.push_back(S.top());
        S.pop();//size is change, cannot use i < S.size()
    }
    return convexPoints;
}
```

来分析下这个算法的复杂度。刚开始用O(N)的时间找p1，然后排序O(nlgn),最复杂的就是这个Scan，表面上看有两层while循环，仔细分析发现：toleft测试的数量=T.pop+s.push =O(N),而每一次toleft测试，总有一个点会从S或者T中pop出来，每个点从S中push进去一次且最多被pop出来一次。因此，整个while循环那里实际只耗费了O(N)。所以整个算法复杂度就是O(nlgn)。

最后自己实现了下以上几个算法，用MFC+OPENGL如图。注意实现时细节的处理，比如按照极角排序等，若考虑算法鲁棒性，得处理多点共线、重点等情况(本文未考虑)。

![](/wp-content/uploads/2013/03/032813_1505_4.png)

参考资料：[邓俊辉](http://www.csai.tsinghua.edu.cn/iar/members/dengjunhui_en.htm) 《计算几何》
