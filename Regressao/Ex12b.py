import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
from sklearn.linear_model import LinearRegression
from sklearn import metrics

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

# Sem preserve_dtypes a importação de exper é feita por int8 e dá problema no quadrado
df = pd.read_stata(os.path.join(base_path, 'WAGE1-Kayo.dta'), preserve_dtypes=False)


X = df[['female', 'educ']]
y = df['wage']
reg = LinearRegression()
reg.fit(X, y)
y_ = reg.predict(X)
print(reg)
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))


H = df[df['female'] == 0].sort_values(by=['educ'])
M = df[df['female'] == 1].sort_values(by=['educ'])

xh = H['educ']
yh = reg.predict(H[['female', 'educ']])

xm = M['educ']
ym = reg.predict(M[['female', 'educ']])

plt.plot(xh, yh)
plt.plot(xm, ym)
plt.show()