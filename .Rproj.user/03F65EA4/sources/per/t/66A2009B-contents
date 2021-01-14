require(tidyverse)
require(readxl)
### 5.5 확장 예제


## 데이터 불러오기

covid19 <- read_delim("docs/Exercise2/covid19-cases-20200601.txt", delim = "\t")
country <- read_excel("docs/Exercise2/country_info.xlsx")
country_pubhealth <- read_csv("docs/Exercise2/country_pubhealth.csv")
glimpse(covid19)
glimpse(country)
glimpse(country_pubhealth)






## 데이터 전처리

# 1. Filtering
# covid19 에서 iso_code가 "OWID_WDL"인 케이스 제외
# 2020년 3월 1일 부터 2020년 5월 31일 까지 데이터만 추출

covid_full <- covid19 %>%
  filter(iso_code != "OWID_WRL",
         date >= as.Date("2020-03-01") &
           date <= as.Date("2020-05-31"))
glimpse(covid_full)

# 2. Join : covid19를 기준으로 나머지 두 데이터셋 결합
covid_full <- covid_full %>%
  left_join(country, by = "iso_code") %>%
  left_join(country_pubhealth, by = c("location"))
glimpse(covid_full)

# 3. 대륙 변수 생성
covid_full <- covid_full %>%
  mutate(continent = gsub("(.+\\s)", "", region) %>%
           factor)
glimpse(covid_full)

# 4. 케이스, 사망자 수 관련 변수를 이용해 100만명 당 확진자 수 및 사망수 계산
covid_full <- covid_full %>%
  mutate_at(vars(matches("cases|deaths")),
            list(per_million = ~ ./population * 10^6))

# 5. 2020년 5월 31일 기준 총 확진자 수가 2000명 이상인 국가만 추출
# 각 국가별로 grouping을 한 후 total_case의 최댓값이 1000명을 초과한 경우만 추출
covid_full <- covid_full %>%
  group_by(location) %>%
  filter(max(total_cases) > 1000)
glimpse(covid_full)

# 6. 각 국가별 total_test 결측값 대체
# 최초 시점의 total_test가 결측인 경우 0으로 대체
# 기록 중 중간에 결측이 발생한 경우 이전 시점 값으로 대체

# 위에서 location 에 대한 grouping이 유지가 되고 있음
# 각 국가별 첫 번째 행이고 그 첫 번째 행이 결측이면 0 값을 대체하고
# 아니면 원래 관측값을 반환
covid_full <- covid_full %>%
  mutate(total_tests = ifelse(row_number() == 1 &
                                is.na(first(total_tests)),
                              0, total_tests)) %>%
  fill(total_tests, .direction = "down") %>%
  ungroup
glimpse(covid_full)

# 7. "_tests"가 포함된 변수들에 대해 인구 천 명당 검사 수 계산(변수이름은 기존 변수명 마지막에 "_per_thousand"을 추가)
# 4 번과 유사
covid_full <- covid_full %>%
  mutate_at(vars(contains("_tests")),
            list(per_thousand = ~ ./population * 10^3))

# 8. iso_code, data, location, continent, population, 그리고 "case","deaths", "tests"가 포함된 변수 선택

covid_full <- covid_full %>%
  select(iso_code, date, location, continent, population,
         matches("case|deaths|tests"))
glimpse(covid_full)
view(covid_full)





## 시각화

# 1. 대륙별 일별 일일 확진자 수(new_case 기준)에 대한 시각화