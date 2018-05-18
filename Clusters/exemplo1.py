import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics.pairwise import paired_distances, euclidean_distances

df = pd.read_csv(
    'D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo1.csv',
     header=0, sep=';', decimal=',')
print(df)

# plt.scatter(x=df['V1'], y=df['V2'])
# plt.show()


for linha in zip(df.V1, df.V2):
    print(linha)
X = [linha for linha in  zip(df.V1, df.V2)]
print(X)

e = euclidean_distances(X[:-1], X[1:])
print(e)


from sklearn.cluster import AgglomerativeClustering

model = AgglomerativeClustering(n_clusters=3)

Y = model.fit_predict(X)
print(Y)

df['cluster'] = Y
print(df)

set_clusters = set(Y)
centroides = {}
for ocluster in set_clusters:
    centroides[ocluster] = {
        'V1': df[df.cluster == ocluster].V1.mean(),
        'V2': df[df.cluster == ocluster].V2.mean()
    }

print(centroides)