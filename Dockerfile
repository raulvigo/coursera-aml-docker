FROM ubuntu:16.04
LABEL maintainer="Zimovnov Andrey <zimovnov@gmail.com>"
ARG DEBIAN_FRONTEND=noninteractive

# install apt packages
RUN apt-get update
RUN apt-get install -yq python3-pip htop nano git

# install python modules
ADD requirements.txt /
RUN pip3 install -r requirements.txt

# setup juptyer
RUN jupyter contrib nbextension install --user
RUN jupyter nbextension enable codefolding/main
RUN echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8080" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /root
EXPOSE 8080
CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]