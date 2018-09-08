This is a data wrangling exercise using a data set various attributes of passengers on the Titanic, including who survived and who didn’t.

I have performed the following steps to clean up the data set:

1. The embarked column has some missing values, which are known to correspond to passengers who actually embarked at Southampton.
   I found missing values and replace them with S
2. Calculated the mean of the Age column and used that value to populate the missing values
3. Many passengers did not make it to a boat. This means that there are a lot of missing values in the boat column.
   I filled these empty slots with a dummy value e.g. the string 'None' or 'NA'
4. You notice that many passengers don’t have a cabin number associated with them.
   I created a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
