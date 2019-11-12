FROM python:3.7-slim

ENV LIB="libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libavformat-dev \
    libpq-dev \
    libasound2-dev \
    libatlas-base-dev \
    gcc \
    wget"

ENV MOD="cython \
    numpy \
    pandas \
    matplotlib \
    folium \
    lxml \
    nltk \
    scipy \
    plotly \
    opencv-python \
    simpleaudio"

ENV LANG=C.UTF-8

RUN apt-get update && apt-get -y upgrade && \
    # installing libraries
    apt-get install --no-install-recommends -qy $LIB && \
    # cleaning
    apt-get clean && apt-get autoclean && apt-get autoremove && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
    # setting jupyterlab
    pip install jupyter && \
    jupyter nbextension enable --py widgetsnbextension && \
    pip install jupyterlab && \
    jupyter serverextension enable --py jupyterlab && \
    # installing python modules
    pip install $MOD && \
    # creating volume directory
    mkdir -p /opt/app/data

# run jupyterlab
EXPOSE 8888
CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root
