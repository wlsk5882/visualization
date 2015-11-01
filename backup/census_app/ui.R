shinyUI(fluidPage(
  titlePanel("censusVis")
  
  , sidebarLayout(
    sidebarPanel(
      helpText("create demographic maps with info from the 2010 US census")
      
      , selectInput("var"
                    , label = "choose a variable to display"
                    , choices = c("Percent White"
                                  , "Pct B"
                                  , "Pct H"
                                  , "Pct A"
                                  )
                    , selected = "percent White"
                    )
      , sliderInput("range"
                    , label = "range of interest"
                    , min = 0
                    , max = 100
                    , value = c(0,100))
    )
    , mainPanel(plotOutput("map"))
  )
)
  
)