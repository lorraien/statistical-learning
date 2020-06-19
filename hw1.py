# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import pandas as pd
data = pd.read_csv("/Users/jing/Desktop/235/hw1/clustering data.txt")
import numpy as np  
import matplotlib.pyplot as plt  
import matplotlib as mpl
np.random.seed(0)

from sklearn import mixture



G3=mixture.GaussianMixture(n_components=3, covariance_type='full')
G4=mixture.GaussianMixture(n_components=4, covariance_type='full')
G5=mixture.GaussianMixture(n_components=5, covariance_type='full')

G3.fit(data)
G4.fit(data)
G5.fit(data)



 print(G3.aic(data),G4.aic(data),G5.aic(data))
 print(G3.bic(data),G4.bic(data),G5.bic(data))


for i in [0,1,2,3]:
plt.scatter(data.iloc[list(G4.predict(data)==i),0],data.iloc[list(G4.predict(data)==i),1]
data.iloc[list(G4.predict(data)==i),2],data.iloc[list(G4.predict(data)==i),3])

from sklearn.cluster import KMeans