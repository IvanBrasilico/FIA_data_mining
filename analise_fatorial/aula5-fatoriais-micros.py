import os
import pandas as pd
from sklearn.decomposition import PCA

path = 'D:\\Users\\25052288840\\Downloads'


df_micros = pd.read_csv(os.path.join(path, 'Micros.csv'), sep=';', decimal=',')

print(df_micros)
df_micros_valores = df_micros[['ts', 'tm', 'ct', 'as', 'mr', 'ar']]

corr = df_micros_valores.corr() 
print(corr)


pca = PCA()
pca.fit(df_micros_valores)
#print(pca.components_)
print(pca.explained_variance_)
print(pca.explained_variance_ratio_)  
print(pca.noise_variance_)
print(pca.singular_values_)  


pca = PCA(n_components=2)
pca.fit(df_micros_valores)
print(pca.explained_variance_)
print(pca.explained_variance_ratio_)  
print(pca.noise_variance_)
print(pca.singular_values_)  

transformed = pca.transform(df_micros_valores)
print(transformed)

fator1 = transformed[:, 0]
indices = sorted(range(len(fator1)), key=lambda k: fator1[k])
print(indices)

fator2 = transformed[:, 1]
indices = sorted(range(len(fator2)), key=lambda k: fator2[k])
print(indices)
