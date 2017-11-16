library(tidyverse)
library(ggplot2)

# Import Asia's tsv files for Best and worst countries
asiaBestCountries <- read_tsv( "asiaBestCountries.tsv" )
asiaWorstCountries <- read_tsv( "asiaWorstCountries.tsv" )

# Import America's tsv files for Best and worst countries
americasBestCountries <- read_tsv( "americasBestCountries.tsv" )
americasWorstCountries <- read_tsv( "americasWorstCountries.tsv" )

# Import Europe's tsv files for Best and worst countries
europeBestCountries <- read_tsv( "europeBestCountries.tsv" )
europeWorstCountries <- read_tsv( "europeWorstCountries.tsv" )

# Import Africa's tsv files for Best and worst countries
africaBestCountries <- read_tsv( "africaBestCountries.tsv" )
africaWorstCountries <- read_tsv( "africaWorstCountries.tsv" )

# Generate figures
# scatterplots of life expectancy vs. year, faceting on country, fitted line overlaid.

#Life Expectancy Vs Year for Africa's 4 best countries
ggplot( africaBestCountries , aes( x = year , y = lifeExp ) ) + 
	geom_point(aes( color = country ) ) +
	facet_wrap( ~ country ) +
	labs(title="Life Expectancy Vs Year for Africa's 4 best countries")+
	geom_smooth( method = "lm" , se = FALSE )+ 
	theme_bw() +
	theme(strip.background = element_rect(fill="#66CC99"),
				axis.title = element_text(size=10),
				strip.text = element_text(size=10, face="bold"))
ggsave("africaBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)

#Life Expectancy Vs Year for Africa's 4 best countries
ggplot( africaWorstCountries , aes( x = year , y = lifeExp ) ) + 
	geom_point(aes( color = country ) ) +
	facet_wrap( ~ country ) +
	labs(title="Life Expectancy Vs Year for Africa's 4 worst countries")+
	geom_smooth( method = "lm" , se = FALSE )+ 
	theme_bw() +
	theme(strip.background = element_rect(fill="#CC6666"),
				axis.title = element_text(size=10),
				strip.text = element_text(size=10, face="bold"))
ggsave("africaWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)

#Life Expectancy Vs Year for Asia's 4 best countries
ggplot( asiaBestCountries , aes( x = year , y = lifeExp ) ) + 
	geom_point(aes( color = country ) ) +
	facet_wrap( ~ country ) +
	labs(title="Life Expectancy Vs Year for Asia's 4 best countries")+
	geom_smooth( method = "lm" , se = FALSE )+ 
	theme_bw() +
	theme(strip.background = element_rect(fill="#66CC99"),
				axis.title = element_text(size=10),
				strip.text = element_text(size=10, face="bold"))
ggsave("asiaBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)

#Life Expectancy Vs Year for Asia's 4 worst countries
ggplot( asiaWorstCountries , aes( x = year , y = lifeExp ) ) + 
	geom_point(aes( color = country ) ) +
	facet_wrap( ~ country ) +
	labs(title="Life Expectancy Vs Year for Asia's 4 worst countries")+
	geom_smooth( method = "lm" , se = FALSE )+ 
	theme_bw() +
	theme(strip.background = element_rect(fill="#CC6666"),
				axis.title = element_text(size=10),
				strip.text = element_text(size=10, face="bold"))
ggsave("asiaWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)

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
ggsave("americasBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)

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
ggsave("americasWorstCountries.png",device = "png",width = 10,height = 10,dpi = 600)

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
ggsave("europeBestCountries.png",device = "png",width = 10,height = 10,dpi = 600)

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
ggsave("europeWorstCountries.png",device = "png",width = 11,height = 10,dpi = 600)
