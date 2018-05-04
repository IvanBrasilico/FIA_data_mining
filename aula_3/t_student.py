# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 16:43:48 2018

@author: 25052288840
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 13:16:11 2018
Pág. 70 da apostila
@author: 25052288840
"""
# import csv
from scipy.stats import t
import pandas as pd
import numpy as np
import os
from math import sqrt

path = 'D:\\Users\\25052288840\\Downloads'
xls = os.path.join(path, 'ESTIMAÇÃO.xls')
df = pd.read_excel(xls, 1, 0)
print(df)

# Intervalo de confiança - pág. 78 - 79
mu = df['vendas'].mean()
print('média', mu)


intervalos = [99.74, 99.00, 95.00, 90.00]
desvios = []
for intervalo in intervalos:
    t19 = t.ppf(((100 - intervalo) / 100) / 2)
    print(intervalo, "%.2f" % n_desvios)
    desvios.append(n_desvios)


