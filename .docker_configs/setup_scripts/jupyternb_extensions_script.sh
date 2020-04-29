#!/bin/sh
set -e
set -o xtrace


#jupyter nbextension enable --py --sys-prefix widgetsnbextension
#pip install gmaps --quiet
#jupyter nbextension enable --py --sys-prefix gmaps

# to open jupyter_contrib_nbextensions - https://localhost:8888/nbextensions
pip install jupyter_contrib_nbextensions --quiet
jupyter contrib nbextension install --system > /dev/null 2>&1

# qgrid - Interactive pandas DataFrames
pip install qgrid --quiet
jupyter nbextension enable --py --sys-prefix qgrid

#pip install jupyter-spark --quiet
#jupyter serverextension enable --py jupyter_spark
#jupyter nbextension install --py jupyter_spark
#jupyter nbextension enable --py jupyter_spark
#jupyter nbextension enable --py widgetsnbextension

# https://github.com/jupyter-incubator/sparkmagic
pip install sparkmagic --quiet
jupyter nbextension enable --py --sys-prefix widgetsnbextension