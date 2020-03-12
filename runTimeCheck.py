tempoPace = tempoMin * 60 + tempoSec

#find time
easyTime = easyPace * easyMiles
tempoTime = tempoPace + tempoMiles

totalTime = easyTime + tempoTime
print('your run was %d' %totalTime)
#find time you'll get back

#cvt 2 min
totalTime / 60
ttMin = int(totalTime / 60)
if ttMin > 60:
    print("< 60 ")
    
ttSec = (totalTime % 60) / 60

print("the time conversion is "+ str(ttMin) +" minutes and "+ str(ttSec) +" seconds")

#add to military time
timeBack = timeLeft + ttMin
print("you will get back at %d" %timeBack)
print("(and %d seconds)" %ttSec)


