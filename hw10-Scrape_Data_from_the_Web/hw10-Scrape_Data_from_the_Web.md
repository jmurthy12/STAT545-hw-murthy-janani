hw10-Scrape\_Data\_from\_the\_Web
================

Task : Make API queries “by hand” using httr
--------------------------------------------

``` r
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'tidyverse' was built under R version 3.4.3

    ## Warning: package 'ggplot2' was built under R version 3.4.3

    ## Warning: package 'tibble' was built under R version 3.4.3

    ## Warning: package 'purrr' was built under R version 3.4.3

    ## Warning: package 'forcats' was built under R version 3.4.3

``` r
suppressPackageStartupMessages(library(jsonlite))
```

    ## Warning: package 'jsonlite' was built under R version 3.4.3

``` r
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(forcats))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(httr))
```

    ## Warning: package 'httr' was built under R version 3.4.3

``` r
suppressPackageStartupMessages(library(repurrrsive))
```

    ## Warning: package 'repurrrsive' was built under R version 3.4.3

``` r
suppressPackageStartupMessages(library(listviewer))
suppressPackageStartupMessages(library(glue))
```

Below code is from Jenny's Git :

``` r
## determines number of pages implied by link header in httr response
n_pages <- . %>%
  headers() %>%
  .[["link"]] %>%
  str_split(",") %>%
  .[[1]] %>%
  str_subset('rel=\"last\"') %>%
  str_match("\\?page=([0-9]+)") %>%
  .[ , 2, drop = TRUE] %>%
  as.integer()
```

Below code is from Jenny's Git :

``` r
## books
## how many books? = # of pages at pageSize = 1
resp <- GET("http://www.anapioficeandfire.com/api/books?pageSize=1")
(n_books <- resp %>% n_pages())
```

    ## [1] 12

``` r
## 12 books

## characters
resp <- GET("http://www.anapioficeandfire.com/api/characters?pageSize=1")
(n_characters <- resp %>% n_pages())
```

    ## [1] 2134

``` r
## 2134 characters?!?

## houses
resp <- GET("http://www.anapioficeandfire.com/api/houses?pageSize=1")
(n_houses <- resp %>% n_pages())
```

    ## [1] 444

``` r
## 444 houses?!?
```

So now we know that there are :

1.  12 Books

2.  2134 characters ,and,

3.  444 houses.

### Get multiple items via the API (i.e. an endpoint that returns multiple items at once) vs. use an iterative framework in R.

My reference for the below code on scrapping data is from [here](https://cran.r-project.org/web/packages/jsonlite/vignettes/json-paging.html)

Let's get the characters from the API

``` r
my_url <- "http://www.anapioficeandfire.com/api/characters/"
characters <- list()
```

### Traverse pages

``` r
for(i in 1:72){
  mydata <- GET(paste0(my_url, "?page=", i, '&pageSize=30'))
  characters[[i]] <- content(mydata, as='parsed')
}

characters[[1]][[12]]
```

    ## $url
    ## [1] "https://www.anapioficeandfire.com/api/characters/12"
    ## 
    ## $name
    ## [1] "Balon Greyjoy"
    ## 
    ## $gender
    ## [1] "Male"
    ## 
    ## $culture
    ## [1] ""
    ## 
    ## $born
    ## [1] ""
    ## 
    ## $died
    ## [1] "299 AC, at Pyke"
    ## 
    ## $titles
    ## $titles[[1]]
    ## [1] "Iron King"
    ## 
    ## $titles[[2]]
    ## [1] "King of the Isles and the North"
    ## 
    ## $titles[[3]]
    ## [1] "King of Salt and Rock"
    ## 
    ## $titles[[4]]
    ## [1] "Son of the Sea Wind"
    ## 
    ## $titles[[5]]
    ## [1] "Lord Reaper of Pyke"
    ## 
    ## $titles[[6]]
    ## [1] "The Greyjoy"
    ## 
    ## $titles[[7]]
    ## [1] "Captain of the Great Kraken"
    ## 
    ## 
    ## $aliases
    ## $aliases[[1]]
    ## [1] "Balon the Brave"
    ## 
    ## $aliases[[2]]
    ## [1] "Balon the Blessed"
    ## 
    ## $aliases[[3]]
    ## [1] "Balon the Twice Crowned"
    ## 
    ## $aliases[[4]]
    ## [1] "Balon the Widowmaker"
    ## 
    ## $aliases[[5]]
    ## [1] "The Kraken King"
    ## 
    ## 
    ## $father
    ## [1] "https://www.anapioficeandfire.com/api/characters/836"
    ## 
    ## $mother
    ## [1] ""
    ## 
    ## $spouse
    ## [1] "https://www.anapioficeandfire.com/api/characters/66"
    ## 
    ## $allegiances
    ## list()
    ## 
    ## $books
    ## $books[[1]]
    ## [1] "https://www.anapioficeandfire.com/api/books/1"
    ## 
    ## $books[[2]]
    ## [1] "https://www.anapioficeandfire.com/api/books/2"
    ## 
    ## $books[[3]]
    ## [1] "https://www.anapioficeandfire.com/api/books/3"
    ## 
    ## $books[[4]]
    ## [1] "https://www.anapioficeandfire.com/api/books/5"
    ## 
    ## $books[[5]]
    ## [1] "https://www.anapioficeandfire.com/api/books/8"
    ## 
    ## 
    ## $povBooks
    ## list()
    ## 
    ## $tvSeries
    ## $tvSeries[[1]]
    ## [1] "Season 2"
    ## 
    ## $tvSeries[[2]]
    ## [1] "Season 3"
    ## 
    ## $tvSeries[[3]]
    ## [1] "Season 6"
    ## 
    ## 
    ## $playedBy
    ## $playedBy[[1]]
    ## [1] "Patrick Malahide"

Similarly,Let's get books from the API

``` r
## This is not my code, taken from the previous link. Modified by me
my_url <- "http://www.anapioficeandfire.com/api/books/"
books <- list()

### Traverse pages
for(i in 1:72){
  mydata <- GET(paste0(my_url, "?page=", i, '&pageSize=30'))
  books[[i]] <- content(mydata, as='parsed')
}


#Let's test this for book name : "A Knight of the Seven Kingdoms"
books[[1]][[12]]
```

    ## $url
    ## [1] "https://www.anapioficeandfire.com/api/books/12"
    ## 
    ## $name
    ## [1] "A Knight of the Seven Kingdoms"
    ## 
    ## $isbn
    ## [1] "978-0345533487"
    ## 
    ## $authors
    ## $authors[[1]]
    ## [1] "George R. R. Martin"
    ## 
    ## 
    ## $numberOfPages
    ## [1] 368
    ## 
    ## $publisher
    ## [1] "Bantam Books"
    ## 
    ## $country
    ## [1] "United States"
    ## 
    ## $mediaType
    ## [1] "Hardcover"
    ## 
    ## $released
    ## [1] "2015-10-06T00:00:00"
    ## 
    ## $characters
    ## list()
    ## 
    ## $povCharacters
    ## list()

Similarly,Let's get the houses from the API

``` r
## This is not my code, taken from the previous link. Modified by me
my_url <- "http://www.anapioficeandfire.com/api/houses/"
houses <- list()

##Traverse pages
for(i in 1:14){
  mydata <- GET(paste0(my_url, "?page=", i, '&pageSize=30'))
  houses[[i]] <- content(mydata, as='parsed')
}

#Let's read the data for house name : "House Baelish of Harrenhal"
houses[[1]][[10]]
```

    ## $url
    ## [1] "https://www.anapioficeandfire.com/api/houses/10"
    ## 
    ## $name
    ## [1] "House Baelish of Harrenhal"
    ## 
    ## $region
    ## [1] "The Riverlands"
    ## 
    ## $coatOfArms
    ## [1] "A field of silver mockingbirds, on a green field(Vert, semé of mockingbirds argent)"
    ## 
    ## $words
    ## [1] ""
    ## 
    ## $titles
    ## $titles[[1]]
    ## [1] "Lord Paramount of the Trident"
    ## 
    ## $titles[[2]]
    ## [1] "Lord of Harrenhal"
    ## 
    ## 
    ## $seats
    ## $seats[[1]]
    ## [1] "Harrenhal"
    ## 
    ## 
    ## $currentLord
    ## [1] "https://www.anapioficeandfire.com/api/characters/823"
    ## 
    ## $heir
    ## [1] ""
    ## 
    ## $overlord
    ## [1] "https://www.anapioficeandfire.com/api/houses/16"
    ## 
    ## $founded
    ## [1] "299 AC"
    ## 
    ## $founder
    ## [1] "https://www.anapioficeandfire.com/api/characters/823"
    ## 
    ## $diedOut
    ## [1] ""
    ## 
    ## $ancestralWeapons
    ## $ancestralWeapons[[1]]
    ## [1] ""
    ## 
    ## 
    ## $cadetBranches
    ## list()
    ## 
    ## $swornMembers
    ## $swornMembers[[1]]
    ## [1] "https://www.anapioficeandfire.com/api/characters/651"
    ## 
    ## $swornMembers[[2]]
    ## [1] "https://www.anapioficeandfire.com/api/characters/804"
    ## 
    ## $swornMembers[[3]]
    ## [1] "https://www.anapioficeandfire.com/api/characters/823"
    ## 
    ## $swornMembers[[4]]
    ## [1] "https://www.anapioficeandfire.com/api/characters/957"
    ## 
    ## $swornMembers[[5]]
    ## [1] "https://www.anapioficeandfire.com/api/characters/970"

### Scraping data from OMDB API

I requested for API key = e1abcd4f

As discussed in class : Create a function to query movie

``` r
get_movie_TY <- function(title,year){
  
  query_string <- glue("http://www.omdbapi.com/?t={title}&y={year}&APIkey=e1abcd4f")
  movie_result <-GET(query_string)
  movie_content <- as.data.frame(content(movie_result))
  return(movie_content)
  
}
```

``` r
babe_df <- get_movie_TY("babe","1995")
knitr::kable(babe_df)
```

| Title | Year | Rated | Released    | Runtime | Genre                 | Director     | Writer                                                                         | Actors                                                          | Plot                                                                                          | Language | Country        | Awards                                         | Poster                                                                                                                                            | Ratings.Source          | Ratings.Value | Ratings.Source.1 | Ratings.Value.1 | Ratings.Source.2 | Ratings.Value.2 | Metascore | imdbRating | imdbVotes | imdbID    | Type  | DVD         | BoxOffice | Production         | Website | Response |
|:------|:-----|:------|:------------|:--------|:----------------------|:-------------|:-------------------------------------------------------------------------------|:----------------------------------------------------------------|:----------------------------------------------------------------------------------------------|:---------|:---------------|:-----------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------|:--------------|:-----------------|:----------------|:-----------------|:----------------|:----------|:-----------|:----------|:----------|:------|:------------|:----------|:-------------------|:--------|:---------|
| Babe  | 1995 | G     | 04 Aug 1995 | 91 min  | Comedy, Drama, Family | Chris Noonan | Dick King-Smith (novel), George Miller (screenplay), Chris Noonan (screenplay) | Christine Cavanaugh, Miriam Margolyes, Danny Mann, Hugo Weaving | Babe, a pig raised by sheepdogs, learns to herd sheep with a little help from Farmer Hoggett. | English  | Australia, USA | Won 1 Oscar. Another 18 wins & 23 nominations. | <https://images-na.ssl-images-amazon.com/images/M/MV5BYjg4ZjUzMzMtYzlmYi00YTcwLTlkOWUtYWFmY2RhNjliODQzXkEyXkFqcGdeQXVyNTUyMzE4Mzg@._V1_SX300.jpg> | Internet Movie Database | 6.8/10        | Rotten Tomatoes  | 97%             | Metacritic       | 83/100          | 83        | 6.8        | 101,166   | tt0112431 | movie | 23 Sep 2003 | N/A       | Universal Pictures | N/A     | True     |

``` r
titanic_df <- get_movie_TY("Titanic","1997")
knitr::kable(titanic_df)
```

| Title   | Year | Rated | Released    | Runtime | Genre          | Director      | Writer        | Actors                                                   | Plot                                                                                                                      | Language         | Country | Awards                                            | Poster                                                                                                                                            | Ratings.Source          | Ratings.Value | Ratings.Source.1 | Ratings.Value.1 | Ratings.Source.2 | Ratings.Value.2 | Metascore | imdbRating | imdbVotes | imdbID    | Type  | DVD         | BoxOffice | Production         | Website                        | Response |
|:--------|:-----|:------|:------------|:--------|:---------------|:--------------|:--------------|:---------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------|:-----------------|:--------|:--------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------|:--------------|:-----------------|:----------------|:-----------------|:----------------|:----------|:-----------|:----------|:----------|:------|:------------|:----------|:-------------------|:-------------------------------|:---------|
| Titanic | 1997 | PG-13 | 19 Dec 1997 | 194 min | Drama, Romance | James Cameron | James Cameron | Leonardo DiCaprio, Kate Winslet, Billy Zane, Kathy Bates | A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic. | English, Swedish | USA     | Won 11 Oscars. Another 110 wins & 75 nominations. | <https://images-na.ssl-images-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg> | Internet Movie Database | 7.8/10        | Rotten Tomatoes  | 88%             | Metacritic       | 74/100          | 74        | 7.8        | 869,216   | tt0120338 | movie | 10 Sep 2012 | N/A       | Paramount Pictures | <http://www.titanicmovie.com/> | True     |

Let's explore using JSON

``` r
GuardiansOfGalaxy <- GET("http://www.omdbapi.com/?i=tt3896198&apikey=e1abcd4f")
GuardiansOfGalaxy$status_code
```

    ## [1] 200

``` r
GuardiansOfGalaxy$headers
```

    ## $date
    ## [1] "Fri, 08 Dec 2017 04:35:12 GMT"
    ## 
    ## $`content-type`
    ## [1] "application/json; charset=utf-8"
    ## 
    ## $`transfer-encoding`
    ## [1] "chunked"
    ## 
    ## $connection
    ## [1] "keep-alive"
    ## 
    ## $`cache-control`
    ## [1] "public, max-age=86400"
    ## 
    ## $expires
    ## [1] "Sat, 09 Dec 2017 04:35:12 GMT"
    ## 
    ## $`last-modified`
    ## [1] "Fri, 08 Dec 2017 03:57:06 GMT"
    ## 
    ## $vary
    ## [1] "*, Accept-Encoding"
    ## 
    ## $`x-aspnet-version`
    ## [1] "4.0.30319"
    ## 
    ## $`x-powered-by`
    ## [1] "ASP.NET"
    ## 
    ## $`access-control-allow-origin`
    ## [1] "*"
    ## 
    ## $`cf-cache-status`
    ## [1] "HIT"
    ## 
    ## $server
    ## [1] "cloudflare-nginx"
    ## 
    ## $`cf-ray`
    ## [1] "3c9d0441c17f29e3-SEA"
    ## 
    ## $`content-encoding`
    ## [1] "gzip"
    ## 
    ## attr(,"class")
    ## [1] "insensitive" "list"
