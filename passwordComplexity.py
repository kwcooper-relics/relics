import math

passLength = int(input("password length > "))
setSize = int(input("set size? > "))

def permuBound(n,r):
    #if no repetion and order matters:
    #n! / (n - r)! where n is types and r is set
    permB = m.factorial(n) / (m.factorial((n - r)))
    print("the perm is %d" %permB)
    return permB


def permuNoBound(n,r):
    permN = m.factorial(r+n-1) / (m.factorial(r) * m.factorial(n - 1))
    print("the perm is %d" %permN)
    return permN

permuBound(setSize, passLength)
permuNoBound(setSize, passLength)


#1000 pwds per s

def crackTime()
