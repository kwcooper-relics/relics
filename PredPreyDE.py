import matplotlib.pyplot as plt

alpha = 1.0
beta = 0.1
delta = 0.02
gamma = 0.4

def PredPreyDE(duration, dt, alpha, beta, gamma, delta):
    y = 10
    x = 10
    t = 0
    
    y_hist = [y]
    x_hist = [x]
    t_hist = [t]
    
    while t < duration:
        dy =(delta * x * y) - (gamma * y)
        dx = (alpha * x) - (beta * x * y)
        x = x + dt*dx
        y = y + dt*dy
        t += dt
        y_hist.append(y)
        x_hist.append(x)
        t_hist.append(t)
    return y_hist,x_hist,t_hist


y, x, t = PredPreyDE(100, .01, alpha, beta, gamma, delta)

plt.plot(t, x, label='rabits')
plt.plot(t,y, label='foxes')
plt.legend()
plt.show()

    

    
