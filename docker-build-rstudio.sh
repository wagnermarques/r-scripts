#!/bin/bash

DOCKER_LINE="RUN mkdir -p  /home/rstudio/R_Workdir && mkdir -p /home/rstudio/R_LIBS_USER"
DOCKERFILE="./hadleyverse/Dockerfile"

#from: http://stackoverflow.com/questions/20267910/how-to-add-a-line-in-sed-if-not-match-is-found
#FIX-ME this functions still no working yet
#I've put $DOCKER_LINE manually in Dockerfile, but for new git clone it must be doing in the same way
# in order to host container volumes works properly 
function update_docker_file(){
    grep -q '^option' file && sed -i 's/^option.*/option=value/' file || echo 'option=value' >> file
}


#update_docker_file
docker build  -t rocker/rstudio:19Dec2016 hadleyverse/.




