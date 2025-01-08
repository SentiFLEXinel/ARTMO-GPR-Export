# ARTMO-GPR-Export
Codes to export an ARTMO Gaussian Processes Regression model to different formats:
  1) Google Earth Engine (GPR_ARTMO_to_GEE function)
  2) Python 'ee' (GPR_ARTMO_to_pyee function)
  3) Python 'numpy' (GPR_ARTMO_to_pyeogpr function)

For the PyEOGPR package, models are exported in the Python 'numpy' format.

**Use:**

Select the function corresponding to the output format you desire. Function has 3 imput arguments: path to the model, suffix, and path to store the output (only the model path is mandatory).

**Developers:**

Originally developed by Luca Pipia:
https://www.researchgate.net/profile/Luca-Pipia
(luca.pipia@uv.es)

Contributed by Matías Salinero Delgado:
https://www.researchgate.net/profile/Matias-Salinero-Delgado 
(matias.salinero@uv.es)

Contributed by Emma De Clerck:
https://www.researchgate.net/profile/Emma-De-Clerck/research
(emma.clerck@uv.es)
