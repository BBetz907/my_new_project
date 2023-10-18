install.packages("readr")
install.packages("aws.s3")
install.packages('devtools')
devtools::install_github(repo = "https://github.com/pepfar-datim/pdaprules.git", ref = "main"
                         )
library(aws.s3)
library(pdaprules)
library(readr)


my_items <- s3_list_bucket_items(bucket = Sys.getenv("S3_READ"))

# print out the first five items
print(my_items[1:5,])

# read a file, in this case pipe delimited
my_data <- my_items[64,]$path_names
data <- aws.s3::s3read_using(FUN = readr::read_delim, "|", escape_double = FALSE,
                             trim_ws = TRUE, col_types = readr::cols(.default = readr::col_character()
                             ), 
                             bucket = Sys.getenv("S3_READ"),
                             object = my_data)

print(head(data))



#interacting with our workspace
