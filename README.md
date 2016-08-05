# r-scripts

my R scripts

The goal is use R as a command line style, like examples below.
I'm using linux so for windows users may try but....

I'm working in my spare time and was started to learn R. Let code togheter?

The firt goas is provide some descriptive statistics with nice outputs.


## Installation
if you in fedora, like me: (TODO for other distros and windows) 

First things first....
```r
dnf update -y 
```

```r
dnf install -y R texlive-scheme-full
dnf install R-RCurl -y
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
./run.R (without parameter, so that in a very first time the script
can install the R packages to use)

./run.R samples suicide-data-analisys
```
The "samples" "suicide-data-analisys" witches is to say... run the
"suicide-data-analisys" sample analisys from default script "samples".


