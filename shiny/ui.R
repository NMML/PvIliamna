library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Lake Iliamna Harbor Seals"),
    
    # Sidebar with a slider input for number of observations
    sidebarPanel(
        h3("Model Parameters"),
        sliderInput("trend_range", 
                    "Date Range (Years)", 
                    min = 1984, 
                    max = 2012 ,
                    step=1,
                    value = c(2000,2010),
                    format = "####"
    ),
        h3("Model Prediction Parameters"),
        selectInput("pred_hod", label="Hour of Day (Prediction):",
                    choices=list("00:00" = 0, 
                         "01:00" = 1, 
                         "02:00" = 2,
                         "03:00" = 3, 
                         "04:00" = 4, 
                         "05:00" = 5,
                         "06:00" = 6, 
                         "07:00" = 7, 
                         "08:00" = 8,
                         "09:00" = 9, 
                         "10:00" = 10, 
                         "11:00" = 11,
                         "12:00" = 12, 
                         "13:00" = 13, 
                         "14:00" = 14,
                         "15:00" = 15, 
                         "16:00" = 16, 
                         "17:00" = 17,
                         "18:00" = 18, 
                         "19:00" = 19, 
                         "20:00" = 20,
                         "21:00" = 21, 
                         "22:00" = 22, 
                         "23:00" = 23),
                    selected="12:00"),
        textInput("pred_doy","Day of Year (Prediction)",227)),
    
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput("pred.plot",height="auto")),
            tabPanel("Summary", verbatimTextOutput("summary")),
            tabPanel("Data Table", tableOutput("data_table"))
        )

    )
))