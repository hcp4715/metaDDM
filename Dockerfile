# Info of jupyter/minimal-notebook:python-3.8.8
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Info of the current HDDM docker image:
## The buid from the base of minimal-notebook, based on python 3.8.8
## Modified by Dr. Hu Chuan-Peng, Nanjing Normal University, Nanjing, China.
## Please contact hcp4715@hotmail.com if you have any question with the curretn HDDM image

## In this version, jupyter lab and jupyter are updated to higher version:
# jupyterlab - 3.0.14
# jupyter_client - 6.1.12
# jupyter_core - 4.7.1
## Which means that some extension for plotting in jupyter should be upgraded too:
# ipympl >= 0.8
# matplotlib >= 3.3.1
# ipywidgets >= 0.76
# jupyter_widget *
#  
## Also note, I removed ipyparallel and used p_tqdm for parallel processing

# ARG BASE_CONTAINER=jupyter/minimal-notebook:python-3.8.8
FROM jupyter/minimal-notebook:python-3.8.8

LABEL maintainer="Hu Chuan-Peng <hcp4715@hotmail.com>"

USER root

# ffmpeg for matplotlib anim & dvipng for latex labels
RUN apt-get update && \
    # apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends ffmpeg dvipng && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install Python 3 packages
RUN conda install --quiet --yes \
    'arviz=0.11.4' \
    'beautifulsoup4=4.9.*' \
    'conda-forge::blas=*=openblas' \
    'bokeh=2.4.*' \
    'bottleneck=1.3.*' \
    'cloudpickle=1.4.*' \
    'cython=0.29.*' \
    'dask=2.15.*' \
    'dill=0.3.*' \
    'h5py=2.10.*' \
    'hdf5=1.10.*' \
    'ipywidgets=7.6.*' \
    'ipympl=0.8.*' \
    'jupyter_bokeh' \
    'jupyterlab_widgets' \
    'matplotlib-base=3.3.*' \
    # numba update to 0.49 fails resolving deps.
    'numba=0.48.*' \
    'numexpr=2.7.*' \
    'pandas=1.0.*' \
    'patsy=0.5.*' \
    'protobuf=3.11.*' \
    'pytables=3.6.*' \
    'scikit-image=0.16.*' \
    'scikit-learn=0.22.*' \
    'scipy=1.4.*' \
    'seaborn=0.11.*' \
    'sqlalchemy=1.3.*' \
    'statsmodels=0.11.*' \
    'sympy=1.5.*' \
    'vincent=0.4.*' \
    'widgetsnbextension=3.5.*'\
    'xlrd=1.2.*' \
    # 'ipyparallel=6.3.0' \
    'pymc=2.3.8' \
    'git' \
    'mkl-service' \
    && \
    conda clean --all -f -y && \
    fix-permissions "/home/${NB_USER}"

# conda install --channel=numba llvmlite
# pip install sparse
# conda install -c conda-forge python-graphviz

# USER root
# RUN jupyter notebook --generate-config -y
    
USER $NB_UID
RUN pip install --upgrade pip && \
    # pip install --no-cache-dir 'hddm==0.8.0' && \
    # install plotly and its chart studio extension
    pip install --no-cache-dir 'chart_studio==1.1.0' && \
    pip install --no-cache-dir 'plotly==4.14.3' && \
    pip install --no-cache-dir 'cufflinks==0.17.3' && \
    # install ptitprince for raincloud plot in python
    pip install --no-cache-dir 'ptitprince==0.2.*' && \
    # pip install --no-cache-dir 'kabuki==0.6.3' && \
    pip install --no-cache-dir 'feather-format' && \
    pip install --no-cache-dir 'p_tqdm' && \
    pip install --no-cache-dir 'pyddm' && \
    pip install --no-cache-dir 'pymc3==3.11.*' && \
    pip install --no-cache-dir 'bambi==0.6.*' && \
    fix-permissions "/home/${NB_USER}"

# install kabuki and hddm from Github
RUN pip install --no-cache-dir git+git://github.com/hddm-devs/kabuki.git && \
    pip install --no-cache-dir git+https://github.com/hddm-devs/hddm && \
    fix-permissions "/home/${NB_USER}"

# Install PyTorch, CPU-only
RUN conda install -c pytorch --quiet --yes \
    'pytorch' \
    'torchvision' \
    'torchaudio' \
    'cpuonly' \
    && \
    conda clean --all -f -y && \
    fix-permissions "/home/${NB_USER}"

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" &&\
     fix-permissions "/home/${NB_USER}"

## Activate ipywidgets extension
    # Activate ipywidgets extension in the environment that runs the notebook server
USER $NB_UID

# Below we install jupyterlab extensions, please check compatibility for each of them:
# https://npm.io/package/@jupyter-widgets/jupyterlab-manager
# # compatibility with bokeh, installed via conda
# # compatibility with matplotlib: https://www.npmjs.com/package/jupyter-matplotlib
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    # jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # jupyter labextension install nbdime-jupyterlab --no-build && \
    # jupyter labextension install bqplot --no-build && \
    # jupyter labextension install @jupyterlab/vega3-extension --no-build && \
    # jupyter labextension install @jupyterlab/git --no-build && \
    # jupyter labextension install @jupyterlab/hub-extension --no-build && \
    # jupyter labextension install jupyterlab_tensorboard --no-build && \
    # jupyter labextension install jupyterlab-kernelspy --no-build && \
    # jupyter labextension install @jupyterlab/plotly-extension --no-build && \
    # jupyter labextension install jupyterlab-chart-editor --no-build && \
    # jupyter labextension install plotlywidget --no-build && \
    # jupyter labextension install @jupyterlab/latex --no-build && \
    # jupyter labextension install @jupyterlab/server-proxy &&\
    jupyter labextension install jupyter-matplotlib --no-build && \
    # jupyter labextension install jupyterlab-drawio --no-build && \
    # jupyter labextension install jupyter-leaflet --no-build && \
    # jupyter labextension install qgrid --no-build && \
    jupyter lab build && \
        jupyter lab clean && \
        jlpm cache clean && \
        npm cache clean --force && \
        rm -rf "/home/${NB_USER}/.cache/yarn" && \
        rm -rf "/home/${NB_USER}/.node-gyp" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_UID
WORKDIR $HOME

# # Change the configuration of ipyparallel
# RUN sed -i  "/# Configuration file for jupyter-notebook./a c.NotebookApp.server_extensions.append('ipyparallel.nbextension')"  /home/jovyan/.jupyter/jupyter_notebook_config.py
	
# Change the jupyter config file name and change the content?
# Run mv /home/${NB_USER}/.jupyter/jupyter_notebook_config.py /home/${NB_USER}/.jupyter/jupyter_server_config.py &&\ 
#    sed -i 's/original/new/g' /home/${NB_USER}/.jupyter/jupyter_server_config.py"

# # Fix permissions on /etc/jupyter as root
# USER root

# # Prepare upgrade to JupyterLab V3.0 #1205
# RUN sed -re "s/c.NotebookApp/c.ServerApp/g" \
#     /etc/jupyter/jupyter_notebook_config.py > /etc/jupyter/jupyter_server_config.py && \
#     fix-permissions /etc/jupyter/

# Create a folder for example
RUN mkdir /home/$NB_USER/example && \
   fix-permissions /home/$NB_USER

# Copy example data and scripts to the example folder
COPY /example/HDDM_official_tutorial_reproduced.ipynb /home/${NB_USER}/example
COPY /example/HDDM_official_tutorial_ArviZ.ipynb /home/${NB_USER}/example