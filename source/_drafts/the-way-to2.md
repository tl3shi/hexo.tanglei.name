二分搜索一下, 把M当成已知的, 去求R, 因为M和R是正相关, R越大, M肯定也越大. 

附上这段查找搜索月息的代码, (未经严格测试, 可能有bug) 

```python
def calM(A, i, R):
    p = pow(1+R, i)
    return R * A * p / (p - 1)

def binarySearchR(start, end, i, A, M):
    while (abs(end - start) >= 0.00001):
        mid = start + (end - start)/2
        m = calM(A, i, mid)
        if (m < M):
            start=mid
        else:
            end=mid
    return start
```