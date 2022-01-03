def calM(A, i, R):
    p = pow(1+R, i)
    return R * A * p / (p - 1)

def binarySearchR(start, end, i, A, M): 
    while (abs(end - start) >= 0.0000001):
        mid = start + (end - start)/2        
        m = calM(A, i, mid)
        if (m < M):
            start=mid
        else: 
            end=mid
    return start

def calcAPR(month, A, M):
    return calcMonthRate(month, A, M)*12

def calcMonthRate(month, A, M):
    return binarySearchR(0, 10.0, month, A, M)


def repaymentSchedules(month, A, monthRate):
    amountMonth = calM(A, month, monthRate)
    remain = A
    schedules = []
    for i in range(month):
        num = i+1
        interest = remain * monthRate
        principle = amountMonth - interest
        remain = remain - principle
        schedules.append([num, str("%.2f"% amountMonth), str("%.2f" % interest), str("%.2f" % principle), str("%.2f"%remain)])
    return schedules

monthRate = calcMonthRate(12, 10000, 929.51)
print monthRate
print monthRate * 12
schedules = repaymentSchedules(12, 10000, monthRate)
for s in schedules: print s
