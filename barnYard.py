def solve(nHeads, nLegs):
    for nChic in range(0, nHeads + 1):
        #print(nChic)
        nPig = nHeads - nChic
        print("heads...")
        print(nHeads," -" ,nChic, "=", nPig)
        totLegs = 2 * nChic + 4 * nPig
        print("checking if legs add up...")
        print(2 * nChic, "+", 4 * nPig, "=", totLegs)
        if totLegs == nLegs:
            print("I got it... so \n")
            return [nPig, nChic]
        else:
            print("Let's try this again...")
    return [None, None]

def barnYard(heads, legs):
    pigs, chickens = solve(heads, legs)
    if pigs == None:
        print("I don't believe a solution exists...")
    else:
        print( 'I think the number of pigs is: ', pigs)
        print( 'I think the number of chickens is: ', chickens)

barnYard(18, 64)
