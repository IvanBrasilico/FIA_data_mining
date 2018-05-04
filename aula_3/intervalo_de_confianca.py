# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 14:49:07 2018

@author: 25052288840
"""
from math import sqrt
import pandas as pd
import os
import scipy.stats

path = 'D:\\Users\\25052288840\\Downloads'
xls = os.path.join(path, 'Exercícios Análise de Dados.xls')
df = pd.read_excel(xls, 0, None)

# Intervalo de confiança - pág. 78 - 79
mu, sigma = 0, 1 # mean and standard deviation
print('média', mu, 'std', sigma)
f = scipy.stats.norm(mu, sigma)
intervalos = [99.74, 99.00, 95.00, 90.00]
desvios = []
for intervalo in intervalos:
    n_desvios = - f.ppf(((100 - intervalo) / 100) / 2)
    print(intervalo, "%.2f" % n_desvios)
    desvios.append(n_desvios)
    

mu = df[0].mean()
sigma = 8 # mean and standard deviation
amostra = 60
sigma = sigma / sqrt(amostra)
print('média', mu, 'std', sigma)
for z, confianca in zip(desvios, intervalos):
    print('de', "%.2f" % (mu - z * sigma), 'a'
          "%.2f" % (mu + z * sigma),
          'z:', "%.2f" %z,
          confianca)

# d) e e)
erro_amostral = 1
for z, confianca in zip(desvios, intervalos):
    n = ( (z * 8) / erro_amostral ) ** 2
    print('Intervalo', confianca, 'tamanho da amostra:', "%.2f" % n)
