##Airbnb New User Bookings

This is a summary document of the important steps taken to cleanup data from Kaggle Airbnb challenge. 

Data used is titled “train_user_2.csv”. This file contains attributes of guests who have booked a reservation in a country on Airbnb. The end goal of analyzing this dataset is to be able to predict country of destination of users who haven’t booked a listing. 

Step 1: Cleanup age column. Consider numeric variables that looks like date of birth to age. Place different age to age groups.

Step 2: Categorize first_browser to five browser types

Step 3: Categorize first_device_types to two devise types

Step 4: Convert two-digit language to language code for the ease of reading

Step 5: Add a column that indicates the primary language used for the destination_country

Step 6: Find the time difference between the date_account_created and date_first_booking

