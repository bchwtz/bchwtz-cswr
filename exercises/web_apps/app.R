#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Shiny Web App to work with Australian tourism data: Filter tourism data, plot
# the corresponding time series and get summarized values.

# The purpose is to implement the program from our exercise on May 3, 2022 in
# form a Shiny Web App. The aim is to filter the Australian tourism data or a
# similar one by its variables state, region and optionally by purpose in order
# to get some summarized values and to plot the corresponding time series.

# Author: Hannah Behrens
# Date: June 21, 2022
# Version Changelog:
#   v0.1 - Initial Release
#   v0.2 - ...

################################################################################
## PART I: Load Libraries and external Dependencies
################################################################################

# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(readxl)
library(plotly)

################################################################################
## PART II: Define Constants
################################################################################


# Load tourism data
tourism <- read_excel("tourism.xlsx")


################################################################################
## PART III: Problem Solving
################################################################################


# Define UI for application
ui <- fluidPage(


  tags$style('.container-fluid {
                           background-color: #add8e6;
              }'), # "Change Background color of fluid page in R shiny", question by chas, November 7, 2019 8:55, answer by Eli Berkow, November 7, 2019 9:22, URL:  https://stackoverflow.com/questions/58745090/change-background-color-of-fluid-page-in-r-shiny [accessed: April 1, 2022; 15:37]


    # Application title
    titlePanel("Australian tourism data"),

    checkboxInput("show_data", "Show data table", TRUE),

    sidebarLayout(
      sidebarPanel(
             selectInput("State",
                         "State:",
                         c("All",
                           unique(as.character(tourism$State)))),

      # defining the values of the selectInput for the regions
      uiOutput("Regionselection"), # "selectInput that is dependent on another selectInput" asked by Hillary, January 21, 2016 16:32, answer by NicE, January 21, 2016 18:00, URL: https://stackoverflow.com/questions/34929206/selectinput-that-is-dependent-on-another-selectinput [accessed: April 1, 2022; 15:39]
            # selectInput("Region",
             #            "Region:",
              #           c("All",
               #            unique(as.character(tourism$Region))))

      uiOutput("Purposeselection"),

      checkboxInput("showSumTripsRegion", "Show the sum of trips by region dependent on the chosen state", TRUE),

      tableOutput("summaryByRegion")

      ),
            # selectInput("Purpose",
             #            "Purpose:",
              #           c("All",
               #            unique(as.character(tourism$Purpose))))
     # ),
    mainPanel(
    # Create a new row for the table.
    DT::dataTableOutput("table"),

    )),


        checkboxInput("show_plot", "Show time series plot", FALSE),
        plotlyOutput('plot_ts') # to generate interactive plots: "Convert ggplot object to plotly in shiny application", question by athlonshi, June 6, 2016 17:52, answer by Bryan Goggin, June 6, 2016 18:05, URL: https://stackoverflow.com/questions/37663854/convert-ggplot-object-to-plotly-in-shiny-application [accessed: March 31, 2022]



)

# Define server logic
server <- function(input, output) {

    output$Regionselection <- renderUI({ # "selectInput that is dependent on another selectInput" asked by Hillary, January 21, 2016 16:32, answer by NicE, January 21, 2016 18:00, URL: https://stackoverflow.com/questions/34929206/selectinput-that-is-dependent-on-another-selectinput [accessed: April 1, 2022; 15:39]
      selectInput("Region", "Region:",
                  choices = c("All", unique(tourism$Region[which(tourism$State == input$State)])))
    })

    output$Purposeselection <- renderUI({
      selectInput("Purpose", "Purpose:",
                  choices = c("All", unique(tourism$Purpose[which(tourism$State == input$State & tourism$Region == input$Region)])))
    })

    # table of summarized trips for each region dependent on the selected state
    output$summaryByRegion <- renderTable({
      sum_R <- tourism %>%
        filter(State == input$State) %>%
        group_by(Region) %>%
        summarize(Trips = sum(Trips))
      sum_R <- as.data.frame(sum_R)
      if(input$showSumTripsRegion == TRUE){
        sum_R
      }
    })

      # generate a datatable which can be filtered, sorted in decreasing/ascending order etc.
      output$table <- DT::renderDataTable(DT::datatable({
        data <- tourism
        if (input$State != "All") {
          data <- data[data$State == input$State,]
        }
        if (input$Region != "All") {
          data <- data[data$Region == input$Region,]
        }
        if (input$Purpose != "All") {
          data <- data[data$Purpose == input$Purpose,]
        }
        if(input$show_data == TRUE){
        data
        }
      }))

      # filtered data as a reactive expression
      selectedData <- reactive({ # see for example: RStudio, Inc. 2019. Build a dynamic UI that reacts to user input.  https://shiny.rstudio.com/articles/dynamic-ui.html [accessed: June 8, 2022 13:19]
        filtered_Data <- tourism %>% filter(State == input$State, Region == input$Region)
        if (input$Purpose != "All") {
          filtered_Data <- filtered_Data %>% filter(Purpose == input$Purpose)
        }
        filtered_Data
      })

      # create time series plot:
      output$plot_ts <- renderPlotly({ # to generate interactive plots: "Convert ggplot object to plotly in shiny application", question by athlonshi, June 6, 2016 17:52, answer by Bryan Goggin, June 6, 2016 18:05, URL: https://stackoverflow.com/questions/37663854/convert-ggplot-object-to-plotly-in-shiny-application [accessed: March 31, 2022]
        if(input$show_plot == TRUE){
          ts_plot <- ggplot(selectedData(), aes(x = as.Date(Quarter),
                                                y = Trips, color = Purpose))+
          geom_line()+
          xlab("Time [Quarter]")+
          ylab("Overnight trips ('000)")
          ts_plot
        }
      })

}

# Run the application
shinyApp(ui = ui, server = server)
