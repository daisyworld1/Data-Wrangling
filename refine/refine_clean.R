refine_new <- read.csv(file="refine_original.csv", header=TRUE, sep=",")
library(dplyr)
library(tidyr)

#convert charaters in company column to lower case 
refine_new$company <- tolower(refine_new$company)

#find distinct strings in the company column for the ease of mapping
company <- refine_new %>% distinct(company)

#create standard company names and bind it with companyto create a mapping table
company_clean [c(1:3)] = "company_akzo"
company_clean [c(4:9)] = "company_philips"
company_clean [c(10:11)] = "company_unilever"
company_clean [c(12:12)] = "company_van_houten"
company_lookup <- cbind(company,company_clean)

#convert table to data frame 
as.data.frame(company_lookup)

#add stardard company names to refine_new
refine_new <- left_join(refine_new,company_lookup)

#separate company name with "-"
split_product <- strsplit(product_vector,split = "-")

#create two separate column for product_code and product_number
product_code <- sapply (split_product,function(x,index){x[index]},index = 1)
product_number <- sapply (split_product,function(x,index){x[index]},index = 2)

#add new columns to table
refine_new <- cbind(refine_new, product_code, product_number)

#create product code to product category mapping table as data frame
product_code_vector <- c("p","v","x","q")
product_category <- c("Smartphone", "TV", "Laptop", "Tablet")
product_category_data_frame <- data.frame(product_code_vector,product_category)

#add product category to refine_new 
refine_new <- left_join(refine_new, product_category_data_frame, by = c("product_code" = "product_code_vector"), copy = "product_code_vector")

#concatenate three address columns to one
full_address <- paste (refine_new$address,", ",refine_new$city,", ",refine_new$country)
refine_new <- cbind.data.frame(refine_new,full_address)

#create four columns each representing a product_category, each row has a binary value indicating whether a product belongs in that category
refine_new <- refine_new %>% 
   				mutate(TF = 1) %>% 
   				distinct %>% 
   				spread(product_category,TF,fill = 0)
#create four columns each representing a company name,  each row has a binary value indicating whether a product belongs in that company
refine_new <- refine_new %>% 
             mutate(TF = 1) %>% 
             distinct %>% 
             spread(company_clean,TF,fill = 0)

write.csv2(refine_new, file = "refine_clean.csv")
