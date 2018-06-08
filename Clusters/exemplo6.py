import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import scatter_matrix
from sklearn.metrics.pairwise import euclidean_distances
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import variance_inflation_factor

from cluster_grid import cluster_grid

df = pd.read_csv(
    'D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo6.csv',
     header=0, sep=';', decimal=',')


X = df[['alcohol', 'calories', 'cost', 'sodium']]
print(X['alcohol'])

cluster_grid(X,
              methods=['average', 'ward', 'kmeans'],
              n_clusters=[2, 3, 4])