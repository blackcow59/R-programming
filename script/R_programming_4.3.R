### 4.3 readr 패키지
# 기본적으로 4.1.1 절에서 학습했던 read.table(), read.csv() 와 거의 동일하게 작동하지만, 읽고 저장하는 속도가 base R 에서 제공하는 기본 입출력 함수보다 월등히 뛰어남. 최근 readr 패키지에서 제공하는 입출력 함수보다 더 빠르게 데이터 입출력이 가능한 feather 패키지
# 데이터를 읽는동안 사소한 문제가 있는 경우 해당 부분에 경고 표시 및 행, 관측 정보를 표시해줌 -> 데이터 디버깅에 유용
require(tidyverse)
# 주요함수
# read_table(), write_table()
# read_csv(), write_csv()

# read vignette을 통해 더 자세한 예시를 살펴볼 수 있음

read.csv(
  file, # 파일명
  col_names = TRUE, # 첫 번쨰 행을 변수명으로 처리할 것인지 여뷰
                    # read.table(), read.csv() 의 header 인수와 동일
  col_types = NULL, # 열(변수)의 데이터 형 지정
                    # 기본적으로 데이터 유형을 자동으로 감지하지만,
                    # 입력 텍스트의 형태에 따라 데이터 유형을
                    # 잘못 추측할 수 있기 떄문에 간혹 해당 인수 입력 필요
                    # col_* 함수 또는 campact string으로 지정 가능
                    # c=character, i=interger, n=number, d=double
                    # l=logical, f=factor, D=data, T=data time, t=time
                    # ?=guess, _/- skip column
  progress, # 데이터 읽기/쓰기 진행 progerss 표시 여부
)

# 예시

# dataset/titanic3.csv 불러오기
titanic <- read_csv("data/dataset/titanic3.csv")
titanic

# read.csv와 비교
head(read.csv("data/dataset/titanic3.csv", header = T),10)
str(read.csv("data/dataset/titanic3.csv", header = T))

# colum type 을 변경
titanic2 <- read_csv("data/dataset/titanic3.csv", col_types = "iicfdiicdcfcic")
titanic2

# 특정 변수만 불러오기
titanic3 <- read_csv("data/dataset/titanic3.csv",
                     col_types = cols_only(
                       pclass = col_integer(),
                       survived = col_integer(),
                       sex = col_factor(),
                       age = col_double()
                     ))
titanic3

# 대용량 데이터셋 읽어올 때 시간 비교
install.packages("feather")
require(feather)
write_feather(pulse, "data/dataser/pulse.feather")

system.time(pulse <- read.csv("data/dataset/pulse.csv", header = TRUE))
system.time(pulse <- readRDS("output/pulse.rds"))
system.time(pulse <- read_csv("data/dataset/pulse.csv"))
system.time(pulse <- read_feather("data/dataset/pulse.feather"))



## 4.3.1 Excel 파일 입출력
# tidyvers 중 하나인 readxl 패키지를 이용해 간편하게 R 작업환경에 엑셀 파일을 읽어오는것이 가능
install.packages("readxl")
require(readxl)

# readxl 패키지 구성 주요 함수
# read_xls() : Excel 97 ~ 2003
# read_xlsx() : Excel 2007 이상
# read_excel() : 버전 상관없음
# excel_sheets() : 엑셀 파일 내 시트 이름 추출 
# -> 한 엑셀 파일의 복수 시트에 데이터가 저장 되어 있는 경우 활용

# 예시
read_xlsx(
  path, # Excel 폴더 및 파일 이름
  sheet = NULL, # 불러올 엑셀 시트 이름
                # default = 첫 번째 시트
  col_names = TRUE, # read_csv()의 인수와 동일한 형태 입력
  col_types = NULL, # read_csv()의 인수와 동일한 형태 입력
)

# 2020년 4월 21일자 COVID-19 국가별 유별률 및 사망률 집계 자료
# dataset/owid-covid-data.xlsx 파일 불러오기 
covid19 <- read_xlsx("data/dataset/owid-covid-data.xlsx")
covid19

# 여러 시트를 동시에 불러올 경우
# dataset/dataR4CTDA.xlsx 의 모든 시트 불러오기
path <- "data/dataset/datR4CTDA.xlsx"
sheet_name <- excel_sheets(path)
dL <- lapply(sheet_name, function(x) read_xlsx(path, sheet = x))
names(dL) <- sheet_name
dL

# Tidyverse 에서는 ? (맛보기)
require(tidyverse)

path %>%
  excel_sheets %>%
  set_names %>%
  map(~read_xlsx(path = path, sheet = .x)) -> dL2
dL2





## 4.3.2 tibble 패키지
# readr 또는 readxl 패키지에서 제공하는 함수를 이용해 외부 데이터를 읽어온 후, 확인할 때 기존 데이터 프레임과 미묘한 차이점이 있다는 것을 확인
# 프린트된 데이터의 맨 윗부분을 보면 (A tibble : 데이터 차원) 이 표시된 부분을 볼 수 있음
# tibble 은 tidyverse 생태계에서 사용되는 데이터 프레임
# -> 데이터 프레임을 조금 더 빠르고 사용하기 쉽게 수정한 버전의 데이터 프레임

# tibble 생성하기
# 기본 R 함수에서 제공하는 as.* 계열 함수처럼 as_tibble() 함수를 통해 기존 일반적인 형태의 데이터 프레임을 tibble 로 변환 가능
head(iris)
as_tibble(iris)

# 개별 벡터로 부터 tibble 생성 가능
# 방금 생성한 변수 참조 가능
# 문자형 변수가 입력된 경우 데이터 프레임과 다르게 별다른 옵션 없어도 강제로 factor로 형 변환을 하지 않음

# 벡터로 부터 tibble 객체 생성
tibble(x = letters, y = rnorm(26), z = y^2)

# 데이터 프레임으로 위와 동일하게 적용하면?
data.frame(x = letters, y = rnorm(26), z = y^2)

# 벡터의 길이가 다른 경우
# 길이가 1인 벡터는 재사용 가능
tibble(x = 1, y = rep(0:1, each = 4), z = 2)

# 데이터 프레임과 마찬가지로 비정상적 문자를 변수명으로 사용 가능
# 역따옴표(``)
tibble(`2000` = "year", `:)` = "smile", `:(` = "sad")


# tribble() : transposed(전치된) tibble의 약어로 데이터를 직접 입력시 유용
tribble(
  ~x, ~y, ~z,
  "M", 172, 69,
  "F", 156, 45,
  "M", 165, 73,
)

# tibble() 과 data.frame()의 차이점
# 가장 큰 차이점은 데이터 처리의 속도 및 데이터의 프린팅
# tibble이 데이터 프레임 보다 간결하고 많은 정보 확인 가능
# str() 에서 확인할 수 있는 데이터 유형 확인 가능
head(iris)
dd <- as_tibble(iris)
dd
