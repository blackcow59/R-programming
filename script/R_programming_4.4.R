### 4.4 dplyr 패키지
# dplyr 은 tidyverse 에서 데이터 전처리를 담당하는 패키지로 데이터 전처리 과정을 쉽고 빠르게 수행할 수 있는 함수로 구성된 패키지임
require(tidyverse)

# dplyr 에서 제공하는 가장 기본 "동사"는 다음과 같다

# filter() : 각 행(row)을 조건에 따라 선택
# arrange() : 선택한 변수(column)에 해당하는 행(row)을 기준으로 정렬
# select() : 변수(column) 선택
# mutate() : 새로운 변수를 추가하거나 이미 존재하는 변수를 변환
# summarize() or summarise() : 변수 집계(평균, 표준편차, 최댓값, 최솟값, ...)
# group_by() : 위 열거한 모든 동사들을 그룹별로 적용


# dplyr 기본 동사와 연동해서 사용되는 주요 함수

# slice(): 행 색인을 이용한 추출  → data[n:m, ]과 동일
# distinct(): 행 레코드 중 중복 항복 제거  → base R 패키지의 unique() 함수와 유사
# sample_n(), sample_frac(): 데이터 레코드를 랜덤하게 샘플링
# rename(): 변수명 변경
# inner_join, right_join(), left_join(), full_join : 두 데이터셋 병합  → merge() 함수와 유사
# tally(), count(), n(): 데이터셋의 행의 길이(개수)를 반환하는 함수로 (그룹별) 집계에 사용: length(), nrow()/NROW() 함수와 유사
# *_all,, *_at, *_if: dplyr에서 제공하는 기본 동사(group_by() 제외) 사용 시 적용 범위를 설정해 기본 동사와 동일한 기능을 수행하는 함수




## 4.4.1 파이프 연산자 : %>%
# Tidyverse 세계에서 tidy를 담당하는 핵심적인 함수
# 여러 함수를 연결(chain)하는 역할을 하며, 이를 통해 불필요한 임시변수를 정의할 필요가 없어짐
# function_1(x) %>% function_2(y) = function_2(function_1(x), y) 
# -> function_1(x) 에서 반환한 값을 function()의 첫 번째 인자로 사용
# x %>% f(y) %>% g(z) = ?
# 기존 R 문법과 차이점
# 기존 R :동사(목적어, 주변수, 나머지 변수)
# Pipe 연결 방식 : 목적어 %>% 동사(주변수, 나머지 변수)

# 예시

# base R 문법적용
print(head(iris, 4))

# %>% 연산자 이용
iris %>% head(4) %>% print

# setosa 종에 해당하는 변수들의 평균 계산
apply(iris[iris$Species == "setosa", -5], 2, mean)

# tidyverse 의 pipe 연산자 이용
iris %>%
  filter(Species == "setosa") %>%
  select(-Species) %>%
  summarise_all(mean)

# Homework #3 b-c 풀이를 위한 pipe 연산 적용
# df <- within(df, {
#   am <- factor(am, levels = 0:1, 
#                labels = c("automatic", "manual"))
# })
# ggregate(cbind(mpg, disp, hp, drat, wt, qsec) ~ am, 
#           data = df, 
#           mean)
# aggregate(cbind(mpg, disp, hp, drat, wt, qsec) ~ am, 
#           data = df, 
#           sd)

mtcars %>%
  mutate(am = factor(vs,
                     levels = 0:1,
                     labels = c("automatic", "manual"))) %>%
  group_by(am) %>%
  summarise_at(vars(mpg, disp:qsec),
               list(mean = mean,
                    sd = sd))


## 4.4.2 filter()

# 행 조작 동사
# 데이터 프레임(또는 tibble)에서 특정 조건을 만족하는 레코드(row)추출
# R base 패키지의 subset() 함수와 유사하게 작동하지만 성능이 더 좋음(속도가 더 빠르다)
# 추출을 위한 조건은 2.1.4절 논리형 스칼라에서 설명한 비교 연산자를 준용함. 단 filter()함수 내에서 and(&)조건은 ,(콤마, comma)로 표현 가능

# filter() 동사 prototype
dplyr::filter(x, # 데이터 프레임 또는 티블 객체
              condition_01, # 첫 번째 조건
              condition_02, # 두 번째 조건
                            # 두 번째 조건 이후의 조건들은
                            # condition_1 & condition_2 & ... & condition_n 임
              )

# 예시

# mpg 데이터 코드북
# 데이터 구조 확인을 위해 dplyr 패키지에서 제공하는 glimpse() 함수(str()유사) 사용
glimpse(mpg)


# 현대 차만 추출 

# 기본 문법 사용
mpg[mpg$manufacturer == "hyundai",]
subset(mpg, manufacturer == "hyundai")

# filter() 함수 사용
filter(mpg, manufacturer == "hyundai")

# pipe 연산자 사용
mpg %>%
  filter(manufacturer == "hyundai")


# 시내 연비가 20 mile/gallon 이상이고 타입이 suv 차량 추출

# 기본 문법 사용
mpg[mpg$cty >= 20 & mpg$class == "suv",]
subset(mpg, cty >= 20 & class == "suv")

# filter() 함수 사용
filter(mpg, cty >= 20, class == "suv")

# pipe 연산자 사용
mpg %>%
  filter(cty >= 20, class == "suv")


# 제조사가 audi 또는 volkwagen 이고 고속 연비가 30 miles/gallon 인 차량만 추출
mpg %>%
  filter(manufacturer == "audi" | manufacturer == "volkswagen",
         hwy >= 30)




## 4.4.3 arrange()

# 행 조작 동사
# 지정한 열을 기준으로 데이터의 레코드(row)를 오름차순(작은 값부터 큰 값)으로 정렬
# 내림차순(큰 값부터 작은값) 정렬 시 desc() 함수 이용
arrange(data, # 데이터 프레임 또는 티블 객체
        var1, # 기준 변수 1
        var2, # 기준 변수 2
        ...)

# 예시 

# 시내 연비를 기준으로 오름차준 정렬

# 기본 문법 사용
mpg[order(mpg$cty),]

# arrange() 함수 사용
arrange(mpg, cty)

# pipe 연산자 사용
mpg_asc <- mpg %>% arrange(cty)
mpg_asc %>% print


# 시내 연비는 오름차순, 차량 타입은 내림차순(알파벳 역순)정렬

# 기본 문법 사용 (문자형 벡터의 순위 계산을 위해 rank() 함수 사용)
mpg_sortb <- mpg[order(mpg$cty, -rank(mpg$class)),]
mpg_sortb

# arrange 함수 사용
mpg_sortt <- mpg %>% arrange(cty, desc(class))
mpg_sortt %>% print

# 두 데이터 셋 동일성 여부
identical(mpg_sortb, mpg_sortt)



## 4.4.4 select()

# 열 조작 동사
# 데이터셋을 구성하는 열(column, variable)을 선택하는 함수
select(
  data, # 데이터프레임 또는 티블 객체
  var_name1, # 변수이름 (따옴표 없이도 가능)
  var_name2,
  ...
)

# 예시

# 제조사(manufacturer), 모델명(model), 베기량(displ), 제조년도(year), 시내연비(cty)만 추출

# 기본 문법 사용
glimpse(mpg[,c("manufacturer","model","displ","year","cty")])
glimpse(mpg[,c(1:4, 8)])
glimpse(mpg[,names(mpg) %in% c("manufacturer", "displ", "model", "year", "cty")])

# select() 함수 사용
mpg %>% select(1:4, 8)
mpg %>% select(c(manufacturer, model, displ, year, cty))
mpg %>%
  select(manufacturer, model, displ, year, cty) %>%
  glimpse


# R 기본 문법과 차이점
# 선택하고자 하는 변수 입력 시 따옴표가 필요 없음
# : 연산자를 이요해 선택 변수의 범위 지정 가능
# - 연산자를 이용해 선택 변수 제거


# 제조사(manufacturer), 모델명(model), 배기량(displ), 제조년도(year), 시내연비(cty) 만 추출
# select() 따옴표 없이 변수명 입력
mpg %>%
  select(manufacturer, model, displ, year, cty) %>%
  glimpse

# : 연산자로 변수 범위 지정
mpg %>%
  select(manufacturer:year, cty) %>%
  glimpse

# 조금 더 간결하게 (':'와'-' 연산 조합)
mpg %>%
  select(-cyl:-drv, -hwy:-class) %>%
  glimpse

# 동일한 기능 : - 는 괄호로 묶을 수 있음
mpg %>%
  select(-(cyl:drv), -(hwy:class)) %>%
  glimpse

# select() 함수를 이용해 변수명 변경 가능
mpg %>%
  select(city_mpg = cty) %>%
  glimpse



# select() 와 조합 시 유용한 선택 함수
# star_with("abc") : "abc"로 시작하는 변수 선택
# ends_with("xyz") : "xyz"로 끝나는 변수 선택
# contains("def") ; "def"를 포함하는 변수 선택
# matches("^F[0-9]") : 정규표현식과 일치하는 변수 선택. "F"와 한 자리 숫자로 시작하는 변수 선택
# everything() : select() 함수 내에서 미리 선택한 변수를 제외한 모든 변수 선택


# 예시

# "m" 으로 시작하는 변수 제거

# 기존 select() 함수 사용
mpg %>%
  select(-manufacturer, -model) %>%
  glimpse

# select() + start_with() 함수 사용
mpg %>%
  select(-starts_with("m")) %>%
  glimpse


# dplyr 내장 데이터 : starwars에서 이름, 성별, "color"를 포함하는 변수 선택

# contains() 함수 사용
starwars %>%
  select(name, gender, contains("color")) %>%
  head


# mpg 데이터 : 맨 마지막 문자가 "y"로 끝나는 변수 선택(제조사, 모델 포함)

# matches() 함수 사용
mpg %>%
  select(starts_with("m"), matches("y$")) %>%
  glimpse


# cty, hwy 변수를 각각 1-2 번째 열에 위치
mpg %>%
  select(matches("y$"), everything()) %>%
  glimpse




## 4.4.5 mutate()

# 열 조작 동사 : 새로운 열을 추가하는 함수로 기본 R 문법의 data$new_variable <- value 와 유사한 기능을 함
# 주어진 데이터 셋(데이터프레임)에 이미 존재하고 있는 변수를 이용해 새로운 값 변환 시 유용
# 새로 만들 열을 mutate() 함수 내에서 사용 가능 -> R base 패키지에서 제공하는 transform() 함수는 mutate() 함수와 거의 동일한 기능을 하지만, transform() 함수 내에서 생성한 변수의 재사용이 불가능함


# 예시

# mpg 데이터 셋의 연비 단위는 miles/gallon 으로 입력 -> kmh/l 로 변환

mile <- 1.61 #km
gallon <- 3.79 #Litres
kpl <- mile/gallon

# 기본 문법 사용
glimpse(transform(mpg,
                  cty_kpl = cty * kpl,
                  hwy_kpl = hwy * kpl))

# tidyverse 문법
mpg %>%
  mutate(cty_kpl = cty*kpl,
         hwy_kpl = hwy*kpl) %>%
  glimpse

# 새로 생성한 변수를 이용해 변환 변수를 원래 단위로 바꿔보기

# 기본 문법 사용
glimpse(transform(mpg,
                  cty_kpl = cty*kpl,
                  hwy_kpl = hwy*kpl,
                  cty_raw = cty_kpl/kpl,
                  hwy_raw = hwy_kpl/kpl))

# Tidyverse 문법
mpg %>%
  mutate(cty_kpl = cty*kpl,
         hwy_kpl = hwy*kpl,
         cty_raw = cty_kpl/kpl,
         hwy_raw = hwy_kpl/kpl) %>%
  glimpse




## 4.4.6 transmute()

# 열 조작 동사 : mutate() 와 유사한 기능을 하지만 추가 또는 변환된 변수만 반환
# mutate()와 유사한 기능을 하지만 추가 또는 변환된 변수만 반환
'연비' <- mpg %>%
  transmute(cty_kpl = cty*kpl,
            hwy_kpl = hwy*kpl,
            cty_raw = cty_kpl/kpl,
            hwy_raw = hwy_kpl/kpl)
`연비` %>% print



## 4.4.7 summarise()

# 변수 요약 및 집계 : 변수를 집계하는 함수로 R stat패키지의 aggregate() 와 유사한 기능을 함
# 보통 mean(), sd(), var(), median(), min(), max()등 요약 통계량을 반환하는 함수와 같이 사용
# 데이터프레임(티블) 객체 반환
# 변수의 모든 레코드에 집계 함수를 적용하므로 summarise() 만 단일로 사용하면 1개의 행만 반환


# 예시

# cty, hwy의 평균과 표준편차 계산
mpg %>%
  summarise(mean_cty = mean(cty),
            sd_cty = sd(cty),
            mean_hwy = mean(hwy),
            sd_hwy = sd(hwy))




## 4.4.8 group_by()

# 행 그룹화
# 보통 summarise() 함수는 aggregate() 함수와 유사하게 그룹 별 요약 통계량을 계산할 때 주로 사용됨
# group_by() 는 "주어진 그룹에 따라(by group)", 즉 지정한 그룹(변수)별 연산을 지정

# 예시

# 모델, 년도에 따른 cty, hwy 평균 계산
by_mpg <- group_by(mpg, model, year)
by_mpg %>%
  head %>%
  print

# 통계량 계산
by_mpg %>%
  summarise(mean_cty = mean(cty),
            mean_hwy = mean(hwy)) %>%
  print

# by_group() : chain 연결
mean_mpg <- mpg %>%
  group_by(model, year) %>%
  summarise(mean_cty = mean(cty),
            mean_hwy = mean(hwy)) %>%
  print


# group_by() 이후 적용되는 동사는 모두 그룹 별 연산 수행

# 제조사 별 시내연비가 낮은 순으로 정렬
audi <- mpg %>%
  group_by(manufacturer) %>%
  arrange(cty) %>%
  filter(manufacturer == "audi")
audi %>% print





## 4.4.9 dplyr 관련 유용한 함수

# 데이터 핸들링시 dplyr 기본 함수와 같이 사용되는 함수 모음


# 4.4.9-1 slice()

# 행 조작 동사 : filter()의 특별한 케이스로 데이터의 색인을 직접 설정하여 원하는 행 추출

# 1~8행에 해당하는 데이터 추출
slice_mpg <- mpg %>% slice(1:8)
slice_mpg

# 각 모델 별 첫 번째 데이터만 추출
slice_mpg_grp <- mpg %>%
  group_by(model) %>%
  slice(1) %>%
  arrange(model)
slice_mpg_grp


# 4.4.9-2 top_n()

# 행 조작 동사 : 선택한 변수를 기준으로 상위 n개의 데이터만 추출

# mpg 데이터에서 시내연비가 높은 5개의 데이터만 추출
mpg %>%
  top_n(5,cty) %>%
  arrange(desc(cty))


# 4.4.9-3 distinct()

# 행 조작 동사 : 선택한 변수를 기준으로 중복 없는 유일한 행 추출 시 사용

# mpg 데이터에서 중복 데이터 제거
mpg_uniq <- mpg %>% distinct()
mpg_uniq; mpg

# model을 기준으로 중복 데이터 제거
mpg_uniq2 <- mpg %>%
  distinct(model, .keep_all = TRUE) %>%
  arrange(model)
mpg_uniq2

# 위 그룹별 silce(1) 예제와 비교
identical(slice_mpg_grp %>% ungroup, mpg_uniq2)


# 4.4.9-4 sample_n()/ sample_frac()

# 행 조작 동사 : 데이터의 행을 랜덤하게 추출하는 함수
# sample_n(k) : 전체 행에서 k개의 행을 랜덤하게 추출
# sample_frac(p) : 전체 행에서 비율p(0~1)만큼 추출

# 234개 행에서 3개의 행을 랜덤하게 추출
mpg %>% sample_n(3)

# 234개 행에서 5%에 해당하는 행을 램덤하게 추출
mpg %>% sample_frac(0.05)


# 4.4.9-4 rename()

# 열 조작 동사 : 변수의 이름을 변경하는 함수
# rename(new_name = old_name) 형태로 변경

# 예시

# 기본 문법 사용
varn_mpg <- names(mpg) # 원 변수명 저장
names(mpg)[5] <- "cylinder" # cyl(5번째 변수)을  cylinder로 변경
names(mpg) <- varn_mpg

# Tidyverse 문법 : rename()사용
mpg %>%
  rename(cylinder = cyl)

# cty를 city_mpg, hwy를 hw_mpg 로 변경
mpg %>%
  rename(city_mpg = cty,
         hw_mpg = hwy)


## 4.4.9-5 count 관련 동사

# 데이터셋의 행 개수를 집계하는 함수들로 데이터 요약 시 유용하게 사용

# tally()
# 총계, 행의 개수를 반환하는 함수
# 데이터프레임(티블) 객체 반환
mpg %>% tally

# 제조사, 년도별 데이터 개수
mpg %>%
  group_by(manufacturer,year) %>%
  tally %>%
  ungroup


# count()
# tally() 함수와 유사하나 개수 집계 전 group_by()와 집계 후 ungroup()을 해줌

# 제조사, 년도별 데이터 개수
mpg %>%
  count(manufacturer,year)


# n()
# 위에서 소개한 함수와 유사하게 행 개수를 반환하지만, 기본동사(summarise(), mutate(), filter() )내에서만 사용

# 제조사, 년도에 따른 배기량, 시내연비의 평균 계산
mpg %>%
  group_by(manufacturer,year) %>%
  summarise(
    N = n(),
    mean_displ = mean(displ),
    mean_cty = mean(cty)
  )

# mutate(), filter() 에서 사용하는 경우
mpg %>%
  group_by(manufacturer,year) %>%
  mutate(N = n()) %>%
  filter(n() < 4)
mpg




## 4.4.10 부가기능

# 위에서 소개한 dplyr 패키지의 기본 동사 함수를 조금 더 효율적으로 사용 하기 위한 범위 지정 함수로서 아래와 같은 부사(adverb), 접속사 또는 전치사가 본 동사 뒤에 붙음

# a. *_all : 모든 변수에 적용
# b. *_at : vars() 함수를 이용해 선택한 변수에 적용
# c. *_if : 조건식 또는 조건 함수로 선택한 변수에 적용
# 여기서 * = {filter, arrange, select, rename, mutate, transmute, summarise, broup_by}

# 적용할 변수들은 대명사로 지칭되며 .로 나타냄
# vars()는 *_at 계열 함수 내에서 변수를 선택해주는 함수로  select() 함수와 동일한 문법으로 사용 가능 (단독으로는 사용하지 않음)



# filter_all(), filter_at(), filter_if()

# filter_all() : all_vars() 또는 any_vars() 라는 조건 함수와 강티 사용되며, 해당 함수 내에 변수는 대명사 . 로 나타냄
# filter_at() : 변수 선택 지시자 vars()와 vars() 에서 선택한 변수에 적용할 조건식 또는 조건 함수를 인수로 받음. 조건식 설정 시 vars()에 포함된 변수들은 대명사. 으로 표시
# filter_if() : 조건을 만족하는 변수들을 선택한 후 , 선택한 변수들 중 모두 또는 하나라도 입력한 조건들을 만족하는 행 추출

# 예시

# mtcars 데이터셋 사용

# filter_all()
# 모든 변수들이 100보다 큰 케이스 추출
mtcars %>%
  filter_all(all_vars(. > 100))

# 모든 변수들 중 하나라도 300보다 큰 케이스 추출
mtcars %>%
  filter_all(any_vars(. > 100))

# filter_at()
# 기어 개수(gear)와 기화기 개수(carb)가 짝수인 케이스만 추출
mtcars %>%
  filter_at(vars(gear,carb),
            ~ . %% 2 == 0) # 대명사 앞에 ~ 표시를 꼭 사용해야 함

# filter_if()
# filter_if(~ all(floor(.) == .),
#           ~ . ! = 0))
# 내림한 값이 원래 값과 같은 변수들 모두 0이 아닌 케이스 추출
mtcars %>%
  filter_if(~ all(floor(.) == .),
            all_vars(. != 0)) 



# select_all(), select_at(), select_if()

# 변수 선택과 변수명 변경을 동시에 수행

# select_all()
# mpg 데이터셋의 모든 변수명을 대문자로 변경
mpg %>%
  select_all(~toupper(.))

# select_if() 
# 문자형 변수를 선택하고 선택한 변수의 이름을 대문자로 변경
mpg %>%
  select_if(~ is.character(.),  ~ toupper(.))

# select_at()
# model에서 cty 까지 변수를 선택하고 선택한 변수명을 대문자로 변경
mpg %>%
  select_at(vars(model:cty), ~ toupper(.))



# mutate_all(), mutate_at(), mutate_if()

# 실제 데이터 전처리 시 가장 많이 사용

# mutate_all() : 모든 변수에 적용
# mutate_at() : 선택한 변수에 적용. vars() 함수로 선택
# mutate_if() : 특정 조건을 만족하는 변수에 적용

# mutate_all()
# 문자형 변수를 선택 후 모든 변수를 요인형으로 변환
mpg %>%
  select_if(~is.character(.)) %>%
  mutate_all(~factor(.))

# mutate_at()
# cty, hwy 단위를 km/l로 변경
mpg %>%
  mutate_at(vars(cty,hwy),
            ~ . *kpl)
# "m" 으로 시작하거나 "s"로 끝나는 변수 선택 후 요인형으로 변환
mpg %>%
  mutate_at(vars(starts_with("m"), ends_with("s")),
         ~ factor(.)) %>%
  summary

# mutate_if()
# 문자형 변수를 요인형으로 변환
mpg %>%
  mutate_if(~ is.character(.), ~ factor(.))




# summarise_all(), summarise_at(), summarise_if()

# 사용 방법은 mutate_* 과 동일
# 다중 변수 요약 시 코드를 효율적으로 작성할 수 있음

# summarise_all()
# 모든 변수의 최솟값과 최댓값 요약
# 문자형 변수는 알파벳 순으로 최솟값과 최댓값 반환
# 복수의 함수를 적용 시 list() 함수 사용
mpg %>%
  summarise_all(list(min = ~ min(.),
                     max = ~ max(.))) %>%
  glimpse

# summarise_at()
# dipl, cyl, cty, hwy 에 대해 제조사 별 n 수와 평균과 표준편차 계산
mpg %>%
  add_count(manufacturer) %>% # 행 집계 결과를 열 변수로 추가하는 함수
  group_by(manufacturer, n) %>%
  summarise_at(vars(displ, cyl, cty, hwy),
               list(mean = ~ mean(.),
                    sd = ~ sd(.)))

# summaris_if()
# 1) 문자형 변수이거나 모든 값이 1999보다 크거나 같은 변수 이거나 8보다 작거나 같고 정수인 변수를 factor로 변환
# 2) 수치형 변수에 대한 제조사별 n, 평균, 표준편차를 구한 후
# 3) 평균 cty(cty_mean) 기준 내림차순으로 정렬
mpg %>%
  mutate_if(~ is.character(.) | all(. >= 199) | (all(. <= 8) & is.integer(.)),
            ~ factor(.)) %>%
  add_count(manufacturer) %>%
  group_by(manufacturer, n) %>%
  summarise_if(~ is.numeric(.),
               list(mean = ~ mean(.),
                    sd = ~ sd(.))) %>%
  arrange(desc(cty_mean))





## 4.4.11 데이터 연결

# 분석용 데이터를 만들기 위해 연관된 복수의 데이터 테이블을 결합하는 작업이 필수임
# 서로 연결 또는 연관된 데이터를 관계형 데이터(relational data)라고 칭함
# 관계는 항상 한 쌍의 데이터 테이블 간의 관계로 정의

# 관계형 데이터 작업을 위해 설계된 3가지 "동사" 유형
# a. Mutating join : 두 데이터 프레임 결합 시 두 테이블 간 행이 일치하는 경우 첫 번째 테이블에 새로운 변수 추가
# b. Filtering join : 다른 테이블의 관측치와 일치 여부에 따라 데이터 테이블의 행을 필터링
# c. Set operation : 데이터 셋의 관측치를 집합 연산으로 조합

# R base 패키지에서 제공하는 merge() 함수로 mutating join에 해당하는 두 데이터간 병합이 가능하지만 앞으로 배울 *_join()로도 동일한 기능을 수행할 수 있고, 다음과 같은 장점을 가짐
# 행 순서를 보존
# merge() 에 비해 코드가 직관적이고 빠름

# *_join() 과 merge() 비교
# inner_join(x, y)	merge(x, y)
# left_join(x, y)	  merge(x, y, all.x = TRUE)
# right_join(x, y)	merge(x, y, all.y = TRUE)
# full_join(x, y)	  merge(x, y, all.x = TRUE, all.y = TRUE)

# 예제
# 데이터 : nycflights13
# flights, airlines, airports, planes, weather 총 5개의 데이터 프레임으로 구성되어 있으며, 데이터 구조와 코드북은 다음과 같다.
install.packages("nycflights13")
require(nycflights13)
flights # 336,776 건의 비행에 대한 기록과 19개의 변수로 구성되어 있는 데이터셋
airlines # 항공사 이름 및 약어 정보로 구성성
airports # 각 공항에 대한 정보를 포함한 데이터셋이고 faa 는 공항 코드드
planes # 항공기 정보(제조사, 일련번호, 유형)에 대한 정보를 포함한 데이터셋
weather # 뉴욕시 각 공항 별 날씨 정보

# 열거한 각 테이블은 한 개 또는 복수의 변수로 연결 가능
# flights  ⟷ planes (by tailnum)
# flights  ⟷ airlines (by carrier)
# flights  ⟷ airports (by origin, dest)
# flights  ⟷ weather (by origin, year, month, day, hour)

# 각 쌍의 데이터를 연결하는데 사용한 변수를 키(key)라고 지칭
# a. 기준 테이블의 키 -> 기본키(primary key)
# b. 병합할 테이블의 키 -> 외래 키(foreign key)
# c. 다수의 변수를 이용한 기본키 및 외래키 생성 가능



# inner_join()
# 두 데이터셋 모두에 존재하는 키 변수가 일치하는 행을 기준으로 병함
x <- tribble(
  ~key, ~val_x,
     1, "x1",
     2, "x2",
     3, "x3"
)
y <- tribble(
  ~key, ~val_y,
     1, "y1",
     2, "y2",
     4, "y3"
)
inner_join(x, y, by = "key")

# left_join()
# 두 데이터셋 관계 중 왼쪽(x) 데이터셋의 행은 모두 보존
left_join(x, y, by = "key")

# right_join()
# 두 데이터셋 관계 중 오른쪽(y) 데이터셋의 행은 모두 보존
right_join(x, y, by = "key")

# full_join()
# 두 데이터셋의 관측치 모두를 보존
full_join(x, y, by = "key")




## 4.4.11.1 NYC flights 2013 데이터 join 예시

# flights 데이터 간소화(일부 열만 추출)
flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
# planes 데이터 간소화
planes2 <- planes %>%
  select(tailnum,model)
# airports 데이터 간소화
airports2 <- airports %>%
  select(faa:name, airport_name = name) 
# weather 데이터 간소화
weather2 <- weather %>%
  select(origin:temp, wind_speed)

# flights2 와 airlines 병합
flights2 %>%
  left_join(airlines, by = "carrier")


# flights2 와 airline, airports 병합
flights2 %>%
  left_join(airlines, by = "carrier") %>%
  left_join(airports2, by = c("origin" = "faa"))


# flights2 와 airline, airports2, planes2 병합
flights2 %>%
  left_join(airlines, by = "carrier") %>%
  left_join(airports2, by = c("origin" = "faa")) %>%
  left_join(planes2, by = "tailnum")

# flights2 와 airline, airports2, planes2, weather2 병합
flights2 %>%
  left_join(airlines, by = "carrier") %>%
  left_join(airports2, by = c("origin" = "faa")) %>%
  left_join(planes2, by = "tailnum") %>%
  left_join(weather2, by = c("origin", "year", "month", "day", "hour"))

# *_join() 과 merge() 비교
# inner_join(x, y)	merge(x, y)
# left_join(x, y)	  merge(x, y, all.x = TRUE)
# right_join(x, y)	merge(x, y, all.y = TRUE)
# full_join(x, y)	  merge(x, y, all.x = TRUE, all.y = TRUE)






## 4.4.12 확장예제 : Gapminder

# gapminder-exercise.xlsx 설명
# 시트 이름	      설명
# region	        국가별 지역 정보 포함
# country_pop	    국가별 1800 ~ 2100년 까지 추계 인구수(명)
# gdpcap	        국가별 1800 ~ 2100년 까지 국민 총소득(달러)
# lifeexp	        국가별 1800 ~ 2100년 까지 기대수명(세)

# 4.4.12.1 Prerequisites
# gapminder 패키지 설치하기
install.packages("gapminder")

# 1. readxl 패키지 + %>% 를 이용해 Gapminder 데이터(gapminder-exercise.xlsx) 불러오기
require(readxl)
require(gapminder)

path <- "data/gapminder-exercise.xlsx"

# 기본 문법 적용
sheet_name <- excel_sheets(path)
gapml <- lapply(sheet_name, function(x) read_excel(path = path, sheet = x))
names(gapml) <- sheet_name

# pipe 연산자 이용
path %>%
  excel_sheets %>%
  set_names %>%
  map(read_excel, path = path) -> gapmL

# 개별 객체에 데이터 저장
command <- paste(names(gapmL), "<-",
                 paste0("gapmL$", names(gapmL)))
for(i in 1:length(command)) eval(parse(text = command[i]))

# check
ls()
region
country_pop
gdpcap
lifeexp


# 2. country_pop, gdpcap, lifeexp 데이터셋 결합
gap_unfilter <- country_pop %>%
  left_join(gdpcap, by = c("iso" = "iso_code",
                           "country",
                           "year")) %>%
  left_join(lifeexp, by = c("iso" = "iso_code",
                            "country",
                            "year"))
gap_unfilter


# 3. 인구 수 6만 이상, 1950 ~ 2020 년도 추출
gap_filter <- gap_unfilter %>%
  filter(population >= 60000,
         between(year, 1950, 2020))
gap_filter


# 4. iso 변수 값을 대문자로 변환하고, 1인당 국민소득(gdp_total/population)변수 gdp_cap 생성 후 gap_total 제거
gap_filter <- gap_filter %>%
  mutate(iso = toupper(iso),
         gdp_cap = gdp_total/population) %>%
  select(-gdp_total)
gap_filter


# 5. region 데이터셋에서 대륙(region)변수 결합
gap_filter <- gap_filter %>%
  left_join(region %>% select(- country),
            by = c("iso"))
gap_filter


# 6. 변수 정렬(iso, country, region, year:gdp_cap 순서로)
gap_filter <- gap_filter %>%
  select(iso:country, region, everything())


# 7. 문자형 변수를 요인형으로 변환하고, population을 정수형으로 변환
gap_filter <- gap_filter %>%
  mutate_if(~ is.character(.), ~factor(.)) %>%
  mutate(population = as.integer(population))


# 8. 2-7 절차를 pipe로 묶으면?
gap_filter <- country_pop %>% 
  left_join(gdpcap, by = c("iso" = "iso_code", 
                           "country", 
                           "year")) %>% 
  left_join(lifeexp, by = c("iso" = "iso_code", 
                            "country", 
                            "year")) %>% 
  filter(population >= 60000, 
         between(year, 1950, 2020)) %>% 
  mutate(iso = toupper(iso), 
         gdp_cap = gdp_total/population) %>% 
  select(-gdp_total) %>% 
  left_join(region %>% select(-country), 
            by = c("iso")) %>% 
  select(iso:country, region, everything()) %>% 
  mutate_if(~ is.character(.), ~factor(.)) %>% 
  mutate(population = as.integer(population)) 


# 9. 2020년 현재 지역별 인구수, 평균 일인당 국민소득, 평균 기대수명 계산 후 인구 수로 내림차순 정렬
gap_filter %>%
  filter(year == 2020) %>%
  group_by(region) %>%
  summarise(Population = sum(population),
            `GDP/Captia` = mean(gdp_cap),
            `Life expect` = mean(life_expectancy, na.rm = TRUE)) %>%
  arrange(desc(Population))
