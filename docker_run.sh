#!/bin/sh
set -e

docker run -t -i -p8888:8888 -v '$(PWD)':'/app/jupyter/' -e JUPYTER_DIR=jupyter mltoolbox
