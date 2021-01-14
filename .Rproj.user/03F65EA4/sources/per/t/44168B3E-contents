require(tidyverse)

# 현재 작업공간(workspace)에 저장되어있는 모든 R 객체(objcets)를 확인할 수 있는 스크립트
ls()

# 현재 작업공간에 저장되어 있는 모든 R 객체를 삭제하는 스크립트
rm(list = ls())

# 현재 작업폴더(working directory)를 확인하는 스크립트
getwd()

# 현재 작업폴더 내 존재하는 파일을 확인하는 스크립트
dir()

# 작업 폴더를 C: 또는 D: 드라이브로 변경하는 스크립트
setwd("")

# R 작업공간에서 폴더를 생선하는 함수를 통해 final_exam_practice 폴더 생성
dir.create("final_exam_practice")

# 작업폴더를 final_exam_practice로 변경
setwd("final_exam_practice")

set.seed(20200618)
# 평균이 4이고 분산이 9인 정규분포에서 200개의 난수를 생성 후 x라는 객체에 저장
x <- rnorm(200,4,sqrt(9))
x

# e라는 객체에 평균이0이고 분산이2인 서로 독립이고 동일한 정규분포(i.i.d)200개에서 분포의 개수만큼 생성한 난수 저장
e <- rnorm(200,0,sqrt(2))

# 위에서 생성한 x와 e를 활용해 yi = 1 + 0.6xi + ei 결과를 y에 저장하기 위한 스크립트
y = 1 + 0.6*x + e
y

# x와 y에 대한 산점도를 생성하는 스크립트
plot(y ~ x)

# x를 이용해 행렬 X를 생성
X <- matrix(data = c(rep(1,length(x)),x), ncol = 2)
X

# X와 y를 이용해 (XtX)-1Xty의 계산 결과를 bhat에 저장
bhat <- solve(t(X) %*% X) %*% t(X) %*% y
bhat

# 
