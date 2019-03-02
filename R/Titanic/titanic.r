titanic <- read.csv(file="titanic3.csv", header=TRUE, sep=",")
library(dplyr)
library(tidyr)

#fill row with missing values with charater "S"
titanic$embarked <- sub("^$", "S", titanic$embarked) 

#calculate mean age for passengers
age_mean <- mean(titanic$age,0,TRUE)

#in age column replace rows with NULL values with mean age.
titanic$age[is.na(titanic$age)] <- age_mean

#replace rows with empty strings in boat column with charater "NA"
titanic$boat <- sub("^$", "NA", titanic$boat)

#create a new column has_cabin_number with boolean values based on whether cabin column has a cabin number or not
titanic$has_cabin_number <- ifelse(titanic$cabin!="",1,0)
