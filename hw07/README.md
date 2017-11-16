# Homework 7 - Automating Data-analysis Pipelines


The R Markdown file can be found [here.](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/hw_07-automating-data-analysis-pipeline.rmd)

And the Markdown file is available  [here.](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/hw_07-automating-data-analysis-pipeline.md)

### Report

Step 1: Data is downloaded from [here](https://github.com/jennybc/gapminder/blob/master/inst/gapminder.tsv)using [this R Script](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/downloadData.R)

Step 2: Exploratory analysis

[exploratory_analyses.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/exploratory_analyses.R) is executed with input/dependency as : "gapminder.tsv" to generate 4 PNG files :[pop_vs_year](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/pop_vs_year.png)[gdpPerCap_vs_year](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/gdpPerCap_vs_year.png) [le_vs_year]() [le_vs_year_lin_fit](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/le_vs_year.png) and the data file[gapminderSortedLifeExpectancy](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/gapminderSortedLifeExpectancy.tsv)

I grouped the data("gapminder.tsv") by continent and Lifeexpectancy and arranged the results in ascending order of Life Expectancy

Step 3: Statistical analysis

[statistical_analyses.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/statistical_analyses.R) is executed with input/dependency from data file generated from Step2 (gap_sort_conti_le.tsv) to generate 8 data files indicating best and worst countries for 4 different continents,they files are :[africaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaBestCountries.tsv) [africaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaWorstCountries.tsv) [americasBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasBestCountries.tsv)[americasWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasWorstCountries.tsv) [asiaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaBestCountries.tsv) [asiaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaWorstCountries.tsv) [europeBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeBestCountries.tsv)[europeWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeWorstCountries.tsv)


A function is created to run a linear model of life expectancy on year.
The model output is extracted using the 'broom' function.
A function is created to filter the best and worst countries based on the Slope values and the trends in Life Expectancy.

Step 4: Generate figures
[generate_figures.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/generate_figures.R) is executed with [africaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaBestCountries.tsv) [africaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaWorstCountries.tsv) [americasBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasBestCountries.tsv)[americasWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasWorstCountries.tsv) [asiaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaBestCountries.tsv) [asiaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaWorstCountries.tsv) [europeBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeBestCountries.tsv)[europeWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeWorstCountries.tsv) as dependency to generate 8 PNG files indicatign the best and worst countries for 4 differencr continents,the ouputPNG files are : [africaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaBestCountries.png)[africaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/africaWorstCountries.png)[asiaBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaBestCountries.png)[asiaWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/asiaWorstCountries.png)[americasBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasBestCountries.png)[americasWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/americasWorstCountries.png)[europeBestCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeBestCountries.png)[europeWorstCountries](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/europeWorstCountries.png)

In this R script I've generated scatterplots of life expectancy vs. year, faceting on country, fitted line overlaid.

Step 5:
[hw_07-automating-data-analysis-pipeline.rmd](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/hw_07-automating-data-analysis-pipeline.rmd) is knit  with 8 PNG files generated in step4 to generate the markdown document [hw_07-automating-data-analysis-pipeline.md](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/hw_07-automating-data-analysis-pipeline.md)

Step 6:
[hw_07-automating-data-analysis-pipeline.html] is rendered using "rmarkdown::render" on R markdown file [hw_07-automating-data-analysis-pipeline.rmd](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/hw_07-automating-data-analysis-pipeline.rmd) .


Step 7:
All the above files are added in the clean section of the [makeFile](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw07/Makefile)to make sure that output files are generated each time the make files is executed using the "Build All" option in R Studio.


Step 8: Markdown report
In my Markdown report I've included all the plots from above steps, along with the plots for 'best' and 'worst' countries.


### Report your process : You’re encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it’s a blog post, a fellow student, an online tutorial, etc.

Figuring out how makefile works on Windows system consumed a lot of time.
The remaining sections of writing R scripts for exploratory,statistical and generating plots were pretty simple and easy.
I did use few material from previous assignments.

###Progress Report along with Links to references.

 - [Jenny Bryan's example on Automation](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area)
 - [Example from Shaun Jackman](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/02_automation-example_r-and-make)
 - Material from previous homeworks were used for this Assignment.