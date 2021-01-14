### 2.4 행렬
# 행렬의 정의
# 동일한 데이터 타입의 원소로 구성된 2차원 데이터 구조
# nx1차원 벡터 p개로 묶여진 데이터 덩어리 -> nxp 행렬로 명칭함

# 행렬 생성함수
matrix(data, # 행렬을 생성할 데이터 벡터
       nrow, # 행의 개수(정수)
       ncol, # 열의 개수(정수)
       by.row, # TRUE : 행 우선, FALSE : 열 우선
               # default = FALSE
       dimnames # 행렬의 각 차원에 부여할 이름 (리스트)
       )

# 예시

x <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3)
x
# 행의 개수나 열의 개수 로 나머지를 추정 가능하다면 둘 중 어떤 인수도 생략 가능
x <- matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3); x 
x <- matrix(c(1,2,3,4,5,6,7,8,9), ncol = 3); x

# nrow x ncol 이 입력한 데이터(벡터)의 길이보다 작거나 큰 경우
# length(x) < nrow * ncol 인 경우 
# nrow * ncol에 해당하는 길이 만큼 x의 원소를 재사용해 행렬 생성
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
y <- matrix(x, nrow = 3, ncol = 4)
y

# length(x) > nrow * ncol 인 경우 
# norw * ncol 만큼만 x 원소의 값을 사용
z <- matrix(x, nrow = 2, ncol = 3)
z

# 행렬 구성 시 길이에 대한 약수가 아닌 값을 nrow 또는 ncol의 인수로 받은 경우

# x (length=9)로 행렬 생성시 nrow = 4를 인수로 입력한 경우
h <- matrix(x, nrow = 4)
h

# x (length = 9)로 행렬 생성시 ncol = 2를 인수로 입력한 경우
h <- matrix(x, ncol = 2)
h



## 2.4.1 행렬의 연산

# 선형대수에서 배우는 행렬-스칼라, 행렬-행렬 간 연산 가능

# 행렬-스칼라 연산

# 합 연산 : 스칼라가 자동적으로 행렬의 차원에 맞춰서 재사용
x <- matrix(1:9,3,3,byrow=T)
x + 4

# 곱 연산 
x * 4

# 행렬-행렬 연산 (*동일 차원간 연산만 가능*)
# 행렬 간 연산에서 스칼라 연산과 다른 점은 차원이 개입

# 행렬 간 합(차)
# 두 행렬의 동일 차원간 합 연산 수행
x <- matrix(1:9, 3, 3, byrow=T)
y <- matrix(c(1,3,-6,-1,2,3,2,4,-7), ncol = 3)
x + y
x - y

# 행렬 곱/나누기
x*y
x/y

# 행렬간 곱(matix product)
X <- matrix(c(1,1,1,-1,-1,1,1,1), nrow = 2, ncol = 4)
Y <- matrix(c(1,1,1,1, -2, 1, 3, 2, -1, 2, 1, 2), nrow = 4, ncol = 3)
X; Y
Z <- X %*% Y
Z

# 행렬-벡터 연산

# 행렬 X의 행 길이와  벡터y의 길이가 같은 경우 -> y를 열 단위로 재사용

x <- c(1,1,1,2,3,2,4,2,1)
X <- matrix(x,nrow=3)
y <- c(30,18,23)
X + y

# 행렬 X의 길이와 벡터 y의 길이가 같은 경우 -> 벡터 y를 자동으로 원소를 행렬(열단위)로 변환

x <- c(1:9); X <- matrix(x, nrow = 3)
y <- x; length(X)
X + y

# 길이가 다른경우

# 1. 행렬보다 길이가 큰 경우
y <- c(1:10)
X + y

# 2. 행렬 길이의 약수가 아닌 경우 -> y 재사용
y <- c(1:4)
X + y

# 행렬-벡터간 곱
x <- c(1,1,1,1,2,1,3,4,1,1,3,4)
y <- c(7,6,8)
X <- matrix(x, nrow = 4, ncol = 3)
X %*% y


# 행렬의 전치
# t() : 전치행렬 반환
x <- 1:6
X <- matrix(x, nrow = 2, ncol = 3, byrow = TRUE)
t(X); X

# 전치행렬과 행렬 간곱
x <- c(1,1,1,1,1,22.3,23.2,21.5,25.3,28.0)
X <- matrix(x,nrow = 5)
t(X) %*% X

# 벡터-벡터간 곱
x <- 1:4

# 벡터의 외적
x %*% t(x)
# 벡터의 내적
t(x) %*% x
x %*% x


# 역행렬(inverse matrix)
# solve() : 행렬의 역행렬 반환

# 2 by 2 행렬의 역행렬
x <- c(1,2,3,4)
X <- matrix(x,2)
X ; solve(X)

# 행렬과 역행렬의 곱은 항등행렬
X %*% solve(X)



# 행렬식
# det() : 임의의 행렬의 행렬식 반환
X <- matrix(c(1,2,0,5,4,-2,0,-1,0),ncol = 3)
det(X)





## 2.4.2 행렬의 색인
# R의 행렬 객체 내 데이터 접근은 벡터와 유사하게 행과 열에 대응하는 색인 또는 이름으로 접근 가능

x <- 1:12
X <- matrix(x, ncol = 4)
X
X[1,]
X[,1]
X[2,3]  
X[1:2,2:3]

# 행렬의 각 행과 열에 이름 부여하기
# dimnames()[[i]] i=1 : 행이름, i=2 : 열이름 변경 및 부여
# rownames() : 행 이름 반환 및 부여
# colnames() : 열 이름 반환 및 부여

# matrix 함수 내에서 행렬 이름 동시 부여
X <- matrix(1:9, nrow = 3, 
            dimnames = list(c("1","2","3"), # 행 이름
                            c("A", "B", "C")))# 열 이름
X

# dimnames() 를 이용한 이름 확인
dimnames(X)

# dimnames() 함수로 행 이름 변경
dimnames(X)[[1]] <- c("r1","r2","r3")
X

dimnames(X)[[2]] <- c("c1","c2","c3")
X

# rownames()를 통해 행 이름 확인
rownames(X)

# colnames()를 통해 열 이름 확인
colnames(X)

# rownames()를 이용해 행 이름 변경
rownames(X) <- c("apple", "strawberry", "orange")
rownames(X)

# colnames()를 이용해 행 이름 변경
colnames(X) <- c("costco", "emart", "homeplus")
colnames(X)

X

# 행과 열에 대한 이름이 존재한다면 벡터와 마찬가지로 이름으로 색인 가능
X[c("apple", "orange"), c("emart")]

# 2번째 열에 해당(emart)를 제외한 나머지 열 반환
X[, colnames(X)[-2]]
X[,-2]

# 색인한 행렬 원소에 다른 값 할당
y <- c(1:12); Y <- matrix(y, ncol = 3)
Y

# 2, 4 행과 2-3열에 다른 값 할당
Y[c(2, 4), 2:3] <- matrix(c(1, 2, 1, 4), ncol = 2)

# 행렬 값 할당 다른 예시
X <- matrix(nrow = 4, ncol = 3) # NA 값으로 구성된 4 by 3 행렬
X

y <- c(1, 0, 0, 1); Y <- matrix(y, ncol = 2)
X[3:4, 2:3] <- Y
X

# 행렬 필터링  → 색인 대신 조건 사용(벡터와 동일)

X = matrix(c(1,2,4,3,2,3,5,6), nrow = 4, ncol = 2)

# X의 1열이 3보다 작거나 같은 행 필터링
X[X[,1] <= 3, ]

# 논리값을 활용한 필터링
idx <- X[, 1] <= 3; idx
X[idx, ]

## 2.4.3 행과 열 추가 및 제거
# 행렬 재할당(re-assignment)를 통해 열이나 행을 직접 추가하거나 삭제 가능

# cbind() (열 붙이기, column bind), rbind() (행 붙이기, row bind) 함수 사용
j <- rep(1, 4)
Z <- matrix(c(1:4, 1, 1, 0, 0, 1, 0, 1, 0), nrow = 4, ncol = 3)
Z

cbind(j, Z) # 열 기준으로 붙이기

# 길이가 다른 경우 재사용
cbind(1, Z)

# Z 행렬 앞에 j 열 붙혀서 새로운 Z 생성
Z <- cbind(j, Z)

# 행 기준으로 붙이기
Z <- rbind(Z, 2)



# 행 또는 열의 제거는 벡터에서와 마찬가지로 색인 앞에 - 사용

# 첫 번째 행 제거
Z[-1, ]

# 1, 5행 , 3열 제거
Z[-c(1, 5), -3]




## 2.4.4 행렬 관련 함수

# diag(): 대각행렬 생성 또는 대각원소(diagonal elements) 추출
D <- diag(c(1:5), 5)
D

# 3차원 항등 행렬(모든 대각원소가 1인 행렬)
I3 <- diag(1, 3)

#대각원소 추출
diag(D)

# 대각원소 재할당
diag(D) <- rep(1, 5)




# dim(object_name): 행렬 또는 데이터 프레임의 행과 열의 개수(차원)를 반환

# dim(): 객체의 차원(dimension)을 반환
Z
dim(Z)



# nrow() 또는 NROW(): 행렬의 행 길이 반환
# ncol() 또는 NCOL(): 행렬의 행 길이 반환
nrow(Z); ncol(Z)

# nrow()/ncol()과 NROW()/NCOL()의 차이점

# nrow()/ncol()은 행렬 또는 데이터 프레임에 적용되며 벡터가 인수로 사용될 때 NULL 값을 반환하는데 비해 NROW()/NCOL()은 벡터의 길이도 반환 가능



# attributes(): 객체가 갖는 속성을 반환함

x <- 1:9; X <- matrix(x, ncol = 3)
# 객체의 속성 확인
attributes(x)
attributes(X)



# class(): 객체의 클래스 명칭 반환 및 클래스 부여

# 객체의 class 확인
class(x); class(X)

# 객체의 class 부여
class(x) <- "vector"



# str(): 객체가 갖고 있는 데이터의 구조 확인

# 객체의 구조 파악
str(x); str(X)


# x와 X에 이름(name) 속성을 추가한 경우
names(x) <- paste0("x", 1:9)
dimnames(X) <- list(paste0("r", 1:3), 
                    paste0("c", 1:3))


attributes(x); attributes(X)
class(x); class(X)
str(x); str(X)



# attr(object, "attribute_name") : 객체가 갖고 있는 속성을 지정해서 확인

# 객체 속성 요소 확인
attr(x, "names")
attr(X, "dimnames")




## 2.4.5 벡터와 행렬의 차이점
# 행렬은 개념적으로 nx1 벡터가 2개 이상 묶어져서 행과 열의 속성을 갖기만 기본적으로는 벡터

z <- 1:8
U <- matrix(z, 4,2)
length(z)

# R에서 U가 행렬임을 나타내기 위해 추가적인 속성(attribute)를 부여
class(z) # 벡터
attributes(z)

class(U) # 행렬
attributes(U)




## 2.4.6 의도하지 않은 차원축소 피하기
# 다음 행렬에서 한 행을 추출
Z <- matrix(c(1:8), 4, 2)
z <- Z[2,]

attributes(Z) # 행과 열의 차원 수를 표시시

# 객체 z의 속성 및 형태는?
attributes(z)

# 차원 축소를 방지하는 방법 

# 1. z를 벡터가 아닌 1x2행렬로 인식
z <- Z[2,,drop = FALSE]
attributes(z)

# 2. as.matrix() 를 이용한 직접 변환
z <- as.matrix(Z[2,])
class(z)
attributes(z)

z # 벡터가 아닌 행렬이 반환됨을 유의의
