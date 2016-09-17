# r-scripts

my R scripts, started to lern R.

The goal is use R as a command line style, like examples below.
I'm using linux so for windows users may try but....

I'm working in my spare time and was started this project to learn R. Let code togheter?

The firt goal is to provide some descriptive statistics with nice
outputs.


## Installation
if you use fedora, like me: (TODO for other distros and windows) 

First things first....

```r
dnf update -y 
```

```r
dnf install -y R texlive-scheme-full

dnf install R-RCurl -y

dnf install libcurl-devel
dnf install libxml2-devel

dnf install libreoffice (to generate final output in odt file)

dnf install latex2html (its a interesting option if you have no spaces
in directory)

dnf install pandoc (a option to convert latex file to final output)

dnf install texlive-tex4ht

dnf install latex2rtf (another option, not works for me, but is a option)

```
The "R" is for R 
The  "texlive-scheme-full" is for to export pdf from latex (TODO)
The "R-RCurl" is for "RCurl" package works in the script

```r
git clone https://github.com/wagnermarques/r-scripts.git
git submodule init
git submodule update --recursive --remote
```

## usage

```r
cd r-script 
./run.R read-data pesq-abandono-etec211-bk.ods

```
and to generate final .odt file, copy the r-script output directory
automatically generated at each run.R command issued and pass to
procude-openoffice-output subcomand 
```r
[wagner@localhost r-scripts]$ ./run.R produce-openoffice-output Output_10_Set_2016_19:00:22
```



## To produce final output with xtables in html and in odt:
1. Use the terminal
2. change to r-script/util
3. Run ./produce_final_output.sh script and pass the last ouptut
   directory of last r-script execution (./run.R read-data
   pesq-abandono-etec211-bk.ods)



The "samples" "suicide-data-analisys" witches is to say... run the
"suicide-data-analisys" sample analisys from default script "samples".


