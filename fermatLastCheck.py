def checkFermat(a,b,c,n):
    #make sure that the n agrees
    if n < 2:
        print("A premise of Fermat's therom is that your n value must be greater than 2")
        while n < 2:
            print("Your n value was %d." %n)
            n = float(input("Please choose a new n value > "))
    #Calculate and check       
    ab = (a**n) + (b**n)
    cn = (c**n)
    if ab == cn:
        print("Holy smokes, Fermat was wrong!")
        print("Since %d = %d" %(ab, cn))
    elif ab != cn:
        print("No, that doesn't work")
        print("%d is not equal to %d" %(ab, cn))
    else:
        print("There was a problem, please try again...")
        
def inputCF():
    print("Let's check Fermat's a^n + b^n = c^n")
    a = float(input("What is your a value? > "))
    b = float(input("What is your b value? > "))
    c = float(input("What is your c value? > "))
    n = float(input("What is your n value? (Make sure it is greater than 2!) > "))

    checkFermat(a,b,c,n)

inputCF()
