df <- data.frame(sex=c("M","F",NA,"M","F"),
                 score=c(5,4,3,4,NA))
df
# 결측치 확인
is.na(df) # 양이 많을경우 보기 불편함

# 결측치 빈도 출력
table(is.na(df))

# 필드별 결측치 개수 확인
table(is.na(df$sex))
table(is.na(df$score))

# 필드에 결측치가 존재하면 계산이 안 됨
mean(df$score)
sum(df$score)

# 결측치에 대한 대안
# 1. 결측치 제거
# 2. 다른 값으로 변환

library(dplyr)
df %>% filter(is.na(score)) # score NA 확인

# score 결측치 제거된 내용 표시
df %>% filter(!is.na(score))
# score 결측치 제거된 내용 저장
df_nomiss <- df %>% filter(!is.na(score))
sum(df_nomiss$score)
# 현재의 데이터에 존재하는 모든 결측치 제거
df_nomiss <- df %>% filter(!is.na(sex) & !is.na(score))
df_nomiss
# 결측치가 하나라도 있으면 제거
df_nomiss2 <- na.omit(df)
df_nomiss2
# 결측치를 제거하지 않고 계산
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam <- read.csv("data/exama.csv")
exam
# 결측치 생성- 3,7행에 대한 수학 결측으로 처리
exam[c(3,5,7),"math"] <- NA
exam

# math 평균 (결측치로 인해 계산 불가)
exam %>% summarise(mean_math = mean(math))
# math 평균 (결측치를 제거하고 계산)
exam %>% summarise(mean_math = mean(math, na.rm = T))
#-----
# 결측치 대체
mean(exam$math,na.rm = T)
exam$math # 결측치 확인
# 결측치를 평균값으로 
exam$math <- ifelse(is.na(exam$math),54.2,exam$math)
# 결측치 확인
table(is.na(exam$math))
mean(exam$math)

# 이상치
outliner <- data.frame(sex = c(1,2,1,3,2,1),
                       score = c(5,4,3,4,2,6))
outliner
# 이상치 확인 -> 분류
# 이상치의 기준 sex : 1,2 score : 5이하
table(outliner$sex)
table(outliner$score)
# 이상치를 결측치로 변환
# sex 3일경우 NA, score 5보다 클 경우 NA
outliner$sex <- ifelse(outliner$sex == 3,NA,outliner$sex)
outliner$score <- ifelse(outliner$score > 5,NA,outliner$score)
outliner
# 결측치를 제외한 후 성별에 따른 score 평균 구함
outliner %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))
