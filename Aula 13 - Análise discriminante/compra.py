import os
import pandas as pd

base_path = os.path.dirname(__file__)
compra_xls = pd.read_excel('compra.xls.xlsx')

compra_xls.boxplot(by='compra')

compra_xls.groupby('compra')['durabilid'].plot.hist()
compra_xls.groupby('compra')['estilo'].plot.hist()

print(compra_xls.describe())

compra_sim = compra_xls[compra_xls['compra'] == 'sim']
compra_nao = compra_xls[compra_xls['compra'] == 'nao']
print(compra_sim.describe())
print(compra_nao.describe())

import scipy.stats as stats
print(stats.f_oneway(
        compra_sim['desempenh'],
        compra_nao['desempenh'])
     )

print(stats.f_oneway(
        compra_sim['durabilid'],
        compra_nao['durabilid'])
     )

print(stats.f_oneway(
        compra_sim['estilo'],
        compra_nao['estilo'])
     )

from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
X = compra_xls[['durabilid', 'desempenh', 'estilo']]
y = compra_xls['compra'] == 'sim'
print(y)
clf = LinearDiscriminantAnalysis()
clf.fit(X, y)
print(clf.decision_function(X))
print(clf.score(X, y))

y_ = clf.predict(X)

print(clf)
print(clf.score(X, y))
print(clf.coef_, clf.intercept_)


comprapredic = pd.read_csv("comprapredic.csv", header=0, sep=";")
X2 = comprapredic[['durabilid', 'desempenh', 'estilo']]
clf.predict(X2)


from sklearn.feature_selection import RFE
clfrfe = LinearDiscriminantAnalysis()
selector = RFE(estimator=clfrfe)
selector.fit(X, y)
print(selector.support_)
print(selector.ranking_)
print(selector.feature_importances_)
Xrfe = selector.transform(X)


X_r = compra_xls[['durabilid', 'desempenh']]
clf2 = LinearDiscriminantAnalysis()
clf2.fit(X_r, y)
print(clf2.decision_function(X_r))
print(clf2.score(X_r, y))
print(clf2.coef_, clf2.intercept_)
