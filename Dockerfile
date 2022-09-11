FROM jupyter/datascience-notebook:python-3.10.6

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

ENV PYTHON_VERSION 3.10

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

# matplotlib で日本語を使えるようにする (mamba / conda のリポジトリに japanize_matplotlib が存在しないので、良くないけど pip で install)
RUN pip install japanize_matplotlib

# matplotlib の font family の設定を書き換え
RUN sed -i '/font\.family/d' /opt/conda/lib/python${PYTHON_VERSION}/site-packages/matplotlib/mpl-data/matplotlibrc
RUN echo "font.family: IPAexGothic" >> /opt/conda/lib/python${PYTHON_VERSION}/site-packages/matplotlib/mpl-data/matplotlibrc

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
