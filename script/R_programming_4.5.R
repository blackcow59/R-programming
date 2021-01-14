### 4.5 데이터 변환

# 데이터 분석에서 적어도 80% 이상의 시간을 데이터 전치리에 할애
# 실제 데이터(real world data, RWD)가 우리가 지금까지 다뤄왔던 예제 데이터 처럼 깔끔하게 정리된 경우는 거의 없음.

# 이상치(outlier)
# 결측(missing data)
# 변수 정의의 부재(예 : 여러 가지 변수 값이 혼합되어 한 열로 포함된 경우)
# 비정형 문자열로 구성된 변수
# 불분명한 데이터 구조
# ...

# Tidyverse 세계에서 지저분한 데이터(messy data)를 분석이 용이하고(전산처리가 쉽고) 깔끔한 데이터(tidy data)로 정제하기 위해 데이터의 구조를 변환하는 함수를 포함하고 있는 패키지가 tidyr
# 여기서 tidy는 organized 와 동일한 의미를 가짐
# tidyr은 Hadely Wickam이 개발한 reshape 와 reshape2 패키지가 포함하고 있는 전반적인 데이터 변환 함수 중 tidy data 를 만드는데 핵심적인 함수만으로 구성된 패키지





## 4.5.1 Tidy data
require(tidyverse)

# 데이터셋의 구성 요소
# a. 데이터셋은 관측갑(value)으로 구성
# b. 각 관찰값은 변수(variable)와 관측(observation) 단위에 속함
# c. 변수는 측정 속성과 단위가 동잏한 값으로 구성(예 : 키, 몸무게, 체온 등)
# d. 관측(observation)은 속성(변수)전체에서 동일한 단위(예 : 사람, 가구, 지역 등)에서 측정된 모든 값.


# Tidy data의 장점

# 표준화된 데이터 구조로 변수 및 관측치 추출이 용이
# 일관된 데이터 구조를 유지된다면 이와 관련한 도구(함수)를 배우는 것이 보다 용이함
# R의 vectorized programming 환경에 최적화  → 동일한 관측에 대한 서로 다른 변수값이 항상 짝으로 매칭되는 것을 보장

# Messy data의 일반적인 문제점

# 1. 열 이름을 변수명이 아닌 값(value)으로 사용
# 2. 두 개 이상의 변수에 해당하는 값이 하나의 열에 저장

# 이러한 문제를 해결 하기 위해 데이터의 구조 변환은 필수적이며, 이를 위해 tidyr패키지에서 아래와 같은 함수 제공
# gather(), pivot_longer() : 아래로 긴 데이터 셋(melt된 데이터셋) -> long format
# spread(), pivot_wider() : 옆으로 긴 데이터 셋(열에 cast된 데이터셋) -> wide format

# long format : 데이터가 적은 수의 열로 이루어지며, 각 열 보통 행의 unique한 정보를 표현하기 위한 ID(또는KEY)로 구성되어 있고 보통은 관측된 변수에 대한 한 개의 열로 구성된 데이터 형태

# wide format : 통계학에서 다루는 데이터 구조와 동일한 개념으로 한 관측단위(사람, 가구, 등)가 한 행을 이루고, 관측 단위에 대한 측정값(예 : 키, 몸무게, 성별)들이 변수로 표현 된 데이터 형태





## 4.5.2 Long format

# "long"형태의 데이터 구조는 "wide"형태의 데이터 보다 "사람"이 이해하기에는 편한 형태는 아니지만 아래와 같은 장점을 가짐
# 1. "컴퓨터"가 이해하기 편한 구조
# 2. "wide"형태보다 유연 -> 데이터의 추가 및 삭제 용이

# "wide"형태의 데이터를 "long"형태로 변환 해주는 tidyr 패키지 내장 함수는
# pivot_longer() : 데이터의 행의 길이를 늘리고 열의 개수를 줄이는 함수
# gather() : pivot_longer()의 이전 버전으로 보다 쉽게 사용할 수 있고, 함수 명칭도 보다 직관적이지만 함수 업데이트는 종료


# pivot_longer() 의 기본 사용 형태
pivot_longer(
  data, # 데이터 프레임
  cols, # long format으로 변경을 위해 선택한 열 이름
        # dplyr select() 함수에서 사용한 변수 선정 방법 준용
  names_to, # 선택한 열 이름을 값으로 갖는 변수명칭 지정
  names_prefix, # 변수명에 처음에 붙은 접두어 패턴 제거
  names_pattern, # 정규표현식의 그룹 지정() 에 해당하는 패턴을 값으로 사용
  valuse_to # 선택한 열에 포함되어 있는 셀 값을 지정할 변수 이름 지정
)

# gather()
gather(
  data, # 데이터 프레임
  key, # 선택한 열 이름을 값으로 갖는 변수명칭 지정
  value, # 선택한 열에 포함되어 있는 셀 값을 저장할 변수 이름 지정
  ... # long format으로 변경할 열 선택
  )

# Example
# 1. 열의 이름이 변수명이 아니라 값으로 표현된 경우

# 데이터 불러오기 : read_csv() 함수를 이용해 tidy-wide-ex01.csv 파일 불러오기
wide_01 <- read_csv("data/tidyr-wide-ex01.csv")
wide_01
# 총 21개의 열과 3개의 행으로 구성된 "wide"형태 데이터 구조
# 열 이름 2001~2020은 2001년부터 2020년까지 년도를 의미함
# 현재 데이터 구조에서 각 셀의값은 일인당 국민 소득을 나타냄
# 한 행은 국가(country)의 2001년부터 2020년 까지 년도 별 일인당 국민소득
# 여기서 관측단위는 국가(country)이며, 각 국가는 2001년부터 2020년까지 일인당 국민소득에 대한 관찰값을 가짐

# 위 데이터가 tidy data 원칙을 준수하려면 어떤 형태로 재구성 되야 할까?
# 1. 열 이름은 년도에 해당하는 값임 -> year라는 새로운 변수에 해당 값을 저장
# 2. 일인당 국민소득 정보를 포함한 gdp_cap 이라는 변수 생성

# long format의 데이터 구조
# Unique한 각각의 관측결과는 하나의 행에 존재
# 데이터에서 변수로 표한할 수 있는 속성은 모두 열로 표시
# 각 변수에 해당하는 값은 하나의 셀에 위치

# 예시1 : wide_01 데이터셋

# pivot_longer() 사용
tidy_ex_01 <- wide_01 %>%
  pivot_longer(`2001` : `2020`,
               names_to = "year",
               values_to = "gdp_cap",
               )
tidy_ex_01

# gather() 사용
tidy_ex_02 <- wide_01 %>%
  gather(year, gdp_cap, `2001` : `2020`)
tidy_ex_02


# 예시2 : billboard 데이터셋
billboard
names(billboard)

# pivot_longer() 사용
billb_tidy <- billboard %>%
  pivot_longer(starts_with("wk"),
               names_to = "week",
               values_to = "rank")
billb_tidy

# names_prefix 인수 값 설정을 통해 변수명에 처음에 붙는 접두어(예 : V, wk 등) 제거 가능
billb_tidy <- billboard %>%
  pivot_longer(starts_with("wk"),
               names_to = "week",
               values_to = "rank",
               names_prefix = "wk",
               values_drop_na = TRUE)
billb_tidy

# pivot_longer() 함수의 인수 중 names_ptypes 또는 valuse_ptypes 인수 값 설정을 통해 새로 생성한 변수(name과 value 에 해당하는)의 데이터 타입 변경 가능
billb_tidy <- billboard %>%
  pivot_longer(starts_with("wk"),
               names_to = "week",
               values_to = "rank",
               names_prefix = "wk",
               names_ptypes = list(week = as.integer()),
               values_drop_na = TRUE)
billb_tidy

# 연습문제 : wide_01 데이터에서 year을 정수형으로 변환(mutate 함수사용 x)
wide_ex <- wide_01 %>%
  pivot_longer(`2001` : `2020`,
               names_to = "year",
               values_to = "gdp_cap",
               names_ptypes = list(year = as.integer()))
wide_ex



# Example
# 2. 두개 이상의 변수에 해당하는 값이 하나의 열에 저장

# 예시 데이터 : tidtr패키지에 내장되어 있는 who 데이터셋
who

# 데이터 정돈 전략(pivot_longer()이용)
# 1. country, iso2, iso3, year은 정상적인 변수 형태임 -> 그대로 둔다
# 2. names_to 인수에 diagnosis, sex, age_group로 변수명을 지정
# 3. names_prefix 인수에서 접두어 제거
# 4. names_pattern 인수에서 추출한 변수의 패턴을 정규표현식을 이용해 표현(각 변수는()으로 구분) -> _를 기준으로 왼쪽에는 (소문자 알파벳이 하나 이상 존재하고), 오른쪽에는(m또는f)와 (숫자가 1개이상)인 패턴
# 5. naems_ptypes 인수를 이용해 생성한 변수의 데이터 타입 지정
#   diagnosis : factor
#   sex : factor
#   age_group : factor
# 6. values_to : 인수에 longer 형태로 변환 후 생성된 값을 저장한 열 이름 count 지정
# 7. values_drop_na 인수를 이용해 결측 제거

# pivot_longer()를 이용해 who 데이터셋 데이터 정돈
who_tidy <- who %>%
  pivot_longer(
    new_sp_m014:newrel_f65,
    names_to = c("diagnosis", "sex", "age_group"),
    names_prefix = "^new_?",
    names_pattern = "([a-z]+)_(m|f)([0-9]+)",
    names_ptypes = list(diagnosis = factor(levels = c("rel","sn","sp","ep")),
                        sex = factor(levels = c("f","m")),
                        age_group = factor(levels = c("014", "1524", "2534", "3544", "4554",
                                                      "5564", "65"),
                                           ordered = TRUE)
  ),
  values_to = "count",
  values_drop_na = TRUE)
who_tidy





## 4.5.3 Wide format
# longer formar의 반대가 되는 데이터 형태
# 관측 단위의 측정값(예 : 다수 변수들)이 다중 행으로 구성된 경우 tidy data를 만들기 위해 wide format으로 데이터 변환 요구
# 요약표 생성 시 유용하게 사용
# "long" 형태의 데이터를 "wide"형태로 변환 해주는 tidyr 패키지 내장 함수는
#   pivot_wider() : 데이터의 행을 줄이고 열의 개수를 늘리는 함수
#   spread() : pivot_wider()의 이전 버전

# pivot_wider()의 기본 사용 형태
pivot_wider(
  data, # 데이터 프레임
  names_from, # 출력 시 변수명으로 사용할 값을 갖고 있는 열 이름
  values_from, # 위에서 선택한 변수의 각 셀에 대응하는 측정 값을 포함하는 열 이름
  values_fill # 
)

# spread() 기본 사용 형태
spread(
  data, # 데이터 프레임
  key, # 출력 시 변수명으로 사용할 값을 갖고 있는 열 이름
  value, # 위에서 선택한 변수의 각 셀에 대응하는 측정 값을 포함하는 열 이름
)



# Example

# 1. pivot_longer()와의 관계
# 위 예시에서 생성한 tidy_ex_01 데이터 예시
# long format 으로 변환환 데이터를 다시 wide format으로 qusrud

# pivot_wider() 함수
wide_ex_01 <- tidy_ex_01 %>%
  pivot_wider(
    names_from = year,
    values_from = gdp_cap
  )
wide_ex_01
tidy_ex_01
all.equal(wide_01, wide_ex_01) # 데이터 동일성 확인인


# spread() 함수
wide_ex_01 <- tidy_ex_01 %>%
  spread(year, gdp_cap)
wide_ex_01



# 2. 관측 단위의 측정값(예 : 다수 변수들)이 다중행으로 구성된 데이터 구조 변환
# 예시 데이터 : table2 데이터셋
table2

# type 변수의 값은 사실 관측 단위의 변수임
# type 값에 대응하는 값을 가진 변수는 count임

# pivot_wider() 함수
table2_tidy <- table2 %>%
  pivot_wider(
    names_from = type,
    values_from = count
  )
table2_tidy



# 3. 데이터 요약 테이블
# 예시 데이터 : mtcars 데이터셋

# 1) 행 이름을 변수로 변환 후 long format 변환
# rownames_to_column() 함수 사용
mtcars2 <- mtcars %>%
  rownames_to_column(var = "model") %>%
  pivot_longer(
    -c("model","vs","am"),
    names_to = "variable",
    values_to = "value"
  )
mtcars2

# 2) 엔진 유형 별 variable의 평균과 표준편차 계산
mtcars2 %>%
  mutate(vs = factor(vs,
                     labels = c("V-shaped",
                                "Straight"))) %>%
  group_by(vs, variable) %>%
  summarise(Mean = mean(value),
            SD = sd(value)) %>%
  pivot_longer(
    Mean:SD,
    names_to = "star",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = variable,
    values_from = value
  )


# 조금 더 응용...
# 위 Mean ± SD 형태로 위와 유사한 구조의 테이블 생성
# tip: 한글로 "ㄷ(e) + 한자" 통해 ± 입력 가능

mtcars2 %>%
  mutate(vs = factor(vs,
                     labels = c("V-shaped",
                                "Straight"))) %>%
  group_by(vs,variable) %>%
  summarise(Mean = mean(value),
            SD = sd(value)) %>%
  mutate(res = sprintf("%.1f ± %.1f",
                       Mean, SD)) %>%
  select(-(Mean:SD)) %>%
  pivot_wider(
    names_from = variable,
    values_from = res
  )





## 4.5.4 Separate and unite
# 하나의 열을 구성하는 값이 두개 이상 변수가 혼합되어 한 셀에 표현된 경우 이를 분리해야 할 필요가 있음 -> srparate()
# 하나의 변수에 대한 값으로 표현할 수 있음에도 불구하고 두 개 이상의 변수로 구성된 경우(예 :날짜 변수의 경우 간혹 year, month, day와 같이 3개의 변수로 분리), 이를 연결하여 하나의 변수로 변경 필요 -> unite()


## Separate
# separate() : 지정한 구분 문자가 존재하는 경우 이를 쪼개서 하나의 열을 다수의 열로 분리
# separate() 함수 기본 사용 형태
separate(
  data, # 데이터 프레임
  col, # 분리 대상이 되는 열 이름
  into, # 분리 후 새로 생성한 열들에 대한 이름(문자형 벡터)지정
  sep = "[^[:alnum:]]+", # 구분자 : 분리 할 대상이 되는 값의 구분 단위(기본적으로 정규표현식 사용)
  concvert # 분리한 열의 데이터 타입 변환 여부
)


# 예시 : table3 데이터셋
table3

# rate 변수를 case와 population 으로 분리
table3 %>%
  separate(rate,
           into = c("case","population"),
           sep = "/")

table3 %>%
  separate(rate,
           into = c("case","population"),
           convert = TRUE) -> table3_sep

# sep 인수값이 수치형 백터인 경우 : 분리할 위치로 인식
# 양수: 문자열 맨 왼쪽에서 1부터 시작
# 음수: 문자열 맨 오른쪽에서 -1부터 시작
# sep의 길이(length)는 into 인수의 길이보다 작아야 함

# year 변수를 century와 year로 분할
table3 %>%
  separate(year,
           into = c("century", "year"),
           sep = -2) 




## Unite
# unite() : seprate() 함수의 반대 기능을 수행하며, 다수 변수를 결합
# unite() 함수 기본 사용 형태
unite(
  data, # 데이터 프레임
  col, # 새로 생성할 변수 이름
  ..., # 선택한 열 이름
  sep, # 연결 구분자
  )

# 예제 : table5 데이터셋
table5

# centry 와 year을 결합한 new 변수 생성
table5 %>%
  unite(new, century, year) 

# _없이 결합 후 new를 정수형으로 변환
table5 %>%
  unite(new, century, year, sep = "") %>%
  mutate(new = as.integer(new))

# table5 데이터 정돈(seaprate(), unite() 동시 사용)
table5 %>%
  unite(new, century, year, sep = "") %>%
  mutate(new = as.integer(new)) %>%
  separate(rate, c("case", "population"),
           convert = TRUE)


# 응용 예제 : mtcars 데이터셋에서 계산한 통계량 정리

# 기어 종류(`am`) 별 `mpg`, `cyl`, `disp`,`hp`, `drat`, `wt`, `qsec`의 평균과 표준편차 계산
mtcar_summ1 <- mtcars %>%
  mutate(am = factor(am, labels = c("automatic","manual"))) %>%
  group_by(am) %>%
  summarise_at(vars(mpg:qsec),
               list(mean = ~mean(.),
                    sd = ~sd(.)))
mtcar_summ1

# am을 제외한 모든 변수에 대해 long foramt 으로 데이터 변환
mtcar_summ2 <- mtcar_summ1 %>%
  pivot_longer(
    -am,
    names_to = "stat",
    values_to = "value"
  )
mtcar_summ2

# stat 변수를 "variable", "statistic" 으로 분리 후 variable과 value를 wide_format으로 데이터 변환
mtcar_summ3 <- mtcar_summ2 %>%
  separate(stat, c("variable","statistic")) %>%
  pivot_wider(
    names_from = variable,
    values_from = value
  )
mtcar_summ3



# Tidy data를 만들기 위한 과정이 꼭 필요할까 ? -> long format 데이터가 정말 필요할까?

# ggplot trailer: 4.5.2 절 Long format 에서 예시 데이터로 활용한 wide-01 데이터 셋을 이용해 국가별 연도에 따른 일인당 국민소득 추이를 시각화

# Strategy
# 1. wide-01 데이터 형태 그대로 시각화
# 2. wide-01을 long format으로 변환한 tidy_ex_01 에서 시각화

tidy_ex_01 <- wide_01 %>%
  pivot_longer(
    `2001`:`2020`,
    names_to = "year",
    values_to = "gdp_cap",
    names_ptypes = list(year = as.integer())
  )

# wide_01
tidy_ex_01 %>%
  ggplot +
  aes(x = year, y = gdp_cap,
      color = country,
      group = country) +
  geom_point(size = 3) +
  geom_line(size = 1) +
  labs(x = "Year",
       y = "Total GDP/captia") +
  theme_classic()

# tidy_ex_01
tidy_ex_01 %>%
  ggplot +
  aes(x = year, y = gdp_cap,
      group = country) +
  geom_point(size = 3) +
  geom_line(size = 1) +
  labs(x = "year",
       y = "Total GDP/captia") +
  facet_grid(~ country) +
  theme_minimal()
