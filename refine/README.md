In this exercise, I worked with a toy data set showing product purchases from an electronics store.

1. Cleaned up the 'company' column so all of the misspellings of the brand names are standardized. 
2. Separated the product code and product number into separate columns
3. For the four product code, I added a column with the product category for each record in order to make the data more readable.
4. Created a new column full_address that concatenates the three address fields (address, city, country), separated by commas.
5. Both the company name and product category are categorical variables 
   In order to use them in further analysis you need to create dummy variables,
   I created dummy binary variables for each of them with the prefix company_ and product_
