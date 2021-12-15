FROM jupyter/pyspark-notebook

# install mamba to speed up conda
RUN conda install -n base -c conda-forge -y mamba

# run conda first since it is so slow
RUN mamba install -c conda-forge -y cudatoolkit=11.2 cudnn nccl

# switch to root user to install system packages
USER root
RUN ln -s /home/${NB_USER}/work /content
RUN apt-get update --yes
RUN apt-get install -y firefox-geckodriver
USER ${NB_USER}

# CIS545 colab packages
RUN mamba install -y pandas==1.1.5 googledrivedownloader pymongo 

# IDE setup
RUN mamba install -y jupyterlab==3.2.5 jupyterlab-lsp python-lsp-server[all] jupyterlab_code_formatter black

# project specific setup
RUN mamba install -y geopandas
RUN pip install -U google-cloud-bigquery pandas_gbq rasterio opencv-python-headless selenium scikit-optimize gdown