library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("State of the Union Address Wordclouds"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            h5("Instructions"),
            helpText("Choose a president/year from the list, choose parameters, and click Submit to generate a wordcloud"),
            
            # users select which president and year
            selectInput("var",
                        label = "Choose a State of the Union Address",
                        choices = c("Donald Trump, 2017",
                                    "Barack Obama, 2009",
                                    "George W Bush, 2001")
                        ),
            
            # Sliders
            sliderInput("min_freq",
                        "Minimum Frequency:",
                        min = 2,  max = 15, value = 10),
            sliderInput("word_count",
                        "Maximum Number of Words:",
                        min = 10,  max = 75,  value = 30),
            
            # Submit button
            actionButton("update", "Submit")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            p("This Shiny app generates wordclouds from United States presidents Trump, Obama, and G.W. Bush. 
              For simplicity, just the first State of the Union Address of each presidency is used."),
            plotOutput("wordcloudT")
        )
    )
))
