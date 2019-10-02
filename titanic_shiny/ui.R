## ui.R ##
library(shinydashboard)

header <- dashboardHeader(
    title = "Explore Titanic Features"
)



sidebar <- dashboardSidebar()



body <- dashboardBody(
    
    fluidRow(
        tabBox(title = NULL, width = 12, 
               tabPanel(
                   title = "About this Application",
                   textOutput("about_app")
               ),
               tabPanel(
                   title = "About Me",
                   textOutput("about_me")
               )
        )
    ),
    
    fluidRow(
        tabBox(title = "Available Features", width = 12,
               tabPanel(
                   title = "Plot Feature Distributions",
                   fluidRow(
                       column(width = 3,
                           radioButtons("plot_by_outcome", label = NULL,
                                        choices = c("Yes" = "yes", "No" = "no")
                           ),
                           radioButtons("plot_feature_type", label = NULL,
                                        choices = c("Continuous" = "continuous", "Categorical" = "categorical")
                           ),
                           uiOutput("plot_feature_options_ui")
                       ),
                       column(width = 9,
                              plotlyOutput("univariate_plot")
                       )
                   )
               )
        )
    )
    
)

dashboardPage(
    header,
    sidebar,
    body
)
