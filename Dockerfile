FROM python:3.7.7-buster
MAINTAINER Filipe Silva <filipe.dls@gmail.com>

ARG jupyter_workdir=jupyter
ENV JUPYTER_DIR=$jupyter_workdir
ENV BACKUP_JUP_CONFIG=true

# /bin/zsh
RUN apt-get update && apt-get install -y zsh && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Intall gcc and cmake for intalling H3 #RUN apt-get autoclean
RUN apt-get update && apt-get -y install gcc python3-dev build-essential cmake protobuf-compiler

RUN pip install --upgrade pip

# https://hub.docker.com/r/nikolaik/python-nodejs/ - https://github.com/nikolaik/docker-python-nodejs
# Install node prereqs, nodejs and yarn
# Refs: https://deb.nodesource.com/setup_12.x & https://yarnpkg.com/en/docs/install
RUN \
  echo "deb https://deb.nodesource.com/node_12.x buster main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  # install yarn
  apt-get update && apt-get install -yqq nodejs && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  rm -rf /var/lib/apt/lists/*

# anaconda
# https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
#RUN apt-get update --fix-missing && \
#    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
#    apt-get clean
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy  > /dev/null 2>&1

#RUN useradd -rm -d /home/usrname -s /bin/bash -g root -G sudo -u 1000 usrname
#RUN echo "usrname ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#USER usrname

# App  setup
RUN mkdir /app
WORKDIR /app

# Setup scripts
COPY .docker_configs/setup_scripts ./setup_scripts
RUN chmod +x --recursive setup_scripts/
# Poetry
RUN pip install --quiet poetry
COPY project ./project
COPY pyproject.toml README.md poetry.lock entrypoint.sh ./
RUN poetry config virtualenvs.create false
#RUN poetry config virtualenvs.in-project true # if virtualenvs.create true
#RUN poetry update --lock
#  --no-dev
RUN poetry install --no-interaction --no-ansi

# JUPYTERLAB ==2.1.0
# dir ref in makefile
RUN pip install --quiet jupyterlab==2.1.0
# ipython config dir = get_ipython().profile_dir.startup_dir - allows nb imports startup
COPY .docker_configs/root_home_dir /root/
#~/.jupyter/lab/user-settings/
RUN ./setup_scripts/jupyter_tools.sh
RUN ./setup_scripts/jupyternb_extensions_script.sh
RUN ./setup_scripts/jupyter_kernels.sh > /dev/null 2>&1
RUN ./setup_scripts/jupyter_extensions_script.sh

# LAUNCH JUPYETR LAB
#RUN mkdir $jupyter_workdir
#WORKDIR $jupyter_workdir
EXPOSE 8888
CMD ["/bin/bash", "./entrypoint.sh"]

#papermill template

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
