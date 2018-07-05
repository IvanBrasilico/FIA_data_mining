import pandas as pd
import os
import statsmodels.api as sm

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

df = pd.read_stata(os.path.join(base_path, 'HPRICE1-Kayo.dta'))
print(df.head())
# df.corr()

X = df[['lotsize', 'sqrft', 'bdrms']]
y = df['price']

X2 = sm.add_constant(X)
model = sm.OLS(y, X2)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())



