library(shiny)
library(ggplot2)
library(rgdal)

tract<- readRDS("data/tract_newLabel.Rda")
state<-readRDS("data/state.Rda")
indir = "data/shapeFiles/USA_adm1"
tractSDF = readOGR(indir, "USA_adm1")
tractSDF@data$NAME_1<-as.character(tractSDF@data$NAME_1)

shinyServer(function(input,output){
  
  output$choropleth <- renderPlot({
    tractSDF@data<- merge(tractSDF@data, state, by.x="NAME_1",by.y="state_name", all.x=TRUE)
      spplot(tractSDF,"ReturnRate", col=NA)
    })
  
  output$hist <- renderPlot({
    p1.1<- qplot(tract$ReturnRate)
    p1.1+
      xlab("Return Rate(%)")
  })
  
  
  output$rRate <- renderPlot({
    
    #a<- tract$State_name[1]
    #colVar<-vars[1]
    #xVar <- vars[3]
    a <-input$state
    xVar<- input$x
    colVar<-input$colour
    
    p2.1<-  with(subset(tract, State_name==a)
           , qplot( x= tract[,xVar]
                   ,y = tract$ReturnRate
                   #,colour=tract[,colVar]
                   )
    )
    p2.1+
      geom_point()+
      theme(axis.text.x = element_text(angle=90)
      )+
      xlab(xVar)+
      ylab("Return Rate(%)")+
      ggtitle(paste("Return Rate of",input$state,"by",input$x))
    
  })
  


  output$pop <- renderPlot(
    { 
      selectedIdxSt<- as.character(input$state)
      fills <- rep("gray",length(state$state_name))
      selectedIdx <- grep(selectedIdxSt,state$state_name)
      fills[selectedIdx] <-"yellow"
      
      
      p1 <-qplot( x = state_name
            , y = population
            , data = state
            , geom = "bar"
            , stat = "identity"
            , fill = fills
      )+
        scale_fill_brewer(type = "qual")+
        theme(axis.text.x = element_text(angle=90)
              , legend.position="none")
      #+        scale_x_continuous(breaks = c(10000,20000,30000,40000))
      p1        
       }
  )
  
  output$state_detail <- renderText({
  
    a <- input$hover_choropleth  
    a$mapping
   paste("input$hover_choropleth$mapping:"
         ,input$hover_choropleth$mapping
         ,"str(input$hover_choropleth):"
         ,str(input$hover_choropleth)
         , "class:"
         , class(input$hover_choropleth)
         , collapse = "<br>"
         )
  })
  
  
  
  
})

