### 2.5 배열(array)
# 통계학의 관점에서 R의 행렬의 행은 조사 대상이 되는 사람, 동물 등 관측 대상에 해당하고, 열은 대상의 특성을 표현하는 변수(예 : 몸무게,키,혈압 등)에 해당 -> 2차원 구조
# 위와 같은 데이터를 년 단위로 수집한다면? -> 한 대상자에 해당하는 변수들은 시간에 따라 변함 -> 시간 차원이 하나 더 존재!
# R에서 이러한 형태의 데이터 구조를 배열(array)이라고 지칭함


## 2.5.1 배열의 생성 및 색인
# 동일한 유형의 데이터가 2차원 이상으로 구성된 데이터 구조
# 동일한 차원(nxp)의 배열(행렬)이 k개 바에 저장된 구조


# array() : 배열 생성 함수
array(data, # 저장할 데이터 벡터 또는 행렬
      dim, # 배열의 차원 지정
      dimnames, # 배열 차원의 명칭
      )

# 예시
# 통게학과 3명의 학생에 대한 중간고사 기준 한 번의 퀴즈와 중간고사 점수, 그리고 기말고사 기준의 한 번의 퀴즈와 기말고사 점수 데이터
x <- c(75,84,93,65,78,92)
y <- c(82,78,85,88,75,88)

first_term <- matrix(x, nrow = 3, ncol = 2)
second_term <- matrix(y, nrow = 3, ncol = 2)
first_term; second_term

z <- array(data = c(first_term, second_term), dim = c(3,2,2) )
z

# z의 속성
attributes(z)
# z의 클래스
class(z)
# z의 구조
str(z)


# 배열 내 데이터 접근은 색인을 통해 가능(벡터 행렬과 동일)

# 첫 번째 층만 추출
z[,,1]

# 두 번째 층에서 2-3행만 추출
z[2:3,,2]




## 2.5.2 배열 확장 예제

# 1. 이미지 입출력 패키지 installation
install.packages("jpeg") # jpeg 파일 입출력 관련 package
install.packages("cowplot") # ggplot add-on package

# 2. 관련 패키지 불러오기
require(tidyverse)
require(jpeg)
require(cowplot)

# 3. 이미지 불러오기
myurl <- "https://img.livescore.co.kr/data/editor/1906/ba517de8162d92f4ea0e9de0ec98ba02.jpg"
z <- tempfile()
download.file(myurl,z,mode="wb")
pic <- readJPEG(z)

# 4. 그래프 출력창에서 이미지 확인
ggdraw() +
  draw_image(pic)

# 5. 이미지 임의 부분 편집하기
pic[300:460, 440:520, 1] <- 0.5
pic[300:460, 440:520, 2] <- 0.5
pic[300:460, 440:520, 3] <- 0.5
ggdraw() +
  draw_image(pic)

# 6. RGB값을 무작위로 샘플링 후 매개변수로 노이즈 가중치 조절해보기
pic <- readJPEG(z)
yr <- pic[300:460, 440:520, 1]
yg <- pic[300:460, 440:520, 2]
yb <- pic[300:460, 440:520, 3]
n <- nrow(yr); p <- ncol(yr)

t <- 0.2
wr <- t * yr + (1 - t)*matrix(runif(length(yr)), nrow = n, ncol = p)
wg <- t * yg + (1 - t)*matrix(runif(length(yg)), nrow = n, ncol = p)
wb <- t * yb + (1 - t)*matrix(runif(length(yb)), nrow = n, ncol = p)


pic[300:460, 440:520, 1] <- wr
pic[300:460, 440:520, 2] <- wg
pic[300:460, 440:520, 3] <- wb

ggdraw() +
  draw_image(pic)
