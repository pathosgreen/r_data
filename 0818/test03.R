library(dplyr)
exam <- read.csv("data/csv_exam.csv")
exam
dim(exam)

# exam에서 class가 1인 경우만 출력
exam %>% filter(class == 1)

# exam에서 class가 2인 경우만 출력
exam %>% filter(class == 2)

# exam에서 class가 1이 아닌 경우만 출력
exam %>% filter(class != 1)

# exam에서 math가 50점 초과인 경우만 출력
exam %>% filter(math > 50)

# exam에서 english가 80점 이하인 경우만 출력
exam %>% filter(english <= 80)

# 여러 조건 (& and) (| or)을 사용해서 나열
# 1반이면서 수학 점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)

# 영어 점수가 90점 미만이거나 과학 점수가 50점 미만인 경우
exam %>% filter(english < 90 | science < 50)

# math만 추출
exam %>% select(math)

# class, math, english 추출
exam %>% select(class , math , english)

# science만 제외
exam %>% select(-science)

# class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)
