#!/bin/sh
set -e
set -o xtrace

# /!\ TDOD: needs spark installed!


# Install Apache Torre Kernel: https://github.com/apache/incubator-toree
#pip install --no-cache-dir toree --quiet
#jupyter toree install --sys-prefix

#jupyter labextension install jupyterlab_spark --no-build


# pylantern - some exts are not sported on v2.1.0
#pip install pylantern --quiet
#jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
#jupyterlab_bokeh - not sup jupyterlab
#pip install --quiet bokeh jupyter_bokeh
#jupyter labextension install @bokeh/jupyter_bokeh --no-build
#jupyter labextension install plotlywidget qgrid ipysheet lineup_widget --no-build
#jupyter labextension install @jupyterlab/plotly-extension --no-build
#jupyter labextension install @jpmorganchase/perspective-jupyterlab --no-build


#pip install jupyter-spark --quiet
#jupyter serverextension enable --py jupyter_spark
#jupyter nbextension install --py jupyter_spark
#jupyter nbextension enable --py jupyter_spark
#jupyter nbextension enable --py widgetsnbextension