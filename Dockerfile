FROM rocker/tidyverse:4.0.1
# Base image https://hub.docker.com/u/rocker/
# FROM rocker/r-base:latest
# Notes:
        # If pull it from github and run (docker run -lit --rm rocker/r-bae) the terminal 
        # will be turned into an R console which we can interatc with it thanks to the argument "-it"
        # the argumen --rm makes sure the container is automatically removed once we stop it.

        # FROM rocker/tidycerse  # this base image has R and R-studio


LABEL dockerfile.version="1.0"
LABEL sofware="R-base"
LABEL base.image="rocker/r-base"
LABEL description=" To donwload fasta files and their corresponding  NCBI-GenBank IDs  \
                    for a USA-Geographig location (state) and duirn a specify time-window \
                    tHe US-State  and time-window are arguments entered by the user \
                    i.e: Docker run --rm -u $(id -u):$(id -g) -v ${PWD}:/data lyapunov123/r_docker.rentrez:latest Rscript myScrupt.R TX 3 \
                    In this case we 'll donwload the fasta files & GenBank IDs for the samples submitted by the sate of Texas during teh last 3 montsh. \
                    Two files are genered: (1): The fasta files, (2): The GenBank ids ina csv file "
LABEL mainteiner ="Olinto Linares-Perdomo"
LABEL mainteiner.email="olinares-perdomo@utah.gov"
LABEL license="working on it"

## create directories
RUN mkdir /data
RUN mkdir /code
RUN mkdir /output
RUN mkdir /analysis

# RUN mkdir -p /modelmortality2

RUN R -e "install.packages('caret')"
RUN R -e "install.packages('randomForest')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('aws.s3')"
RUN R -e "install.packages('rentrez')"
RUN R -e "install.packages('ape')"
RUN R -e "install.packages('stringr')"
RUN R -e "install.packages('seqinr')"
RUN R -e "install.packages('easypackages')"

## copy files insite de image
#COPY install_packages.R /home/code/install_packages.R
# 
# we stop this 
COPY myScript.R /code/myScript.R
#COPY demographic.csv /home/data/demographic.csv

## installing the necessary R--packages
#RUN Rscript /code/myScript.R
#CMD ["echo", "por aqui pase .  .como la ve paramito de Santa Rosa..como me la ve"]
# CMD Rscript /code/myScript.R
