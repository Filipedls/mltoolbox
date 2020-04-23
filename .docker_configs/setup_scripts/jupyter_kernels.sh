#!/bin/sh
set -e
set -o xtrace

## Compiling from source:
#git clone https://github.com/zeromq/zeromq4-x.git libzmq
#cd libzmq
#mkdir build
#cd build
#cmake ..
#make install
#ldconfig
#
## R
##add-apt-repository ppa:chris-lea/zeromq
##apt-get update
#apt-get install libcurl4-openssl-dev libssl-dev
## jupyter-core jupyter-client
#
## installing R packages
#R -e "install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source')"
#R -e "IRkernel::installspec(user = FALSE)"

# R kernel
# https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile

# R pre-requisites
apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc && \
    rm -rf /var/lib/apt/lists/* > /dev/null 2>&1

conda config --append channels conda-forge
#wget https://raw.githubusercontent.com/jupyter/docker-stacks/master/base-notebook/fix-permissions -P /usr/local/bin/
#chmod a+rx /usr/local/bin/fix-permissions
conda install --quiet --yes \
    'r-base=3.6.3' \
    'r-caret=6.0*' \
    'r-crayon=1.3*' \
    'r-devtools=2.2*' \
    'r-forecast=8.11*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.4*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-plyr=1.8*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-reshape2=1.4*' \
    'r-rmarkdown=2.1*' \
    'r-rodbc=1.3*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.4*' \
    'r-tidyverse=1.3*' \
    'unixodbc=2.3.*' \
    && \
    conda clean --all -f -y > /dev/null 2>&1
#    fix-permissions $CONDA_DIR

# Install e1071 R package (dependency of the caret R package)
conda install --quiet --yes r-e1071 > /dev/null 2>&1
