setwd("~/Desktop/2019 Spring/CapeTownABM/DATA")
library(ggplot2)
library(gridExtra)
data5 = read.csv2("Monthly_urban_agriculture_water_use.csv", header = TRUE, sep = ",")
data5 = as.data.frame(data5)
data5 = as.numeric(as.factor(data5))
df1 = data5[-1,]
month = 1:120
df1 = cbind.data.frame(month,df1)
p1 <- ggplot(df1, aes(x= month, y=Dam.Storage)) + 
  geom_point(color = "#CC0000", size = 1) + geom_line(color = "#CC0000") + ylim(0, 1000000) + xlim(0,120) + 
  theme_bw()+ xlab(label = "Month") + ylab(label = "Dam Storage (ML)") + theme(text = element_text(size=16))
                                                                            

p2 <- ggplot(df1, aes(x= month, y=Urban) )+ 
  geom_point(color = "#FF6600", size = 1) + geom_line(color = "#FF6600") + ylim(0,1500) + xlim(0,120) + theme_bw() +  xlab(label = "Month") +
  ylab(label = "Municipal Water Use (MLD)")+ theme(text = element_text(size=16))

p3 <- ggplot(df1, aes(x= month, y=Ag) )+ 
  geom_point(color = "#99FF00", size = 1) + geom_line(color = "#99FF00") + ylim(0,1500)+ xlim(0,120)+ theme_bw() + xlab(label = "Month") +
  ylab(label = "Agricultural Water Use (MLD)")+ theme(text = element_text(size=16))

grid.arrange(p1, p2, p3, nrow = 3)

library(tidyverse)

df2 <- df1 %>% select(month:Ag) %>% 
  gather(key = "category", value = "demand", Dam.Storage, Urban, Ag) %>%
  mutate(category = ordered(category, levels = c("Dam.Storage", "Urban", "Ag"),
                       labels = c("Dam Storage", "Municipal Water Use", "Agricultural Water Use")))

ggplot(df2, aes(x = month, y = demand)) + geom_line() +
  facet_wrap(~category, ncol = 1, scale = "free_y") +
  labs(x = "Month", y = "Million Litres per day") +
  theme_bw()+ theme(text = element_text(size=16))
