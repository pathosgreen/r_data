exam <- read_excel("data/excel_exam.xlsx")
exam

head(exam) # 앞 부분 부터 6개의 데이터 출력

tail(exam) # 뒷 부분 부터 6개의 데이터 출력

head(exam,2) # 지정 개수로 확인인

View(exam)

dim(exam)

str(exam)

summary(exam)

# mpg 데이터 분석
# install.packages("ggplot2")
library(ggplot2)

# ggplot2의 mpg 데이터를 데이터 프레임 형테로 불러오기
mpg <- as.data.frame(ggplot2::mpg)

dim(mpg)
head(mpg)
tail(mpg)

str(mpg)

# 변수명 바꾸기
df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

install.packages("dplyr")
library(dplyr)

# 복사본 생성
df_new <- df_raw

#var2 v2로 수정
df_new <- rename(df_new, v2=var2)
df_new

df <- data.frame(var1 = c(4,3,6),
                 var2 = c(2,6,1))
df

# 파생변수 - 합계
df$var_sum <- df$var1 + df$var2
df

# 파생변수 - 평균
df$var_mean <- (df$var1 + df$var2)/2
df

# mpg의 통합 연비 변수 생성 -total
mpg$total <- (mpg$hwy + mpg$cty)/2
mpg
dim(mpg)

# 통합 연비의 평균
mean(mpg$total)
# 재확인
summary(mpg$total)

# total이 20 이상이면 pass 20 미만이면 fail
mpg$test <- ifelse(mpg$total >= 20, "pass","fail")

View(mpg)

table(mpg$test)

# fail과 pass를 시각화
library(ggplot2)
qplot(mpg$test)

# grade 이름으로 파생 변수 생성
# total이 30 이상이면 A, 30 미만 20 이상이면 B, 20 미만이면 C
mpg$grade <- ifelse(mpg$total >= 30,"A",ifelse(mpg$total >= 20,"B","C"))

head(mpg,20)
View(mpg)

table(mpg$grade)
qplot(mpg$grade)

