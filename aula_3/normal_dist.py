# -*- coding: utf-8 -*-
"""
Spyder Editor

Este é um arquivo de script temporário.
"""


import numpy as np
import matplotlib.pyplot as plt

mu, sigma = 10000, 1000 # mean and standard deviation
s = np.random.normal(mu, sigma, 1000)

count, bins, ignored = plt.hist(s, 30, normed=True)
plt.plot(bins, 1/(sigma * np.sqrt(2 * np.pi)) *
                np.exp( - (bins - mu)**2 / (2 * sigma**2) ),
          linewidth=2, color='r')
plt.show()

import scipy.stats

f = scipy.stats.norm(mu, sigma)

print(f.cdf(13000))


print(f.cdf(13200))

mu3 = 10000*3
sigma3 = ((1000 ** 2) * 3) ** (1/2)
print(sigma3)
f3 = scipy.stats.norm(mu3, sigma3)
print(1 - f3.cdf(33200))
print(f3.ppf(.99))

