#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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


# Define the server function
server <- function(input, output, session)
{
	
				#Load the data
				bcl_data <- read_csv(file="bcl-data.csv")
				
				filtered_bcl <- reactive({
					if (input$selectCountry) {
						return(
							bcl_data %>% 
								filter(Price >= input$PriceIn[1], 
											 Price <= input$PriceIn[2],
											 Type == input$TypeIn,
											 Country == input$countryInput)
								)
					}
						return(
							bcl_data %>% 
								filter(Price >= input$PriceIn[1], 
											 Price <= input$PriceIn[2], 
											 Type == input$TypeIn)
						)
				})
			
				
				# Creates Country Select drop down box
				# Canada is slected by default
				output$countryOutput <- renderUI({
					selectInput("countryInput", "Country",
											choices = sort(unique(bcl_data$Country)),
											selected = "CANADA")
				})
				
				
			
				# Create "Sweetness level" drop down if Type WINE' is selected
				# Sweetness Level 0 is selected by default.
				output$sweetnessLevelOutput <- renderUI({
					conditionalPanel(
						condition = "input.TypeIn == 'WINE'",
						selectInput("sweetnessLevel", "Sweetness level", 
												choices = sort(unique(bcl_data$Sweetness)),
												selected = "0")
					)
				})
				
				
				# Check if "WINE" option is selected and categorise based on WINE
				# filter based on Sweetness level
				#If "WINE" is not selected then DO NOTHING on the data
				filteredData <- reactive({
					if(input$TypeIn != "WINE") {
						return(
							filtered_bcl()
						)
					}
						return(
							
							filtered_bcl() %>%
								filter(Sweetness == input$sweetnessLevel)
						)
				})
				
			
			#Generate Sub-type drop down menu
			#use nrow() to check if Dataframe is NULL
				subtype_data <- reactive({
					if(nrow(filteredData()) >= 1) {
						return(
							filteredData() %>%
								select(Subtype) %>%
								unique())
					} 

						return(NULL)
					
				})
				
				
				# Generate Sub-type drop down menu on UI
				output$subTypeOutput <- renderUI({
					if (is_empty(subtype_data())) {
						return(NULL)
					}
					selectInput("subtypeInput", "Sub Type", subtype_data())
				})
				
				
				# Filter based on Sub-Type
				# Sort based on selection of "Sort by Price" option
				filteredSubtype <- reactive({
					
					if(nrow(filteredData()) == 0) {
						return(NULL)
					}
					
					if (is_empty(input$countryInput)) {
						return(NULL)
					}
			
					if(input$sortByPrice) {
						return(
							filteredData() %>%
								filter(Subtype == input$subtypeInput) %>%
								arrange(Price)
						)
					}
				
						return(
							filteredData() %>%
								filter(Subtype == input$subtypeInput)
						)
					
				})
				
				
				
				# Download data is .csv format
				output$DownloadResults <- downloadHandler(
					filename = function() { 
						paste("BC_LiquorStore_Data-", Sys.Date(), ".csv", sep = "")
					},
					content = function(file) { 
						write.csv(filteredSubtype(), file)
					}
				)
				
				
				# Count Results/options for User
				output$NumberOfOptions <- renderText({
					if (is_empty(filteredSubtype())) {
						return(
							paste("Oops! No results found, You have a unique taste!")
						)
					}
						paste( "We found", nrow(filteredSubtype()) ,"options for you!")
				})
				
				# Histogram of alcohol content 
				output$AlcoholContentPlot <- renderPlot({
					if (is_empty(filteredSubtype())) {
						return(NULL)
					}
					
						ggplot(filteredSubtype(), aes(Alcohol_Content)) +
							geom_histogram(color = "#b01df2", fill = "#eabde3")+
							theme_bw() +
							theme(axis.text.x = element_text(size=15, face = "bold"),
										axis.text.y = element_text(size=15, face = "bold"),
										plot.title = element_text(size=15, face = "bold", hjust = 0.5),
										axis.title = element_text(size=15, face = "bold")) +
							labs(x = "Alcohol Content ", 
									 y = "Number of Beverages",
									 title = "Histogram of Alcohol Content")
					
				})
				
				# Generate Table of data selected by user
				output$userOptions <- DT::renderDataTable({
					filteredSubtype()
				})
	
	
}