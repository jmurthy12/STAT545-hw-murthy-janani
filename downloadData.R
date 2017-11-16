##This part of code is from Jenny's tutorial: https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/01_automation-example_just-r
# loading the necessary packages
library(downloader)

## Download the gapminder raw data from the URL and save it as a .tsv file
download( url = "https://github.com/jennybc/gapminder/blob/master/inst/extdata/gapminder.tsv" , 
          destfile = "gapminder.tsv")