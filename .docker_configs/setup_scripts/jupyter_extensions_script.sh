#!/bin/sh
set -e
set -o xtrace

# jupyter labextension install jupyterlab-drawio --no-build

jupyter labextension install @ijmbarr/jupyterlab_spellchecker --no-build

jupyter labextension install @jupyterlab/theme-dark-extension --no-build

pip install --quiet ipywidgets

# NB Resource Usage
pip install --quiet nbresuse
jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor --no-build

# table of contents
jupyter labextension install @jupyterlab/toc --no-build

# Code formater
jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build
pip install jupyterlab_code_formatter --quiet
jupyter serverextension enable --py jupyterlab_code_formatter
pip install --quiet black
# might also need: https://jupyterlab-code-formatter.readthedocs.io/en/latest/how-to-use.html#changing-default-formatter

# Language Server Protocol integration for Jupyter(Lab)
pip install --quiet jupyter-lsp
jupyter labextension install @krassowski/jupyterlab-lsp --no-build
pip install --quiet python-language-server

# github
# check how to add cdredentials: https://github.com/jupyterlab/jupyterlab-github
jupyter labextension install @jupyterlab/github --no-build
pip install --quiet jupyterlab_github
jupyter serverextension enable --sys-prefix jupyterlab_github

# jupytext - notebooks on markdown format
pip install jupytext --upgrade --quiet

# qgrid - Interactive pandas DataFrames
pip install qgrid --quiet
jupyter nbextension enable --py --sys-prefix qgrid

# pylantern - some exts are not sported on v2.1.0
#pip install pylantern --quiet
#jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
#jupyterlab_bokeh - not sup jupyterlab
#pip install --quiet bokeh jupyter_bokeh
#jupyter labextension install @bokeh/jupyter_bokeh --no-build
#jupyter labextension install plotlywidget qgrid ipysheet lineup_widget --no-build
#jupyter labextension install @jupyterlab/plotly-extension --no-build
#jupyter labextension install @jpmorganchase/perspective-jupyterlab --no-build


jupyter lab build