library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Lake Iliamna Harbor Seals"),
    
    # Sidebar with a slider input for number of observations
    sidebarPanel(
        sliderInput("trend_range", 
                    "Trend Range", 
                    min = 1984, 
                    max = 2012 ,
                    step=1,
                    value = c(2000,2010)
    )),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("pred.plot"),
        tableOutput("pred.table"),
        verbatimTextOutput("summary")
    )
))