library(tidyverse)
library(jsonlite)
library(httr)

# Stahni data z API
# https://api.fbi.gov/wanted/v1/list?page=1 

total <- 1:3
urlnames <- str_c("https://api.fbi.gov/wanted/v1/list?page=", total) 
urlnames


# responses <- list()
# for (i in seq_along(urlnames)) {
#   responses[[i]] <- httr::GET(urlnames[i])
# }

responses <- purrr::map(.x = urlnames, ~ httr::GET(url = .x))
responses[[1]] %>% str()

contents_list <- purrr::map(.x = responses, 
  ~ httr::content(x = .x, as = "text"))
contents_list[[1]]

jsons_list <- purrr::map(.x = contents_list,
  ~ fromJSON(txt = .x))

#jsons_list2 <- purrr::map(.x = contents_list, \(.x) fromJSON(.x))


items_list <- purrr::map(.x = jsons_list, 
   ~.x$items)

purrr::map(.x = jsons_list, "total")

df <- purrr::map(.x = items_list, ~ bind_rows(.x) )
df <- purrr::list_rbind(x = items_list)





