read.csv(file="train_users_2.csv", header=TRUE, sep=",")
library(tidyr)
library(dplyr)

#categorize different ages
train_user <- read.csv(file="train_users_2.csv", header=TRUE, sep=",")

#categorize different ages

age_cat <- as.numeric(train_user$age)
age_cat[is.na(age_cat)] <- -1
age_cat <- ifelse(age_cat >1000, 2015 - age_cat, age_cat)
age_cat <- ifelse(age_cat >65 & age_cat < 1000,"above 65", age_cat)
age_cat <- ifelse(age_cat >55 & age_cat <= 65 ,"between 56 and 65", age_cat)
age_cat <- ifelse(age_cat >45 & age_cat <= 55 ,"between 46 and 55", age_cat)
age_cat <- ifelse(age_cat >35 & age_cat <= 45 ,"between 36 and 45", age_cat)
age_cat <- ifelse(age_cat >25 & age_cat <= 35 ,"between 26 and 35", age_cat)
age_cat <- ifelse(age_cat >18 & age_cat <= 25 ,"between 18 and 25", age_cat)
age_cat <- ifelse(age_cat > 0 & age_cat <= 18,"under 18", age_cat)
train_user <- cbind(train_user,age_cat)

train_user$age_cat <- as.character(train_user$age_cat)
train_user$age_cat <- ifelse(train_user$age_cat == 7, "under 18", train_user$age_cat)
train_user$age_cat <- ifelse(train_user$age_cat == -1, "-unknown-", train_user$age_cat)

#create a new variable gender_age
train_user$gender_age <- paste(train_user$gender, train_user$age_cat)
#categorize browser type
browser_type <- as.character(train_user$first_browser)

#view the top browser used
unique_browser <- train_user %>% 
  group_by(first_browser) %>% 
  tally()
arrange(unique_browser,desc(n))
sum(unique_browser$n)

browser_table <-  data_frame(
  first_browser = c("Chrome","Chrome Mobile", "Safari", "Safari Mobile", "Firefox", "IE"),
  browser_type = c("Chrome","Chrome","Safari","Safari","Firefox", "IE"))

train_user <- left_join(train_user, browser_table, by = "first_browser", copy = "browser_table")
train_user$browser_type[is.na(train_user$browser_type)] <- "others"

#view unique devise type
device_type <- train_user %>% 
  group_by(first_device_type) %>% 
  tally()
arrange(devise_type,desc(n))
sum(devise_type$n)

device_table <-  data_frame(
  first_device_type = c("Mac Desktop","Windows Desktop", "iPhone", "iPad" , "Android Phone", "Android Tablet ","Desktop (Other)","SmartPhone (Other)"),
  device_type = c("Desktop","Desktop","Portable","Portable","Portable", "Portable","Desktop","Portable"))

train_user <- left_join(train_user, device_table, by = "first_device_type", copy = "device_table")
train_user$device_type[is.na(train_user$device_type)] <- "others"


#bring in the name of each language code. "language_code.csv" came from the google search
language_code <- read.csv(file="language_code.csv",header=TRUE,sep=",")
train_user <- left_join(train_user, language_code, by = "language", copy = "language_code")
names(train_user)[names(train_user) == 'ï..language_full'] <- 'language_full'

#add primary_language to country_destination
destination_language <-  data_frame(
  country_destination = c("US", "FR", "IT", "GB", "ES", "CA", "DE", "NL", "AU","PT"),
  country_primary_language = c("English", "French", "Italian", "English", "Spanish", "English", "German", "Dutch", "English","Portuguese"))

train_user <- left_join(train_user, destination_language, by = "country_destination", copy = "destination_language")
train_user$country_primary_language [is.na(train_user$country_primary_language)] <- "others"
train_user$language_combo <- paste(train_user$language_full,"-",train_user$country_primary_language)
#calculate the time difference between date_account_created and date_first_booking
train_user$time_diff <- as.Date(train_user$date_first_booking,"%Y-%m-%d") - as.Date(train_user$date_account_created,"%Y-%m-%d")

write.csv2(train_user, file = "train_user_clean.csv")
