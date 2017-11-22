# Homework 8 - Shiny App

### Links to :

	- Link to [ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R)
	
	- Link to [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R)
	 
	- Link to [app.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/app.R)
	
	- My App is deployed [here](https://jananishiny.shinyapps.io/RShinyApp/)


### Report

 - BC Liquor Store app is split into a ui.R file and a server.R file

 - Option to sort the results table by price is added in [ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R) using checkboxInput() to get TRUE/FALSE values from the user 
 - Image of the BC Liquor Store is added in [ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R) using img(src = "imagename.png")

 - DT package to turn the current results table into an interactive table is added in [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R)
 
 - Fixed issue in renderPlot() and renderTable() in [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R) ,such that , the filtered reactive expression checks for the number of rows in the filtered data, and if that number is 0 then return NULL instead of a 0-row data frame.
 
 - Incorporated tabsetPanel()[ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R)  to create an interface with multiple tabs.
 
 - Used textOutput() inn [ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R) so that app displays “We found 122 options for you” in the search results section
 
  - Included downloadHandler() function in [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R) to download the results table as a .csv file.
  
  - Used conditionalPanel() function in in [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R) to input "sweetness level" whenever user choses Wines option.
  
  - Added uiOutput()  in [server.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/server.R) to create a "SubType"" (red wine, rum, cider, etc.) user Option.
  
  - Option included to "Filter by country” in [ui.R](https://github.com/jmurthy12/STAT545-hw-murthy-janani/tree/master/hw08-R-Shiny-App/RShinyApp/ui.R) , using , checkboxInput() and conditionalPanel() function.


### Report your process : You’re encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Give credit to your sources, whether it’s a blog post, a fellow student, an online tutorial, etc.

  - This assignment was took a lot of time to complete
  - On the other hand, it was very interesting to create a shiny app.
  - I did refer to many sections in [R Studio's Shiny](https://shiny.rstudio.com) to complete this homework

### Links to references.

 - Link for [Shiny theme](https://cran.r-project.org/web/packages/shinythemes/shinythemes.pdf)
 - Link for [Downloader](https://shiny.rstudio.com/reference/shiny/1.0.3/downloadHandler.html)
 - [Daatali's BCL shiny App](https://daattali.com/shiny/bcl/)
 - [Shiny Cheetsheet](http://shiny.rstudio.com/images/shiny-cheatsheet.pdf)
 - [Tutorial](https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/)
 - [Checkbox Input Control](https://shiny.rstudio.com/reference/shiny/latest/checkboxInput.html)
 - [Tabset panel](https://shiny.rstudio.com/reference/shiny/1.0.5/tabsetPanel.html)
 - [Conditional Panel](https://shiny.rstudio.com/reference/shiny/0.11/conditionalPanel.html)