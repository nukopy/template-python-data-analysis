FROM jupyter/datascience-notebook:ubuntu-20.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

# 固定
ENV USER jovyan

# -------------------------------------------------
# Install general dependencies
# -------------------------------------------------

USER root

# Install general packages
RUN apt-get update \
    && apt-get install -y \
        fonts-ipaexfont \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# Install Python packages
# -------------------------------------------------

WORKDIR /home/${USER}/workdir

# Install DevDependencies
RUN mamba install --quiet --yes \
    'mypy' \
    'pytest' \
    'flake8' \
    'black' \
    'isort' \
    'ipython'
    # && mamba clean

# Install Dependencies
RUN mamba install --quiet --yes \
    'networkx' \
    'graph-tool' \
    'python-igraph'

# matplotlib で日本語を使えるようにする
RUN sed -i '/font\.family/d' /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/matplotlibrc
RUN echo "font.family: IPAexGothic" >> /opt/conda/lib/python3.9/site-packages/matplotlib/mpl-data/matplotlibrc
RUN rm -rf ${HOME}/.cache

# -------------------------------------------------
# Copy source files
# -------------------------------------------------

COPY . .

# -------------------------------------------------
# Setting bash
# -------------------------------------------------

RUN ln -sf ${HOME}/workdir/sh/.bashrc ${HOME}/.bashrc

USER ${USER}
