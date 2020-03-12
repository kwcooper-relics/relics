import numpy as np
import timeit
import matplotlib.pyplot as plt


#FFT Implimentation

"""Cooley, James W., and John W. Tukey, 1965, “An algorithm for the machine
calculation of complex Fourier series,” Math. Comput. 19: 297-301."""

'''Introduction to astroML: Machine learning for astrophysics,
Vanderplas et al,proc. of CIDU, pp. 47-54, 2012'''

#Else use...
#numpy.fft
#scipy.fftpack

#Formula
#Xk=∑n=0N−1(xn⋅e^(−i 2π k n / N))

#matrix Multiplication
def FTTsimple(x):
    x = np.asarray(x, dtype=float)
    N = x.shape[0]

    n = np.arange(N)
    k = n.reshape((N, 1))
    
    M = np.exp(-2j * np.pi * k * n / N)
    return np.dot(M, x)


def FFT(x):
    x = np.asarray(x, dtype=float)
    N = x.shape[0]

    #Split evens and odds
    if N % 2 > 0:
        raise ValueError("Wrong X size")
    elif N <= 32:  # this cutoff should be optimized
        return FTTsimple(x)
    else:
        evX = FFT(x[::2])
        oddX = FFT(x[1::2])
        factor = np.exp(-2j * np.pi * np.arange(N) / N)
        return np.concatenate([evX + factor[:N / 2] * oddX,
                               evX + factor[N / 2:] * oddX])


x = np.random.random(256 * 244)


#plt.plot(x)
plt.plot(np.fft.fft(x))

plt.show()
