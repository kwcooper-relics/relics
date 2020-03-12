#hw7

import agent
import matplotlib.pyplot as plt
import math

# “A person starts from a point 0 and walks d yards in a straight line; they then turn through
#any angle whatever and walk another d yards in a second straight line. They repeat this
#process n times. What is the probability that after these n stretches they are at a distance r
#from his starting point, 0?” Karl Pearson (1905). The problem of the random walk. Nature.

def distance(p0, p1):
    return math.sqrt((p0 - 0)**2 + (p1- 0)**2)

a = agent.Agent()

x_hist = []
y_hist = []
def runSim(steps):
    time = 0
    while time < steps:
        a.step()
        x_hist.append(a.x)
        y_hist.append(a.y)
        time += 1

runSim(100)
plt.plot(x_hist,y_hist)
plt.title("random Dist")
plt.show()

dist = []
for x,y in zip(x_hist, y_hist):
    dist.append(distance(x,y))

plt.plot(dist)
plt.title('Normal Distro Dist')
plt.show()




#Normal Distrobution 
def runSimNorm(steps):
    time = 0
    while time < steps:
        a.stepNorm()
        x_hist.append(a.x)
        y_hist.append(a.y)
        time += 1

runSimNorm(100)
plt.plot(x_hist,y_hist)
plt.title("Normal Distro Walk")
plt.show()


dist = []

for x,y in zip(x_hist, y_hist):
    dist.append(distance(x,y))

print(dist)

plt.plot(dist)
plt.title('Normal Distro Dist')
plt.show()




tx = []
ty = []
time = 0
for i in range(1,10):
    while time < 100:
        a.step()
        x_hist.append(a.x)
        y_hist.append(a.y)
        time += 1
    tx.append(x_hist)
    ty.append(y_hist)

dist = []
for x, y in zip(tx,ty):
    for x,y in zip(x_hist, y_hist):
        dist.append(distance(x,y))
    plt.plot(dist)

plt.title('10 trials')
plt.show()


