# -*- coding: utf-8 -*-
"""
Created on Thu Jun 21 10:12:56 2018

@author: 25052288840
"""
import pandas as pd
import os
from sklearn.linear_model import LinearRegression
from sklearn import metrics
import statsmodels.api as sm
import matplotlib.pyplot as plt 

base_path = os.path.dirname(__file__)

base_path = os.path.join(base_path, 'Aula 8')

df = pd.read_csv(os.path.join(base_path, 'SalMensal.csv'),
                 encoding='latin1')
print(df.head())

reg = LinearRegression()

X = df[['man']]
y = df['sal']

reg.fit(X, y)
y_ = reg.predict(X)

print(reg)
print(reg.score(X, y))
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))

plt.scatter(X, y)
plt.plot(X, y_)
plt.show()


# Note the swap of X and y
X2 = sm.add_constant(X)
model = sm.OLS(y, X2)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())
"""
# TESTE Hot Encoding x dummie
woman = []
for man in df['man']:
    woman.append(0 if man == 1 else 1)
df['woman'] = woman
X3 = df[['woman', 'man']]
y = df[['sal']]

reg.fit(X3, y)
y_ = reg.predict(X3)

print(reg)
print(reg.score(X3, y))
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))

plt.scatter(X3['man'], y)
plt.scatter(X3['woman'], y)
plt.plot(X3, y_)
plt.show()

X4 = sm.add_constant(X3)
model = sm.OLS(y, X4)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())
"""