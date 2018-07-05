import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
import statsmodels.formula.api as smf
from sklearn.linear_model import LinearRegression
from sklearn import metrics

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

# Sem preserve_dtypes a importação de exper é feita por int8 e dá problema no quadrado
df = pd.read_stata(os.path.join(base_path, 'WAGE1-Kayo.dta'), preserve_dtypes=False)

model = smf.ols(formula ='wage ~ female', data=df)
results = model.fit()
print(results.summary())