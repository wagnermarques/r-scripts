# r-scripts

my R scripts, started to learn R.

The firt goal is to provide some descriptive statistics with nice
outputs using xtable.


## Installation

git clone https://github.com/wagnermarques/r-scripts.git
git git submodule update --init --recursive

install docker and stard docker service

## usage

cd r-scripts

Build https://github.com/rocker-org/hadleyverse rstudio image with
run docker-build-rstudio.sh 

Run the rstudion container with
Don't forget change docker volumes accordingly your needs
run docker-run-rstudio.sh

Install R packages needed for this r-scripts
docker-exec-install-rpackages.sh

to access r-studio...
http://localhost:8787/

More informations:https://github.com/rocker-org/rocker/wiki
no word to thanks that guys...

## To produce final output with xtables in html and in odt:
1. Use the terminal
2. change to r-script/util
3. Run ./produce_final_output.sh script and pass the last ouptut
   directory of last r-script execution (./run.R read-data
   pesq-abandono-etec211-bk.ods)





