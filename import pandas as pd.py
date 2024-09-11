import pandas as pd
import os
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns

current_directory = os.getcwd()
print(f"Current working directory: {current_directory}")
# Read CSV file

new_directory = 'c:/Users/yuanting/Desktop/6501hw3-1/data 6.2'
os.chdir(new_directory)

# Display first few rows of the data
data = pd.read_csv('temps.txt', delimiter='\t')
print(data.head())

# 绘制直方图
# sns.histplot(data.iloc[:,2:], kde=True)
# plt.show()

#绘制 Q-Q 图
stats.probplot(data.iloc[:,2], dist="norm", plot=plt)
plt.show()

# Shapiro-Wilk 检验
stat, p = stats.shapiro(data.iloc[:,2:])
print('Shapiro-Wilk 检验统计量 = {:.3f}, p 值 = {:.3f}'.format(stat, p))

if p > 0.05:
    print("数据可能服从正态分布")
else:
    print("数据不服从正态分布")