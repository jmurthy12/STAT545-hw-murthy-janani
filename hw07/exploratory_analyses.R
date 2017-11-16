library(tidyverse)
library(ggplot2)
library(Cairo)
library(RColorBrewer)


#Contents of this R Script:
#Perform exploratory analyses

#Save a couple descriptive plots to file with highly informative names.
# Bring the data in as data frame.
gapminder_tsv <- read_tsv("gapminder.tsv")

#Let's use Color Brewer from Homework 5
# Plotting Population Vs Year
ggplot( gapminder_tsv , aes( x = year , y = pop ) ) + 
	geom_point( size=2,aes( color = continent ) )+
	labs(title="Population vs Year") + 
	theme(plot.title=element_text(hjust=0.5))+
	scale_colour_brewer(palette="Set1")
ggsave("pop_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)

# Plotting GDP Per capita Vs Year
ggplot( gapminder_tsv , aes( x = year , y = gdpPercap ) ) + 
	geom_point(size=2, aes( color = continent ) )+
	labs(title="Population vs Year") + 
	theme(plot.title=element_text(hjust=0.5))+
	scale_colour_brewer(palette="Spectral")
ggsave("gdpPerCap_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)


#From : http://stat545.com/hw07_automation.html#i-want-to-aim-higher
#Are there variables you’re just willing to drop at this point? Do it!
#Are there annoying observations that require very special handling or crap up your figures (e.g. Oceania)? Drop them!

#Dropping Population and gdpPerCapita as it's already been explored in previous assignments.
gapminderData <- gapminder_tsv %>% 
	select( - pop , - gdpPercap ) %>% 
	filter( continent != "Oceania" )

#Plot Life Expectency Vs Year
ggplot( gapminderData , aes( x = year , y = lifeExp ) ) + 
	geom_point( size=2,aes( color = continent ) )+
	labs(title="LifeExp vs Year") + 
	theme(plot.title=element_text(hjust=0.5))+
	scale_colour_brewer(palette="Dark2")
ggsave("le_vs_year.png",device = "png",width = 15,height = 10,dpi = 600)


# facetting the above plot by continent, applying linear regression and saving to disk
ggplot( gapminderData , aes( x = year , y = lifeExp ) ) + 
	facet_wrap( ~ continent ) +
	geom_point(size=2,aes( color = continent ) ) +
	labs(title="LifeExpectancy vs Year") + 
	theme(plot.title=element_text(hjust=0.5))+
	geom_smooth( method = "lm", aes( color = "linear" ), lwd=0.5,se = FALSE )+
	theme_bw() +
	theme(strip.background = element_rect(fill="salmon"),
				axis.title = element_text(size=10),
				strip.text = element_text(size=10))
ggsave("le_vs_year_lin_fit.png")

#Reorder the continents based on life expectancy.
reorderLifeExpectancyContinents <- gapminderData %>% 
	mutate(continent=fct_reorder(continent,lifeExp))

#Sort the actual data in a deliberate fashion
# Let's group the data by continent and Lifeexpectancy and 
#arrange the gapminder results in ascending order of Life Expectancy
gapminderSortedLifeExpectancy <- gapminderData %>% 
	group_by( continent , lifeExp ) %>% 
	arrange( continent , lifeExp )

# writing the data to file for future use
write_tsv( gapminderSortedLifeExpectancy , "gapminderSortedLifeExpectancy.tsv" )