import math
import time

#this will decide if the number is prime of not
#returns true/false
def isPrime(number):
      if number < 2:
            return False
      if number % 2 == 0:
            return False
      else:
            for i in range(3, number):
                  if not number % i:
                        return False
            return True 

def nthPrime():
    nth = int(input('Which prime would you like?: '))
    s=time.time()
    
    primes = []
    for iteration in range(100000):
        #print(iteration)
        if isPrime(iteration) == True:
            primes.append(iteration)
        if len(primes) == nth:
            break
    #print (primes)

    print("The %d th prime is: " %nth , str(primes[nth-2]) )
    print("That took me", time.time()-s, "seconds")


nthPrime()
