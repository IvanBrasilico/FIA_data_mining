import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics.pairwise import paired_distances, euclidean_distances
from sklearn.cluster import AgglomerativeClustering, KMeans


def cluster_grid(X, 
                methods=['average', 'complete', 'ward', 'kmeans'],
                n_clusters=[8, 9]):
    plot_index = 421
    for method in methods:
        for n_clusters in [8, 9]:
            if method == 'kmeans':
                model = KMeans(n_clusters=n_clusters)
            else:
                model = AgglomerativeClustering(n_clusters=n_clusters, linkage=method)
            model.method = method
            Y = model.fit_predict(X)
            # print(Y)
            df['cluster'] = Y
            # print(df)

            set_clusters = set(Y)
            centroides = {}
            cx = []
            cy = []
            for ocluster in set_clusters:
                lx = df[df.cluster == ocluster].x.mean()
                ly = df[df.cluster == ocluster].y.mean()
                centroides[ocluster] = {
                    'x': lx,
                    'y': ly
                }
                cx.append(lx)
                cy.append(ly)
            # print(centroides)
            # print(df)
            plt.subplot(plot_index)
            plot_index += 1
            plt.scatter(x=df['x'], y=df['y'], c=df['cluster'])
            plt.title(method + ' ' + str(n_clusters))
            plt.scatter(cx, cy, marker=(5, 2))

plt.show()
