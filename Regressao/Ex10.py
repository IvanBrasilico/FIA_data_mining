import pandas as pd
import numpy as np
import os
import statsmodels.formula.api as smf
# http://www.statsmodels.org/dev/example_formulas.html


base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

df = pd.read_stata(os.path.join(base_path, 'WAGE1-Kayo.dta'))
df = df[['wage', 'exper']]
print(df.head())
print(df.describe())

model = smf.ols(formula ='wage ~ exper + I(exper ** 2)', data=df)
results = model.fit()
print(results.summary())
