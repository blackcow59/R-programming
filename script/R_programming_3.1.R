### 3.1 유용한 문자열 관련 함수

## 3.1.1 nachar()
# 인간이 눈으로 읽을 수 있는 문자의 개수(길이)를 반환
# 공백, 줄바꿈 표시자(예 : \n)도 하나의 문자 개수로 인식
# 한글의 한 글자는 2바이트(byte)지만 한 글자로 인식 -> byte 단위 반환 가능

# 문자열을 구성하는 문자 개수 반환
nchar(
  x, # 문자형 벡터
  type # "bytes" : 바이트 단위 길이 반환
      # "char" : 인간이 읽을 수 있는 글자 길이 반환
      # "width" : 문자열이 표현된 폭의 길이 반환
)

# 예시
x <- "Carlos Gardel's song : Por Una Cabeza"
nchar(x)

y <- "abcde\nfghij"
nchar(y)

z <- "양준일 : 가나다라마바사"
nchar(z)

# 문자열 벡터
str <- sentences[1:10]
nchar(str)

s <- c("abc", "가나다", "1234[]", "R programming\n", "\"R\"")
nchar(s)

nchar(s, type = "byte")
nchar(s, type = "width")


## 3.1.2 paste(), paste0()
# 하나 이상의 문자열을 연결하여 하나의 문자열로 만들어주는 함수
# Excel의 문자열 연결자인 &와 거의 동일한 기능을 수행

paste(
  ..., # 한 개 이상의 R 객체. 강제로 문자형 변환
  sep # 연결 구분자 : 디폴드 값은 공백(" ")
  collapese # 묶을 객체가 하나의 문자열 벡터인 경우 
            # 모든 원소를 collapse 구분자로 묶은 길이가 1인 벡터 반환
)

# paste0()은 paste()의 wrapper 함수이고 paste()의 구분자 인수 sep = "" 일 때와 동일한 결과 반환
# 예시

i <- 1:length(letters)

paste(letters,i) # sep = " "
paste(letters,i,sep = "_") # sep = "_"
paste0(letters,i) # paste(letters,i,sep = "") 동일

# collapse 인수 활용
paste(letters, collapse = "")
writeLines(paste(str,collapes = "\n"))

# 3개 이상 객체 묶기
paste("Col", 1:2, c(TRUE, FALSE, TRUE), sep = " ", collapse = "<->")

# paste 함수 응용
# 스트링 명령어 실행
exprs <- paste("lm(mpg ~", names(mtcars)[3:5],", data = mtcars)")
exprs

sapply(1:length(exprs), function(i) coef(eval(parse(text = exprs[i]))))


## 3.1.3 sprintf()
# c 언어의 sprintf() 함수와 동일하며 특정 변수들의 값을 이용해 문자열을 반환함
# 수치형 값의 소숫점 자리수를 맞추거나 할 때 유용하게 사용
# 포맷팅 문자열을 통해 수치형의 자릿수를 지정 뿐 아니라 전체 문자열의 길이 및 정렬 가능

# 예시
options()$digits #

pi # 파이 값
sprintf("%f", pi)

# 소숫점 자리수 3자리 까지 출력
sprintf("%.3f",pi)

# 소숫점 출력 하지 않음
sprintf("%1.0f",pi)

# 출력 문자열의 길이를 5로 고정 후 소숫점 한 자리까지 출력
sprintf("%5.1f",pi)
nchar(sprintf("%5.1f", pi))

# 빈 공백에 0값 대입
sprintf("%05.1f",pi)

# 양수/음수 표현
sprintf("%+f", pi)
sprintf("%+f", -pi)

# 출력 문자열의 첫 번째 값을 공백으로
sprintf("% f", pi)

# 왼쪽 정렬
sprintf("%-10.3f", pi)

# 수치형에 정수 포맷을 입력하면?
sprintf("%d", pi)

# 정수형
sprintf("%d",100); sprintf("%d", 20L)

# 지수형
sprintf("%e", pi)
sprintf("%E", pi)
sprintf("%.2E",pi)

# 문자열
sprintf("%s = %.2f", "Mean", pi)

# 응용
mn <- apply(cars, 2 ,mean)
std <- apply(cars, 2, sd)

# Mean +- SD 형태로 결과 출력 (소숫점 2자리 고정)
res <- sprintf("%.2f \U00B1 %.2f", mn, std)
resp <- paste(paste0(names(cars), ":", res), collapes = "\n")
writeLines(resp)


## 3.1.4 substr()
# 문자열에서 특정 부분을 추출하는 함수
# 보통 한 문자열이 주어졌을때 start 에서 end까지 추출
substr(
  x, # 문자형 벡터
  start, # 문자열 추출 시작 위치
  stop # 문자열 추출 종료 위치
)

# 예시
cnu <- "충남대학교 자연과학대학 정보통계학과"
substr(cnu, start = 14, stop = nchar(str))

# 문자열 벡터에서 각 원소 별 적용
substr(str, 5, 15)


## 3.1.5 tolower(), toupper()
# 대소문자를 소문자(tolower())혹은 소문자를 대문자(toupper())로 변환
LETTERS; tolower(LETTERS)
letters; toupper(letters)