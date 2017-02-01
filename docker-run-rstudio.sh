
R_WORKDIR_IN_HOST=$(pwd)
R_LIBS_USER_IN_HOST="/home/wagner/wagnerdocri@gmail.com2/fzlbpms/fzlStudio/integrated/R/libs"

chmod 777 -R $R_LIBS_USER_IN_HOST #Fix-me workaroundo to evict not writeble direcotry during installation packages

#fix-me: test if container exist first and only rm if its true
#but works well when the use case is re-run a already running container with the same name
CONTAINER_NAME=fzl_rstudio_FROM_hadleyverse_rstudio
docker stop $(docker ps -a |  grep $CONTAINER_NAME | awk '{print $1}')
docker rm  $(docker ps -a |  grep  $CONTAINER_NAME | awk '{print $1}')

docker run -d -p 8787:8787 \
       --name=" $CONTAINER_NAME" \
       -v "$R_WORKDIR_IN_HOST":/home/rstudio/R_Workdir \
       -v "R_LIBS_USER_IN_HOST":/home/rstudio/R_LIBS_USER \
       rocker/rstudio:19Dec2016 && docker logs $(docker ps -q -l)




