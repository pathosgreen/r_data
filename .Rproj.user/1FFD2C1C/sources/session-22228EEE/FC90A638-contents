# install.packages("ggplot2")
library(ggplot2) # 패키지 목록 체크와 동일한 기능.

x <- c("a","a","b","c")
x

qplot(x)

# 미국환경보호국에서 공개한 자료로 mpg는 갤런
# hwy는 자동차가 고속도로에서 1갤런에 몇 마일 변수
# data에 mpg, x축에 hwy 변수 지정해서 그래프로 출력
qplot(data=mpg,x=hwy)

# x축 cty
qplot(data=mpg,x=cty)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data=mpg,x=drv,y=hwy,geom="line")

# x축 drv, y축 hwy, 상자 그림 그래프 형태
qplot(data=mpg,x=drv,y=hwy,geom="boxplot")

# x축 drv, y축 hwy, 상자 그림 그래프 형태, drv별 색 표현
qplot(data=mpg,x=drv,y=hwy,geom="boxplot",colour=drv)
