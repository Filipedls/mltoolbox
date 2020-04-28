# mltoolbox


Jupyter docker sandbox for quick prototyping.

Runs `jupyter lab` in the directory where the docker image is started. All the files are read/write to that dir.

**Includes**
 * a whole bunch of jupyter pre-configured extensions (might need to do a bit of manual work here :)
 * a jupyter R kernel
 * `oh my zsh` jupyter terminal session
 * `pip` and `conda` to install python and R packages on-the-fly

## Config's

The folder `.docker_configs/` contains all the docker extra configurations.
In here you will find a `setup_scripts` directory with all the scripts to install the jupyter extras and extensions (+details bellow).

The folder `.docker_configs/root_home_dir` has all the jupyter (including extensions settings), ipython and R settings.
These all loaded to the docker image via the root user directory, `/root/`.

### - jupyter settings

Check `.docker_configs/root_home_dir/.jupyter`. In here you'll find:
 * `jupyter_notebook_config.py` file for jupyter server and extensions configurations
 * `lab/user-settings/@jupyterlab` directory, for extensions settings
 * `.Rprofile` the common R settings file, used by the jupyter R kernel

Also in `.ipython/profile_default/` you'll find:
 * `ipython_config.py` where *%magic* extensions are automatically loaded
 * a `startup` folder where code that runs before every notebook is placed

All the other configuration file are default and haven't been changed.

#### Pre-activated extensions

[list of extensions...]

# Available kernels
### python kernel

Python version: `3.7.7` (base docker img: *python:3.7.7-buster*)

python kernel libraries/dependencies can be manage in `pyproject.toml`.

(also put python kernel configs here???)

### R kernel

ver
libs
configs?


## Setup
### Pre-requisites

just docker :)

### Building the docker image

Build/Run variables:
 * `jupyter_workdir=jupyter` jupyter starting directory
 * `BACKUP_JUP_CONFIG=true` flag to backup the jupyter settings

How to:
build and run:

    make docker
    
just build:

    make docker-build

just run:

    make docker-run

(figure out out to do an alias that runs from any dir???)

#### Other cmds (Makefile?):
    
Adding new dependencies:

    poetry add <pip_package_name>
    
Updating all dependencies:

    make update
    

