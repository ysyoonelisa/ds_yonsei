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

v1 <- ifelse(tbl[, 4]>0, "상승","하강")
tbl1 <- cbind(tbl[,r(1:2)], v1, tbl[,r(3:6)])
##tbl행렬의 4번째 열의 값이 0보다 크면 상승, 그렇지 않으면 하강으로 
##표현하는 새로운 열을 생성하여 tbl의 2열과 3열 사이에 삽입하고자 하였습니다.

print(x = tbl1)

View(x = tbl1)
