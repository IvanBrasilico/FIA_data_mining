import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
import statsmodels.formula.api as smf

base_path = os.path.dirname(__file__)
base_path = os.path.join(base_path, 'Aula 9')

# Sem preserve_dtypes a importação de exper é feita por int8 e dá problema no quadrado
df = pd.read_stata(os.path.join(base_path, 'WAGE1-Kayo.dta'), preserve_dtypes=False)

model = smf.ols(formula ='np.log(wage) ~ female * educ + exper + expersq + tenure + tenursq', data=df)
results = model.fit()
# y = results.predict(df)
print(results.summary())

H = df[df['female'] == 0].sort_values(by=['educ'])
M = df[df['female'] == 1].sort_values(by=['educ'])

xh = H['educ']
yh = results.predict(H)

xm = M['educ']
ym = results.predict(M)

lxh = np.arange(0, H['educ'].max() + 2, 1)
lyh = results.params['Intercept'] + lxh * results.params['educ']
lxm = np.arange(0, M['educ'].max() + 2, 1)
lym = results.params['female'] + lxm * (results.params['educ'] + results.params['female:educ'])

plt.scatter(xh, yh, label='men wage x educ')
plt.plot(lxh, lyh, label='educ x wage line men')
plt.scatter(xm, ym, label='women wage x educ')
plt.plot(lxm, lym, label='educ x wage line women')
leg = plt.legend(loc='best', mode="expand", shadow=True, fancybox=True)
leg.get_frame().set_alpha(0.5)
plt.show()

print(results.params)