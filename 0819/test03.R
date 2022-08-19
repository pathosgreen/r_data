# 데이터 분석 시각화
library(dplyr)
library(ggplot2)
# 산점도
# x축은 displ, y축은 hwy로 지정해 배경 생성
ggplot(data=mpg, aes(x=displ, y=hwy))
# 배경에 산점도 추가
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()
# x축 범위 3~6으로 지정
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()+xlim(3,6)
# y축 범위 10~30으로 지정
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()+xlim(3,6)+ylim(10,30)


df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

ggplot(data=df_mpg, aes(x=drv,y=mean_hwy))+geom_col()
# 크기 순으로 정렬
ggplot(data=df_mpg, aes(x=reorder(drv,-mean_hwy), y=mean_hwy))+geom_col()

# 시간의 흐름에 따라 나타나는 그래프 - 선 그래프
# 일정 시간 간격을 두고 나열된 데이터 - 시계열 데이터
ggplot(data=economics, aes(x=date,y=unemploy))+geom_line()

# 상자 그림 만들기 - Boxplot
ggplot(data= mpg, aes(x= drv, y= hwy))+geom_boxplot()
