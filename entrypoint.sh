#!/bin/sh
set -e

# "--core-mode": no extensions
# "--NotebookApp.token=''"
cd $JUPYTER_DIR && jupyter lab --port=${1:-8888} --no-browser --ip=0.0.0.0 --allow-root

