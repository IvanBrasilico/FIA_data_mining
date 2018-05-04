# -*- coding: utf-8 -*-
"""
Spyder Editor

Este é um arquivo de script temporário.
"""
import scipy.stats
import pprint

mus = [100, 100.3, 100.6, 101.0]
sigma = 1
producao = 1000
rejeitados = {}
f = {}
for mu in mus:
    f = scipy.stats.norm(mu, sigma)
    rejeitados[mu] = (f.cdf(98.) * producao, (1 - f.cdf(102.)) * producao)
    
   
pprint.pprint(rejeitados)
    
for key, value in rejeitados.items():
    custo = 7 * value[0] + 1 * value[1]
    print('Média', key)
    print('Rejeitados', int(sum(value)))
    print('Custo', '%0.2f' % custo)

