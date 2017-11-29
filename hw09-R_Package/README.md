# Homework 9 - R Package

### Links to :

- Foofactors R Package is [here](https://github.com/jmurthy12/foofactors)

- README is [here](https://github.com/jmurthy12/foofactors/blob/master/README.Rmd)

- Vignettes is [here](https://github.com/jmurthy12/foofactors/tree/master/vignettes)

- Package can be installed using devtools::install_github("jmurthy12/foofactors")

### Report

Extensions made to Jenny Bryan's foofactors are :

- Function "check_factor_character()" is added to detect factors that should be character

- Function "reorder_descending()" is my version of reorder() that uses desc() a la (d)plyr

- Function "factor_as_orginal()" is my a version of factor() that sets levels to the order in which they appear in the data, i.e. set the levels “as is”

- Document all exported functions.

- Included three unit tests for every function that is exported. Two unit tests for success and one for failure.

- R package  passes check() without errors .

- Updated the README and vignette to show usage of all the functions in the package. 

### Report your process : You’re encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it’s a blog post, a fellow student, an online tutorial, etc.

- This assignment consumed a lot of time during check() so as to resolve all the errors.
  
- It took a while to understand the interworking of several folders
  

### Links to references.

 - From STAT 545 Class Notes :
 	- [cm 109 and cm 110](http://stat545.com/cm109-110-notes_and_exercises.html)
 		
 	- [Part 2](http://stat545.com/block011_write-your-own-function-02.html)
 		
 	- [Part 3](http://stat545.com/block011_write-your-own-function-03.html)
 		
 - [Tutorial by Jenny Bryan](http://stat545.com/packages06_foofactors-package.html)