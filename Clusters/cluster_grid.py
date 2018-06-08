import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics.pairwise import paired_distances, euclidean_distances
from sklearn.cluster import AgglomerativeClustering, KMeans


def cluster_grid(df, 
                methods=['average', 'complete', 'ward', 'kmeans'],
                n_clusters=[8, 9]):
    plot_index = 421
    for method in methods:
        for n_cluster in n_clusters:
            if method == 'kmeans':
                model = KMeans(n_clusters=n_cluster)
            else:
                model = AgglomerativeClustering(n_clusters=n_cluster, linkage=method)
            model.method = method
            Y = model.fit_predict(df)
            # print(Y)
            df['cluster'] = Y
            # print(df)

            set_clusters = set(Y)
            centroides = {}
            cx = []
            cy = []
            for ocluster in set_clusters:
                lx = df[df.cluster == ocluster][df.columns[0]].mean()
                ly = df[df.cluster == ocluster][df.columns[1]].mean()
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
            plt.scatter(x=df[df.columns[0]], y=df[df.columns[1]], c=df['cluster'])
            plt.title(method + ' ' + str(n_clusters))
            plt.scatter(cx, cy, marker=(5, 2))

plt.show()
