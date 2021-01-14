require(tidyverse)
require(readxl)
## 1.
X = matrix(c(3, -4, 3, -2,
             1, -1, 1, -1,
             2, -4, 2, -3,
             2, -1, 1, -3), byrow = T, nrow = 4)
y = matrix(c(8, 4, 1, 5), nrow = 4)
a <- solve(X) %*% y
all.equal(X %*% a, y)



## 2.

# a.
set.seed(20200511)
c <- rep(rnorm(25, 5, sqrt(3)), 100)

# b.
mean(c); sd(c)

# c.



## 3.

# a.
country_info <- read_excel("country_info.xlsx")
country_pubhealth <- read_csv("country_pubhealth.csv")
covid19 <- read_delim("covid19-cases-20200601.txt", delim = "\t")

# b.
covid19_full <- covid19 %>%
  left_join(country_info, by = "iso_code") %>%
  left_join(country_pubhealth, by = "location")

covid19_full <- covid19_full %>%
  filter(date >= as.Date("2020-01-20") & 
           date <= as.Date("2020-05-31"))

covid19_full <- covid19_full %>%
  mutate(continent = gsub("(.+\\s)", "", region))

covid19_full <- covid19_full %>%
  mutate_at(vars(matches("case|death")),
            list(per_million = ~ ./population*10^6))

covid19_full <- covid19_full %>%
  group_by(location) %>%
  filter(max(total_cases) >= 1000)

covid19_full <- covid19_full %>%
  mutate(total_tests = ifelse(row_number() == 1 &
                                is.na(first(total_tests)),
                                      0, total_tests))

covid19_full <- covid19_full %>%
  fill(total_cases, .direction = "down")

covid19_full <- covid19_full %>%
  mutate_at(vars(contains("_test")),
                 list(per_thousand =  ~ ./population * 10^3))

covid19_full <- covid19_full %>%
  select(iso_code, date, location, continent, population, total_cases, new_cases, total_deaths, new_deaths, total_tests, new_tests, new_tests_smoothed, total_cases_per_million, new_cases_per_million, total_deaths_per_million, new_deaths_per_million, total_tests_per_thousand, new_tests_per_thousand, new_tests_smoothed_per_thousand )

glimpse(covid19_full)

# c.
covid19_full %>%
  ggplot() +
  aes(x = scale_x_date(date), y = total_tests) +
  geom_bar(color = "white", fill = "lightblue") +
  ggtitle("Daily COVID-19 test in South Korea") +
  theme_minimal(base_size = 15, base_line_size = 0.5)
