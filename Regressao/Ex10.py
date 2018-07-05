import pandas as pd
import numpy as np
import os
import statsmodels.formula.api as smf
from sklearn.linear_model import LinearRegression
from sklearn import metrics

# http://www.statsmodels.org/dev/example_formulas.html


base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

# Sem preserve_dtypes a importação de exper é feita por int8 e dá problema no quadrado
df = pd.read_stata(os.path.join(base_path, 'WAGE1-Kayo.dta'), preserve_dtypes=False)
print(df.head())
print(df.describe())

model = smf.ols(formula ='wage ~ exper + I(exper ** 2)', data=df)
results = model.fit()
print(results.summary())


print(df['exper'].describe())
X2 = np.asarray(df['exper'], dtype=np.float32)
print(X2[:5])
df['exper2'] = np.square(df['exper'])
X = df[['exper', 'exper2']]
y = df['wage']
print(X[:5])


reg = LinearRegression()
reg.fit(X, y)
y_ = reg.predict(X)

print(reg)
print(reg.coef_, reg.intercept_)
print(metrics.r2_score(y, y_))
