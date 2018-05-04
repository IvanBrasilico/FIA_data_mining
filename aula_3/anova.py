# -*- coding: utf-8 -*-
"""
Created on Fri Apr 20 15:54:45 2018

@author: 25052288840
"""

import pandas as pd
datafile='D:/Users/25052288840/Downloads/TESTES.xlsx'
sheet='ANOVA P38'
data = pd.read_excel(datafile, sheet_name=sheet)
 
#Create a boxplot
data.boxplot('MILHO', by='ADUBOS', figsize=(12, 8))
 
ctrl = data['MILHO'][data.ADUBOS == 'A']
 
grps = pd.unique(data.ADUBOS.values)
d_data = {grp:data['MILHO'][data.ADUBOS == grp] for grp in grps}
 
k = len(pd.unique(data.ADUBOS))  # number of conditions
N = len(data.values)  # conditions times participants
n = data.groupby('ADUBOS').size()[0] #Participants in each condition

from scipy import stats
 
F, p = stats.f_oneway(d_data['A'], d_data['B'], d_data['C'])

print('F', '%0.4f' % F)
print('p', '%0.4f' % (p*100), '%')