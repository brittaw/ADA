library(tidyverse)

##Class 02/20/20
f <- "https://raw.githubusercontent.com/difiore/ADA-datasets/master/KamilarAndCooperData.csv"
d <- read_csv(f, col_names = TRUE) # creates a "tibble"
s <- filter(d, Family == "Hominidae" & Mass_Dimorphism > 2)
head(s)
# selecting specific columns...
s <- select(d, Family, Genus, Body_mass_male_mean)
head(s)
# reordering a data frame by a set of variables...
s <- arrange(d, Family, Genus, Body_mass_male_mean)
head(s)
# `desc()` can be used to reverse the order
s <- arrange(d, desc(Family), Genus, Species, desc(Body_mass_male_mean))
head(s)
# renaming columns...
s <- rename(d, "Female_Mass" = Body_mass_female_mean)
head(s$Female_Mass)

###Making Functions - 02/25/20
add_prefix <- function(df, prefix = "", variable) {
  df[[variable]] <- paste0(prefix, df[[variable]])
  return(df)
}
df <-
  data.frame(
    "name" = c(
      "Ned", "Sansa", "Cersei", "Tyrion", "Jon", "Daenerys",
      "Aria", "Brienne", "Rickon", "Edmure", "Petyr", "Jamie",
      "Robert", "Stannis", "Theon"
    ),
    "house" = c(
      "Stark", "Stark", "Lannister", "Lannister", "Stark",
      "Targaryen", "Stark", "Tarth", "Stark", "Tully",
      "Baelish", "Lannister", "Baratheon", "Baratheon", "Greyjoy"
    ),
    "code" = sample(100000:999999, 15, replace = FALSE)
  )
df <- add_prefix(df, variable = "house") # uses default prefix
head(df)

df <- add_prefix(df, prefix = "House ", variable = "house")
head(df)

df <- add_prefix(df, prefix = "00001-", variable = "code")
head(df)

i <- TRUE

if (i == TRUE) {
  print("Yes")
} else {
  print("No")
}
i <- FALSE

if (i == TRUE) {
  print("Yes")
} else {
  print("No")
}
i <- 9
ifelse(i <= 10, "Yes", "No")

i <- c(9, 10, 11)
ifelse(i <= 10, "Yes", "No")


#dplyr package distinct and specify columns match, it will return mismatches. 

v <- seq(from = 100, to = 120, by = 2)
for (i in 1:length(v)) { # here, we are looping over the indices of v
  print(v[i])
}


for (i in 1:nrow(df)){
  print(df[i,])}



library(stringi)
stri_reverse(i)


for (i in df$code) {
  print(stri_reverse(i))
}


output <- sapply(s, FUN = median, na.rm = TRUE)
# NOTE: Here we are passing on an extra argument to the median() function, i.e., na.rm = TRUE
# This is an example of "dot-dot-dot" (`...`) being an extra argument of the `sapply()` function
# where those arguments are "passed through" as arguments of the `FUN=` function.
# Basically, this means that we can pass on an arbitrary set and number of arguments
# into `sapply()` which, in this case, are then being used in the `median()` function
output


output <- lapply(s, FUN = median, na.rm = TRUE)
output
