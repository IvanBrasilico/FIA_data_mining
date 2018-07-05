import pandas as pd
import os
import statsmodels.api as sm
from statsmodels.stats.diagnostic import het_breuschpagan

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

df = pd.read_stata(os.path.join(base_path, 'HPRICE1-Kayo.dta'))
print(df.head())
# df.corr()

X = df[['lotsize', 'sqrft', 'bdrms']]
y = df['price']

X2 = sm.add_constant(X)
# model = sm.RLM(y, X2,  M=sm.robust.norms.HuberT())
model = sm.OLS(y, X2)
results = model.fit(cov_type='HC0')
# Statsmodels gives R-like statistical output
print(results.summary())

name = ['Lagrange multiplier statistic', 'p-value', 
        'f-value', 'f p-value']
bp = het_breuschpagan(results.resid, results.model.exog)
bp
df = pd.DataFrame(name,bp)
print(df)
