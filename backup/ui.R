library(shiny)
library(ggplot2)
library(rgdal)

tract <- readRDS("data/tract_newLabel.Rda")
vars<-c("Income", "Med_House_val", "pct_Males", "pct_Pop_5_17","pct_Pop_18_24"
         , "pct_Pop_25_44", "pct_Pop_45_64", "pct_Pop_65plus", "pct_Hispanic"
         , "pct_NH_White_alone", "pct_NH_Blk_alone", "pct_Not_HS_Grad", "pct_College"
         , "pct_Prs_Blw_Pov_Lev", "pct_Diff_HU_1yr_Ago", "pct_MrdCple_HHD"
         , "pct_Female_No_HB", "pct_Sngl_Prns_HHD", "avg_Tot_Prns_in_HHD", "pct_Rel_Under_6"
         , "pct_Vacant_Units", "pct_Renter_Occp_HU", "pct_Single_Unit", "Population", "LAND_AREA"
         , "density" )

shinyUI(
  fluidPage(
    
    titlePanel("US Census 2010 Mail Return Rate")
    
    ,fluidRow(
      column(8
             , plotOutput("choropleth"
                           , hover = "hover_choropleth"
                           )
             )
      ,column(4
              ,plotOutput("hist")
              )
      )
    
    , fluidRow(
      column(4
             , offset=4
             , strong("hovered states")
             , htmlOutput("state_detail")
      )
    )
    , fluidRow(
        column(2
               ,wellPanel( # UI elements to include inside the panel
                 helpText("select a state to highlight")
               , selectInput(
                 "state"
                 , "States"
                 , choices= unique(state_name)
                 )
               #, selectInput(
               #  "colour"
               #  , "Variables to show with different color"
                # , choices = vars
               #  )
             , helpText("Choose a variable to draw as x-axis")
             , selectInput(
               "x"
               ,"Variables"
               , choices = vars
               )
             )
        )
             
      ,column(4
              ,"Return Rates"
              , plotOutput("rRate"))
      ,column(4
              , "Popualation of states"
              , plotOutput("pop")
              )

    )
)
)