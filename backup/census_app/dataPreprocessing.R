library(UScensus2010)
library(maps)
library(mapproj)
source("helpers.R")
data(county.fips)

tract_extracted<-readRDS("data/tract_extracted.Rda")
# <- readRDS("data/counties.rds")
newColnames <- c("X", "GIDTR", "State", "State_name", "County", "County_name", "Tract", "Income", "Med_House_val", "ReturnRate", "pct_Males", "pct_Pop_5_17", "pct_Pop_18_24","pct_Pop_25_44", "pct_Pop_45_64", "pct_Pop_65plus", "pct_Hispanic", "pct_NH_White_alone", "pct_NH_Blk_alone", "pct_Not_HS_Grad",  "pct_College", "pct_Prs_Blw_Pov_Lev", "pct_Diff_HU_1yr_Ago", "pct_MrdCple_HHD", "pct_Female_No_HB", "pct_Sngl_Prns_HHD", "avg_Tot_Prns_in_HHD",  "pct_Rel_Under_6", "pct_Vacant_Units", "pct_Renter_Occp_HU", "pct_Single_Unit", "Population", "LAND_AREA", "density")

colnames(tract_extracted) <- newColnames
head(tract_extracted)
#tract_extracted$St_County<- apply(tract_extracted[,c("State_name","County_name")],1,paste,collapse =".")

county_name<-tolower(gsub(" County", "", County_name))
state_name<- tolower(State_name)    
a<-data.frame(state_name,county_name)
b<-as.data.frame(apply(a[,c("state_name","county_name")],1,paste,collapse=","))



all.equal(as.character(b[1,1]),as.character(county.fips[1,2]))
tract_extracted$polyname <- b



by.county <- data.frame(tapply(tract_extracted$ReturnRate,tract_extracted$polyname, median, na.rm=TRUE))
by.county$polyname <- rownames(by.county)
head(by.county)
colnames(by.county) <- c("ReturnRate","polyname")
head(by.county)

county.fips$polyname <- as.character(county.fips$polyname)
tract_extracted$polyname <- as.character(tract_extracted$polyname)

class(county.fips$polyname)
class(tract_extracted$polyname)


c<- merge(county.fips, tract_extracted, by = "polyname")
head(c)
