# -*- coding: utf-8 -*-
"""
Created on Thu Jun 21 14:59:01 2018

@author: 25052288840
"""

import pandas as pd
import os
from sklearn import metrics
from sklearn.feature_selection import f_regression
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 8')

df = pd.read_csv(os.path.join(base_path, 'twoyear.csv'))
print(df.head())
# df.corr()

X = df[['jc', 'univ', 'exper']]
y = df['lwage']


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

hypotheses = 'jc = univ'
t_test = results.t_test(hypotheses)
print(t_test)

print(f_regression(X, y))


