FROM python:3.7.7-buster
MAINTAINER Filipe Silva <filipe.dls@gmail.com>

#RUN apt-get autoclean
# Intall gcc and cmake for intalling H3
RUN apt-get update && \
    apt-get -y install gcc && \
    apt-get install -y python3-dev build-essential && \
    apt-get -y install cmake protobuf-compiler

# https://hub.docker.com/r/nikolaik/python-nodejs/
# https://github.com/nikolaik/docker-python-nodejs
# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_12.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  echo "deb https://deb.nodesource.com/node_12.x buster main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  # install yarn
  apt-get install -yqq nodejs && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  rm -rf /var/lib/apt/lists/*

# App  setup
RUN mkdir /app
WORKDIR /app

# Setup scripts
COPY .docker_configs/setup_scripts ./setup_scripts
RUN chmod +x --recursive setup_scripts/
# Poetry
RUN pip install --quiet poetry
COPY project ./project
COPY pyproject.toml README.md poetry.lock ./
RUN POETRY_VIRTUALENVS_CREATE=false poetry install --no-interaction --no-ansi --no-dev

# JUPYTERLAB ==2.1.0
# dir ref in makefile
#RUN mkdir /app/jupyter
#RUN pip install --quiet jupyterlab
## ipython config dir = get_ipython().profile_dir.startup_dir - allows nb imports startup
#COPY .docker_configs/ipython /root/.ipython/
#RUN ./setup_scripts/jupyter_extensions_script.sh
#
## LAUNCH JUPYETR LAB
#WORKDIR jupyter
#EXPOSE 8888
#CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

# https://github.com/amineHY/docker-streamlit-app/blob/master/Dockerfile
# --------------- Configure Streamlit ---------------
RUN pip install --quiet streamlit
RUN mkdir -p /root/.streamlit

RUN bash -c 'echo -e "\
	[server]\n\
	enableCORS = false\n\
	" > /root/.streamlit/config.toml'

EXPOSE 8888

# --------------- Export envirennement variable ---------------
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD ["streamlit", "run", "--browser.serverAddress", "0.0.0.0", "--server.port", "8888", "project/streamlit_sample.py"]
