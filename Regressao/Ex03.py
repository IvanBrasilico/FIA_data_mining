# -*- coding: utf-8 -*-
"""
Created on Thu Jun 21 13:40:55 2018

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

df = pd.read_csv(os.path.join(base_path, 'F1.csv'))
print(df.head())
df.corr()

X = df[['rain_mm', 'training']]
y = df['points']


reg = LinearRegression()
reg.fit(X, y)
y_ = reg.predict(X)

print(reg)
print(reg.score(X, y))
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))

plt.scatter(X['training'], y)
plt.plot(X['training'], y_)
plt.show()

plt.scatter(X['rain_mm'], y)
plt.plot(X['rain_mm'], y_)
plt.show()


# Note the swap of X and y
X2 = sm.add_constant(X)
model = sm.OLS(y, X2)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())
