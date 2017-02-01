#be carefull, use this script just after docker run... otherwise is not garanted stop correct container
docker stop $(docker -ps -q -l)
