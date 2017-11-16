Automating data analysis pipelines
================

``` r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(forcats))
suppressPackageStartupMessages(library(broom))
```

Table of Contents
=================

-   [Perform exploratory analyses](#Perform-exploratory-analyses)
-   [Perform statistical analyses](#Perform-statistical-analyses)
-   [Generate figures](#Generate-figures)
-   [Automate the pipeline](#Automate-the-pipeline)

### Perform exploratory analyses

#### Brought the data in as data frame using R Script:"downloadData.R"

``` r
gapminder_tsv <- read_tsv("gapminder.tsv")
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double(),
    ##   pop = col_integer(),
    ##   gdpPercap = col_double()
    ## )

#### Saved a couple descriptive plots to file with highly informative names using R Script :"exploratory\_analyses.R"

        -Plot of gdpPerCap Versus Year for each continent
        

``` r
ggplot( gapminder_tsv , aes( x = year , y = gdpPercap ) ) + 
    geom_point(size=2, aes( color = continent ) )+
    labs(title="GDP Per Capita vs Year") + 
    theme(plot.title=element_text(hjust=0.5))+
    scale_colour_brewer(palette="Spectral")
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
ggsave("gdpPerCap_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)
```

        -Plot of Population Versus Year for each continent
        

``` r
ggplot( gapminder_tsv , aes( x = year , y = pop ) ) + 
    geom_point( size=2,aes( color = continent ) )+
    labs(title="Population vs Year") + 
    theme(plot.title=element_text(hjust=0.5))+
    scale_colour_brewer(palette="Set1")
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
ggsave("pop_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)
```

        -Dropping Population and gdpPerCapita and the continent Oceania, as they've been explored in previous assignments.
        

``` r
gapminderData <- gapminder_tsv %>% 
    select( - pop , - gdpPercap ) %>% 
    filter( continent != "Oceania" )
```

-   Plot of Life Expectancy Versus Year

``` r
  ggplot( gapminderData , aes( x = year , y = lifeExp ) ) + 
    geom_point( size=2,aes( color = continent ) )+
    labs(title="Life Expectancy vs Year") + 
    theme(plot.title=element_text(hjust=0.5))+
    scale_colour_brewer(palette="Dark2")
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

``` r
ggsave("le_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)
```

-   Reorder the continents based on life expectancy.

``` r
reorderLifeExpectancyContinents <- gapminderData %>% 
    mutate(continent=fct_reorder(continent,lifeExp))
```

-   Sort the actual data in a deliberate fashion. You decide the details, but this should at least implement your new continent ordering.

``` r
gapminderSortedLifeExpectancy <- gapminderData %>% 
    group_by( continent , lifeExp ) %>% 
    arrange( continent , lifeExp )
```

-   Write the Gapminder data to file(s), for immediate and future reuse

``` r
write_tsv( gapminderSortedLifeExpectancy , "gapminderSortedLifeExpectancy.tsv" )
```

### Perform statistical analyses using R Script :statistical\_analyses.R"

-   Import the gapminderSortedLifeExpectancy.tsv created in the first script in the second script :statistical\_analyses.R

-   Fit a linear regression of life expectancy on year within each country. Write the estimated intercepts, slopes, and residual error variance (or sd) to file. The R package broom may be useful here.

-   Linear fit using Broom package

``` r
gapminderLinearFit_Broom <- gapminderSortedLifeExpectancy %>% 
    group_by( continent , country ) %>% 
    do( fit = lm( lifeExp ~ I( year - 1952 ) , . ) )
```

-   Let's use broom's tidy() learnt in Homework 6 to extract more information on Linear Regression

``` r
gapminderLinearFit_Estimates <- gapminderLinearFit_Broom %>% 
    tidy( fit ) %>%  
    spread( key = "term" , value = "estimate" ) %>% 
    rename(Slope = `I(year - 1952)` )
```

    - Find the 3 or 4 worst and best countries for each continent. You decide the details.

-   This function selects 4 best countries for a given COntinent based on Slope value.

``` r
filterSort_best_countries <- function( continent_selected ){
    result <-  gapminderLinearFit_Estimates %>% 
        filter( continent == continent_selected ) %>% 
        group_by( continent ) %>% 
        filter(min_rank(desc( Slope )) < 5 )
    return( result )
}
```

-   This function selects 4 worst countries for a given COntinent based on Slope value.

``` r
filterSort_worst_countries <- function( continent_selected ){
    result <-  gapminderLinearFit_Estimates %>% 
        filter( continent == continent_selected ) %>% 
        group_by( continent ) %>% 
        filter( min_rank((Slope ) ) < 5 )
    return( result )
}
```

-   Generate figures
    -   Create a figure for each continent, and write one file per continent, with an informative name. The figure should give scatterplots of life expectancy vs. year, faceting on country, fitted line overlaid. generate\_figures.R is used to generate Plots.

###### 1)Import the files saved using the second R Script.

``` r
 # Import Asia's tsv files for Best and worst countries
asiaBestCountries <- read_tsv( "asiaBestCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
asiaWorstCountries <- read_tsv( "asiaWorstCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
 # Import America's tsv files for Best and worst countries
americasBestCountries <- read_tsv( "americasBestCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
americasWorstCountries <- read_tsv( "americasWorstCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
 # Import Europe's tsv files for Best and worst countries
europeBestCountries <- read_tsv( "europeBestCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
europeWorstCountries <- read_tsv( "europeWorstCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
 # Import Africa's tsv files for Best and worst countries
africaBestCountries <- read_tsv( "africaBestCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

``` r
africaWorstCountries <- read_tsv( "africaWorstCountries.tsv" )
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   continent = col_character(),
    ##   year = col_integer(),
    ##   lifeExp = col_double()
    ## )

###### 2)scatterplots of life expectancy vs. year, faceting on country, fitted line overlaid.

-   Life Expectancy Vs Year for Africa's 4 best countries

``` r
ggplot( africaBestCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Africa's 4 best countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#66CC99"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png)

``` r
ggsave("africaBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for Africa's 4 best countries

``` r
ggplot( africaWorstCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Africa's 4 worst countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#CC6666"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)

``` r
ggsave("africaWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for Asia's 4 best countries

``` r
ggplot( asiaBestCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Asia's 4 best countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#66CC99"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

``` r
ggsave("asiaBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for Asia's 4 worst countries

``` r
ggplot( asiaWorstCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Asia's 4 worst countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#CC6666"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-18-1.png)

``` r
ggsave("asiaWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for America's 4 best countries

``` r
 #Life Expectancy Vs Year for America's 4 best countries
ggplot( americasBestCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for America's 4 best countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#66CC99"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-19-1.png)

``` r
ggsave("americasBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for America's 4 worst countries

``` r
 #Life Expectancy Vs Year for America's 4 worst countries
ggplot( americasWorstCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for America's 4 worst countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#CC6666"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-20-1.png)

``` r
ggsave("americasWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for Europe's 4 best countries

``` r
 #Life Expectancy Vs Year for Europe's 4 best countries
ggplot( europeBestCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Europe's 4 best countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#66CC99"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-21-1.png)

``` r
ggsave("europeBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)
```

-   Life Expectancy Vs Year for Europe's 4 worst countries

``` r
 #Life Expectancy Vs Year for Europe's 4 worst countries
ggplot( europeWorstCountries , aes( x = year , y = lifeExp ) ) + 
    geom_point(aes( color = country ) ) +
    facet_wrap( ~ country ) +
    labs(title="Life Expectancy Vs Year for Europe's 4 worst countries")+
    geom_smooth( method = "lm" , se = FALSE )+ 
    theme_bw() +
    theme(strip.background = element_rect(fill="#CC6666"),
                axis.title = element_text(size=10),
                strip.text = element_text(size=10, face="bold"))
```

![](hw_07-automating-data-analysis-pipeline_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-22-1.png)

``` r
ggsave("europeWorstCountries.png",device = "png",width = 11,height = 10,dpi = 600)
```
