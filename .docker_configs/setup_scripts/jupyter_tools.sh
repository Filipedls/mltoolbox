#!/bin/sh
set -e
set -o xtrace

# Jupyter Notebook Diff and Merge tools
#pip install nbdime --quiet

# python progress bar
pip install tqdm --quiet

pip install ipython-sql --quiet

pip install --quiet ipywidgets

# parametrize notebook runs
pip install papermill --quiet

# jupytext - notebooks on markdown format
pip install jupytext --upgrade --quiet

# cell magic %%notify that notifies the user upon completion of a cell
pip install jupyternotify --quiet


