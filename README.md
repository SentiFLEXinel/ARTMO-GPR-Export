# ARTMO-GPR-Export
Codes to export an ARTMO Gaussian Processes Regression model to different formats:
  1) **Google Earth Engine** (GPR_ARTMO_to_GEE function)
  2) **Python 'ee'** (GPR_ARTMO_to_pyee function)
  3) **Python 'numpy'** (GPR_ARTMO_to_pyeogpr function)

For the PyEOGPR package, models are exported in the Python 'numpy' format. Both Python versions include uncertainties.

## Use:

Select the function corresponding to the output format you desire in *script_GPRexport*. 

The functions have **three input arguments**:
1. **Path to the model** (mandatory)  
2. **Suffix** (optional)  
3. **Path to store the output** (optional)

For example run the line: *[out] = GPR_ARTMO_to_GEE('D:/Documents/exampleModel_CNC_Cab.mat','_CNC_Cab')*. 

You will then find a .txt (for GEE) that you can copy in a script on https://code.earthengine.google.com/ or for the python functions a .py file that you can import in a Python environment. 



## Developers:

Originally developed by Luca Pipia:
https://www.researchgate.net/profile/Luca-Pipia
(luca.pipia@uv.es)

Contributed by Matías Salinero Delgado:
https://www.researchgate.net/profile/Matias-Salinero-Delgado 
(matias.salinero@uv.es)

Contributed by Emma De Clerck:
https://www.researchgate.net/profile/Emma-De-Clerck/research
(emma.clerck@uv.es)
