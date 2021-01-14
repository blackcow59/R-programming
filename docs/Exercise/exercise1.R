require(markdown)
require(knitr)
require(tidyverse)
require(readxl)

### 1

# a. 현재 작업공간에 저장되어 있는 모든 R객체를 확인할 수 있는 스크립트를 작성하시오
ls()

# b. 현재 작업공간에 저장되어 있는 모든 R 객체를 삭제하는 스크립트를 작성 하시오
rm(list=ls())

# c. 현재 작업폴대를 확인하는 스크립트를 작성 하시오
getwd()

# d. 현재 작업폴더 내 존재하는 파일을 확인하는 스크립트를 작성 하시오
list.files()

# e. 작업폴더를 C: 또는 D: 드라이브로 변경하는 스크립트를 작성 하시오
setwd("C:/")

# f. R 작업공간에서 폴더를 생성하는 함수에 대해 googling을 통해 검색하고, 검색한 함수를 적용해 C 또는 D 드라이브에 final-exam-practice 라는 폴더를 생성하시오
dir.create("final-exam-practice")
list.files()

# g. 작업폴더를 final-exam-parctice로 변경하시오
setwd("C:/final-exam-practice/")

# h. R 작업공간에서 폴더를 변경을 위해 절대폴더를 입력하는 방법과 현재 작업폴더를 기준으로 폴더를 변경하기 위해 상대적 폴더를 사용하는 방법이 있따, 상대적 폴더를 지정 및 사용방법을 예시를 통해 설명하시오
getwd()
setwd()


### 2 다음은 R 객체 vector와 matrix와 관련한 질문이다. 해당 코드를 순차적으로 작성하시오. 단, 재현성을 위해 set.seed(20200618)을 실행 후 아래 문제에 대해 답하시오
set.seed(20200618)

# a. 평균이 4이고 분산이 9인 정규분포에서 200개의 난수를 생성 후 x 라는 객체에 저장하시오
rnorm(200, 4, 3) -> x

# b. 
e <- rnorm(200, 0, sqrt(2))

# c. 위에서 생성한 x와 c를 결과를 y에 저장하기 위한 스크립트를 작성하시오
y = 1 + 0.6*x + e

# d. x 와 y에 대한 산점도를 생성하는 스크립트를 작성하시오
plot(y ~ x)

# e. x를 이용해 아래와 같은 행렬 x를 생성하는 스크립트를 작성하시오.
X <- as.matrix(data.frame(1, x))
class(X)

# f. 객체X와 y를 이용해 bhat을 만들어라
bhat <- solve(t(X)%*%X)%*%t(X)%*%y

# g. bhat의 의미를 기술하시오
# 모수의 최소제곱추정량을 의미한다



### 4
# a.
dir.exists("gapminder/gapminder_filter.csv")

# b. 
gapdat <- read_csv("gapminder/gapminder_filter.csv")

# c.
gap_2017 <- gapdat %>%
  mutate(continent = factor(sub("^\\w+-*\\w*\\s", "", region))) %>%
  filter(year == 2017)

gap_2017_1 <- gapdat %>%
  mutate(continent = factor(gsub(".+\\s", "", region))) %>%
  filter(year == 2017)

all.equal(gap_2017, gap_2017_1)


# d. 
ggplot(gap_2017,aes(x = gdp_cap, y = life_expectancy)) +
  geom_point(aes(col = continent ,size = population), alpha = 0.4) + 
  scale_size_continuous(range = c(1, 20)) +
  scale_color_brewer(palette = 'Set1') + geom_text(aes(label = country),check_overlap = T) + 
  guides(size = F,
         color = guide_legend(override.aes = list(size = 5))) +
  labs(col = '') + 
  xlab('GDP per capita ($)') + 
  ylab('Age (year)') + 
  ggtitle('Relationship between life expectancy and income at 2017') + 
  theme_minimal()
  




### 5

# a
desc_status <- diamonds %>%
  mutate(status = factor(ifelse(price <= 5000, 'cheap',
                                ifelse(price <= 10000, 'normal', 'expensive')),
                         levels = c('cheap', 'normal', 'expensive'))) %>%
  group_by(status, cut) %>%
  summarise_at(vars(carat, x, y, z),
               list(mean = ~ mean(.),
                    sd = ~ sd(.),
                    median = ~ median(.),
                    iqr = ~ IQR(.)))

#
diamonds %>%
  mutate(status = factor(ifelse(price <= 5000, 'cheap',
                                ifelse(price <= 10000, 'normal', 'expensive')),
                         levels = c('cheap', 'normal', 'expensive'))) -> diamonds_status %>%
  group_by(status, cut) %>%
  summarise_at(vars(carat, x, y, z),
               list(mean = ~ mean(.),
                    sd = ~ sd(.),
                    median = ~ median(.),
                    iqr = ~ IQR(.))) -> desc_status


#
tab_status_cut <- diamonds_status %>%
  table(status, cut) %>%
  data.frame
 
 
#
desc_status_new <- tab_status_cut %>%
  inner_join(desc_status, by = c("status", "cut"))

