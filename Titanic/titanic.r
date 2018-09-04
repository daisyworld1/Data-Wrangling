titanic <- read.csv(file="titanic3.csv", header=TRUE, sep=",")
library(dplyr)
library(tidyr)

titanic$embarked <- sub("^$", "S", titanic$embarked)
age_mean <- mean(titanic$age,0,TRUE)
titanic$age[is.na(titanic$age)] <- age_mean
titanic$boat <- sub("^$", "NA", titanic$boat)
titanic$has_cabin_number <- ifelse(titanic$cabin!="",1,0)
