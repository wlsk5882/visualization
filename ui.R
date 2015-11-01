shinyUI(
  fluidPage(
    
    titlePanel(h1("US Census 2010 Mail Return Rate", align = "center"))
    ,fluidRow(
      #h2("Introduction", style = "color:#3182bd"),
      br()
      ,p("This document is visualizing 2010 US census return rate status and correlations among the return rate and
         demographic factors."
         ,align = 'center'
         )
      ,p("This would be useful to identify regions or demographic groups for promotions
         improving mail return rate."
         ,align = 'center'
        )
      ,p("Individual data points represents average of each tract."
         ,align = 'center'
         )

      ,h2("Mail Return Rate and summary by each state", style = "color:#3182bd")
      ,br()
    )
    ,fluidRow(
      column(8
             ,p("A median mail response rate is 79.6%, and 78.7% on average across 52 states in U.S.
                Detailed information of each state will come up when you click on a graph below."
             ,align = 'center'
               )
             , plotOutput("boxplot"
                           , click  = "click_box"
                           )
             )
      ,column(4
              , helpText("")
              , wellPanel(
                htmlOutput("summary")
                )
              )
      )
    ,fluidRow(
      h2("Correlation of 'Mail Return Rate' and 'Demographic Variables'", style = "color:#3182bd")
      ,br()
      ,br()
      
    )
    , fluidRow(
        
        )
    , fluidRow(
      column(8
             ,p("Regions where have more married couple residents or college graduates tends to get higher return rate."
                ,align = 'center'
             )
             , plotOutput("corr")
             )
      ,column(4
              ,wellPanel(
                h4("Filter")
                , radioButtons("radio",h5("* Demographic variable")
                             ,c("Percentage of Married Couple"="pct_MrdCple_HHD"
                                , "Percentage of College Graduate" = "pct_College"
                                )
                             )
                , sliderInput(inputId= "range"
                              , label = h5("* Range of a selected variable(%)")
                              , min =0
                              , max =100
                              , value = c(50,100)
                              )
                , sliderInput(inputId= "income"
                              , label = h5("* Range of Income($)")
                              , min =0
                              , max =max(as.numeric(tract$Income))
                              , value = c(0,max(as.numeric(tract$Income)))
                              )
    
                )
              , checkboxInput(inputId = "smooth"
                              ,label= "regression line"
                              , value = TRUE
              )
              )
      )
    ,fluidRow(
      doc <- tags$html(
        tags$body(
          br()
          ,br()
          ,p('data source: '
            , a('2015 Planning Database, US Census Bureau'
                , href="http://www.census.gov/research/data/planning_database/2015/")
            )
          ,br()
          ,br()
          )
      )
      ,cat(as.character(doc))
      )
    )
  
  
)

