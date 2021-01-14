### 3.2 정규표현식 기본 함수
## 3.2.1 grep(), grepl()
## 정규표현식을 이용한 특정 문자 패턴 검색 시 가장 빈번히 사용되는 함수들 중 하나임

# grep()
# 특정 문자 벡터에서 찾고자 하는 패턴과 일치하는 원소의 인덱스, 원소값 반환
# 일치하는 특정 문자열을 포함하느 원소값(문자형) 또는 인덱스(정수)를 반환

ggrep(
  pattern, # 정규 표현식 또는 문자 패턴
  string, # 패턴을 검색할 문자열 벡터
  value, # 논리값
         # TRUE : pattern에 해당하는 원소값 반환
         # FALSE : pattern 이 있는 원소의 색인 반환
)

x <- c("Equator", "North Pole", "South Pole")

# x에서 Pole 이 있는 원소의 문자열 반환
grep("Pole", x, value = TRUE)

# x에서 Pole 이 있는 원소의 색인 반환
grep("Pole", x, value = FALSE)

# x에서 Eq를 포함한 원소 색인 반환
grep("Eq", x, value = FALSE)


# grepl()
# grep()과 유사한 기능을 갖지만, 함수의 반환값이 논리형 벡터임
# 일치하는 특정 문자열을 포함하는 원소 색인에 대한 논리값 반환

grepl(
  pattern, # 정규 표현식 또는 문자 패턴
  string # 패턴을 검색할 문자열 벡터
)

# grepl()예시
# Titanic data 불러오기
url1 <- "https://raw.githubusercontent.com/"
url2 <- "agconti/kaggle-titanic/master/data/train.csv"
titanic <- read.csv(paste0(url1, url2),stringsAsFactors = FALSE)

# 승객이름 추출
pname <- titanic$Name

# 승객 이름이 James 인 사람만 추출
g <- grepl("James", pname)
pname[g]
g

## 3.2.2 regexpr(), gregexpr()

# grep()과 grepl()의 한계점 보완 : 특정 문자 패턴의 일치 여부에 대한 정보를 제공하지만 위치 및 정규식의 일치 여부를 알려주지는 않음

# regexpr()
# 문자열에서 패턴이 일치하는 문자(표현)가 첫 번째 등장하는 위치와 몇 개의 문자로 구성(길이) 되어 있는지를 반환

# 예시
x <- c("Darth Vader: If you only knew the power of the Dark Side. 
       Obi-Wan never told you what happend to your father", 
       "Luke: He told me enough! It was you who killed him!", 
       "Darth Vader: No. I'm your father")

# grep 계열 함수
grep("you", x); grepl("you", x)

# regexpr()
regexpr("you", x) # 각 x의 문자열에서 you가 처음 나타난 위치 및 길이 반환

# substr() 함수와 regexpr() 함수를 이용해 텍스트 내 원하는 문자 추출 가능
idx <- regexpr("father",x)
substr(x,idx,idx + attr(idx, "match.length")-1)

# gregexpr()
# 영역에 걸쳐 패턴과 일치하는 문자의 위치 및 길이 반환(regexpr() 의 global 버전)
gregexpr("you", x) # 각 x의 문자열에서 you 가 나타난 모든 위치 및 길이 반환
gregexpr("father", x) # 패턴을 포함하지 않은 경우 -1 반환


## 3.2.3 sub(), gsub()
# 검색하고자 하는 패턴을 원하는 문자로 변경
# 문자열 벡터의 패턴을 일치시키거나 문자열 정리가 필요할 때 사용

# sub()
# 문자열에서 첫 번쨰 일치하는 패턴만 변경
sub(pattern, # r검색하고자 하는 문자, 패턴, 표현
    replacement, # 검색할 패턴 대신 변경하고자 하는 문자 및 표현
    x # 문자형 벡터
)

# 예시

jude <- c("Hey Jude, don't make it bad", 
          "Take a sad song and make it better", 
          "Remember to let her into your heart", 
          "Then you can start to make it better")

sub("a", "X", jude)

# gsub()
# 문자열에서 일치하는 모든 패턴 변경

# 예시
sub(" ","_", jude)
gsub("a","X",jude)


## 3.2.4 regexec()
# regexpr()과 유사하게 작동하지만 괄호(()) 로 묶인 하위 표현식에 대한 인덱스를 제공
# () : 정규 표현식의 메타 문자 중 하나로 그룹을 나타냄 -> 정규표현식 내 논리적 텍스트 수행 가능

bla <- c("I like statistics", 
         "I like R programming", 
         "I like bananas", 
         "Estates and statues are too expensive")

grepl("like", bla)
grepl("are", bla)
grepl("(like|are)", bla)

# 찾고자 하는 패턴을 두 그룹으로 나눌 때 유용
# 예시
gregexpr("stat", bla)
gregexpr("(st)(at)", bla)
# "at"에 대한 패턴을 찾지 못하고
# "star" 패턴과 동일한 결과 반환

regexec("(st)(at)", bla)
# "stat" 패턴도 동시에 반환됨을 유의
# 첫 번째 일치 패턴만 반환


## 3.2.5 strsplit()
# 문자열에서 매칭되는 특정 패턴(문자)을 기준으로 문자열을 분할함

strsplit(
  x, # 문자형 벡터
  split # 분할 구분 문자(정규표현식 포함)
)

# 예시
jude_w1 <- strsplit(jude," ")
jude_w1

# 공백, 쉼표가 있는 경우 구분
jude_w2 <- strsplit(jude, "(\\s|,)")   # \\s : 공백의 정규표현식
jude_w2
