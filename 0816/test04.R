english <- c(90,80,70,60)
english

math = c(50,60,100,20)
math

# 데이터 프레임에 할당
df_midterm <- data.frame(english,math)
df_midterm

class <- c(1,1,2,2)
class
# 학생의 반을 추가
df_midterm <- data.frame(english,math,class)
df_midterm
# 데이터 분석
mean(df_midterm$english) # 영어 평균
mean(df_midterm$math) # 수학 평균
