#!/usr/bin/env Rscript
cat("suicide-data-analisys.R loaded sucessfully\n")

##gets the workspace dir for this script
print(getwd())
##change workspace dir to r-script
setwd("../")
##checks it out
print(getwd())

##now is possible to load some scripts
##just notice that the workspace dir now
##is the root for relative paths
##and no this scrips dir

source(file = "libUtils/utils.R")
source(file = "libPackages/setupPackages.R")
source(file = "libdata/dataUtils.R")
source(file = "libdata/readData.R")


##descricao url1
##visualizacao em http://tabnet.saude.prefeitura.sp.gov.br/cgi/tabcgi.exe?secretarias/saude/TABNET/SIM/obito.def
##dados sobre mortalidade
##linha -> causas especificas
##coluna -> meses do ano
##conteudo -> qtde obtidos residentes msp

url1 = "http://tabnet.saude.prefeitura.sp.gov.br/csv/A202503201_83_245_36.csv"
url1FileName="A202503201_83_245_36.csv"
##downloadDataFromUrl(url1,url1FileName);
dtaObj1 <- readCsv(url1FileName)
View(dtaObj1)






