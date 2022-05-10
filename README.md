# metaDDM: Building a docker image for drift diffusion modelling
Drift-diffusion models (DDMs) or Evidence accumulation models (EAMs) are widely used in studying human decision-making, and DDMs are a particular model of sequential sampling model (SSM). DDM is increasingly used in analyzing RT data in psychology, neuroscience, and psychiatry. However, different packages provided different (and usually limited) functions for DDM. The goal of metaDDM is to make the modelling process approaching to standardized. 

This project was generated after seeing the usefullness of the [hddm docker image](https://hub.docker.com/r/hcp4715/hddm), which aimed at increase the computational reprodocubility of analyses based on HDDM. Only after reading a lot papers, I realized the chaotic status of the modelling field. The humble goal of this project is to create a more general tool (That's why I choose HDDM at the very beginning, it's widely used). 

There are three sub-goals of metaDDM: (1) provide a hitchhiker's guide to the chaotic world of DDM/EAM/SSM; (2) provide an all-in-one docker image for DDM related python packages, and maybe other packages, such `r` packages, in thie docker image or as a separate image in the future; (3) provide some workflow like recommmendations for using DDM. Thus this repo might be developed into three repos, depends on whether we have enough people in the future.

This project has just started. If you are interested in this project, please feel free to email me and jump in. My email address is: hcp4715 AT hotmail dot com.

## What is DDM? 
To be continued ...

## DDM/EAM/SSM in Python
### Packages for modelling
#### [HDDM](https://hddm.readthedocs.io/en/latest/)
HDDM is a python toolbox for hierarchical Bayesian parameter estimation of the Drift Diffusion Model (via PyMC2.3.8).

#### [pyDDM](https://github.com/mwshinn/PyDDM)
PyDDM is a simulator and modeling framework for generalized drift-diffusion models (DDM), with a focus on cognitive neuroscience.

#### [PyBEAM](https://github.com/murrowma/pybeam)
PyBEAM (Bayesian Evidence Accumulation Models) is a Python package designed to rapidly fit two-boundary, binary choice models to choice-RT data using Bayesian inference methods. 

### Supporting packages
A complete workflow for DDM needs packages other than parameter estimation or simulation, but more, e.g., statstical inference, visualization. In this docker image, we included python packages we think are essential for complete workflow:

#### Packages for parallel processing
`p_tqdm`, which includs `pathos` and `tqdm`.

#### Bayesian inference
`ArviZ`, `pymc3`, and `bambi`

#### Visualization
`seaborn` and `plotly`

#### To be continued...

### docker images for DDM in Python.
Tags will be used to distinct the packages and version of packages in each docker image.

## DDM in R

## DDM in  other languages
### *EZ*

### fast-dm 

## How to use a docker image
Please see this [hddm docker image](https://hub.docker.com/r/hcp4715/hddm) about details of using docker image. 

## Report issues
If you have any problem in using this docker image, please report an issue at the [github repo](https://github.com/hcp4715/hddm_docker/issues) 