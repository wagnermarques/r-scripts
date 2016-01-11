#!/usr/bin/env Rscript

cat('CONFIGURANDO VARIAVEIS PARA EXECUCAO DESTE SCRIPT...\n')
cat("----------------------------------------------------------------------\n")

args <- commandArgs(trailingOnly = F)  
scriptPath <- normalizePath(dirname(sub("^--file=", "", args[grep("^--file=", args)])))

scriptWorkspace <- scriptPath
print(paste("scriptWorkspace",scriptWorkspace, sep=" => "))

scriptWorkspaceLibDirectory <- paste(scriptWorkspace, "lib", sep='/')
print(paste("scriptWorkspaceLibDirectory",scriptWorkspaceLibDirectory, sep=" => "))

scriptWorkspaceDownloadDestFilesDirectory <- paste(scriptWorkspace, "destFiles",sep='/')
print(paste("scriptWorkspaceDownloadDestFilesDirectory",scriptWorkspaceDownloadDestFilesDirectory, sep=" => "))
cat("\n\n");

cat("CONFIGURANDO DIRETORIO LIB DENTRO DO WORKSPACE PARA BAIXAR OS PACORES DO R... \n")
cat("----------------------------------------------------------------------\n")

##http://stackoverflow.com/questions/30809544/where-to-install-r-packages-on-linux-server-that-are-to-be-used-by-multiple-user
.libPaths( c(.libPaths(), paste(scriptWorkspace,"lib",sep="/")))
print(.libPaths())
cat("\n\n");

##pegando os argumentos do script
##scriptArgs <- commandArgs(trailingOnly=TRUE)


cat("URLS IMPORTANTES PARA DOWNLOAD DOS DADOS \n")
cat("----------------------------------------------------------------------\n")

ftpDatasusBASE <- 'ftp://ftp.datasus.gov.br/'
ftpDatasusSIHSUS <- 'dissemin/publicos/SIHSUS/'

rowsCsvURL <- "https://cdph.data.ca.gov/api/views/ezms-cei8/rows.csv?accessType=DOWNLOAD"
rowsCsvUrlFileName <- "cdph.data.ca.gov.rows.csv"


print(paste("ftpDatasusBASE ",ftpDatasusBASE,sep="=>"))
print(paste("ftpDatasusSIHSUS ",ftpDatasusSIHSUS,sep="=>"))      
cat("\n\n");

##Estes outros script vao fornecer funcoes que vamos utilizar nesse nosso script
source ("handle_parameters.R")
source ("getData.R")
#source ("data.R")



downloadFile("https://cdph.data.ca.gov/api/views/ezms-cei8/rows.csv?accessType=DOWNLOAD","raw.csv")


