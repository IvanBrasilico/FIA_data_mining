import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import scatter_matrix
from sklearn.metrics.pairwise import euclidean_distances
from patsy import dmatrices
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import variance_inflation_factor

df = pd.read_csv(
    'D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo5.csv',
     header=0, sep=';', decimal=',')
print(df)
X = df[df.columns[0:7]]
print(X)
e = euclidean_distances(X[1:], X[:-1])
print(e)
"""
plt.figure()
scatter_matrix(X)
X.plot.box()
plt.show()
"""
columns = list(X.columns)
columns.pop(len(columns)-1)
print(columns)
features = "+".join(columns)
# get y and X dataframes based on this regression:
y, X = dmatrices('x7 ~' + features, X, return_type='dataframe')
# print(X)
vif = pd.DataFrame()
vif["VIF Factor"] = [variance_inflation_factor(X.values, i) for i in range(X.shape[1])]
vif["features"] = X.columns
print(vif.round(1))