install.packages("lubridate")
library(lubridate)
library(httr)
library(rvest)
library(xts)

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

tbl <- tbl[-c(1, 5, 6, 7, 8, 12, 13),]

rownames(x = tbl) <- NULL

colnames(x = tbl)[2] <- '체결가(원)'

print(x = tbl)

View(x = tbl)
