import random
print('hello, how are you? My name is Synthia. I am the AI here. But today, I am the gamemaster!') 
print ' '
print 'Welcome to the game!'

name = raw_input('first, what is your name? ')
print ' '
print 'hello ' + name + ' nice to meet you' 
print ' '
print 'I think it is time we start a game.'
print ' '
wtp = raw_input('do you want to play Rock, Paper, Scissors? y or n? ')
while wtp != 'y':
    rn = random.randint(1, 5)
    if rn == 1:
        print 'try again!'
    elif rn == 2:
        print 'oh come on!'
    elif rn == 3: 
        print 'you are being a fucktard'
    else:
        print 'do not lie to me!'
    wtp = raw_input('y or n? ')
    if wtp == 'y':
        print 'okay lets play!'
        break
print ' '
print 'Rock, Paper, Scissors (rps) is an easy game to play. It is pretty self explanatory too.'
htp = raw_input('do you know how it is played? y or n? ')
print ' '
if htp == 'y':
    print 'good! I will not have to teach you then!'
elif htp == 'n':
    print 'eh, you can figure it out yourself'
else:
    print 'that was not what I asked, but lets move on anyway'
print ' '
print 'okay, so here is how things are going to go. I will ask you to pick Rock, Paper, or Scissors, and to pick them you will type r for rock, p for paper, and s for scissors. I think you can manage that.'
print ' '
print 'Next, I will select my answer, and then we will see who wins'
print ' '
rtp = raw_input('so, are you ready to play? y or n? ')
while rtp != 'y':
    rnm = random.randint(1, 5)
    if rnm == 1:
        print 'try again!'
    elif rnm == 2:
        print 'oh come on!'
    elif rnm == 3: 
        print 'you are being difficult'
    else:
        print 'well hurry up and get ready then'
    rtp = raw_input('y or n? ')
    if rtp == 'y':
        print 'okay lets play!'
        break
print ' '
uc = raw_input('r, p, or s? ')
cc = random.randint(1,3)
print cc
if cc == 1:
    cc = "r"
    print 'the computer chose rock'
elif cc == 2: 
    cc = "p"
    print 'the computer chose paper'
elif cc == 3:
    cc = "s"
    print 'the computer chose scissors'
else:
    print 'cc error, try again'

uw = 0
cw = 0

if cc == 'r' and uc == 'r':
    print 'its a tie'
elif cc == 'p' and uc == 'p':
    print 'its a tie'
elif cc == 's' and uc == 's':
    print 'its a tie'
elif cc == 'r' and uc == 'p':
    print 'You Win!'
    uw +1
elif cc == 'p' and uc == 's':
    print 'You Win!'
    uw +1
elif cc == 's' and uc == 'r':
    print 'You Win!'
    uw +1
elif cc == 'r' and uc == 's':
    print 'You lose!'
    cw +1
elif cc == 'p' and uc == 'r':
    print 'You Loose!'
    cw +1
elif cc == 's' and uc == 'p':
    print 'You Loose!'
    cw +1
print ' '    
print 'The computer has won %s times' % cw 
print 'The user has won %s times' % uw

pa = raw_input('Do you want to play again? y or n ')
while pa == 'y':
    uc = raw_input('r, p, or s? ')
    cc = random.randint(1,3)
    
    if cc == 1:
        cc = "r"
        print 'the computer chose rock'
    elif cc == 2: 
        cc = "p"
        print 'the computer chose paper'
    elif cc == 3:
        cc = "s"
        print 'the computer chose scissors'
    else:
        print 'cc error, try again'

    uw = 0
    cw = 0

    if cc == 'r' and uc == 'r':
        print 'its a tie'
    elif cc == 'p' and uc == 'p':
        print 'its a tie'
    elif cc == 's' and uc == 's':
        print 'its a tie'
    elif cc == 'r' and uc == 'p':
        print 'You Win!'
        uw + 1
    elif cc == 'p' and uc == 's':
        print 'You Win!'
        uw + 1
    elif cc == 's' and uc == 'r':
        print 'You Win!'
        uw + 1
    elif cc == 'r' and uc == 's':
        print 'You lose!'
        cw + 1
    elif cc == 'p' and uc == 'r':
        print 'You Loose!'
        cw + 1
    elif cc == 's' and uc == 'p':
        print 'You Loose!'
        cw + 1
    print ' '    
    print 'The computer has won %s times' % cw 
    print 'The user has won %s times' % uw
    print ' '
    pa = raw_input('Do you want to play again? y or n ')
else:
    print 'thanks for playing '
    
    





    

