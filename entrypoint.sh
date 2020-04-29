#!/bin/sh
set +e

# Allows to use arrows in the terminal jupyer app
export SHELL=/bin/zsh

# "--core-mode": no extensions
# "--NotebookApp.token=''"
# also be used for extensions: --NotebookApp.ResourceUseDisplay.track_cpu_percent=True
cd $JUPYTER_DIR
echo $JUPYTER_DIR
# jupyter lab --ip=0.0.0.0 --no-browser --NotebookApp.notebook_dir=~/ --app-dir=~/
jupyter lab --port=${1:-8888} --no-browser --ip=0.0.0.0 --allow-root

# backing up jupyter settings
if [ "$BACKUP_JUP_CONFIG" = true ] ; then
    echo "backing up jupyter configs"
    cp -r /root/.jupyter /app/$JUPYTER_DIR/jupyter_backup_test
    cp -r /root/.ipython /app/$JUPYTER_DIR/jupyter_backup_test
fi



# https://github.com/amineHY/docker-streamlit-app/blob/master/Dockerfile
# --------------- Configure Streamlit ---------------
#RUN pip install --quiet streamlit
#RUN mkdir -p /root/.streamlit
#
#RUN bash -c 'echo -e "\
#	[server]\n\
#	enableCORS = false\n\
#	" > /root/.streamlit/config.toml'
#
#EXPOSE 8888
#
## --------------- Export envirennement variable ---------------
#ENV LC_ALL=C.UTF-8
#ENV LANG=C.UTF-8
## --server.enableCORS False
#CMD ["streamlit", "run", "--browser.serverAddress", "0.0.0.0", "--server.port", "8888", "project/streamlit_sample.py"]
