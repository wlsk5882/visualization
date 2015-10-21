shinyServer(function(input,output)({

    output$boxplot <- renderPlot({
    qplot(x = factor(tract$State_name, levels=state_sorted)
          , y = tract$ReturnRate
          , geom = 'boxplot'
          )+
      geom_hline(yintercept = median(tract$ReturnRate,na.rm=TRUE)
                  , stat = "hline"
                  , position = "identity"
                  , color = 'red'
                  , show_guide = FALSE)+
      xlab("State")+
      ylab("Return Rate(%)")+
      ggtitle("2010 Census Mail Return Rate By States")+
      annotate("text", x = 50.5, y = 90, label = c("median"), col='red', size=3.5, angle=90)+
      annotate("text", x = 51.5, y = 90, label = c("79.6%"), col='red', size=3.5, angle=90)+
      theme(axis.text.x = element_text(angle=90, size=rel(1.2)))
    
  })
  

  output$summary <- renderText({
    
    clicked <- input$click_box
    domain <- clicked$domain
    x<-clicked$x
    
    width<- domain$right-domain$left
    widthEach <- width/nrow(summaryByState)
   
    idx<-round(x/widthEach,0)
    clickedState<- state_sorted[idx]

    #clickedState<- input$hover_box #clickedState = state[1]
    attach(summaryByState)
    paste(h3(clickedState), "<br>"
          , "Population: ", summaryByState[which(state==clickedState),"Population"],"<br>"
          , "Number of Counties: ", summaryByState[which(state==clickedState),"NumberOfCounty"],"<br>"
          , "Number of Tracts: ", summaryByState[which(state==clickedState),"NumberOfTract"],"<br><br>"
          , "Average Mail Return Rate: ", summaryByState[which(state==clickedState),"meanRate"], "%","<br>"
          , "Median Mail Return Rate: ", summaryByState[which(state==clickedState),"medianRate"], "%","<br>"
          , "Max Mail Return Rate: ", summaryByState[which(state==clickedState),"maxRate"], "%","<br>"
          , "Min Mail Return Rate: ", summaryByState[which(state==clickedState),"minRate"], "%","<br>"
          )
  })
  
  
  output$corr <- renderPlot({
    
    xVars <- input$radio #xVars<-"pct_Pop_65plus" #c("pct_Pop_18_24","pct_Pop_25_44","pct_Pop_45_64","pct_Pop_65plus")
    rng <- input$range #rng<-c(50,100)
    income <-input$income
    line<-input$smooth
    
    x <- tract[,xVars]
    ic<- as.numeric(tract$Income)
    
    #subsetting w/ x limit
    idx.x<-which(x>rng[1]&x<=rng[2])
    idx.income<- which(ic>=income[1]&ic<=income[2])
    
    subset.idx<-intersect(idx.x, idx.income)
    
    x<- x[subset.idx]
    y <- tract$ReturnRate[subset.idx]
    
    addReg<- ifelse(line==TRUE,"r","")
    
    var_names <- list(pct_MrdCple_HHD="Percentage of Married Couple"
                      , pct_College="Percentage of College Graduate"
                      )
    
    hexbinplot(y ~ x
               , tract
               , aspect = 1
               , xlab = paste(var_names[[xVars]],"(%)")
               , ylab = "Return Rate(%)"
               , type = addReg
               , colramp= ifelse(xVars=="pct_MrdCple_HHD",magent,topo.colors)
               )
    })
}
)
)

