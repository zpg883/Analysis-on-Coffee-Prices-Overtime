<<<<<<< HEAD
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(readr)
library(zoo)
library(tidyverse)

##loading data
coffee <- read_csv("coffee.csv")


# Define UI for application that draws a histogram

min_date <- min(coffee$Date)
max_date <- max(coffee$Date)
set_date <- as.Date('2011-08-09')

ui <- fluidPage(

    # Application title
    titlePanel("Daily Coffee Prices Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("years",
                        "Select Year Range:",
                        min = min_date,
                        max = max_date,
                        value = set_date
        )),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("barPlot"),
           plotOutput("scatterPlot"),
           plotOutput("barPlot2"),
           plotOutput("timeseries"),
           DT::dataTableOutput("mytable")
        )
    )
)

# Define server logic required to draw the graphs
server <- function(input, output) {

    output$barPlot <- renderPlot({
        # generate years based on input$bins from ui.R
        coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Volume = sum(Volume)) %>% 

        # draw the bar chart based on specified year range
        ggplot(aes(x = years, y = Volume)) + 
        geom_col(fill = 'pink3') +
        scale_y_continuous(labels = scales::comma) +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Volume of Coffee Sold by Year',
             y = 'Volume',
             x = 'Year',
             caption = '*Plots react to the input in the side panel')  
    })
    output$scatterPlot <- renderPlot({
      # generate years based on input$years from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Close = sum(Close), Open = sum(Open)) %>%   
        
        # draw the scatter plot based on specified year range
        ggplot(aes(x = Open, y = Close)) +
        geom_point(color="pink3",
                   fill="lightpink2",
                   shape=21,
                   alpha=0.5,
                   size=6,
                   stroke = 2) +
        theme_minimal() +
        scale_x_continuous(labels = scales::dollar_format()) + 
        scale_y_continuous(labels = scales::dollar_format(prefix="$")) +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Open & Closing Prices of Coffee',
             y = 'Close',
             x = 'Open',
             caption = '*Plots react to the input in the side panel')  
    })
    output$barPlot2 <- renderPlot({
      # generate years based on input$bins from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Low = median(Low)) %>% 
        
        # draw the bar chart based on specified year range
        ggplot(aes(x = years, y = Low)) + 
        geom_col(fill = 'pink3') +
        scale_y_continuous(labels = scales::comma) +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'The Low of Coffee by Year',
             y = 'Low',
             x = 'Year',
             caption = '*Plots react to the input in the side panel')  
    })
    output$timeseries <- renderPlot({
      # generate years based on input$years from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        #summarize(Close = avg(Close)) %>%  
        # include time series graph based on the avg price per year for coffee
        ggplot(aes(x = years, y = Close)) +
        geom_line(aes(color = "pink3")) +
        theme_minimal() +
        theme(legend.position = "none") +
        scale_y_continuous(labels = scales::dollar_format(prefix="$")) +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Average Closing Price of Coffee Over Time',
             y = 'Close',
             x = 'Years',
             caption = '*Plots react to the input in the side panel')  
    })
    # include data table
    output$mytable <- DT::renderDataTable(coffee %>% 
                                            filter(Date <= input$years) %>% 
                                            mutate(years = factor(lubridate::year(Date))) %>% 
                                            #group_by(years) %>% 
                                            summarize(Date, Open, High, Low, Close, Volume, Currency),
                                          options = list(scrollX = TRUE),
                                          rownames = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)
=======
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(readr)
library(zoo)
library(tidyverse)

##loading data
coffee <- read_csv("coffee.csv")


# Define UI for application that draws a histogram

min_date <- min(coffee$Date)
max_date <- max(coffee$Date)
set_date <- as.Date('2011-08-09')

ui <- fluidPage(

    # Application title
    titlePanel("Daily Coffee Prices Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("years",
                        "Select Year Range:",
                        min = min_date,
                        max = max_date,
                        value = set_date
        )),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("barPlot"),
           plotOutput("scatterPlot"),
           plotOutput("barPlot2"),
           plotOutput("timeseries"),
           DT::dataTableOutput("mytable")
        )
    )
)

# Define server logic required to draw the graphs
server <- function(input, output) {

    output$barPlot <- renderPlot({
        # generate years based on input$bins from ui.R
        coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Volume = sum(Volume)) %>% 

        # draw the bar chart based on specified year range
        ggplot(aes(x = years, y = Volume)) + 
        geom_col(fill = 'pink3') +
        scale_y_continuous(labels = scales::comma) +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Volume of Coffee Sold by Year',
             y = 'Volume',
             x = 'Year',
             caption = '*Plots react to the input in the side panel')  
    })
    output$scatterPlot <- renderPlot({
      # generate years based on input$years from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Close = sum(Close), Open = sum(Open)) %>%   
        
        # draw the scatter plot based on specified year range
        ggplot(aes(x = Open, y = Close)) +
        geom_point(color="pink3",
                   fill="lightpink2",
                   shape=21,
                   alpha=0.5,
                   size=6,
                   stroke = 2) +
        theme_minimal() +
        scale_x_continuous(labels = scales::dollar_format()) + 
        scale_y_continuous(labels = scales::dollar_format(prefix="$")) +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Open & Closing Prices of Coffee',
             y = 'Close',
             x = 'Open',
             caption = '*Plots react to the input in the side panel')  
    })
    output$barPlot2 <- renderPlot({
      # generate years based on input$bins from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        summarize(Low = median(Low)) %>% 
        
        # draw the bar chart based on specified year range
        ggplot(aes(x = years, y = Low)) + 
        geom_col(fill = 'pink3') +
        scale_y_continuous(labels = scales::comma) +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'The Low of Coffee by Year',
             y = 'Low',
             x = 'Year',
             caption = '*Plots react to the input in the side panel')  
    })
    output$timeseries <- renderPlot({
      # generate years based on input$years from ui.R
      coffee %>% 
        filter(Date <= input$years) %>% 
        mutate(years = factor(lubridate::year(Date))) %>% 
        group_by(years) %>% 
        #summarize(Close = avg(Close)) %>%  
        # include time series graph based on the avg price per year for coffee
        ggplot(aes(x = years, y = Close)) +
        geom_line(aes(color = "pink3")) +
        theme_minimal() +
        theme(legend.position = "none") +
        scale_y_continuous(labels = scales::dollar_format(prefix="$")) +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(title = 'Average Closing Price of Coffee Over Time',
             y = 'Close',
             x = 'Years',
             caption = '*Plots react to the input in the side panel')  
    })
    # include data table
    output$mytable <- DT::renderDataTable(coffee %>% 
                                            filter(Date <= input$years) %>% 
                                            mutate(years = factor(lubridate::year(Date))) %>% 
                                            #group_by(years) %>% 
                                            summarize(Date, Open, High, Low, Close, Volume, Currency),
                                          options = list(scrollX = TRUE),
                                          rownames = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)
>>>>>>> 1339a3e63e20bfa9d1f49f45c3c0a211dd2fb29e
