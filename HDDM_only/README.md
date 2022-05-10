# A HDDM docker image

This is a docker image for HDDM 0.9.0 (beta). There an additional docker images for HDDM 0.8.0, see `arviz` [hcp4715/hddm/tags](https://hub.docker.com/r/hcp4715/hddm/tags).

## What is HDDM? 
HDDM is a python package for hierarchical drift diffusion modelling, see [here](http://ski.clps.brown.edu/hddm_docs/index.html) for more.

## What's new about this docker image?
This light HDDM docker image was based on a previous HDDM docker image by Mads ([@madslupe](https://hub.docker.com/r/madslupe/hddm)), with a few improvements. 
* Parallel processing with `p_tqdm` (pathos and tqdm). 
* With the latest HDDM package.
* A few new python packages that are used for plotting (`seaborn`, `plotly`).

In the `example` folder of this docker image (see below on how to use this image), you can find two example jupyter notebooks: one for reproducing the [official tutorial](http://ski.clps.brown.edu/hddm_docs/tutorial.html), and one for converting HDDM model objects into `ArviZ` InferenceData.

## How to use this docker image
### Installation
First, install `docker` and test it. There are many tutorials on this.

#### Ubuntu
Please read this [post on docker's website](https://docs.docker.com/engine/install/ubuntu/) for installing docker for linux (ubuntu included).

Then, pull the current docker image from docker hub:

```
docker pull hcp4715/hddm:0.9_beta
```

**Note**: you may need sudo permission to run the command `docker`.

#### Window 10 (pro)
Please read this [post](https://docs.docker.com/docker-for-windows/install/) for installing docker on window 10. During the installation of docker, you might be instructed to install/update your window subsystem linux (WSL), please follow the instruction to finish the installation of docker.

Then, open window power shell, and pull the current docker image from docker hub:

```
docker pull hcp4715/hddm:0.9_beta
```

### Open Jupyter notebook

After pulling it from docker hub, you can then run jupyter notebook in the container (e.g., in bash of linux or power shell of windows):

#### Example code for Ubuntu:
```
docker run -it --rm --cpus=4 \
-e NB_USER=jovyan -e CHOWN_HOME=yes -e CHOWN_EXTRA_OPTS='-R' -w /home/jovyan/ \
-v /home/hcp4715/hddm_docker:/home/jovyan/hddm \
-p 8888:8888 hcp4715/hddm:0.9_beta jupyter notebook
```

#### Example code for windows:

```
docker run -it --rm --cpus=4 -w /home/jovyan/ -v /d/hcp4715/hddm_docker:/home/jovyan/hddm -p 8888:8888 hcp4715/hddm:0.9_beta jupyter notebook  
```

#### Explanations of the example code

`docker run` ---- Run a docker image in a container

`-it` ---- Keep STDIN open even if not attached

`--rm` ---- Automatically remove the container when it exits

`--cpus=4` ---- [optional] Number of cores will be used by docker

`-v` ---- Mount a folder to the container

`/home/hcp4715/hddm_docker` ---- The directory of a local folder where I stored my data. [For Linux]

`/d/hcp4715/hddm_docker` ---- The directory of a local folder under drive D. It appears as `D:\hcp4715\hddm_docker` in windows system.

`/home/jovyan/hddm` ---- The directory inside the docker image (the mounting point of the local folder in the docker image). Note that the docker container itself likes a mini virtual linux system, so the file system inside it is linux style. 

`-p` ---- Publish a container’s port(s) to the host

`hcp4715/hddm:0.9_beta` ---- The docker image to run, `0.9_beta` after `:` is the tag of the current docker image.

`jupyter notebook` ---- Open juypter notebook when start running the container.

After running the code above, bash will has output like this:

```
....
....
To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
Or copy and paste one of these URLs:
    http://174196acc395:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
 or http://127.0.0.1:8888/?token=75f1a7a8ffcbb55f0c2802433a9a5d57ac00868e05089c09
```

Copy the full url (http://127.0.0.1:8888/?.......) to a browser (firefox or chrome) and it will show a web page, this is the interface of jupyter notebook! Note, in Windows system, it might be `localhost` instead of `127.0.0.1` in the url.

Under the `Files` tab, there should be two folders: `example` and `hddm`. The `hddm` folder is the local folder mounted in docker container. The `example` folder was the one built in docker image, this folder includes one dataset and one jupyter notebook, you can test the parallel processing by running this jupyter notebook.

Enter `hddm` folder, you can start your analyses within this jupyter notebook.

## Using example
The `example` folder also includes two other jupyter notebooks, `HDDM_official_tutorial_reproduced.ipynb` reproduces the tutorial code, using the `HDDM` in this docker image; `HDDM_official_tutorial_ArviZ.ipynb` illustrates how to convert HDDM data to `ArviZ` InferenceData to plot posterior traces and posterior predictives (but not work with `loo` and `waic` yet).

```
docker run -it --rm --cpus=5 \
-p 8888:8888 hcp4715/hddm:0.9_beta jupyter notebook
```

## Potential errors
* Permission denied. If you still encounter this error, please see this [post](https://groups.google.com/forum/#!topic/hddm-users/Qh-aOC0N6cU) about the permission problem. 

## How this docker image was built
An alternative way to get the docker image is to build it from `Dockerfile`.

I built this docker image under Ubuntu 20.04. 

This Dockerfile is modified by Dr. Rui Yuan @ Stanford, based on the Dockerfile of [jupyter/scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook/dockerfile). We installed additional packages for Bayesian inference and DDM. See `Dockerfile` for the details

The command for building the docker image (don't forget the `.` in the end):

```
docker build -t hcp4715/hddm:0.9_light -f Dockerfile .
```

## Acknowledgement
Thank [@madslupe](https://github.com/madslupe) for his previous HDDM image, which laid the base for the current version.

Thank [Dr Rui Yuan](https://scholar.google.com/citations?user=h8_wSLkAAAAJ&hl=en) for his help in creating the Dockerfile.

## Report issues
If you have any problem in using this docker image, please report an issue at the [github repo](https://github.com/hcp4715/HDDM_Container/issues). 