#Ackermann's function
#ack(4,2)

"""
A(m,n)=n+1                       if m=0
           =A(m-1,1)               if m>0 and n=1
           =A(m-1,A(m,n-1)    if m>0 and n>0
"""
import time

ackVals = []
ackTime = []

def ack(m,n):
    if m==0:
        return n+1
    elif m>0 and n==0:
        return ack(m-1,1)
    elif m>0 and n>0:
        return ack(m-1,ack(m,n-1)) 

i = 0
j = 0

print('getting Ackermann vals')

for x in range(1,100):
    if j == 4:
        j = 0
        i += 1
        if i == 4:
            i == 0
    s = time.time()
    print('ack of ', i, j, '=', ack(i,j))
    ackVals.append(ack(i,j))
    ackTime.append(time.time()-s)
    j += 1

##def ack(m,n):
##    
##    ans = 0
##
##    if m == 0:
##        ans = n + 1
##    elif n == 0:
##        ans = ack(m-1,1)
##    else:
##        ack(m-1, ack(m, n-1))
##
##    return ans
