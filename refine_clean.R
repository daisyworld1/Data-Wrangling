refine_new <- read.csv(file="refine_original.csv", header=TRUE, sep=",")
library(dplyr)
library(tidyr)

refine_new$company <- tolower(refine_new$company)

company <- refine_new %>% distinct(company)
company_clean [c(1:3)] = "company_akzo"
company_clean [c(4:9)] = "company_philips"
company_clean [c(10:11)] = "company_unilever"
company_clean [c(12:12)] = "company_van_houten"
company_lookup <- cbind(company_raw,company_clean)
as.data.frame(company_lookup)
refine_new <- left_join(refine_new,company_lookup)

split_product <- strsplit(product_vector,split = "-")

product_code <- sapply (split_product,function(x,index){x[index]},index = 1)
product_number <- sapply (split_product,function(x,index){x[index]},index = 2)

refine_new <- cbind(refine,product_code,product_number)

product_code_vector <- c("p","v","x","q")
product_category <- c("Smartphone", "TV", "Laptop", "Tablet")
data.frame(product_code_vector,product_category)

product_category_data_frame <- data.frame(product_code_vector,product_category)


refine_new <- left_join(refine_new,product_category_data_frame, by = c("product_code" = "product_code_vector"), copy = "product_code_vector")

full_address <- paste (refine_new$address,", ",refine_new$city,", ",refine_new$country)
refine_new <- cbind.data.frame(refine_new,full_address)


refine_new <- refine_new %>% 
   				mutate(TF = 1) %>% 
   				distinct %>% 
   				spread(product_category,TF,fill = 0)

refine_new <- refine_new %>% 
             mutate(TF = 1) %>% 
             distinct %>% 
             spread(company_clean,TF,fill = 0)

write.csv2(refine_new, file = "refine_clean.csv")
