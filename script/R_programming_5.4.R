### 5.4 ggpolt2
require(ggplot2)
require(tidyverse)
# 데이터에 대한 그래프는 데이터의 속성과 시각적 속성간에 대응 또는 매핑으로 이루어짐
# R에서 가장 유명한 데이터 시각화 패키지 중 하나로 2005년 Hadley Wickham이 개발 및 배포


# R 기본 데이터셋 : ToothGrowth
ToothGrowth %>%
  group_by(supp, dose) %>%
  summarise(mean = mean(len)) %>%
  mutate(dose = factor(dose,
                       ordered = TRUE)) -> tg_long

tg_long %>%
  spread(supp, mean) %>%
  column_to_rownames("dose") %>%  # 열 값을 열 이름으로 변환
  as.matrix -> tg_mat

# R graphics : barplot() 사용
barplot(tg_mat, beside = T)

# dose로 그룹화 하기 위해 데이터 전치
barplot(t(tg_mat), beside = T)

# 막대 대신 선으로 표현
plot(tg_mat[,1], type = 'l', col = 'blue')
lines(tg_mat[,2], type = "l", col = 'black')

# ggplot 사용 : data.frame에만 적용 가능
ggplot(data  = tg_long,
       aes(y = mean)) -> gmap
gmap +
  geom_bar(aes(x = supp,, fill = dose),
           stat = 'identity',
           position = 'dodge')

# 데이터 구조를 변경하지 않고 ggplot의 매핑 변수 변경
gmap + 
  geom_bar(aes(x = dose, fill = supp),
           stat = 'identity',
           position = 'dodge')

# ggplot을 이용한 선 도표 생성
gmap + 
  geom_line(aes(x = dose,
                group = supp,
                color = supp),
            size = 1)






## 5.4.1 기본 문법
# ggplot(data = <DATA>) + 
#   <GEOM_FUCTION>(mapping = aes(<MAPPING>)) +
#   <SCALE_FUCTION> + 
#   <LABEL or GUIDES> +
#   <ANNOTATION> +
#   <THEME>

  
# 용어
# data : 시각화의 대상으로 관측값과 변수로 이루어짐
# geom : 데이터의 값을 시각적으로 보여주기 위한 레이어로 막대, 선, 점과 같은 기하학적 객체
# aesthetic : geom의 시각적 속성을 정의하며, x,y 위치 , 선 색상, 점 모양 등을 정의
# mapping : 데이터 값을 asthetic에 매핑
# scale : astheice에 매핑 시 세부 값들을 제어
# guide : 그래프 해석에 도움을 주는 속성으로 x-y축의 눈금, 레이블, 범례를 포함
# annotation : 생성한 그래프 위에 추가적인 정보 추가
# theme : 그래프의 비데이터적 요소 제어를 통해 그래프의 미적효과 극대화

# ggplot 그래프 생성 기본 단계
# 1. ggplot()으로 ggplot 객체 초기화
# -> ggpplot객체를 생성하는 함수로 시각화할 데이터가 무엇인지, 그리고 데이터에 포함된 변수들이 어떤 asthetic에 매핑되는지를 선언
# 2. aes() 함수로 x-y 축 지정
# -> 데이터 내 변수들이 어떤 geoms레이어에서 어떤 시각적 속성을 갖는지를 지정해주는 함수로 ggplot() 함수 내, 혹은 독립적인 레이어로 추가 가능
# 3. geom 계열 함수로 데이터를 시각적 요소로 매핑. 이때 aes() 함수와 같이 색상, 크기 등 지정
# 4. scale 계열 함수를 이용해 asthetic 세부 값을 조정
# 5. 축 제목, 레이블, 범례 설정 조정
# 6. 필요 시 theme 조정을 통해 시각적 요소 가미


# ggplot() 을 이용한 ggplot() 생성

# cars dataset

# ggplot() 내에 aes() 지정
ggplot(data = cars,
       aes(x = speed, y = dist)) +
  geom_point()

# aesthetic을 ggplot() 함수 밖에서 지정
ggplot(data = cars) +
  aes(x = speed, y = dist) +
  geom_point()

# geom 계열 함수 내에서 aesthetic 지정
ggplot(data = cars) +
  geom_point(aes(x = speed, y = dist))

# ggplot 객체 생성
gp <- ggplot(data = cars); gp
gp <- gp + 
  aes(x = speed, y = dist); gp
gp + geom_point()

# 참고 : R 기본 plot()의 결과는 객체로 저장되지 않음



# 주요 aesthetics
# x, y : x-y 축에 해당하는 변수명, x와 y의 이름은 생략 가능
# color : 점, 선, 텍스트 색상
# fill : 면(막대, 상자, 도형 등)색상
# alpha : 색상의 투명도
# group : 시각화에 사용할 데이터의 그룹
# size : 점, 선, 텍스트의 크기 또는 굵기
# shape : 점의 모양
# linetype : 선의 형태 지정

# 색상관련 aesthetics : color, fill, alpha
# aes() 함수 내부 또는 외부에서 인수 조정 가능 (함수 내부 : 변수명으로 지정, 함수외부 : 특정 값으로 지정)


# 막대도표 예시
# 'aes()' 함수 외부에서 사용 시 단일 값을 입력
gpcol <- ggplot(data = mpg, aes(x = class))
gpcol + geom_bar() +
  labs(title = "Default geom_bar()") # 그래프 제목 지정
gpcol + geom_bar(fill = 'navy') +
  labs(title = "fill = 'navy'")

gpcol + geom_bar(color = 'red') +
  labs(title = "color = 'red'")

gpcol + geom_bar(color = 'red', fill = 'white') +
  labs(title = "color = 'red', fill = 'white'")

# 연료 타입에 따라 면 색 지정
gpcol + 
  geom_bar(aes(fill = fl)) +
  labs(title = "Filled by fuel types (fl)")

# 연료 타입에 따라 막대 선 색 지정
gpcol +
  geom_bar(aes(color = fl)) +
  labs(title = "Colored by fuel types (fl)")

# alpha ; 0-1 사이 값을 갖고 투명도 지정
# 주로 aes() 함수 밖에서 사용됨
set.seed(20200605)
df1 <- tibble(
  x = rnorm(5000),
  y = rnorm(5000)
)
gpalpha <- ggplot(data = df1, aes(x,y))

gpalpha + geom_point() +
  labs(title = "alpha = 1")

gpalpha + geom_point(alpha = 0.1) +
  labs(title = "alpha = 0.1")

# 그룹(gruop) aesthetic
# 기본적으로 aes() 내부에서 aesthetic에 대응하는 변수가 이산형(범주형)변수로 정해짐
# 보통은 color, shape, linetype 으로 그룹 지정이 가능하지만 충분하지 않은 경우 group인수 값 지정

# 다중 집단에 하나의 aesthetic만 적용한 경우
# gapminder dataset
gapm <- read_csv("data/gapminder_filter.csv")
gapm_filter <- gapm %>%
  filter(grepl('Asia', region))
gpgroup <- ggplot(data = gapm_filter,
                  aes(x = year, y = life_expectancy))
gpgroup + geom_line(size = 0.5, alpha = 0.2)
gpgroup_1 <- gpgroup + geom_line(aes(group = country),
                                 size = 0.5, alpha = 0.2)
gpgroup_1


# 전체 아시아 국가의 평균 추세선
# geom_line과 geom_smooth 모두 group을 country로 지정
gpgroup_1 + 
  geom_smooth(aes(group = country),
              method = "loess",
              size = 0.5,
              color = "blue",
              se = FALSE)

# 모든 국가에 가장 적합한 하나의 곡선으로 fitting
gpgroup_1 + 
  geom_smooth(aes(group = 1),
              method = "loess",
              size = 1,
              color = "blue",
              se = F)

# 크기(size), 점 모양(shape), 선모양(linetype) aesthetic
# size 지정
gpsize <- ggplot(data = mtcars,
                 aes(disp, mpg))

gpsize + geom_point(size = 4)

gpsize + geom_point(aes(size = hp),
                    alpha = 0.5)


# shape 지정
gpshape <- ggplot(data = mtcars,
                  aes(hp, mpg))
gpshape + 
  geom_point(shape = 5)

# 실린더 개수에 따라 점 모양 지정
gpshape + 
  geom_point(aes(shape = factor(cyl)),
             size = 4)


# linetype 지정 (economics_long data)
gplty <- ggplot(data = economics_long,
                aes(x = date, y = value01))
gplty + 
  geom_line(aes(group = variable, color = variable),
            size = 0.5,
            linetype = 6)

# 변수에 따라 선 모양 지정
gplty + 
  geom_line(aes(linetype = variable,
               color = variable),
           size = 0.5)








## 5.4.2 Geoms : 선 관련 geometric

# geom_line() : x축에 대응한 변수의 순서대로 관측값을 선으로 연결
# geom_path() : 관측치가 데이터셋에 나타난 순서대로 선으로 연결
# geom_abline(slope, intercept) : 기울기와 절편에 대한 직선 -> R 기본 그래픽함수 abline()과 유사
# geom_vline(xintercept) : x축에 수직(y축에 수평)인 직선 생성
# geom_hline(yintercept) : x축에 수평(y축에 수직)인 직선 생성

# gap-minder data
gpline <- ggplot(data = gapm_filter,
                 aes(y = gdp_cap))

# geom_line
gpline + 
  geom_line(aes(x = year,
                group = country),
            size = 0.5,
            alpha = 0.3,
            linetype = 'solid') -> gpline
gpline


# geom_path
highlight_country <- c('South Korea','China', 'Japan', 'India', 'Taiwan', 'Singapore')

# dplyr 패키지 체인과 ggplot 함수 연결 가능
gppath <- gapm %>%
  filter(year >= 2000,
         country %in% highlight_country) %>%
  ggplot(aes(x = gdp_cap,
             y = life_expectancy))
gppath + geom_path(aes(group = country))

# 선 굵기 및 색상 조정
gppath + geom_path(aes(color = country),
                   size = 4,
                   alpha = 0.5) -> gppath

#  선과 점 동시에 출력
gppath + 
  geom_point(aes(shape = country),
             size = 2)

# geom_aline, geom_hline, geom_vline

# abline
m <- lm(gdp_cap ~ year, data = gapm_filter)
gpline + 
  geom_abline(slope = coef(m)[2],
              intercept = coef(m)[1],
              size = 2,
              color = 'blue') -> gplines
gplines


# hline
gplines + 
  geom_hline(yintercept = mean(gapm_filter$gdp_cap,
                               na.rm = TRUE),
             color = 'red',
             size = 1) -> gplines
gplines + ggtitle('Addling a horizontal line : mean of gdp_cap')


# vline
gplines + 
  geom_vline(xintercept = mean(gapm_filter$year,
                               na.rm = T),
             color = 'red',
             size = 1) + 
  ggtitle("Adding a vertical line : mean of year")






## 5.4.3 Geoms : 점 geometrics
# geom_point() : ggplot 객체에 지정된 aesthetic(x-y에 대응하는 변수)에 대한 산점도를 생성
# geom_jiter() : 각 점의 위치에 random noise를 추가해 overplotting 처리 -> geom_point(position = "jitter")의 축약 버전

# geom_point
gppoint <- gapm %>%
  mutate(continent = gsub("(.+\\s)","",region) %>%
           factor) %>%
  filter(year == 2015) %>%
  ggplot(aes(x = life_expectancy, y = gdp_cap))
gppoint + 
  geom_point(size = 1)


# 점의 크기는 해당 국가 인구수(log10 변환) 에 비례
# 각 대륙에 따라 색 구분
# 투명도는 0.3
# -> Bubble plot
gppoint + geom_point(aes(size = log(population, base = 10),
                         color = continent),
                     alpha = 0.3)

# mpg data
# cylinder 개수에 따른 시내 연비
gppoint2 <- ggplot(data = mpg,
                   aes(x = cyl, y = cty))
gppoint2 + geom_point(size = 3)

# geom_jitter
# geom_point 에서 position 인수 조정
gppoint2 + 
  geom_point(position = "jitter",
             aes(color = class)) +
  ggtitle("geom_point() with position = 'jitter'")

# geom_jitter : jitterng 크기는 0.3
# class 로 색 조정
gppoint2 +
geom_jitter(aes(color = class),
            width = 0.3) +
  ggtitle("Jittering using geom_jitter()")






## 5.4.4 Geoms : 막대 geometrics

# geom_bar() : 범주형(factor 또는 문자열)변수에 대응하는 케이스의 수를 막대의 높이로 나타냄.
# 기본적으로 stat_count()를 통해 각 집단 별 케이스 수가 그래프에 표현
# 함수 내 stat인수 값을 "identifity"로 설정 시 데이터 값 표현 가능
# geom_col() : 데이터 값 자체를 높이로 표현
# stat_identity() 를 사용


# Example

# geom_bar() 와 geom_col() 예시

p1 <- ggplot(data = mpg,
             aes(x = class)) + 
  geom_bar() +
  labs(title = 'p2 : Barplot via geom_bar()',
       caption = 'The y-axis indicates the number of cases in each class')
p2 <- mpg %>%
  group_by(class) %>%
  summarise(mean = mean(cty)) %>%
  ggplot(aes(x = class, y = mean)) +
  geom_col() + 
  labs(title = 'p1 : Barplot via geom_col',
       caption = 'The y axis indicates the identical values of means')
p1
p2

# geom_bar (stat = 'identity') 인 경우 geom_col() 과 동일한 결과 도출
p1 <- mpg %>%
  group_by(class) %>%
  summarise(mean = mean(cty)) %>%
  ggplot(aes(x = class, y = mean)) +
  geom_bar(stat = 'identity') +
  labs(title = "p1 : Barplot via geom_bar(stat = 'identity')")
p1

# 막대도표 x-y 축 변환
# 이 경우 geom_bar() 에 aesthetic 추가
p2 <- ggplot(mpg) +
  geom_bar(aes(y = class)) +
  labs(title = "p2 : Map 'class' variable to y")
p2


# diamonds dataset
# 2개의 범주형 변수가 aesthetic에 mapping 된 경우
# staked barplot
gbar_iit <- ggplot(data  = diamonds) + 
  aes(x = color, fill = cut)
p1 <- gbar_iit +
  geom_bar()
p1

p2 <- gbar_iit +
  geom_bar(position = 'dodge2')
p2


# 막대도표 값 순으로 정렬하기
# gapminder region 별 중위수 계산
gapm_median <- gapm %>%
  filter(year == 2015) %>%
  group_by(region) %>%
  summarise(median = median(gdp_cap, na.rm = T))

p1 <- ggplot(gapm_median) +
  aes(x = region, y = median) +
  geom_bar(stat = "identity") +
  coord_flip()
p2 <- gapm_median %>%
  mutate(region = reorder(region, median)) %>%
  ggplot(aes(x = region, y = median)) +
  geom_bar(stat = "identity") + 
  coord_flip() # x-y 축 뒤집기






## 5.4.5 Geom : 수직 범위선 관련 geometrics
# 오차 막대, 신뢰구간 등을 도식화 할 때 많이 활용되며 데이터의 변수를 mapping 시 위치 관련 aesthetic에 x, y 외에 ymin, xmin, ymax, xmax 가 사용

# geom_errorbar() : 주어진 범위 내 오차막대 생성 -> 오차막대는 선 끝에 범위선과 수직인 선이 생성
# geom_linerange() : 주어진 범위 내 선 생성

# 주요인수 : ymin(ymax) , xmin(xmax) 지정 필수

# geom_errorbar() 예시
# diamonds cut, color에 따른 carat의 평균, 표준편차, 95% 신뢰구간 계산
# dplyr + pipe operator를 이용한 통계량 계산

carrat_sum <- diamonds %>%
  group_by(cut, color) %>%
  summarise(N = n(),
            mean = mean(carat),
            sd = sd(carat)) %>%
  mutate(lcl = mean - qt(0.975, N-1)*sd/sqrt(N),
         ucl = mean + qt(0.975, N-1)*sd/sqrt(N))

gerror_init <- ggplot(data = carrat_sum) +
  aes(x = cut, y = mean, color = color) 
gerror_init

# 오차 막대 도표 오차 범위는 95% 신뢰구간
gerror_init + 
  geom_errorbar(aes(ymin = lcl,
                    ymax = ucl),
                width = 0.1, # 선 너비 지정)
                position = position_dodge(0.8)) +
  geom_line(aes(group = color),
            position = position_dodge(0.8)) +
  geom_point(size = 3,
             position = position_dodge(0.8))

# 막대도표 위에 오차 막대 표시 예제

# warpbreaks data
# R 기본 그래픽스 barplot() 예제와 동일한 그래프 생성

break_summ <- warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(N = n(),
            mean = mean(breaks),
            sem = sd(breaks)/sqrt(N))

ggplot(data = break_summ) + 
  aes(x = tension, y = mean, fill = wool) + 
  geom_col(position = position_dodge(0.9),
           color = "black") +
  geom_errorbar(aes(ymin = mean - sem,
                    ymax = mean + sem),
                position = position_dodge(0.9),
                width = 0.1)


# 95% 신뢰구간 시뮬레이션 예제
# geom_linerange 예시
# 정규 난수 생성
# 표본 크기 n = 30, 반복 N = 200
# 평균 mu = 20, 표준편차 sx = 10
# 각 표본에 대한  95% 신뢰구간 계산(모분산은 안다고 가정)
set.seed(20200609)
n <- 30 ; N = 200
mu <- 20; sx <- 10
X <- mapply(rnorm,
            rep(n, N),
            rep(mu, N),
            rep(sx, N))
mi <- apply(X, 2, mean)
si <- apply(X, 2, sd)
alpha <- 0.05 # 유의수준
lower_ci <- mi - qnorm(1-alpha/2)*si/sqrt(n)
upper_ci <- mi + qnorm(1-alpha/2)*si/sqrt(n)
df_ci <- tibble(lower_ci, upper_ci) %>%
  mutate(nsim = seq_len(N),
         mu_contain = lower_ci <= mu &
           mu <= upper_ci)
ggci_init <- ggplot(df_ci) + 
  aes(x = nsim)

ggci_init +
  geom_linerange(
    aes(ymin = lower_ci,
        ymax = upper_ci,
        color = mu_contain),
    size = 1.2,
    alpha = 0.3
  ) + 
  geom_hline(yintercept = mu,
             color = "tomato",
             size = 1)






## 5.4.6 Geoms : 텍스트 관련 geometrics
# x-y 좌표축제 텍스트를 추가하기 위한 함수. 여기서 미리 지정된 x-y aesthetic에 대한 매핑은 사용할 수 있으며, 별도의 aesthetic 정의를 통해 새로운 좌표점에 텍스트 추가 가능

# geom_text(
# geom_label()

# geom_text() example

gtext_init <- mtcars %>% 
  rownames_to_column(var = "model") %>% 
  ggplot(aes(x = wt, y = mpg)) 

gtext1 <- gtext_init + 
  geom_text(aes(label = model), 
            size = 4) +  # x-y aesthetic 사용
  labs(title = "geom_text() with size = 4")

# 중첩되는 텍스트 제거
gtext2 <- gtext_init + 
  geom_text(aes(label = model), 
            size = 4, 
            check_overlap = TRUE) + 
  labs(title = "Remove overlapped text with check_overlap = TRUE")

# geom_label() 
# check_overlap 옵션 사용할 수 없음
gtext3 <- gtext_init + 
  geom_label(aes(label = model), 
             size = 4) + 
  labs(title = "geom_label()")

gtext4 <- gtext_init + 
  geom_point(size = 1) + 
  geom_text(aes(label = model, 
                color = factor(cyl)), 
            size = 4, 
            fontface = "italic", 
            check_overlap = TRUE) + 
  labs(title = "Both points and texts: using italic fontface")



#ggplot 텍스트 위치 조정
# R 기본 그래픽 함수 text() 함수의 adj 인수와 유사

# vjust: (-) 방향 ↑ ; middle = 0.5; (+) 방향  ↓
# hjust: (-) 방향 → ; middle = 0.5; (+) 방향  ←






## 5.4.7 Geoms : 면적 관련 geometrics
# geom_ribbon() : 각 x 값에 대해 ymin과 ymax로 정의된 간격을 면적으로 표시
# geom_area() : geom_ribbon()의 special case 로 ymin = 0, ymax 대신 y를 사용하여 면적 영역 표시


# Example

# geom_ribbon() 예시
# gap_minder dataset
gapm %>%
  filter(iso == "KOR") %>%
  select(year, gdp_cap) %>%
  ggplot(aes(x = year, y = gdp_cap)) +
  geom_ribbon(aes(ymin = gdp_cap - 5000,
                  ymax = gdp_cap + 5000),
              fill = 'gray',
              alpha = 0.5) +
  geom_line(size = 1.5,
            color = 'black')

# 표준정규분포 밀도함수 곡선 아래 면적 표시

x <- seq(-3, 3, by = 0.01)
z <- dnorm(x)
df_norm <- data.frame(x, z)
idx <- -1.2 < x & x < 0.7
df_area <- df_norm %>%
  filter(idx)
expr <- bquote(P({-1.2 < Z} < 0.7) == 
                 .(sprintf("%.3f", pnorm(0.7) - pnorm(-1.2))))

# 각 geom 별로 다른 데이터 적용
ggplot() + 
  geom_line(data = df_norm,
       aes(x = x, y = z), size = 1) +
  geom_area(data = df_area,
            aes(x = x, y = z),
            fill = "red", alpha = 0.2) +
  geom_text(aes(x = -1, y = 0.2,
                label = paste(deparse(expr), collapse = "")),
            parse = T, size = 5,
            hjust = 0)





## 5.4.8 Geoms : 통계 그래프 관련 geomtrics

# geom_histogram example
# diamonds 데이터셋

p0 <- ggplot(data = diamonds, aes(x = carat))
p1 <- p0 + geom_histogram() + 
  labs(title = "bins, binwidth = default")
p2 <- p0 + geom_histogram(binwidth = 0.01) + 
  labs(title = "binwidth = 0.05")
p3 <- p0 + geom_histogram(bins = 150) + 
  labs(title = "bins = 150")
p4 <- ggplot(data = diamonds, aes(y = carat)) + 
  geom_histogram() + # y 축 기준으로 히스토그램 생성
  labs(title = "Map to y (flipped)")
p1
p2
p3
p4

# iris 데이터셋. 변수: Sepal Length
p0 <- ggplot(data = iris, aes(x = Petal.Length))
p1 <- p0 + 
  geom_histogram(aes(fill = Species), 
                 color = "white",
                 bins = 20, 
                 alpha = 0.2) + 
  labs(title = "p1: Histograms of petal length: frequency"); p1

p2 <- p0 + 
  geom_histogram(aes(fill = Species, 
                     y = ..density..), # y축을 밀도로 변경
                 color = "white", # 막대 테두리선 지정
                 alpha = 0.2, 
                 bins = 20) +  
  labs(title = "p2: Histograms of petal length: density"); p2

# geom_density() : 막대 형태의 히스토그램을 부드러운 선으로 나타낸 곡선으로, 커널 밀도 추정을 통해 밀도 곡선 추정

# geom_histogram() 예시 이어서

p1 <- p0 + 
  geom_density() + 
  labs(title = "p1: Basic geom_density()")

p2 <- p0 + 
  geom_density(aes(color = Species)) + 
  labs(title = "p2: geom_density(aes(color = Species))")

p3 <- p0 + 
  geom_density(aes(fill = Species, 
                   color = Species), 
               alpha = 0.2) + 
  labs(title = "p3: geom_density(aes(color = Species))")
p4 <- p0 + 
  geom_density(aes(fill = Species, 
                   color = Species), 
               alpha = 0.2) + 
  geom_histogram(aes(y = ..density.., # 밀도로 변환 필요
                     fill = Species), 
                 color = "white", 
                 alpha = 0.3, 
                 bins = 20) + 
  labs(title = "p4: Overlaying multiple histograms with multiple densities")


# geom_boxplot() : R 기본 그래픽스 함수 boxplot() 과 유사. stat_boxplot() 함수의 결과값을 기반으로 그래프 도출

# diamond dataset
p0 <- ggplot(data = diamonds,
             aes(y = carat))

p1 <- p0 + 
  geom_boxplot()
p1

p2 <- p0 + 
  geom_boxplot(aes(x = cut,
                   fill = cut))
p2

p3 <- p0 + 
  geom_boxplot(aes(x = cut,
                   fill = cut),
               width = 0.5)
p3

p4 <- p0 + 
  geom_boxplot(aes(x = cut,
                   fill = color),
               outlier.shape = 4,
               outlier.color = "red")
p4



# geom_boxplot() + geom_jitter() 콜라보
# mpg dataset

p0 <- ggplot(data = mpg)+
  aes(x = class, y = cty)
p0

p1 <- p0 + 
  geom_boxplot(aes(fill = class),
               outlier.shape = NA,
               alpha = 0.1) +
  geom_jitter(aes(color = class),
              alpha = 0.5,
              width = 0.2) +
  labs(title = "p1 : boxplot with jittered data points per eahc class (unordered)")
p1

p2 <- mpg %>%
  mutate(class = reorder(class, cty, median)) %>%
  ggplot(aes(x = class, y = cty)) +
  geom_boxplot(aes(fill = class),
               outlier.shape = NA,
               alpha = 0.1) +
  geom_jitter(aes(color = class),
              alpha = 0.5,
              width = 0.2) +
  labs(title = "p2 : orderd by median of cty for each car class")
p2


# geom_smooth() : x-y 관계에 대한 패턴을 도식화하기 위한 그래프로 아래와 같은 방법을 이용해 추세선과 추정 직선의 오차 그래프 출력

p0 <- ggplot(data = diamonds) +
  aes(x = carat, y = price)

p1 <- p0 + 
  geom_point(alpha = 0.2) +
  geom_smooth() +
  labs(title = "p1 : geom_smooth() default")
p1

p2 <- p0 +
  geom_point(aes(color = color),
             alpha = 0.2) +
  geom_smooth(aes(color = color)) +
  labs(title = "p2 : geom_smooth() for diffrent color groups")
p2





## 5.4.9 : Scales : X-Y축 관련 aesthetic 조정

# scale_x_*, scale_y_* :  x-y 축의 범위, plot 상 눈금선, 축 제목 등을 조정
# xlim(), ylim(): scale_x_*, scale_y_*의 특별한 케이스로 x-y 축의 범위 조정



## 5.4.10 Scales: 색상 관련 aesthetic 조정
# scale_color_*, scale_fill_*: aes()에 color 또는 fill이 정의된 경우, 기본 색상 변경 가능
# 색상 조정은 palette를 통해 가능하며, 색상 파레트를 사용할 경우 scale_*_brewer()를 통해 palette 설정 가능
# RColorBrewer 패키지 설치 시 보다 다양한 palette 사용 가능



## 5.4.11 Scales: 크기, 선 종류, 점 모양 aesthetic 조정
# scale_size_*: size에 대한 세부적인 값 지정 가능
# scale_shape_*: shape가 aes() 함수에 사용된 경우, shape에 대한 세부 값(점 모양, 크기, 색 등 지정 가능)
# scale_linetype_*: linetype이 aes() 함수에 사용된 경우, linetype에 대한 세부 값(선 종류, 굵기 등 조정 가능)

## 5.4.11.1 scale_size_* example
gppoint + 
  geom_point(aes(size = population,
                 color = continent),
             alpha = 0.3) +
  scale_size_continuous(range = c(1, 20))




## 5.4.12 Coordinate systems
# coord_filp() : x-y 축 뒤집기

p0 <- ggplot(data = diamonds,
             aes(y = carat))

p1 <- p0 + geom_boxplot(aes(x = color,
                            fill = color),
                        width = 0.5)
p1

p2 <- p1 + 
  coord_flip()
p2




## 5.4.13 Guides: x-y 축 및 그래프 제목 관련

# labs(): x-y 축 제목, 부제목, 캡션 조정
# xlab(), ylab(), ggtitle(): labs()의 조정 인수를 개별 함수로 구현
# guide_legend(): guides() 함수 내부에서 사용되며, 범례 영역 조정하기 위한 함수
# 이미 정의한 aesthetic에 대한 범례 영역의 세부 속성을 변경하고 싶은 경우 overrride.aes 인수 조정(입력값은 리스트)


gapm %>% 
  mutate(continent = gsub("(.+\\s)", "", region) %>% 
           factor) %>% 
  filter(year == 2015) %>% 
  ggplot(aes(x = life_expectancy, y = gdp_cap)) + 
  geom_point(aes(size = population, 
                 color = continent), 
             alpha = 0.3) -> p1

p2 <- p1 + 
  guides(size = FALSE, # size 관련 guide(범례는 출력하지 않음)
         color = guide_legend(
           title = "Contient",
           title.theme = element_text(face = "bold"),
           override.aes = list(size = 5)
         )) + 
  theme(legend.position = "top")
p2





## 5.4.14 Facets : 국소 시각화 기법
