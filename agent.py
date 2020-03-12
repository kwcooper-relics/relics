import math
import random
import numpy as np

class Agent:

    def __init__(self):
        self.x = 0.0  # agent's x position
        self.y = 0.0  # agent's y position
        self.d = random.random()*2*math.pi  # agent's direction
        self.o = 0
        #self.o = self.o + np.random.normal(0,1)
        self.v = 1.0 # agent's velocity

    def step(self):
        self.d = random.random()*2*math.pi
        self.x = self.x + self.v * math.cos(self.d)
        self.y = self.y + self.v * math.sin(self.d)        


    def stepNorm(self):
       sigma = 1
       self.o = self.o + np.random.normal(0,sigma)
       self.x = self.x + self.v * math.cos(self.o)
       self.y = self.y + self.v * math.sin(self.o) 
