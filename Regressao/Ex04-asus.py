import pandas as pd
import os
from sklearn import metrics
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import StandardScaler
import statsmodels.api as sm
import matplotlib.pyplot as plt

base_path = os.path.dirname(__file__)

base_path = os.path.join(base_path, 'Aula 8')

df = pd.read_csv(os.path.join(base_path, 'twoyear.csv'))
X = df[['jc', 'univ', 'exper']]
y = df['lwage']

print(X.head())
print(X.describe())
print(X.corr())

reg = LinearRegression()
reg.fit(X, y)
y_ = reg.predict(X)

print(reg.score(X, y))
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))




# Note the swap of X and y
X2 = sm.add_constant(X)
print(X2.columns)
model = sm.OLS(y, X2)
results = model.fit()
print('Sumário sem padronização')
print(results.summary())
hypotheses = '(jc=univ)'
t_test = results.t_test(hypotheses)
print('t_test sem padronização')
print(t_test)


# Com padronização
scaler = StandardScaler()
scaler.fit(X)
columns = X.columns
X_padronizado = scaler.transform(X)
X_padronizado = pd.DataFrame(X_padronizado, columns=columns)
X3 = sm.add_constant(X_padronizado)
model = sm.OLS(y, X3)
results = model.fit()
print('Sumário com padronização')
print(results.summary())
hypotheses = '(jc=univ)'
t_test = results.t_test(hypotheses)
print('t_test com padronização')
print(t_test)