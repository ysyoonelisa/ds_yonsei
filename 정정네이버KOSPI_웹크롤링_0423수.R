install.packages("lubridate")
install.packages("lubridate")
install.packages("httr")
install.packages("rvest")
install.packages("xts")
install.packages("glimpse")
install.packages("tidyverse")
installed.packages("dplyr")
library(lubridate)
library(httr)
library(rvest)
library(xts)
library(tidyverse)
library(dplyr)

https://finance.naver.com/sise/sise_index_day.nhn?code=KOSPI&page=1


myUA <- 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'


res <- GET(url = 'https://finance.naver.com/sise/sise_index_day.nhn?code=KOSPI&page=1', 
           user_agent(agent = myUA))

Sys.setlocale(category = 'LC_ALL', locale = 'C')

tbl <- res %>% 
  read_html() %>% 
  html_node(css = 'body > div > table.type_1') %>% 
  html_table(fill = TRUE)

Sys.setlocale(category = 'LC_ALL', locale = 'korean')

glimpse(x = tbl)

Z <- tbl[-c(1, 5, 6, 7, 8, 12, 13),]

rownames(x = Z) <- NULL

colnames(x = Z)[2] <- '체결가(원)'

print(x = Z)

v1 <- ifelse(Z$등락률 %>% str_remove(pattern = '%') %>% as.numeric()>0, "상승","하강")


tbl <- cbind(Z[,c(1:2)], v1, Z[,c(3:6)])

colnames(x = tbl)[3] <- '전일비 상승하강'

print(x = tbl)


View(x = tbl)
