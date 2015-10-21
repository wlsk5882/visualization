library(shiny)
library(ggplot2)
library(plyr)
library(RColorBrewer)
library(hexbin)
library(grid)

load("data/tract_noDuplicate.Rda")
load("data/summaryByState.Rda")

tract <- tract_noDuplicate
state_sorted<- (summaryByState[order(-summaryByState$medianRate),])$state
attach(tract)

clr<- c("#8dd3c7","#ffffb3","#bebada","#fb8072","#80b1d3","#fdb462","#b3de69","#fccde5","#d9d9d9")
pltt <- c("LinGray","BTC","LinOCS","heat.ob","magent","plinrain", terrain.colors, topo.colors, cm.colors)
