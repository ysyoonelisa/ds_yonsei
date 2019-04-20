library(tidyverse)
library(httr)
library(rvest)
library(writexl)

res <- GET(url = "https://www.daum.net/")

print(x = res)

status_code(x = res)

cat(content(x = res, as = 'text', encoding = 'UTF-8'))

html <- read_html(x = res) 

span <- html_nodes(x = html, css = ' ol > li > div > div:nth-child(1) > span.txt_issue > a') 

searchWords <- html_text(x = span)

print(x = searchWords)
