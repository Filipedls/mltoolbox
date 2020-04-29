#!/bin/sh
set -e
set -o xtrace


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
    rm -rf /var/lib/apt/lists/*

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
    conda clean --all -f -y
#    fix-permissions $CONDA_DIR

# Install e1071 R package (dependency of the caret R package)
conda install --quiet --yes r-e1071


# BASH
pip install bash_kernel
python -m bash_kernel.install

# Julia
# https://github.com/andferrari/julia_notebook/blob/master/Dockerfile

export JULIA_VERSION=1.4.1

mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Add packages and precompile
julia -e 'import Pkg; Pkg.update()' && \
julia -e 'import Pkg; Pkg.add("Plots"); using Plots' && \
#    julia -e 'import Pkg; Pkg.add("Distributions"); using Distributions' && \
#    julia -e 'import Pkg; Pkg.add("Optim"); using Optim' && \
#    julia -e 'import Pkg; Pkg.add("FFTW"); using FFTW' && \
    # julia -e 'import Pkg; Pkg.add("StatsPlots"); using StatsPlots' && \
#    julia -e 'import Pkg; Pkg.add("DSP"); using DSP' && \
julia -e 'import Pkg; Pkg.add("IJulia"); using IJulia'
