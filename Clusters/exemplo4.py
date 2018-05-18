import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import scatter_matrix
from sklearn.metrics.pairwise import paired_distances, euclidean_distances


df = pd.read_csv(
    'D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo4.csv',
     header=0, sep=';')
print(df)
X = df[df.columns[1:6]]
print(X)
e = euclidean_distances(X[1:], X[:-1])
print(e)
plt.figure()
scatter_matrix(X, diagonal='kde')
X.plot.box()
plt.show()
