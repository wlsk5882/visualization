shinyServer(
  
  function(input, output){
    
    library(UScensus2010)
    library(maps)
    library(mapproj)
    source("helpers.R")
    
    

    
    # https://gist.github.com/garrettgman/6465117
    #counties <- readRDS("data/counties.rds")
    percent_map(counties$white,"darkgreen","% white")
    
    output$map <- renderPlot({
      data<- switch(input$var
                    , "Percent White" = counties$white
                    , "Pct B" = counties$black
                    , "Pct H" = counties$hispanic
                    , "Pct A" = counties$asian
                    )
      max <- max(input$range)
      min <- min(input$range)
      percent_map(var=data #var = counties$white 
                  , color="darkgreen"
                  , legend.title=paste("%", input$var) #legend.title = "% white"
                  , max = max # max = 100
                  , min = min) # min = 0
      
      
    })
  }
)
head(county.fips)



#percent_map(counties$white,"darkgreen","% white")