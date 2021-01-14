require(rmarkdown)
require(knitr)
require(tidyverse)
require(readxl)
require(RColorBrewer)
# 1.
X <- matrix(c(3,-4,3,-2,
              1,-1,1,-1,
              2,-4,2,-3,
              2,-1,1,-3), nrow = 4, byrow = T)
y <- matrix(c(8,4,1,5), nrow = 4)
a = solve(X)%*%y
a
all.equal(X %*% a, y)

# 3.

# a
setwd("C:\\r-project/R-programming/docs/Exercise2/")
country_info <- read_excel("country_info.xlsx")
country_pubhealth <- read_csv("country_pubhealth.csv")
covid19_cases_20200601 <- tibble(read.table("covid19-cases-20200601.txt", sep = "\t", header = T))

# b
covid19_full <- covid19_cases_20200601 %>%
  left_join(country_info, by = "iso_code") %>%
  left_join(country_pubhealth, by = "location")

covid19_full %>%
  mutate_at(vars(date),
            ~ as.Date(. ,format = "%Y-%m-%d")) %>%
  filter(date >= as.Date("2020-01-21") , date <= as.Date("2020-05-31")) %>%
  mutate(continent = factor(gsub("(.+//s)", "", region))) %>%
  

