.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

all: hw_07-automating-data-analysis-pipeline.md hw_07-automating-data-analysis-pipeline.html

clean: 
				rm -f gapminder.tsv
				rm -f le_vs_year.png pop_vs_year.png gdpPerCap_vs_year.png le_vs_year_lin_fit.png  gapminderSorytedLifeExpectancy.tsv
				rm -f asiaBestCountries.tsv asiaWorstCountries.tsv americasBestCountries.tsv americasWorstCountries.tsv europeBestCountries.tsv europeWorstCountries.tsv africaBestCountries.tsv africaWorstCountries.tsv
				rm -f asiaBestCountries.png asiaWorstCountries.png americasBestCountries.png americasWorstCountries.png europeBestCountries.png europeWorstCountries.png
				rm -f hw_07-automating-data-analysis-pipeline.md hw_07-automating-data-analysis-pipeline.html

gapminder.tsv: downloadData.R
				Rscript $<

le_vs_year.png pop_vs_year.png gdpPerCap_vs_year.png le_vs_year_lin_fit.png gapminderSorytedLifeExpectancy.tsv: exploratory_analyses.R gapminder.tsv
				Rscript $<

asiaBestCountries.tsv asiaWorstCountries.tsv americasBestCountries.tsv americasWorstCountries.tsv europeBestCountries.tsv europeWorstCountries.tsv africaBestCountries.tsv africaWorstCountries.tsv: statistical_analyses.R gapminderSorytedLifeExpectancy.tsv
				Rscript $<

asiaBestCountries.png asiaWorstCountries.png americasBestCountries.png americasWorstCountries.png europeBestCountries.png europeWorstCountries.png: generate_figures.R asiaBestCountries.tsv asiaWorstCountries.tsv americasBestCountries.tsv americasWorstCountries.tsv europeBestCountries.tsv europeWorstCountries.tsv africaBestCountries.tsv africaWorstCountries.tsv
				Rscript $<

hw_07-automating-data-analysis-pipeline.md: hw_07-automating-data-analysis-pipeline.rmd le_vs_year.png pop_vs_year.png gdpPerCap_vs_year.png le_vs_year_lin_fit.png asiaBestCountries.png asiaWorstCountries.png americasBestCountries.png americasWorstCountries.png europeBestCountries.png europeWorstCountries.png
				Rscript -e "knitr::knit('$<')"

hw_07-automating-data-analysis-pipeline.html: hw_07-automating-data-analysis-pipeline.rmd le_vs_year.png pop_vs_year.png gdpPerCap_vs_year.png le_vs_year_lin_fit.png asiaBestCountries.png asiaWorstCountries.png americasBestCountries.png americasWorstCountries.png europeBestCountries.png europeWorstCountries.png
				Rscript -e "rmarkdown::render('$<')"