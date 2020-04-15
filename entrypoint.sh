#!/bin/sh
set +e

# "--core-mode": no extensions
# "--NotebookApp.token=''"
cd $JUPYTER_DIR
echo $JUPYTER_DIR
jupyter lab --port=${1:-8888} --no-browser --ip=0.0.0.0 --allow-root

# backing up jupyter settings
if [ "$BACKUP_JUP_CONFIG" = true ] ; then
    echo "backing up jupyter configs"
    cp -r /root/.jupyter /app/$JUPYTER_DIR/jupyter_backup_test
    cp -r /root/.ipython /app/$JUPYTER_DIR/jupyter_backup_test
fi
