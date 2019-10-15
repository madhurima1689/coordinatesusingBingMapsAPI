#Setting up working directory, from where the required input file with place names will be imported
setwd("C:/Users/mchoudhu/Documents/PGP-BABI")

#BingMaps API = AmQ2wYrNc-ifHwCws5q0J0nynWSokmRzu-49B53Esp-Hq7x5STo_XbLVw0GOgPc0

places=read.csv("Latlong.csv",header = TRUE)
attach(places)
places$concat=paste(place,",",state)


install.packages("data.table")
library(data.table)
devtools::install_github("gsk3/taRifx.geo")
library(taRifx.geo)
options(BingMapsKey='AmQ2wYrNc-ifHwCws5q0J0nynWSokmRzu-49B53Esp-Hq7x5STo_XbLVw0GOgPc0')
#You can generate your own Bing Maps API key from here - https://docs.microsoft.com/en-us/bingmaps/getting-started/bing-maps-dev-center-help/getting-a-bing-maps-key
final=data.frame()
temp.df=data.frame()
for (i in 1:nrow(places)) 
  {
  var=places[i,3]
  temp = geocode(var, service="bing", returntype="coordinates")
  temp.df=as.data.frame(t(temp))
  temp.df$place=places[i,3]
  final = as.data.table(rbind(final,temp.df))
  
}

colnames(final) = c("Latitude","Longitude", "Concatenated place name")

write.csv(final,"Coordinates_Bingmaps.csv")
