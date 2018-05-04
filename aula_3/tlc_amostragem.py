# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 13:16:11 2018
Pág. 70 da apostila
@author: 25052288840
"""
# import csv
import scipy
import numpy as np
from math import sqrt

mu, sigma = 5000, 500 # mean and standard deviation
print('média', mu, 'std', sigma)

rows = [1, 2, 10, 20, 100, 200]
cols =  25
amostragem = []
for row in rows:
    medias = []
    for _ in range(row):
        amostra = np.random.normal(mu, sigma, cols)
        # amostragem.append(list(amostra))
        medias.append(amostra.mean())
    array = np.array(medias)
    print('rows', row, 'média', array.mean(), 'std', array.std())

# print(medias)



"""with open('D:\\Users\\25052288840\\Downloads\\amostragem.csv', 'w', newline='') as out:
    writer = csv.writer(out)
    writer.writerows(amostragem)
""" 


# EX. Pág. 76
mu, sigma = 12000, 850 # mean and standard deviation
print('média', mu, 'std', sigma)
f = scipy.stats.norm(mu, sigma)
print('Probabilidade de gasto ser superior a 12.700', 1 - f.cdf(12700))
# Para amostra de 10 dias:
sigma = sigma / (10 ** (1/2))
print('média', mu, 'std', sigma)
f = scipy.stats.norm(mu, sigma)
print('Probabilidade de gasto ser superior a 12.700', 1 - f.cdf(12700))


# EX. Pág. 77
mu, sigma = 5000, 1000 # mean and standard deviation
amostra = 100
sigma = sigma / sqrt(amostra)
print('média', mu, 'std', sigma)
f = scipy.stats.norm(mu, sigma)
print('Probabilidade de gasto ser menor ou igual a 4620', f.cdf(4620))

# Intervalo de confiança - pág. 78 