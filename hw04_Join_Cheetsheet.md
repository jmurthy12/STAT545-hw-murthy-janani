hw04\_Join\_Cheetsheet
================

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

``` r
library(reshape2)
```

    ## 
    ## Attaching package: 'reshape2'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     smiths

### Join, merge, look up

#### Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a dplyr join function and make some observations about the process and result. Explore the different types of joins.

Solution:

Created second data frame with Country and its Capital City.

``` r
country_capitals <- data.frame(country=c("Australia","Austria","Belgium","China", "Italy", "Croatia", "Egypt", "Greece", "India"), capital=c("CANBERRA","VIENNA","BRUSSELS","BEIJING","ROME","ZAGREB","CAIRO","ATHENS","NEW DELHI"))
knitr::kable(country_capitals)
```

| country   | capital   |
|:----------|:----------|
| Australia | CANBERRA  |
| Austria   | VIENNA    |
| Belgium   | BRUSSELS  |
| China     | BEIJING   |
| Italy     | ROME      |
| Croatia   | ZAGREB    |
| Egypt     | CAIRO     |
| Greece    | ATHENS    |
| India     | NEW DELHI |

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

##### Left Join

left\_join() : Retains the column country in gapminder dataset and appends the capital city(New data) as a new column into the gampminder dataset. left\_join returns data from the second data frame aswell.Please note Column 7 in the below table (i.e. capital city)

``` r
Left_Join <-left_join(gapminder,country_capitals ,by = "country")
```

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
Left_Join %>% filter(country %in% c("Australia","Austria","Belgium","China", "Italy", "Croatia", "Egypt", "Greece", "India"))
```

    ## # A tibble: 108 x 7
    ##      country continent  year lifeExp      pop gdpPercap  capital
    ##        <chr>    <fctr> <int>   <dbl>    <int>     <dbl>   <fctr>
    ##  1 Australia   Oceania  1952   69.12  8691212  10039.60 CANBERRA
    ##  2 Australia   Oceania  1957   70.33  9712569  10949.65 CANBERRA
    ##  3 Australia   Oceania  1962   70.93 10794968  12217.23 CANBERRA
    ##  4 Australia   Oceania  1967   71.10 11872264  14526.12 CANBERRA
    ##  5 Australia   Oceania  1972   71.93 13177000  16788.63 CANBERRA
    ##  6 Australia   Oceania  1977   73.49 14074100  18334.20 CANBERRA
    ##  7 Australia   Oceania  1982   74.74 15184200  19477.01 CANBERRA
    ##  8 Australia   Oceania  1987   76.32 16257249  21888.89 CANBERRA
    ##  9 Australia   Oceania  1992   77.56 17481977  23424.77 CANBERRA
    ## 10 Australia   Oceania  1997   78.83 18565243  26997.94 CANBERRA
    ## # ... with 98 more rows

##### Anti Join

anti\_join() : Retains the coutries that are present in gapminder dataset but not in the second data set. And hence in the below example it only displays 1,596 rows(i.e Gapminder (1704 rows) - Second data set(108 rows)) anti\_join does not contain return any column of the second data set.

``` r
Anti_join<-anti_join(gapminder,country_capitals)
```

    ## Joining, by = "country"

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
Anti_join
```

    ## # A tibble: 1,596 x 6
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
    ## # ... with 1,586 more rows

##### Semi Join

Semi\_join() : Retains the countries that are common in both gapminder dataset and in the second data set.However,it does not return the column present in second data frame,hence the below table contains 6 columns only.

``` r
Semi_join<-semi_join(gapminder,country_capitals)
```

    ## Joining, by = "country"

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
Semi_join %>% filter(country %in% c("Australia","Austria","Belgium","China", "Italy", "Croatia", "Egypt", "Greece", "India"))
```

    ## # A tibble: 108 x 6
    ##      country continent  year lifeExp      pop gdpPercap
    ##       <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ##  1 Australia   Oceania  1952   69.12  8691212  10039.60
    ##  2 Australia   Oceania  1957   70.33  9712569  10949.65
    ##  3 Australia   Oceania  1962   70.93 10794968  12217.23
    ##  4 Australia   Oceania  1967   71.10 11872264  14526.12
    ##  5 Australia   Oceania  1972   71.93 13177000  16788.63
    ##  6 Australia   Oceania  1977   73.49 14074100  18334.20
    ##  7 Australia   Oceania  1982   74.74 15184200  19477.01
    ##  8 Australia   Oceania  1987   76.32 16257249  21888.89
    ##  9 Australia   Oceania  1992   77.56 17481977  23424.77
    ## 10 Australia   Oceania  1997   78.83 18565243  26997.94
    ## # ... with 98 more rows

##### Full Join

Full\_join() :Retains the countries from both gapminder and the second data set and appends additional information against each country.Updates unavailable data as NA in the last column(i.e..,column 7)

``` r
Full_join <-full_join(gapminder,country_capitals)
```

    ## Joining, by = "country"

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
Full_join %>% filter(country %in% c("Australia","Austria","Belgium","China", "Italy", "Croatia", "Egypt", "Greece", "India"))
```

    ## # A tibble: 108 x 7
    ##      country continent  year lifeExp      pop gdpPercap  capital
    ##        <chr>    <fctr> <int>   <dbl>    <int>     <dbl>   <fctr>
    ##  1 Australia   Oceania  1952   69.12  8691212  10039.60 CANBERRA
    ##  2 Australia   Oceania  1957   70.33  9712569  10949.65 CANBERRA
    ##  3 Australia   Oceania  1962   70.93 10794968  12217.23 CANBERRA
    ##  4 Australia   Oceania  1967   71.10 11872264  14526.12 CANBERRA
    ##  5 Australia   Oceania  1972   71.93 13177000  16788.63 CANBERRA
    ##  6 Australia   Oceania  1977   73.49 14074100  18334.20 CANBERRA
    ##  7 Australia   Oceania  1982   74.74 15184200  19477.01 CANBERRA
    ##  8 Australia   Oceania  1987   76.32 16257249  21888.89 CANBERRA
    ##  9 Australia   Oceania  1992   77.56 17481977  23424.77 CANBERRA
    ## 10 Australia   Oceania  1997   78.83 18565243  26997.94 CANBERRA
    ## # ... with 98 more rows

##### Inner Join

Inner\_join() :Retains the countries that are common to both gapminder dataset and the second data set and also, appends a new column for new information against each country.

``` r
Inner_join <-inner_join(gapminder,country_capitals)
```

    ## Joining, by = "country"

    ## Warning: Column `country` joining factors with different levels, coercing
    ## to character vector

``` r
Inner_join %>% filter(country %in% c("Australia","Austria","Belgium","China", "Italy", "Croatia", "Egypt", "Greece", "India"))
```

    ## # A tibble: 108 x 7
    ##      country continent  year lifeExp      pop gdpPercap  capital
    ##        <chr>    <fctr> <int>   <dbl>    <int>     <dbl>   <fctr>
    ##  1 Australia   Oceania  1952   69.12  8691212  10039.60 CANBERRA
    ##  2 Australia   Oceania  1957   70.33  9712569  10949.65 CANBERRA
    ##  3 Australia   Oceania  1962   70.93 10794968  12217.23 CANBERRA
    ##  4 Australia   Oceania  1967   71.10 11872264  14526.12 CANBERRA
    ##  5 Australia   Oceania  1972   71.93 13177000  16788.63 CANBERRA
    ##  6 Australia   Oceania  1977   73.49 14074100  18334.20 CANBERRA
    ##  7 Australia   Oceania  1982   74.74 15184200  19477.01 CANBERRA
    ##  8 Australia   Oceania  1987   76.32 16257249  21888.89 CANBERRA
    ##  9 Australia   Oceania  1992   77.56 17481977  23424.77 CANBERRA
    ## 10 Australia   Oceania  1997   78.83 18565243  26997.94 CANBERRA
    ## # ... with 98 more rows

#### Create your own cheatsheet patterned after mine but focused on something you care about more than comics

This is my [Join Cheetsheet](#Join%20Cheetsheet)
