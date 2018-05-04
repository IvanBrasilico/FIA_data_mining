# -*- coding: utf-8 -*-
"""
Spyder Editor

Este é um arquivo de script temporário.
"""
import scipy.stats
import numpy as np
import matplotlib.pyplot as plt


mu = 100
sigma = 1
f = scipy.stats.norm(mu, sigma)
s = np.random.normal(mu, sigma, 10000)

count, bins, ignored = plt.hist(s, 30)
plt.show()



