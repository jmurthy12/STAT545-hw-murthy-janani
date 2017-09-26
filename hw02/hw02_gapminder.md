<https://github.com/jmurthy12/STAT545-hw02-murthy-janani>
================

Exploring Gapminder!
====================

### Bring rectangular data in

``` r
library(gapminder)
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

### Smell test the data

Explore the gapminder object:

1)Is it a data.frame, a matrix, a vector, a list?

Answer : List.Gapminder is a dataframe and a List.

``` r
is.data.frame(gapminder)
```

    ## [1] TRUE

``` r
is.list(gapminder)
```

    ## [1] TRUE

2)What's its class?

Answer : Class is dataframe and also a tibble.

``` r
class(gapminder)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
gapminder
```

    ## # A tibble: 1,704 x 6
    ##        country continent  year lifeExp      pop gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453
    ##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007
    ##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971
    ##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811
    ##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134
    ##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114
    ##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959
    ##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414
    ## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
    ## # ... with 1,694 more rows

OR

An alternative way is to find the number of rows and columns is mentioned below :

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

3)How many variables/columns?

Answer :There are 6 variables/coulmns . The Variables are : country,continent,year,lifeExp,pop and gdpPercap

``` r
gapminder
```

    ## # A tibble: 1,704 x 6
    ##        country continent  year lifeExp      pop gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453
    ##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007
    ##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971
    ##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811
    ##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134
    ##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114
    ##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959
    ##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414
    ## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
    ## # ... with 1,694 more rows

4)How many rows/observations?

Answer : There are 1,1704 rows/observartions

5)Can you get these facts about "extent" or "size" in more than one way? Can you imagine different functions being useful in different contexts?

Answer : Various methods/functions to find the "extent" or "size" are described below :

``` r
dim(gapminder)
```

    ## [1] 1704    6

``` r
nrow(gapminder)
```

    ## [1] 1704

``` r
ncol(gapminder)
```

    ## [1] 6

``` r
head(gapminder) #gives the number of columns and data tyoes for each column
```

    ## # A tibble: 6 x 6
    ##       country continent  year lifeExp      pop gdpPercap
    ##        <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan      Asia  1952  28.801  8425333  779.4453
    ## 2 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ## 3 Afghanistan      Asia  1962  31.997 10267083  853.1007
    ## 4 Afghanistan      Asia  1967  34.020 11537966  836.1971
    ## 5 Afghanistan      Asia  1972  36.088 13079460  739.9811
    ## 6 Afghanistan      Asia  1977  38.438 14880372  786.1134

``` r
length(gapminder) # gives the number of columns
```

    ## [1] 6

6)What data type is each variable?

``` r
class(gapminder$country)
```

    ## [1] "factor"

``` r
class(gapminder$continent)
```

    ## [1] "factor"

``` r
class(gapminder$year)
```

    ## [1] "integer"

``` r
class(gapminder$lifeExp)
```

    ## [1] "numeric"

``` r
class(gapminder$pop)
```

    ## [1] "integer"

``` r
class(gapminder$gdpPercap)
```

    ## [1] "numeric"

OR,

alternatively we could use the str() command

``` r
str(gapminder) # gives the consolidated data type for each variable/column.
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

``` r
summary(gapminder)
```

    ##         country        continent        year         lifeExp     
    ##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
    ##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
    ##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
    ##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
    ##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
    ##  Australia  :  12                  Max.   :2007   Max.   :82.60  
    ##  (Other)    :1632                                                
    ##       pop              gdpPercap       
    ##  Min.   :6.001e+04   Min.   :   241.2  
    ##  1st Qu.:2.794e+06   1st Qu.:  1202.1  
    ##  Median :7.024e+06   Median :  3531.8  
    ##  Mean   :2.960e+07   Mean   :  7215.3  
    ##  3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
    ##  Max.   :1.319e+09   Max.   :113523.1  
    ## 

### Explore individual variables :

1)Pick at least one categorical variable and at least one quantitative variable to explore.

Answer : Categorical variable : continent
Quantitative variable : life expectancy(lifeExp)

``` r
ContinentVar <- gapminder$continent
lifeExpVar <- gapminder$lifeExp
```

2)What are possible values (or range, whichever is appropriate) of each variable? What values are typical? What’s the spread? What’s the distribution? Etc., tailored to the variable at hand. Feel free to use summary stats, tables, figures. We’re NOT expecting high production value (yet).

``` r
continentTable <- table(ContinentVar)
continentTable
```

    ## ContinentVar
    ##   Africa Americas     Asia   Europe  Oceania 
    ##      624      300      396      360       24

``` r
hist(continentTable) #Distribution of Continent (Similar to frequency distribution)
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

``` r
range(lifeExpVar)
```

    ## [1] 23.599 82.603

``` r
hist(lifeExpVar) #Distribution of ife Expectency
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-2.png)

``` r
mean(lifeExpVar)
```

    ## [1] 59.47444

``` r
sd(lifeExpVar)
```

    ## [1] 12.91711

Needs further exploring!

``` r
gap_with_colors <-
data.frame(gapminder,
cc = I(country_colors[match(gapminder$country,
names(country_colors))]))
```

Explore various plot types
--------------------------

See the ggplot2 tutorial, which also uses the gapminder data, for ideas.

Make a few plots, probably of the same variable you chose to characterize numerically. Try to explore more than one plot type. Just as an example of what I mean:

    A scatterplot of two quantitative variables.

``` r
ggplot(gapminder, 
      aes(x=year, y=pop)) +
      geom_point(size = 4, color = "indianred4")
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

    A plot of one quantitative variable. Maybe a histogram or densityplot or frequency polygon.
    A plot of one quantitative variable and one categorical. Maybe boxplots for several continents or countries.

``` r
library("ggplot2")
plot(lifeExp~continent,data = gapminder, xlab= "Continent",ylab = "Life Expectency")
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

``` r
ggplot(gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point()
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-2.png)

``` r
ggplot(gapminder, aes(x =lifeExp, y = year))+
  geom_point()
```

![](hw02_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-3.png)
