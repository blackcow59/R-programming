### 2.6 요인(factor)과 테이블(table)

# 요인(factor) 데이터 타입은 통계학에서 범주형 변수(categorical variable)을 표현하기 위한 R의 데이터 타입으로 범주형 자료는 크게 명목형(nominal)과 순서형(ordinal)으로 구분
# 테이블(table) 객체는 factor객체에 대한 빈도를 나타내기 위해 사용


# 범주형 자료
# 데이터가 사전에 정해진 특정 유형으로만 분류되는 경우 : 성별, 인종, 혈액형 등
# 범주형 자료는 명목형과 순서형으로 구분 가능
# 순서형 자료 : 성적, 교육수준, 선호도, 중증도 등



# 2.6.1 요인(factor)
# 범주형 자료를 표현하기 위한 R의 객체 클래스
# Factor는 정수형 벡터를 기반으로 leverls(수준)이라는 속성이 추가된 객체임
# 숫자 또는 문자로 표현 되었다 하더라도 범주형으로 이해
# Factor는 level 에 해당하는 값만 가질 수 있는 벡터로 간주

# factor() : Factor 생성 함수
factor(data, # factor로 표현하고자 하는 값. 주로 문자형
       levels, # 요인의 수준, 미리 정한 값
       labels, # 수준에 대한 레이블링
       ordered, # 순서형 자료 표시 여부
                # TRUE/FALSE, default = FALSE
       )
# 수치형을 factor로 만들어도 처음 입력 값은 문자형으로 변하고 level 값으로 치환
# 대신 (1,2,3)이 중심값이 됨 -> 정수형 벡터임


# 예시
score <- rep(c(4:6),each = 4)
fscore <- factor(score)

# factor의 기본 데이터 타입
typeof(fscore)
# factor의 속성
attributes(fscore)
# factor의 구조
str(fscore)

# levels() : factor의 수준(levels) 반환 함수
levels(fscore)

# nlevels() : level 의 개수 반환
nlevels(fscore)


# Factor를 벡터 결합 함수 c()로 결합
c(fscore, factor(4)) # 강제로 정수형 벡터로 변환
fscore

# Factor의 범주 수준(level) 및 범주명(label) 지정
x <- rep(c(1:2), each = 4)

# factor 의 범주 수준 지정
sex <- factor(x, levels = 1:2)
sex

# facotr의 범주 수준 및 범주 명칭 지정
sex <- factor(x, levels = 1:2, labels = c("male","female"))
sex
str(sex)

# 값은 존재하지 않으나 수준을 미리 정해 놓은 경우
severity <- factor(1:2, levels = c(1,2,3), labels = c("Mild","Moderate", "Severe"))
severity[2] <- "Severe"

# 존재하지 않는 수준 할당
severity[1] <- "Good"

severity



# 순서형 factor 생성
severity <- factor(rep(1:3, times = 3), levels = 1:3,
                   labels = c("Mild","Moderate","Severe"),
                   ordered = T)
severity

# 순서형 범주 체크
is.ordered(severity)




# 요인형객체에 적용되는 일반적인 함수
# tapply()함수
# 특정 요인 수준의 고유한 조합으로 각 그룹에 속한 값에 특정 함수를 적용한 결과를 반환
tapply(
  x, # 벡터,
  INDEX, # 벡터를 그룹화할 색인(factor)
  FUN, # 각 그룹마다 적용할 함수
)

# 예시 : 2020년 4월 15일 총선의 연령별 지지율

# 문자열을 INDEX의 인수로 받은 경우

x <- c(48,43,27,52,38,
       67,23,58,72,85) # 유권자 연령
f <- rep(c("더불어민주당", "미래통합당"),each = 5)
# f의 요인 수준 별 x (연령) 평균 계산
t <- tapply(x, f, mean)
t

# x,f 순서를 랜덤하게 섞은 다음 결과
set.seed(12345)
idx <- order(runif(10))
x <- x[idx]
f <- f[idx]
tapply(x,f,mean)


# Factor가 2개 이상인 경우 두 factor 객체의 수준의 조합(AND조건)에 따른 그룹을 만든 후 그룹별 함수 적용
s <- rep(c("M","F"), each = 6)
income <- c(35,42,68,29,85,55,
            30,40,63,27,83,52)*100 # 단위 : 만원원
age <- c(32,36,44,25,55,41,
         28,33,46,23,54,44)

set.seed(12345)
idx <- order(runif(12))
s <- s[idx]; income <- income[idx]; age <- age[idx]

# (age <= 40 : 1), (40 < age <= 50 : 2), (age >= 50 : 3) 할당 : ifeles() 함수 사용
age <- ifelse(age <= 40, 1, ifelse(age <= 50, 2, 3))
tapply(income, list(sex = s, age = age), mean)


# split() 함수
# tapply()는 주어진 요인의 수준에 따라 특정 함수를 적용하지만, split()은 데이터를 요인의 수준(그룹)별로 데이터를 나누어 리스트 형태로 반환
split(
  x, # 분리할 데이터(벡터)
  f, # 데이터를 분리할 기준이 되는 factor 지정
)

# 예시

# 성별의 수준 남녀 별 소득 수준 분리
split(income, s)

# 두 개 요인 조합으로 income 벡터 분리
split(income, list(s,age))

# 요인의 각 수준에 대한 인덱스를 반환하고자 하는 경우
abalone <- read.csv("data/abalone.data",header = FALSE) # V1 : 전복종류(F=암,M=수,I=새끼)
head(abalone)
g <- abalone[,1]
set.seed(20200410)
idx <- sample(1:length(g),size = 10)
g <- g[idx]
split(1:length(g),g)





## 2.6.3 테이블(table)
# 범주형 변수의 빈도 또는 분할표(교차표)를 표현하기 위한 객체(클래스)
# 범주 별 통계량(평균, 표준편차, 중위수)요약

# tapply() 함수를 이용한 테이블 만들기
# 길이가 12인 임의의 벡터u를 수준의 개수가 각각 3,2 인 factor의 조합으로 부분벡터 분리후 length() 적용 -> tapply() 함수 사용

u <- runif(12)
f1 <- factor(c(4,4,3,5,5,4,3,3,4,5,5,3))
f2 <- factor(c("a", "a", "a", "a", "b", "a", 
               "b", "b", "a", "a", "b", "b"))
tapply(u, list(f1, f2), length)

# u의 값과 상관없이 두 factor 형 변수 f1 과 f2의 조합에 따른 개수 반환 -> 분할표
# 위 예시에서 f1이 "4"이고, f2가 "b"인 경우는 없기 때문에 0 값이 있어야 하나, tapply() 함수 적용시 결측값 NA를 반환


# table() : 하나 이상의 factor의 수준 또는 수준의 조합으로 분할표 생성
# Factor가 3개 이상인 경우 배열로 다차원 분할표 표현

# table() 적용 예시
t1 <- table(f1, f2)
t1
typeof(t1); attributes(t1); str(t1)

# factor 가 한개인 경우
table(f1)

# factor가 3개인 경우
year = c("1","1","2","3","3","4")
gender = c("M","M","F","M","F","F")
grade = c("A","C","B","B","A","C")

table(gender, grade, year)



# 테이블 관련 함수

# tabulate() 함수
# 정수로 이루어진 벡터에 정수 값이 발생한 횟수를 카운팅한 결과를 반환 -> table()함수의 핵심 함수
tabulate(
  bin, # 정수형(수치형) 벡터 또는 factor
  nbins, # 사용할 수준(bin)의 개수
)

# 예시
x <- c(2,2,2,1,3,4,5,5,10,8,8)
tabulate(x)

tabulate(x, nbins = 3)


# addmargins() 함수
# 테이블 객체(분할표)를 인수로 받아 각 요인의 수준 및 수준 조합 별 합계 갑을 테이블과 동시 반환
addmargins(
  T # 테이블 또는 배열 객체
)

# 예시
t1 <- table(f1, f2)
addmargins(t1)

# 3차원 이상 테이블
t2 <- table(gender, grade, year)
is.table(t2); is.array(t2)
addmargins(t2)



# ftable() 함수
# "평평한(flat)" 교차표 생성
# 다차원 교차표 작성 시 행변수와 열변수 교환을 통해 재사용 가능
ftable(
  x, # factor, table 또는 ftable 클래스를 갖는 객체
  row.vars, # 행 변수 지정 색인(정수, 문자)
  col.vars # 열 변수 지정 색인(정수, 문자)
)

# 예시 
t3 <- ftable(t2)
t3; attributes(t3); str(t3)

# 테이블 내 행 변수 바꾸기
t4 <- ftable(t2, row.vars = c("year", "gender"))
t4

# 테이블 내 열 변수 바꾸기
t5 <- ftable(t2, col.vars = 1)
t5



# margin.table() 함수
# 배열 형식으로 지정된 교차표(table() 반환결과)에서 지정된 차원 색인에 대한 표 합계 계산 결과 반환
margin.table(
  x, # table 또는 ftable 클래스를 갖는 객체
  margin # 차원 색인 번호
)

# 예시
t2

margin.table(t2,1) # 1 차원(행) : 성별
margin.table(t2,2) # 2 차원(열) : 성적
margin.table(t2,3) # 3 차원(배열 방 번호) : 학년



# prop.table() 함수
# table 객체 빈도에 대한 비율 계산
# 전체, 차원 단위 비율 계산 가능
prop.table(
  x, # table 또는 ftable 클래스를 갖는 객체
  margin # 차원 색인 번호
         # margin = NULL: 각 셀을 전체 cell의 합으로 나눈 비율
         # margin = 1: 각 행 별 셀에 대해 각 행에 해당하는 cell 합으로 나눈 비율
         # margin = 2: 각 열 별 셀에 대해 각 열에 해당하는 cell 합으로 나눈 비율
)

# 예시

# 2차원 교차표
prop.table(t1)
prop.table(t1,1)
prop.table(t1,2)
