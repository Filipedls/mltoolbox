#!/bin/sh
set -e
set -o xtrace

jupyter labextension install jupyterlab-drawio --no-build

jupyter labextension install @ijmbarr/jupyterlab_spellchecker --no-build

jupyter labextension install @jupyterlab/theme-dark-extension --no-build

jupyter labextension install jupyterlab-execute-time --no-build

# NB Resource Usage
pip install --quiet nbresuse
jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor jupyterlab-theme-toggle --no-build

# table of contents
jupyter labextension install @jupyterlab/toc --no-build

# NS2.1.0
#pip install knowledgelab --quiet
#jupyter labextension install knowledgelab --no-build
#jupyter serverextension enable --py knowledgelab

pip install jupyterlab_email --quiet
jupyter labextension install jupyterlab_email --no-build
#jupyter serverextension enable --py jupyterlab_email

# Code formater
jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build
pip install jupyterlab_code_formatter --quiet
jupyter serverextension enable --py jupyterlab_code_formatter
pip install --quiet black
# might also need: https://jupyterlab-code-formatter.readthedocs.io/en/latest/how-to-use.html#changing-default-formatter

# Language Server Protocol integration for Jupyter(Lab)
pip install --quiet jupyter-lsp
jupyter labextension install @krassowski/jupyterlab-lsp --no-build
pip install --quiet python-language-server[all]

# NS2.1.0
# Tools for cleaning code, recovering lost code, and comparing versions of code in Jupyter Lab.
#jupyter labextension install nbgather --no-build

# NS2.1.0
#pip install jupyterlab_autoversion --quiet
#jupyter labextension install jupyterlab_autoversion --no-build
#jupyter serverextension enable --py jupyterlab_autoversion

# github
# check how to add cdredentials: https://github.com/jupyterlab/jupyterlab-github
jupyter labextension install @jupyterlab/github --no-build
pip install --quiet jupyterlab_github
jupyter serverextension enable --sys-prefix jupyterlab_github

#pip install --upgrade jupyterlab-git --quiet
#jupyter serverextension enable --py jupyterlab_git

#jupyter labextension install @jupyterlab/google-drive --no-build

jupyter labextension install jupyterlab_tensorboard --no-build

jupyter labextension install @lckr/jupyterlab_variableinspector --no-build

jupyter labextension install @jupyterlab/debugger --no-build

# NS2.1.0
#jupyter labextension install @jupyter-widgets/jupyterlab-manager

pip install jupyterlab_templates --quiet
jupyter labextension install jupyterlab_templates --no-build
jupyter serverextension enable --py jupyterlab_templates

# NS2.1.0
#jupyter labextension install jupyterlab_voyager --no-build

# https://github.com/jupyter-incubator/sparkmagic
pip install sparkmagic --quiet
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter serverextension enable --py sparkmagic

# fixing  tonrnado's ver - sparkmonitor bug
pip install tornado==5.1.1 --quiet
#pip install nbconvert==5.6.1 --quiet
pip install sparkmonitor --quiet
#pip install --quiet sparkmonitor-s==0.0.11
jupyter nbextension install sparkmonitor --py --user --symlink
jupyter nbextension enable sparkmonitor --py --user
jupyter serverextension enable --py --user sparkmonitor
ipython profile create && echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

# NS2.1.0
# SQL
#pip install --quiet jupyterlab_sql
#jupyter serverextension enable jupyterlab_sql --py --sys-prefix

jupyter lab build --dev-build=False --minimize=False
