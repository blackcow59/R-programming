### 3.3 정규 표현식(regular expression)
# 주어진 문자열에 특정한 패턴이 있는 경우, 해당 패턴을 일반화(수식화)한 문자열
# 특정 패턴을 표현한 문자열을 메타 문자(meta character) 라고 지칭
# 일반적으로 특정 규칙 또는 패턴이 문자열을 찾고(to find), 해당 규칙에 해당하는 문자열을 대체(replace, sbstitute) 하기 위해 사용
# R언어 뿐 아니라 타 프로그래밍 언어(C, Perl, Python 등)워드 프로세서, 텍스트 편집기, 검색엔진, 운영체제(Window, Linux등)에서도 범용적으로 사용
# 정규식이라고도 불리우며 영어로는 regex 또는 regexp 로 명칭됨

## 3.3.1 기본 메타 문자

# 메타 문자를 메타 문자가 아닌 문자 자체로 인식하기 위해서는 해당 문자 앞에 \\를 붙임

# 마침표가 있는 위치 반환
str2 <- str[1:2]
regexpr(".",str2)
str

# 에러 출력
regexpr("\.",str2)

# 정확한 표현
regexpr("\\.", str2)


## 마침표(period) : .
# 어떤 임의의 한 문자를 의미한다.

# 문자열 자체가 존재하니까 참값 반환
grepl(".", jude)
grepl(".","#$@%@#%@#$@#%@#%")

# 문자 없음 ""
grepl(".", "")

# a로 시작하고 중간에 어떤 글자가 하나 존재하고 b로 끝나는 패턴
bla2 <- c("acc", "abb", "accb", "acadb")
g <- grepl("a.b",bla2)
bla2[g]

# a와 b사이 어떤 두 문자가 존재하는 패턴
g <- grepl("a..b",bla2)
bla2[g]


## 플러스(plus) : +
# +에 선행된 패턴이 한 번 이상 매칭 -> +앞에 문자를 1개 이상 포함

# "a"를 적어도 하나 이상 포함한 원소 반환
grepl("a+", c("ab", "aa", "aab", "aaab", "b"))

# "l"과 "n" 사이에 "o"가 하나 이상인 원소 반환
grepl("lo+n", c("bloon", "blno", "leno", "lnooon", "lololon"))


## 별(asterisk) : *
# * 앞에 선행된 문자 또는 패턴이 0번 이상 매치 -> *앞에 문자를 0개 또는 1개 이상 포함

# xx가 "a"를 0 또는 1개 이상 포함하고 있는가?
xx <- c("bbb", "acb", "def", "cde", "zde", "era", "xsery")
# "a" 존재와 상관 없이 모든 문자열이 조건에 부합
g <- grepl("a*", xx)
xx[g]

# "aab"와 "c" 사이에 "d"가 없거나 하나 이상인 경우 
# "caabec"인 경우 "aab"와 "c" 사이에 "e"가 존재하기 때문에 FALSE
grepl("aabd*c", c("aabddc", "caabec", "aabc"))


## 물음표(question) : ?
# ?앞에 항목은 선택 사항이며 많아야 한 번 매치 -> ? 앞의 문자를 0개 또는 1개 포함

xx <- c("ac", "abbc", "abc", "abcd", "abbdc")
g <- grepl("ab?c", xx) ## "a"와 "c" 사이 "b"가 0개 또는 1개 포함
xx[g]

yy <- c("aabc", "aabbc", "daabec", "aabbbc", "aabbbbc")
g <- grepl("aabb?c", yy) ## "aab"와 "c" 사이에 "b"가 0개 또는 1개 있는 경우 일치
yy[g]


## (caret) : ^
# ^ 뒤에 나오는 문자(열)로 시작하는 문자열 반환

# str에서 "The"로 시작하는 문자열 반환
g <- grepl("^The",str)
str[g]

# [^] : 대괄호 안에 첫 번째 문자가 ^인 경우 ^ 뒤에 있는 문자들을 제외한 모든 문자와 매치

xx <- c("abc", "def", "xyz", "werx", "wbcsp", "cba")
# "a", "b", "c"를 '순서 상관 없이 동시에' 포함하지 않은 문자열 반환
g <- grepl("[^abc]", xx)
xx[g]

# ^[] : [] 안에 들어간 문자 중 어느 한 단어로 시작하는 문자열 반환

xx <- c("def", "wasp", "sepcial", "statisitc", "abbey load", "cross", "batman")
g <- grepl("^[abc]",xx)
xx[g]

## 달러(dollar) : $
# $ 앞에 나오는 문자 및 패턴과 문자열의 맨 마지막 문자 및 패턴을 매치
g <- grepl("father$",x)
writeLines(x[g])

## 중괄호(curly bracket) : {}
# {} 앞의 문자 패턴이 {} 안에 숫자만큼 반복되는 패턴을 매치
# {n} : 정확히 n번 매치
# {n,m} : n번에서 m번 매치
# {n,} : 적어도 n번 이상 매치

xx <- c("tango", "jazz", "swing jazz", "hip hop", 
        "groove", "rock'n roll", "heavy metal")

# "z"가 정확히 2번 반복되는 원소 반환
g <- grepl("z{2}", xx)
xx[g]

# "e" 가 2번 이상 반복되는 원소 반환
yy <- c("deer", "abacd", "abcd", "daaeb", "eel", "greeeeg")
g <- grepl("e{2,}",yy)
yy[g]

# "b"가 2번 이상 4번 이하 반복되고 앞에 "a"가 있는 원소 반환
zz <- c("ababababab", "abbb", "cbbe", "xabbbbcd")
g <- grepl("ab{2,4}", zz)
zz[g]


#### 참고: 위에서 소개한 메타 문자 중 
####        *는 {0,}     +는 {1,}     ?는 {0,1}   과 동일한 의미를 가짐

## 괄호(parenthesis) : ()
# 특정 문자열을 () 로 grouping
# 한 개 이상의 그룹 지정 가능

# ab가 1~4회 이상 반복되는 문자열 반환
g <- grepl("(ab){1,4}", zz)
zz[g]

# "The"로 시작하고  "punch"가 포함된 문자열 ㅂ반환
g <- grepl("^(The)+.*(punch)", str)
str[g]

## (vertical bar) : |
# |를 기준으로 좌우 문자 패턴 중 하나를 의미하며 OR 조건과 동일한 의미를 가짐
# [] 의 경우 메타문자나 문자 한글자에 대해서만 적용되는 반면 |는 문자를 묶어 문자열로 지정 가능

g <- grepl("(is|was)", str)
str[g]

g <- grepl("(are|were)", str)
str[g]

## 3.3.2 문자 집합

# \w 를 이용해 email 추출

# 이메일 주소가 naver 또는 gmail만 추출
email <- c("demo@naver.com", 
           "sample@gmail.com", 
           "coffee@daum.net", 
           "redbull@nate.com", 
           "android@gmail.com", 
           "secondmoon@gmail.com", 
           "zorba1997@korea.re.kr")
g <- grepl("\\w+@(naver|gmail)\\.\\w+",email)
email[g]
g <- grepl("\\w+@(naver|gmail)",email)


# 숫자를 포함하는 문자열 추출 :\d
ex <- c("ticket", "51203", "+-.,!@#", "ABCD", "_", "010-123-4567")
g <- grepl("\\d",ex)
ex[g]

# 뒤쪽 공백문자 제거 : 공백문자(\s)
xx <- c("some text on the line 1; \n and then some text on line two        ")
sub("\\s+$","",xx)

# [ 영문자(소문자 및 대문자), 숫자, 언더바(_) ]를 제외한 문자 포함 : \W
g <- grep("\\W",ex)
ex[g]

# 숫자를 제외한 모든 문자 반환 : \D
g <- grepl("\\D",ex)
ex[g]

# [ 영문자, 숫자, 언더바 ]를 제외한 모든 문자를 포함하고 숫자와 특수문자를 포함하는 문자열도 제외 : \W, \D
g <- grepl("\\W\\D",ex)
ex[g]

# (공백, 탭)을 제외한 모든 문자 포함 : \S
blank <- c(" ", "_", "abcd", "\t", "%^$#*#*") 
g <- grepl("\\S",blank)
blank[g]


# 각 영화제목의 첫글자를 대문자로 변경
# \b는 단어의 양쪽 가장 자리의 빈 문자를 의미
# \\1은 () 첫 번째 그룹, \\U는 대문자(perl)
movie <- c("terminator 3: rise of the machiens", 
           "les miserables", 
           "avengers: infinity war", 
           "iron man", 
           "indiana jones: the last crusade", 
           "irish man", 
           "mission impossible", 
           "the devil wears prada", 
           "parasite (gisaengchung)", 
           "once upon a time in hollywood")
gsub("\\b(\\w)", "\\U\\1", movie, perl = T)


# 엑셀에서 ()로 표시된 음수 데이터를 읽어온 경우
# 이를 음수로 표시
num <- c("0.123", "0.456", "(0.45)", "1.25")
gsub("\\(([0-9.]+)\\)", "-\\1", num)



## 3.3.4 정규 표현식 예시
# 텍스트 데이터를 처리할 때 일반적으로 많이 활용되는 정규 표현식
# 정제되지 않은 데이터 가공 시 유용하게 활용

# 공백 제거
# 1. 공백을 다른 문자로 교체해 주는 함수 : gsub()
# 2. 공백 character class : \\s
# 3. 처음과 끝 지정 meta character : ^(처음), $(끝)
# 4. 조건을 찾기 위한 meta character : +, |
# 모든 공백 제거 : \\s
# 앞쪽 공백 제거 : ^\\s+
# 뒤쪽 공백 제거 : \\s+$
# 양쪽 공백 모두 제거 : (^\\s+|\\s+$)

# 예시

txt <- c("        신종 코로나바이러스 감염증(코로나19) 환자 가운데 회복해서 항체가
         생긴 사람 중 절반가량은 체내에 바이러스가 남아 있는 것으로 나타났다.   ")
txt
writeLines(txt)

# 모든 공백 제거
gsub("\\s","", txt)

# 앞쪽 공백만 제거
gsub("^\\s+","", txt)

# 뒤쪽 공백만 제거
gsub("\\s+$","",txt)

# 양쪽 공백 모두 제거
gsub("(^\\s+|\\s+$)","",txt)

# 가운데 /n 뒤에 존재하는 공백들을 없애려면??
gsub("(^\\s+| {2,}|\\s+$)","",txt)


# 핸드폰 번호 추출

# 필요한 표현식
# 1. 처음 세자리 : ^(01)\\d{1}
# 2. 가운데 3~4자리 : -\\d{3,4}
# 3. 마지막 4자리 : -\\d{4}

# 예시

phone <- c("042-868-9999", "02-3345-1234", 
           "010-5661-7578", "016-123-4567", 
           "063-123-5678", "070-5498- 1904", 
           "011-423-2912", "010-6745-2973")

g <- grepl("^(01)\\d{1}-\\d{3,4}-\\d{4}",phone)
phone[g]


# 이메일 추출
# 정규 표현식을 이용해 이메일(e-mail)주소만 텍스트 문서에서 추출
# 이메일 주소 구성

# 필요한 표현식
# 1. E-mail ID(@왼쪽) : 어떤 알파벳, 숫자, 특수문자가 1개이상 -> [A-Za-z0-9[:punct:]]+
# 2. E-mail ID(@오른쪽-1) : 어떤 알파벳이나 숫자가 하나 이상 존재하고 특수문자 포함 (xx.xx.) -> @[A-Za-z0-9[:punct:]]
# 3. E-mail ID(@오른쪽-2) : .xx 또는 .xxx 검색 -> \\.[A-Za-z]+

# 예시

# 크롤링 한 데이터 불러오기
news_naver <- read.csv("C:\\r-project\\r-programming\\data\\dataset\\news-scraping.csv", header = TRUE, stringsAsFactors = FALSE)

# regmaches 함수 : regexpr(), gregexpr(), regexec() 로 검색한 패턴을 텍스트(문자열)에서 추출

# ID 추출

id <- regmatches(news_naver$url, regexpr("\\d{10}", news_naver$url))
contents <- news_naver$news_content
news_naver2 <- data.frame(id, title = news_naver$news_title,
                          stringsAsFactors = FALSE)
# \\b는 단어의 양쪽 가장자리의 빈 문자를 의미
tmp <- regmatches(contents, 
                  gregexpr("\\b[A-za-z0-9[:punct:]]+@[A-Za-z0-9[:punct:]]+\\.[A-Za-z]+",contents))
names(tmp) <- id
x <- t(sapply(tmp,function(x) x[1:2], simplify = "array"))
colnames(x) <- paste0("email",1:2)
x
email <- data.frame(id = row.names(x), x, stringsAsFactors = FALSE)
email
res <- merge(news_naver2, email, by = "id")
head(res)




# stringr 패키지 사용

library(stringr)

email <- str_extract_all(contents,
         "\\b[A-Za-z0-9[:punct:]]+@[A-Za-z0-9[:punct:]]+\\.[A-Za-z]+",
        simplify = TRUE)
email <- data.frame(email, stringsAsFactors = FALSE)
names(email) <- paste0("email", 1:2)
res <- data.frame(id, title = news_naver$news_title, email,
                  stringsAsFactors = FALSE)
head(res)
