library(dplyr)
library(ggplot2)
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats
# 12~37을 벗어난 이상치에 대해서 결측치로 변환
temp <- mpg
View(temp)

temp$hwy <- ifelse(temp$hwy < 12 | temp$hwy > 37 , NA,temp$hwy)
table(is.na(temp$hwy))
