import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def Lorenz(duration, dt):
    s = 10
    r = 28
    b = 2.667
    y = 1.0
    x = 0.0
    z = 1.05
    t = 0
    
    y_hist = [y]
    x_hist = [x]
    z_hist = [z]
    t_hist = [t]
    
    while t < duration:
        dy = (r * x) - y - (x * z)
        dx = s * (y-x)
        dz = (y * x) - (b * z)
        x = x + dt*dx
        y = y + dt*dy
        z = z + dt*dz
        t += dt
        y_hist.append(y)
        x_hist.append(x)
        z_hist.append(z)
        t_hist.append(t)
    return y_hist,x_hist,z_hist,t_hist
    

    
y_hist,x_hist,z_hist,t_hist = Lorenz(35,0.01)
#plt.plot(t_hist,x_hist, "b", label="x")
#plt.plot(t_hist,y_hist, "r", label="y")
#plt.plot(t_hist,z_hist, "g", label="z")
#plt.xlabel("time")
#plt.ylabel("chaos")
#plt.legend()
#plt.show()
fig = plt.figure()
ax = fig.gca(projection="3d")
ax.plot(y_hist,x_hist,z_hist)

plt.show()

