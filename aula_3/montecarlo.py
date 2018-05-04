# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 10:57:21 2018

@author: 25052288840
"""
import numpy as np
from scipy import stats

mu, sigma = 2500, 300
f = stats.norm(mu, sigma)

custo_estoque = 1.50
preparo_lanche = 2.00
preco_lanche = 8.50
# Lucro sem custo_lanche
lucro1 = preco_lanche - preparo_lanche

def lucro(oferta, demanda):
    if demanda > oferta:
        return (lucro1 - custo_estoque) * oferta
    # Se demanda < oferta
    return lucro1 * demanda - custo_estoque * oferta
    

#Monte Carlo
ofertas = range(2200, 2900)
demandas = np.random.normal(mu, sigma, 1000)

max_lucro = 0
lucros = []
melhor_oferta = mu
for oferta in ofertas:
    olucro = 0
    for demanda in demandas:
        olucro = olucro + lucro(oferta, demanda)
    lucros.append(olucro/1000)
    if olucro > max_lucro:
        max_lucro = olucro
        melhor_oferta = oferta
        
print(melhor_oferta, max_lucro/1000)

import matplotlib.pyplot as plt
plt.plot(ofertas, lucros)