install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

# 데이터 불러오기
raw_welfare <- read.spss(file = "한국인의삶/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
# 복사본 만들기
welfare <- raw_welfare
head(welfare)
dim(welfare)
View(welfare)

# 조사항목
# 성별에 따른 임금
# 나이에 따른 임금
# 혼인 유무에 따른 임금
# 종교에 따른 임금
# 직업에 따른 임금

welfare <- rename(welfare,
                  sex = h10_g3,          # 성별
                  birth = h10_g4,        # 태어난 년도
                  marrige = h10_g10,     # 혼인상태
                  religion = h10_g11,    # 종교
                  code_job = h10_eco9,   # 직업 코드
                  income = p1002_8aq1,   # 월급
                  code_region = h10_reg7 # 지역 코드
                  )

class(welfare$sex) # 성별 변수 속성
table(welfare$sex) # 성별 인원수 확인인

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목에 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male","female")
table(welfare$sex)

qplot(welfare$sex)

class(welfare$income) # 임금의 속성

summary(welfare$income)

qplot(welfare$income)
qplot(welfare$income) + xlim(0,1000)

# 임금 이상치를 결측치로 변환
welfare$income <- ifelse(welfare$income %in% c(0,9999),NA,welfare$income)

# 결측치 확인
table(is.na(welfare$income))

class(welfare$birth) # 출생년도 속성

summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 나이 변수 생성
welfare$age <- 2015 - welfare$birth+1
summary(welfare$age)

qplot(welfare$age)

age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()

# 30세 미만, 30~59세, 60세 이상
welfare <- welfare %>% 
  mutate(ageg = ifelse(age<30,"young",
                       ifelse(age<=59,"middle","old")))

table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

ggplot(data = ageg_income,aes(x=ageg,y=mean_income)) + geom_col()

ggplot(data = ageg_income,aes(x=ageg,y=mean_income)) +
         geom_col() +
         scale_x_discrete(limits = c("young","middle","old"))

# 연령대 및 성별 월급 평균표 만들기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income = mean(income))

sex_income       

# 시각화
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young","middle","old"))

# 나이 및 성별 월급 차이 분석
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

# 시각화
ggplot(data = sex_age, aes(x = age,y = mean_income, col = sex)) +
  geom_line()

## 직업별 임금 차이
class(welfare$code_job)
table(welfare$code_job)

list_job <- read_excel("한국인의삶/Koweps_Codebook.xlsx", col_names = T,sheet = 2)

head(list_job)

dim(list_job)

welfare <- left_join(welfare, list_job, id= "code_job")

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 직업별 월급 평균표 제작
job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

top_10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top_10

# 시각화
ggplot(data = top_10,aes(x=reorder(job,mean_income),y=mean_income)) +
  geom_col() +
  coord_flip()
