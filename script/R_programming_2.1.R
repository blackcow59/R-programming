### 2.1  스칼라(scalar)
# 단일 차원의 값(하나의 값) : 1 x 1 벡터로 표현 -> R 데이터 객체의 기본은 벡터
# 데이터 객체 유형은 크게 숫자형, 문자열, 논리형이 있음

## 2.1.1 선언
# 일반적으로 컴파일이 필요한 언어(예 : C언어)의 경우 변수 또는 객체를 사용전에 선언이 필요
# R언어에서는 변수를 선언할 필요가 전혀 없음.

## 2.1.2 숫자형
# 정수형(interger)와 실수형(double)로 구분됨
# 정수형 구분시 숫자 뒤 L을 표시

# 정수형 구분자 사용 예시
# typeof() R 객체의 데이터 타입을 반환하는 함수
typeof(10L)
typeof(10)

# 수치연산
# 숫자형 스칼라 연산 적용 예시
a <- 3
b <- 10
a; b

# 덧셈
c <- a + b
c
# 덧셈을 함수로 입력
c <- "+"(a,b)
c

# 뺄셈
d <- b-a
d

# 곱셈
m <- a*b
m

# 나누기
dd <- b/a
dd

# 멱승
b^a

# 나누기의 나머지 반환
r <- b%%a
r

# 나누기의 몫 반환
q <- b%/%a
q


## 2.1.3 문자형(character)
# 수치형이 아닌 문자 형식의 단일 원소
# 수치연산 불가능
# 따옴표 (', ")로 문자를 묶어서 문자열 표시

h1 <- c("Hellow CNU!!")
h2 <- c("R is not too difficult")
typeof(h1); typeof(h2)
h1
h2

# 문자열의 문자 수 반환
nchar(h1); nchar(h2)


## 2.1.4 논리형 스칼라(logical)
# 참(TRUE) 또는 거짓(FALSE)를 나타내는 값
# 논리형 스칼라는 숫자형 연산 가능(TRUE = 1, FALSE = 0)

# 논리형 스칼라의 논리 및 비교 연산 예시
typeof(TRUE)
TRUE&TRUE  # TRUE
TRUE&FALSE  #FALSE
# 아래 연산은 모두 TRUE 반환
TRUE|TRUE
TRUE|FALSE
# TRUE 와 FALSE 의 반대
!TRUE
!FALSE
# T/F 에는 변수값을 할당할 수 있지만 TRUE/FALSE에는 변수값을 할당할 수 없음
T <- FALSE
T
TRUE <- FALSE

# &(|) 와 &&(||)의 차이
l.01 <- c(TRUE, TRUE, FALSE, TRUE)  # 논리형 값으로 구성된 벡터
l.02 <- c(FALSE, TRUE, TRUE, TRUE)
l.01 & l.02  # l.01과 l.02 각 원소 별 & 연산
l.01 && l.02 # l.01과 l.02 의  첫 번째 원소에 대해 & 연산

# 비교연산자
x <- 9
y <- 4
typeof(x>y)

x>y
x<y
x==y
x!=y
x>=y
x<=y


## 결측값(missing value)
# 결측치 지정 상수 : NA ->R과 다른 언어의 가장 큰 차이점 중 하나

# 예를 들어 4명의 통계학과 학생 중 3명의 통계학 개론 중간고사 점수가 각각 80,90,75 점이고 4번째 학생의 점수가 없는 경우 NA로 결측값 표현
# is.na() 함수를 이용해 해당 값이 결측을 포함하고 있는지 확인
one <- 80; two <- 90; three <- 75; four <- NA
four

# 결측이 포함되어 있으면 is.na() 는 TRUE
is.na(four)

#### 참고 : 자료에 NA가 포함된 경우 연산 결과는 모두 NA가 반환
NA+1
NA&TRUE
NA >= 3

## 2.1.6 NULL값
# NULL : 초기화 되지 않은 변수 또는 객체를 지칭함
# is.null() 함수를 통해 객체가 NULL인지 판단

x <- NULL # NULL지정
is.null(x) # NULL 객체인지 판단
x <- 1
is.null(x)


#### NULL 과 NA의 차이 
# NULL : 값을 지정하지 않은 객체를 표현하는데 사용. 
#        즉 아직 변수 또는 객체의 상태가 미정인 상태를 나타냄
# NA : 데이터 값이 결측임을 지정해주는 논리형 상수


## 2.1.7 무한대/무한소/숫자아님
# Inf : 무한대
# Inf : 무한소
# NaN : 숫자아님
# is.finite(), is.infinite(), is.nan() 함수를 통해 객체판단
x <- Inf
is.finite(x)
is.infinite(x)

x <- 0/0
is.nan(x)
is.finite(x)
is.infinite(x)
