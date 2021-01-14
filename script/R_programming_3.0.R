### 3 문자열 처리와 정규표현식
## 학습목표
# 텍스트 문자 처리에 있어 가장 기본인 정규 표현식(regular rexpression)에 대해 알아본다
# R에서 기본으로 재공하는 문자열 처리 함수에 대해 알아본다.


# 정규 표현식의 기본함수

# grep(),grepl() : 문자형 벡터에서 정규 표현식 또는 문자 패턴의 일치를 검색
# grep() : 일치하는 특정 문자열을 포함하는 문자형 벡터 또는 인덱스를 반환
# grepl() : 문자열 포함 여부에 대한 논리값 반환

# regexpr(),gregexpr() : 문자형 벡터에서 정규 표현식 또는 문자 패턴과 일치하는 원소를 검색하고, 일치가 시작되는 문자열의 인덱스와 일치 길이를 반환

# sub(), gsub() : 문자열 벡터에서 정규 표현식 또는 문자 패턴과 일치하는 원소를 검색하고 해당 문자열을 다른 문자열로 변경

# regexec() : regexpr()과 동일하게 일치가 시작되는 문자열의 인덱스를 반환하지만 괄호로 묶인 하위 표현식의 위치를 추가로 반환

# 문자열 기초
# 탈출 지시자(escape indicator) : \
# 키보드로 입력할 수 없는 문자를 입력하기 위해 사용
# 문자열에 백슬래쉬\를 입력하려면 \\로 표시

# 문자열에 따옴표(single of double quote, ', " )입력
double_quote <- "\""
double_quote

single_quote <- '\''
single_quote

x <- c("\"", "\\", '\'')
writeLines(x)

# 백슬레쉬가 포함된 문자열
x <- "abc\nabc"
y <- "abc\tabc"
# \n : Enter
# \t : tab 문자를 표현

writeLines(x)
writeLines(y)

# 특수문자 표현
x <- "\u00b5"   # 그리스 문자 mu 표현 (유니코드)
x
writeLines(x)
