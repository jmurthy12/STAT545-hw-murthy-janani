#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)
library(readr)

# # Define User Interface for the app
ui<-fluidPage(
	
		#Shiny theme "cerulean" is selected
		theme=shinytheme("cerulean"),
		
		
		img(src = "BC-Liquor-Store1.jpg",width = "100%", height = "5%"),
		
		# App title
		titlePanel(" Menu "),
	

		#	Slider Input for Price
		sidebarPanel
			(     sliderInput("PriceIn", 
												"Price of Liquor" ,
												min = 0, 
												max = 300, 
												value = c(10, 40),
												pre = "CAD"
						),
						
				 		#Generate Radio button option for Type of Booze
						radioButtons(
							"TypeIn",
							"Type of Liquor",
							choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
							selected = "WINE"
						),
						
						# Generate Sub Type drop down menu on UI
						uiOutput("subTypeOutput"),
						
						# Generate Sweetness Level drop down menu on UI
						uiOutput("sweetnessLevelOutput"),
				 
						# Use checkboxInput() to provide 'filter by country' drop down menu
						checkboxInput("selectCountry", "Filter by Country", FALSE),
				 
						# Use conditionalpanel() to list down countries in drop down menu
						conditionalPanel(
							condition = "input.selectCountry",
							uiOutput("countryOutput")
						),
						
					  # Use checkboxInput() to provide 'Sort by Price' drop down menu
					  checkboxInput("sortByPrice", "Sort by Price", FALSE),
				 
					 
					 img(src = "wine-glasses.png",width = "100%", height = "50%")
		),
		
		# Generate Historgram with Alcohol COntent
		mainPanel
		(
					# Use textOutput() to generate the Number of Options available for User Selection
					textOutput("NumberOfOptions"),
					
					# Use tabsetPanel() to generate tabs
					tabsetPanel
					(
						#First tab displays the histogram of Alcohol Content Vs Number of Beverages
						tabPanel("Histogram of Alcohol Content", plotOutput("AlcoholContentPlot")),
						br(),
						#Second tab dispays the User Options in a tabulated form
						tabPanel("Tabulated Results", DT::dataTableOutput("userOptions")),
						br()
					),
			
					# Use downloadButton() to provide Download results option to User
					downloadButton("DownloadResults", "Download Results"),
					br(),br()
			
		)
)





