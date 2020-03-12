print('Welcome to the Game')
name = raw_input('What is your name?\n') 
print 'Hi, %s. These are the inputs:' % name 
print('   ')
print('Rock = r')
print('Paper = p')
print('Scissors = s')
print('   ')

uc = raw_input('Enter your choice')

if uc == 'r':
    print 'You chose Rock'
elif uc == 'p':
    print 'You chose Paper'
elif uc == 's':
    print "You chose Scissors"
else:
    print "Reread the instructions and try again."
    
from random import randint
cc = randint(0,15)

if cc <=5:
    cc = 'rc'
    print ('The computer chose Rock')
elif cc > 5 and cc <= 10:
    cc = 'pc'
    print ('The computer chose Paper')
elif cc > 10 and cc <= 15:
    cc = 'sc'
    print ('The computer chose Scissors')
else:
    print ('...wait do we go on shoot or what?')


if uc == 'r' and cc == 'sc':
    print ('You Win!')
elif uc == 'p' and cc == 'rc':
    print ('You Win!')
elif uc == 's' and cc == 'pc':
    print ('You Win!')
elif uc == 'r' and cc == 'pc':
    print ('You Loose!')
elif uc == 'p' and cc == 'sc':
    print ('You Loose!')
elif uc == 's' and cc == 'rc':
    print ('You Loose!')
elif uc == 's' and cc == 'sc':
    print ('Draw! Try again.')
elif uc == 'p' and cc == 'pc':
    print ('Draw! Try again.')
elif uc == 's' and cc == 'sc':
    print ('Draw! Try again.')
else:
    print ('Error')
    
    
    

