### 4.1 Prerequisites

## 4.1.1 외부데이터 불러오기 및 저장

# 기본 R에서 제공하는 함수를 이용해 외부 데이터를 읽고, 내보내고, 저장하는 방법에 대해 살펴봄
# 가장 일반적인 형태의 데이터는 보통 텍스트 파일 형태로 저장
# 첫 번째 줄 : 변수명
# 두 번째 줄 부터 : 데이터
# 데이터의 자료값과 자료값을 구분하는 문자를 구분자(separator라고 하며 주로 공백(), 콤마(,), tab(\t)등이 사용됨

# 외부 데이터를 불러온다는 것은 외부에 저장되어 있는 파일을 R작업환경으로 읽어온다는 의미이기 떄문에, 현재 작업공간의 디렉토리(working diretory) 확인이 필요
# getwd() : 현재 작업공간의 디렉토리 확인
# dir() : 현재 작업공간의 디렉토리에 있는 파일 확인

getwd()
dir()


# read.table() / write.table()
# 가장 범용적으로 외부 텍스트 데이터를 R 작업공간으로 데이터 프레임으로 읽고 저장하는 함수
# 텍스트 파일의 형태에 따라 구분자 지정 가능

read.table(
  file, # 파일명. 일반적으로 폴더명 구분자
        # 보통 folder/파일이름.txt 형태로 입력
  header = FALSE, # 첫 번째 행을 헤더(변수명)으로 처리할 지 여부
  sep = "", # 구분자 "," , "\t" 등의 형태로 입력
  comment.char = "#", # 주석문자 지정
  stringsAsFactors = TRUE, # 문자형 변수를 factor으로 변환할 지 여부
  encoding = "unknown" # 텍스트의 encoding 보통 CP949 또는 UTF-8
                       # 한글이 입력된 데이터가 있을 때 사용
)

# 예시


# tab 구분자 데이터 불러오기

# dataset 폴더에 저장되어 있는 DBP.txt 파일 읽어오기
dbp <- read.table("data/dataset/DBP.txt", sep = "\t", header = TRUE)
str(dbp)

# 문자형 값들을 factor으로 변환하지 않는 경우
dbp2 <- read.table("data/dataset/DBP.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)
str(dbp2)

# 데이터 형태 파악
head(dbp)


# 콤마 구분자 데이터 불러오기

# dataset 폴더에 저장되어 있는 diabetes_csv.txt 파일 읽어오기
diab <- read.table("data/dataset/diabetes_csv.txt", sep = ",", header = TRUE)
str(diab)
head(diab)


# Encoding이 다른 경우(한글 데이터 포함)
# 한약재 사전 데이터 (CP949 encoding으로 저장)
# tab 구분자 데이터 사용

# UTF-8로 읽어오기
herb <- read.table("data/dataset/herb_dic_sample.txt", sep = "\t",
                   encoding = "UTF-8",
                   header = TRUE,
                   stringsAsFactors = FALSE)
head(herb)

# CP949로 읽어오기
herb <- read.table("data/dataset/herb_dic_sample.txt", sep = "\t",
                   encoding = "CP949",
                   header = TRUE,
                   stringsAsFactors = FALSE)
head(herb)



# read.table() + textConnection() : 웹사이트나 URL 등에 있는 데이터를 Copy + Paste 해서 읽어올 경우 유용하게 사용
# txetConnection() : 텍스트에서 한 줄씩 읽어 문자형 벡터처럼 인식할 수 있도록 해주는 함수

# Plasma 데이터: http://lib.stat.cmu.edu/datasets/Plasma_Retinol 
input1 <- ("64	2	2	21.4838	1	1298.8	57	6.3	0	170.3	1945	890	200	915
76	2	1	23.87631	1	1032.5	50.1	15.8	0	75.8	2653	451	124	727
38	2	2	20.0108	2	2372.3	83.6	19.1	14.1	257.9	6321	660	328	721
40	2	2	25.14062	3	2449.5	97.5	26.5	0.5	332.6	1061	864	153	615
72	2	1	20.98504	1	1952.1	82.6	16.2	0	170.8	2863	1209	92	799
40	2	2	27.52136	3	1366.9	56	9.6	1.3	154.6	1729	1439	148	654
65	2	1	22.01154	2	2213.9	52	28.7	0	255.1	5371	802	258	834
58	2	1	28.75702	1	1595.6	63.4	10.9	0	214.1	823	2571	64	825
35	2	1	23.07662	3	1800.5	57.8	20.3	0.6	233.6	2895	944	218	517
55	2	2	34.96995	3	1263.6	39.6	15.5	0	171.9	3307	493	81	562
66	2	2	20.94647	1	1460.8	58	18.2	1	137.4	1714	535	184	935
40	2	1	36.43161	2	1638.2	49.3	14.9	0	130.7	2031	492	91	741
57	1	1	31.73039	3	2072.9	106.7	9.6	0.9	420	1982	1105	120	679
66	2	1	21.78854	1	987.5	35.6	10.3	0	254.9	2120	1047	61	507
66	1	1	27.31916	3	1574.3	75	7.1	0	361.5	1388	980	108	852
64	1	2	31.44674	3	2868.5	128.8	15	20	379.5	3888	1545	211	1249
62	1	2	25.90246	1	1751.1	80.7	8.4	14.1	160.3	2194	242	235	1035
75	1	2	29.15264	1	1407.6	35	20.8	7	144.1	3470	479	288	1262
68	2	1	38.18727	3	1628.5	78.6	11.6	0	512.3	2108	921	102	904
57	1	2	25.89669	3	1101.4	48.5	8.5	5	197.2	1157	445	113	1727
56	1	2	24.45884	3	2433.6	127.6	19.9	7.1	271.2	1739	926	74	684")

input2 <- ("AGE: Age (years)
    SEX: Sex (1=Male, 2=Female).
    SMOKSTAT: Smoking status (1=Never, 2=Former, 3=Current Smoker)
    QUETELET: Quetelet (weight/(height^2))
    VITUSE: Vitamin Use (1=Yes, fairly often, 2=Yes, not often, 3=No)
    CALORIES: Number of calories consumed per day.
    FAT: Grams of fat consumed per day.
    FIBER: Grams of fiber consumed per day.
    ALCOHOL: Number of alcoholic drinks consumed per week.
    CHOLESTEROL: Cholesterol consumed (mg per day).
    BETADIET: Dietary beta-carotene consumed (mcg per day).
    RETDIET: Dietary retinol consumed (mcg per day)
    BETAPLASMA: Plasma beta-carotene (ng/ml)
    RETPLASMA: Plasma Retinol (ng/ml)")

plasma <- read.table(textConnection(input1), sep = "\t", header = F)
plasma
codebook <- read.table(textConnection(input2), sep = ":", header = F)
varname <- gsub("^\\s+","",codebook$V1)
names(plasma) <- varname
head(plasma)



# write.table() : R 객체를 텍스트 파일로 저장하기
write.ftable(
  data_obj, # 저장할 객체 이름
  file, # 저장할 위치 및 파일명 또는 "파일쓰기"를 위한 연결 명칭
  sep, # 저장 시 사용할 구분자
  row.names = TRUE # 행 이름 저장 여부
)


# 예시

# 위에서 읽어온 plasma 객체를 dataset/plasma.txt 로 내보내기
# 행 이름은 생략, tab 으로 데이터 구분 
write.table(plasma, "data/dataset/plasma.txt", sep = "\t", row.names = F)

# 파일 저장 대신 windows clipboard 로 내보내기 가능
# cilpboard 로 복사 후 excel 시트에 해당 데이터 붙여넣기
write.table(plasma, "clipboard", sep = "\t", row.names = F) # Ctrl + V

# read.csv() / write.csv() : read.table() 함수의 wrapper 함수로 구분자 인수 sep이 콤마(,)로 고정



# R 바이너리(binary) 파일 입출력
# R 작업공간에 존재하는 한 개 이상의 객체들을 저장하고 읽기 위한 함수

# R 데이터 관련 바이너리 파일은 한 개 이상의 객체가 저장된 바이너리 파일인 경우 *.Rdata 형태를 갖고, 단일 객체를 저장할 경우 보통 *.rds 파일 확장자로 저장


# *.Rdata 입출력 함수

# load(): *.Rdata 파일 읽어오기
# save(): 한 개 이상 R 작업공간에 존재하는 객체를 .Rdata 파일로 저장
# save.image(): 현재 R 작업공간에 존재하는 모든 객체를 .Rdata 파일로 저장


# 현재 작업공간에 존재하는 모든 객체를 "output" 폴더에 저장
# output 폴더가 존재하지 않는 경우 아래 명령 실행
# dir.create("output")
dir.create("output")

ls() # 현재 작업공간에 존재하는 객체 확인

save.image(file = "output/all_obj.Rdata")
rm(list = ls()) # 현재 작업공간에 존재하는 객체 모두 삭제
ls()


# 저장된 binary 파일("output/all_obj.Rdata") 불러오기
load("output/all_obj.Rdata")
ls()


# plasma 데이터만 output 폴더에 sub_obj.Rdata 로 저장
save(plasma, file = "output/sub_obj.Rdata")
rm(list = c("Plasma","plasma"))
ls()

# sub_obj.Rdata 파일 불러오기
load("output/sub_obj.Rdata")
ls()



# *.rds 입출력 함수
# readRDS()/ saveRDS(): 단일 객체가 저장된 *.rds 파일을 읽거나 저장
# 대용량 데이터를 다룰 때 유용함
# read.table() 보다 데이터를 읽는 속도가 빠르며, 다른 확장자 명의 텍스트 파일보다 높은 압축율을 보임

# 대용량 파일 data/dataset/pulse.csv 불러오기
# system.time() : 명령 실행 시간 계산 함수
system.time(pulse <- read.csv("data/dataset/pulse.csv", header = T))

# saveRDS()함수를 이용해 output/pulse.rds 파일로 저장
saveRDS(pulse, "output/pulse.rds")
rm(pulse) ; ls()

system.time(pulse <-readRDS("output/pulse.rds"))
