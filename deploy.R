path<-"C:\\Users\\Jina\\Documents\\GitHub"
path2<-"C:\\Users\\Jina\\Documents\\GitHub\\visualization"
setwd(path)
library(rsconnect)

shinyapps::deployApp("visualization")
shinyapps::deployApp(path2)
