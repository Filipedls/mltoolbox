#!/bin/sh
set -e
set -o xtrace

# Jupyter Notebook Diff and Merge tools
pip install nbdime --quiet

# python progress bar
pip install tqdm --quiet

pip install ipython-sql --quiet
