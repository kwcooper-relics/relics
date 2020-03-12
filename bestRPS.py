import random
from random import randint

def rps():
    #create a list of play options
    c = ["Rock", "Paper", "Scissors"]
    aiChoice = c[randint(0,2)]
    
    choice = input("Rock, Paper, Scissors? > ").lower()
    if choice == aiChoice:
        print("Looks like a tie! \n")
        return "t"

    elif choice == "paper":
        if aiChoice == "Scissors":
            print("The computer chose", aiChoice)
            print("You lose! \n")
            return "l"
        else:
            print("The computer chose", aiChoice)
            print("You win! \n")
            return "w"

    elif choice == "rock":
        if aiChoice == "Paper":
            print("The computer chose", aiChoice)
            print("You lose! \n")
            return "l"
        else:
            print("The computer chose", aiChoice)
            print("You win! \n")
            return "w"

    elif choice == "scissors":
        if aiChoice == "Rock":
            print("The computer chose", aiChoice)
            print("You lose! \n")
            return "l"
        else:
            print("The computer chose", aiChoice)
            print("You win! \n")
            return "w"
    else:
        print("I couldn't understand you... Please try again! \n")
        return "e"
    

#add Stats logic
s = True
t = 0
w = 0
l = 0
while s == True:
    gms = rps()
    for i in gms:
        if i == "t":
            t += 1
        elif i == "w":
            w += 1
        elif i == "l":
            l += 1
    s = input("play again? > ")
    
    if s == "no" or s == "No" or s == "n" or s == "N":
        print("you won %d times, lost %d times, and tied %d times" %(w,l,t))
        break
    else:
        s = True
