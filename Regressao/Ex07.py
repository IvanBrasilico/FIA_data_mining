import os
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.stats.diagnostic import het_breuschpagan

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

df = pd.read_stata(os.path.join(base_path, 'HPRICE1-Kayo.dta'))
lotsize = sorted(df['lotsize'])
plt.subplot(2, 3, 1)
plt.hist(lotsize)
plt.subplot(2, 3, 2)
plt.hist(np.log(lotsize))
plt.subplot(2, 3, 3)
plt.plot(lotsize, np.log(lotsize))
price = sorted(df['price'])
plt.subplot(2, 3, 4)
plt.hist(price)
plt.subplot(2, 3, 5)
plt.hist(np.log(price))
plt.subplot(2, 3, 6)
plt.plot(price, np.log(price))
plt.show()

df['lotsize'] = np.log(df['lotsize'])
df['sqrft'] = np.log(df['sqrft'])
print(df.head())

X = df[['lotsize', 'sqrft', 'bdrms']]
y = df['price']
ylog = np.log(df['price'])
X2 = sm.add_constant(X)

model = sm.OLS(ylog, X2)
results = model.fit()
# Statsmodels gives R-like statistical output
print(results.summary())

name = ['Lagrange multiplier statistic', 'p-value', 
        'f-value', 'f p-value']
bp = het_breuschpagan(results.resid, results.model.exog)
df = pd.DataFrame(name,bp)
print(df)
