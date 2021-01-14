### 2.2 벡터(vector)
## 2.2.1 벡터의 특징

# 숫자형 벡터
x <- c(2,0,2,0,0,3,2,4)
x

# 문자형 벡터
y <- c("Boncho Ku", "R programming", "Male", "sophomore", "2020-03-24")
y

# 두개 이상의 벡터는 c()함수를 통해 결합 가능
# 함수 내 , 구분자를 통해 결합

# 두 벡터의 결합
x <- 1:5
y <- 10:6
z <- c(x,y)
x; y
z

x <- 5:10
x1 <- x[1:3]
x2 <- c(x1, 15, x[4])
x2

# 서로 다른 자료형으로 벡터를 구성한 경우 표현력이 높은 자료형으로 변환한 값 반환
# 변환규칙
# NULL < raw < logical < integer < double < complex < character < list < expression

# 숫자형 벡터와 문자열 벡터 혼용
k <- c(1,2,"3","4")
k
is.numeric(k)
is.character(k)

# 숫자형 벡터와 논리형 벡터 결합
x <- 9:4
y <- c(TRUE, TRUE, FALSE)
z <- c(x,y)
z
is.numeric(z)
is.logical(z)

# 두 벡터는 중첩이 불가능 -> 동일한 벡터 2개를 결합 시 단일 차원 벡터 생성
x <- y <- 1:3
x
y
z <- c(x,y)
z

# 벡터 각 원소에 이름 부여 가능
# names() 함수를 이용해 원소 이름 지정
# 사용 예시
x <- c("Boncho Ku", "R programming", "Male", "sophomore", "2020-03-24")
names(x) <- c("name", "course", "gender", "grade", "date") 
x

y <- c(a = 10, b = 9, c = 9)
names(y)

# 벡터의 길이(차원) 확인
# length() 또는 NROW() 사용

# length() : 벡터, 행렬인 경우 원소의 개수, 데이터프레임인 경우 열의 개수 반환
x <- 1:50
length(x)

# NROW() : 벡터의 경우 원소의 개수, 행렬 이나 데이터 프레임인경우 행의 개수 반환
NROW(x)


## 2.2.2 벡터의 연산

# 원소 단위 사칙연산 및 비교연산 수행 -> 벡터화 연산

x <- 1:3 ; y <- 2:4
x+y
x-y
x*y
x/y
x%%y
x%/%y
x^y

# 차원이 서로 맞지 않을경우 작은 차원의 벡터를 재사용해서 연산한다
x <- 1:3; y <- 2:3
x;y
# x의 길이가 3이고 y의 길이가 2이기 때문에 3을 맞추기 위해 y의 1번째 원소를 재사용
x+y
x-y
x*y
x/y
x%%y
x%/%y

# 논리형 값으로 구성된 벡터의 기본 연산 시 수치형으로 변환된 연산 결과를 반환
# 차원이 다른 두 벡터의 연산시 재사용 규칙은 그대로 적용
b1 <- c(TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE)
b2 <- c(FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE)
is.numeric(b1); is.numeric(b2)
is.logical(b1); is.logical(b2)
b1+b2
b1-b2
b1*b2
b1/b2

# 두 벡터의 비교연산
# 차원이 다른 두 벡터의 연산시 재사용 규칙은 그대로 적용
x <- c(2, 4, 3, 10, 5, 9)
y <- c(3, 4, 6, 2, 10, 7)

x == y
x != y
x >= y
x <= y


# 문자열 벡터의 연산은 == 또는 != 만 가능( 사칙연산 불가능 )
c1 <- letters[1:5]
c2 <- letters[c(1:2, 6:8)]
c1==c2
c1!=c2

# NA 를 포함한 두 벡터 연산시 동일 위치에 NA 가 존재하면 어떤 연산이든 NA 값을 반환
x <- c(1:10, c(NA, NA))
y <- c(NA, NA, 1:10)
x; y
x+y
x-y
x*y
x/y
x^y
x%%y
x%/%y
x>y
x<y
# NULL 값은 벡터에 포함되더라도 벡터의 길이에는 변동이 없다.
x <- c(1,2,3,NULL,NULL,NULL)
length(x)


## 2.3.3 벡터의 색인(indexing)
# 벡터의 특정 위치에 있는 원소를 추출
# 색인(indexing)을 통해 벡터의 원소에 접근 가능

# x[i] : x의 i번째 요소
# x[i:j] : x의 i번째 부터 j번째까지 값 반환
# x[-i] : x의 i번째 요소를 제외한 나머지 값 반환

x <- c(1,3,5,1,7,2,4,9,6,5)
x[3]
x[3:6]
x[-length(x)]
x[c(1,3)]
v <- c(1,7)
x[v]

# 원소 이름으로 인덱싱
# 원소 이름 지정
names(x) <- paste0("x",1:length(x))
x
x["x4"]

# 필터링(filterring) : 특정한 조건을 만족하는 원소 추출
z <- c(5,2,-3,8)
#1
w <- z[z^2 > 8]
w
#2
idx <- z^2 > 8
z[idx]

# 역으로 특정 조건을 만족하는 벡터의 위치에 임의의 값을 치환할 수 있다.
z[idx]<-0
z


## 2.2.4 벡터 관련 함수
# c() 함수 외에 R은 벡터 생성을 위해 몇 가지 유용한 함수를 제공함
# seq()
seq(
  from, # 시작값
  to, # 끝값
  by # 공차(증가치)
)  # 그외의 인수 : length.out = n (생성하고자 하는 벡터의 길이가 n인 수열 생성)
                # along.with = 1:n (index 가 1에서 n까지 길이를 갖는 수열 생성)

# 예시
x <- seq(from =2 ,to =30, by =2)
x
x <- seq(from = 0, to = 3, by = 0.2)
x
x <- seq(from = -3 ,to = 3 ,length.out = 10)
x
x <- seq(length.out=10)
x
x <- seq(along.with=1:10 )
x
x <- seq(1,5,along.with = 1:10)
x

# 벡터 x에 seq() 함수 적용시 1: length(x) 값 반환
seq(x)

# seq_along() : 주어진 객체의 길이만큼 1부터 1간격의 수열 생성
seq_along(x)  # 1부터 x벡터의 길이까지 1단위 수열 값 반환

# seq_len() : 인수로 받은 값 만큼 1부터 해당 값 까지 1간격의 수열 생성
seq_len(10)   # 1부터 10까지 1단위 수열 값 반환


# rep계열 함수
# rep() : 벡터 또는 벡터의 개별 원소를 반복한 값 반환
rep(
  x, # 반복할 값이 저장된 벡터
  times, # 전체 벡터의 반복 횟수
  each # 개별 원소의 반복 횟수
)

# 예시
x <- rep(4,5)
x

x<-c(1:3)
xr1<-rep(x,3)
xr1

xr2<-rep(x,each=4)
xr2

xr3 <- rep(x,each=3,times=2)
xr3

# 문자형 벡터의 반복
# 아래 sex 벡터의 각 원소를 2번 반복하고 해당 벡터를 4회 반복
sex <- c("Male", "Female")
sexr <- rep(sex,each=2,times=4)
sexr

# rep.int(), rep_len() : rep()함수의 simple버전으로 속도(performance)가 요구되는 프로그래밍시 사용
rep.int(1:5,3)  # 1:5 벡터를 3번 반복
rep_len(1:5,length.out = 7)  # 불완전한 사이클로 벡터 반복복



# Filtering 관련 함수
# subset() : 기존 필터링 방식과 비교할 때 NA를 처리하는 방식에서 차이를 보임
#            벡터 뿐 아니라 행렬 및 데이터프레임 객체에도 적용 가능
x <- c(6,1:3,NA,NA,12)
x

# 일반적인 필터링 적용
x[x>5]

# subset() 함수 적용
subset(x,x>5)


# which() : 한 벡터에서 특정 조건에 맞는 위치(인덱스)를 반환
#           논리형 벡터를 인수로 받고 해당 논리형 벡터가 참인 index 반환

# 예시
x <- c(3,8,3,1,7)

# x의 원소값이 3인 index 반환
which(x==3)

# x의 원소가 4보다 큰 원소의 index 반환
which(x>4)

# 9월(Sep)과 12월(Dec)와 같은 원소 index
# month.abb: R 내장 벡터로 월 약어(Jan ~ Dec)를 저장한 문자열 벡터
which(month.abb == c("Sep", "Dec"))

# 조건을 만족하는 원소가 존재하지 않는다면?
x <- which(x>9)
x

length(x)
is.null(x)
is.na(x)


# 특정 조건 만족 여부를 확인
# any(condition) -> 하나라도 conditiond을 만족하는 원소가 존재하는지 판단
# TRUE 또는 FALSE 갑 반환
any(x>9)




# 집합 관련 함수
# 벡터는 숫자, 문자열의 묶음, 즉 원소의 집합(set)으로 볼 수 있기 때문에 집합 연산이 가능
# 두 집합을 X와Y로 정의 했을 때 아래와 같은 집합 연산 가능
# setequal(X,Y) : X와Y가 동일한지 판단 -> TRUE 또는 FALSE 반환
x <- y <- c(1,9,7,3,6)
setequal(x,y)

# union(X,Y) : X와Y의 합집합
y <- c(1,9,8,2,0,3)
union(x,y)

# intersect(X,Y) : X와Y의 교집합
intersect(x,y)

# setdiff(x,y) : X와Y의 차집합
setdiff(x,y)
setdiff(y,x)

# X %in% Y : X(기준)가 집합 Y의 원소인지 논리값 반환
x <- c("apple", "banana", "strawberry", "mango", "peach", "orange")
y <- c("strawberry", "orange", "mango")

x %in% y
y %in% x


# 두 벡터의 동일성 테스트
x<-1:3
y<-c(1,3,4)

# x==y : 두 벡터 x,y의 각 원소에 대한 동일성 테스트
x==y

# all(x==y) : 단지 두 벡터가 동일한지 아닌지 판단
all(x==y)

# 보다 나은 방법으로 identical() 함수 적용 
# identical()함수는 벡터가 갖는 데이터 타입의 동일성 까지 체크함
identical(x,y)

x<-1:5; y<-c(1,2,3,4,5)
x==y
all(x==y)
identical(x,y)
typeof(x); typeof(y)
