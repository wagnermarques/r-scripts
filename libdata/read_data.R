#!/usr/bin/env Rscript
##https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html

## converts input from the old
##    West-European encoding ISO-8859-1 to Unicode.
##iconv -f ISO-8859-1 -t UTF-8 fileNameTccGlauc > fileNameTccGlaucIsoUtf8
options(encoding = 'iso-8859-1')
lineSeparator <- "-------------------------------------------------------------------"
	

##
## S O M E    D E F A U L T   V A L U E S
## 

##True if the name of the variables is in the first line of the file data
headerFlag    <-   T   

##field separator character
## for tab separator use "/t"
sepChar       <-  ";"  

##quote character for strings values  change to  "\"'"  for "
quoteChar     <-  ""   

##decimal point separator char
decChar       <-  "."

numeralsVector <-  c("allow.loss", "warn.loss", "no.loss")

## A vector of row names.
## 1) A vector giving the actual row names,
## 2) or a single number giving the column of the table which contains the row names,
## 3) or character string giving the name of the table column containing the row names.
## row.names = NULL forces row numbering.
rowNames      <-  NULL

## a vector of optional names for the variables.
## The default is to use "V" followed by the column number.
## colNames      <- col.names
colNames      <- NULL     	


## Default behavior of read.DIF is to convert character variables to factors.
## The variable as.is controls the conversion of columns not otherwise specified by colClasses.
## Its value is either
## 1) a vector of logicals (values are recycled if necessary),
## 2) or a vector of numeric or character indices which specify which columns should not be converted to factors.
## Note:
## In releases prior to R 2.12.1,
##    cells marked as being of character type were converted to logical,
##    numeric or complex using type.convert as in read.table.
## Note:
##    to suppress all conversions including those of numeric columns, set colClasses = "character".
## Note
##    as.is is specified per column (not per variable)
##    and so includes the column of row names (if any) and any columns to be skipped. 


#read.table(fileName, headerFlag, sepChar, quoteChar, decChar, numeralsVector,
#           rowNames, colNames, as.is = !stringsAsFactors,
#           na.strings = "NA", colClasses = NA, nrows = -1,
#           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
#           strip.white = FALSE, blank.lines.skip = TRUE,
#           comment.char = "#",
#           allowEscapes = FALSE, flush = FALSE,
#           stringsAsFactors = default.stringsAsFactors(),
#           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)



#read.csv(file, header = TRUE, sep = ",", quote = "\"",
#         dec = ".", fill = TRUE, comment.char = "", ...)

#read.csv2(file, header = TRUE, sep = ";", quote = "\"",\
#          dec = ",", fill = TRUE, comment.char = "", ...)

#read.delim(file, header = TRUE, sep = "\t", quote = "\"",
#           dec = ".", fill = TRUE, comment.char = "", ...)

#            dec = ",", fill = TRUE, comment.char = "", ...)

dataTccGlauc <- read.csv(fileNameTccGlauc,headerFlag,sepChar)
dta <- dataTccGlauc
#print(lineSeparator)
#print("S A M P L E   D A T A . .")
#print(dataTccGlauc[1:10,1:4])
#print(lineSeparator)

varNameToSampling <- "Inicio"
print(c("S A M P L E  ",varNameToSampling))
print(dataTccGlauc)
#print(length(dataTccGlauc$varNameToSampling))
print(lineSeparator)



print(lineSeparator)
print("V A R I A B L E S C O N F I G.......")
vars <- names(dataTccGlauc)
#dta$Caso 
dta$Sexo <- factor(dta$Sexo,levels=c(1,2),labels=c("Masculino","Feminino"))
summary(dta$Sexo)
dta$Idade
dta$Qtt.AF         
dta$AF.GM
dta$AF.Along
dta$Outras.AF
dta$Inicio
dta$Alergia
dta$Rinite
dta$Sinusite
dta$Chiado         
dta$Asma
dta$Bronquite
dta$Antec..MÃe
dta$Antec..IrmÃos
dta$Filhos
dta$HAS
dta$Arritmia
dta$Peso
dta$Altura
dta$IMC
dta$Classif.
dta$C..Cintura     
dta$Risco
dta$C..Quadril
dta$RCQ
dta$PFE.Esperado   
dta$Dif.do.esperado
dta$PFE.Rep.
dta$PFE.pos.EF
dta$DIF..PFE       
dta$Aum.Redu
dta$BIE
dta$PFE.pos.5.min
dta$DIF..PFE.1     
dta$Aum.Redu.1
dta$BIE.1
dta$PFE.pos.15.min
dta$DIF..PFE.2
dta$Aum.Redu.2
dta$BIE.2
dta$PFE.pos.25.min
dta$Dif.PFE        
dta$Aum.Redu.3
dta$BIE.3          


                                        
##varsMtx <- matrix(vars)
#varsMtx <- cbind(varsMtx,varsDesc)
#print(varsMtx)
print(lineSeparator)



#varSexoAsFactor <- as.factor(dataTccGlauc$Sexo)
#print(lineSeparator)
#print("Var Sexo...")
#summary(varSexoAsFactor)
#print(varSexoAsFactor)
#print(lineSeparator)

##print("Vars...")
##print(vars)

#Caso Sexo Idade Qtt.AF AF.GM AF.Along Outras.AF Inicio Alergia Rinite  Sinusite Chiado Asma Bronquite Antec..MÆe Antec..IrmÆos Filhos HAS Arritmia     Peso Altura   IMC  Classif. C..Cintura    Risco C..Quadril  RCQ    PFE.Esperado Dif.do.esperado PFE.Rep. PFE.pos.EF DIF..PFE Aum.Redu      BIE PFE.pos.5.min DIF..PFE.1 Aum.Redu.1    BIE.1 PFE.pos.15.min DIF..PFE.2    Aum.Redu.2    BIE.2 PFE.pos.25.min Dif.PFE Aum.Redu.3    BIE.3
