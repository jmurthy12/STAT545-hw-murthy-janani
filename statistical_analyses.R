library(tidyverse)
library(broom)

#Importing the re-ordered gapminder file
gapminderSorytedLifeExpectancy <- read_tsv("gapminderSortedLifeExpectancy.tsv")

# Linear fit using Broom package
gapminderLinearFit_Broom <- gapminderSorytedLifeExpectancy %>% 
	group_by( continent , country ) %>% 
	do( fit = lm( lifeExp ~ I( year - 1952 ) , . ) )

# Let's use broom's tidy() learnt in Homework 6 to extract more information on Linear Regression
gapminderLinearFit_Estimates <- gapminderLinearFit_Broom %>% 
	tidy( fit ) %>%  
	spread( key = "term" , value = "estimate" ) %>% 
	rename(Slope = `I(year - 1952)` )

# This function selects 4 best countries for a given COntinent based on Slope value. 
filterSort_best_countries <- function( continent_selected ){
	result <-  gapminderLinearFit_Estimates %>% 
		filter( continent == continent_selected ) %>% 
		group_by( continent ) %>% 
		filter(min_rank(desc( Slope )) < 5 )
	return( result )
}

# This function selects 4 worst countries for a given COntinent based on Slope value. 
filterSort_worst_countries <- function( continent_selected ){
	result <-  gapminderLinearFit_Estimates %>% 
		filter( continent == continent_selected ) %>% 
		group_by( continent ) %>% 
		filter( min_rank((Slope ) ) < 5 )
	return( result )
}


#Best and Worst Countries for Continent:Asia
asiaBestCountries <- filterSort_best_countries("Asia")
asiaWorstCountries <- filterSort_worst_countries("Asia")

asiaBestCountries <- semi_join( gapminderSorytedLifeExpectancy , asiaBestCountries )
asiaWorstCountries <- semi_join( gapminderSorytedLifeExpectancy , asiaWorstCountries )


# Write the data to file 
write_tsv( asiaBestCountries , "asiaBestCountries.tsv" )
write_tsv( asiaWorstCountries , "asiaWorstCountries.tsv" )


#Best and Worst Countries for Continent:Americas
americasBestCountries <- filterSort_best_countries("Americas")
americasWorstCountries <- filterSort_worst_countries("Americas")

americasBestCountries <- semi_join( gapminderSorytedLifeExpectancy , americasBestCountries )
americasWorstCountries <- semi_join( gapminderSorytedLifeExpectancy , americasWorstCountries )

# Write the data to file 
write_tsv( americasBestCountries , "americasBestCountries.tsv" )
write_tsv( americasWorstCountries , "americasWorstCountries.tsv" )


#Best and Worst Countries for Continent:Europe
europeBestCountries <- filterSort_best_countries("Europe")
europeWorstCountries <- filterSort_worst_countries("Europe")

europeBestCountries <- semi_join( gapminderSorytedLifeExpectancy , europeBestCountries )
europeWorstCountries <- semi_join( gapminderSorytedLifeExpectancy , europeWorstCountries )

# Write the data to file 
write_tsv( europeBestCountries , "europeBestCountries.tsv" )
write_tsv( europeWorstCountries , "europeWorstCountries.tsv" )


#Best and Worst Countries for Continent:Africa
africaBestCountries <- filterSort_best_countries("Africa")
africaWorstCountries <- filterSort_worst_countries("Africa")

africaBestCountries <- semi_join( gapminderSorytedLifeExpectancy , africaBestCountries )
africaWorstCountries <- semi_join( gapminderSorytedLifeExpectancy , africaWorstCountries )

# Write the data to file 
write_tsv( africaBestCountries , "africaBestCountries.tsv" )
write_tsv( africaWorstCountries , "africaWorstCountries.tsv" )
