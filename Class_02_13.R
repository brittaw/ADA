## Module 9
library(tidyverse)
library(curl)
library(skimr)
library(summarytools)
library(dataMaid)
library(psych)
library(pastecs)
library(Hmisc)
library(car)
library(GGally)
library(corrplot)
library(magrittr)
library(curl)
f <- curl("https://raw.githubusercontent.com/difiore/ADA-datasets/master/CPDS-1960-2014-reduced.csv")
d <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)


library(skimr)
library(kableExtra)
s <- skim(d) # the main `skimr()` function
s %>%
  filter(skim_type == "numeric") %>%
  # select(skim_variable,n_missing, numeric.mean,numeric.sd,numeric.p0,numeric.p25,numeric.p50,numeric.p75, numeric.p100,numeric.hist) %>% # OR
  select(skim_variable, n_missing, starts_with("numeric")) %>%
  kable() %>%
  kable_styling(font_size = 10)



f <-file.choose()
f

par(mfrow = c(1, 2)) # # sets up two panels side by side
attach(f) # lets us use variable names without specifing the data frame!
hist(
  log(population),
  freq = FALSE,
  col = "red",
  main = "Plot 1",
  xlab = "log(population size)",
  ylab = "density",
  ylim = c(0, 0.2)
)


f <- curl("https://raw.githubusercontent.com/difiore/ADA-datasets/master/KamilarAndCooperData.csv")
d <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)

d <- as_tibble(d) # I like tibbles!
head(d)


boxplot(log(d$Body_mass_female_mean) ~ d$Family)
summary(d$Body_mass_female_mean)
