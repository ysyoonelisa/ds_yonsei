install.packages("tidyverse")
install.packages("ggmap")
install.packages("dplyr")
install.packages("maps")
install.packages("mapdata")
install.packages("mapproj")
install.packages("shiny")

library(tidyverse)
library(ggplot2)
library(ggmap)
library(dplyr)
library(maps)
library(mapdata)
library(mapproj)
library(shiny)


world_map <- map_data("world")
nation<-read.csv("raw_data_nation.csv", header=T)

suicide_2015 <- subset(nation,(year==2015), select=c(country, year, total_suicides_100k),sort=F)
names(suicide_2015)[1] <- c("region")
head(suicide_2015)


Suicide_world <- data.frame(suicide_2015) %>%
  merge(world_map, by = "region")


arrange(Suicide_world, order) %>% 
  ggplot(aes(x=long, y=lat, group = group, fill = total_suicides_100k)) + 
  geom_polygon() +
  scale_fill_continuous(low = "pink", high = "black")
