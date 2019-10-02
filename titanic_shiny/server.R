## app.R ##
library(dplyr)
library(readr)
library(plotly)
library(shiny)
library(shinydashboard)
library(wrapr)

data <- read_csv("Data/train.csv")

continuous_data <- data %>%
    select_if(is.numeric) %>%
    names()

categorical_data <- data %>%
    select_if(is.character) %>%
    names()

server <- function(input, output) {
    
    ###########################################################################
    # About Box
    ###########################################################################
    
    output$about_app <- renderText({
        "This app allows users to explore different solutions to the famous Titanic
        problem on Kaggle."
    })
    
    output$about_me <- renderText({
        "My name is Zack Barry, and I am an applied mathematician turned data
        scientist."
    })
    
    ###########################################################################
    # Plot Box
    ###########################################################################
    
    output$plot_feature_options_ui <- renderUI({
        
        choices <- switch(input$plot_feature_type,
                          "continuous" = continuous_data,
                          "categorical" = categorical_data)
        
        radioButtons("plot_feature_options", label = NULL,
                     choices = choices)
    })
    
    output$univariate_plot <- renderPlotly({
            
        plot <- plot_ly()
        
        if (input$plot_feature_type == "continuous") {
            
            let(
                alias = list(var = input$plot_feature_options),
                expr = {
                    plot <- plot %>%
                        add_histogram(
                            data = filter(data, Survived == 1), 
                            x = ~var
                        ) %>%
                        add_histogram(
                            data = filter(data, Survived == 0),
                            x = ~var
                        ) %>%
                        layout(barmod = "stacked")
                }
            )
            
        }
        
        if (input$plot_feature_type == "categorical") {
            
            let(
                alias = list(var = input$plot_feature_options),
                expr = {
                    data <- data %>%
                        select(Survived, var) %>%
                        group_by(var) %>%
                        summarise(
                            Died = sum(Survived == 0),
                            Survived = sum(Survived == 1)
                        ) %>%
                        ungroup() %>%
                        arrange(var)
                    
                    plot <- plot_ly(
                        data, 
                        x = ~var, 
                        y = ~Survived, 
                        type = "bar",
                        name = "Survived"
                    ) %>%
                        add_trace(y = ~Died, name = "Died") %>%
                        layout(yaxis = list(title = "Count", barmode = "group"))
                }
            )
        }
        
        plot
    })
    
    ###########################################################################
    # Model Box
    ###########################################################################
    
    
}