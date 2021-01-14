## 2.8 객체의 유형 판별 및 변환

# is/as 계열 함수 사용 예시
x <- c("M","F"); f<-factor(x)

is.character(x)  # x가 문자열인가?
is.factor(f)  # f가 factor인가?
is.numeric(f) # f가 숫자형인가?

# f를 수치형으로 변환
f <- as.numeric(f)
is.numeric(f)
f

# 다시 f를 factor형으로 변환
as.factor(f)


# 2차원 데이터 객체 유형 판별 및 변환

X <- matrix(rnorm(9),3)
d <- data.frame(group = rep(LETTERS[1:3],each = 2),
                means = c(mapply(rnorm,
                                 c(2,2,2),
                                 c(1,2,3),
                                 c(1,1,1))))
# 객체 유형 확인
is.matrix(X); is.data.frame(X)
is.matrix(d); is.data.frame(d)

#객체 유형 변환
as.data.frame(X); as.matrix(d)
as.list(X); as.list(d)