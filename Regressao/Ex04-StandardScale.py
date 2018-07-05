# -*- coding: utf-8 -*-
"""
Created on Thu Jun 21 15:42:16 2018

@author: 25052288840
"""
import pandas as pd
import os
from sklearn.linear_model import LinearRegression
from sklearn import metrics
import statsmodels.api as sm
from sklearn.preprocessing import StandardScaler

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 8')

df = pd.read_csv(os.path.join(base_path, 'twoyear.csv'))
print(df.head())
# df.corr()

X = df[['jc', 'univ', 'exper']]
y = df['lwage']
scaler = StandardScaler()
scaler.fit(X)
X = scaler.transform(X)


reg = LinearRegression()
reg.fit(X, y)
y_ = reg.predict(X)

print(reg)
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))


# Note the swap of X and y
X2 = sm.add_constant(X)
model = sm.OLS(y, X2)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())

hypotheses = 'x1 = x2'
t_test = results.t_test(hypotheses)
print(t_test)


