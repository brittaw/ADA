f <-file.choose()
f

d <- read.table(f, header = TRUE, sep = "\t", stringsAsFactors = FALSE, fill = TRUE)
d
library(readr)
d <- read_tsv(f, col_names = TRUE) # for tab-separated value files
d
library(readxl)
f <- "data/CPDS-1960-2014-reduced.xlsx"
d <- read_excel(f, sheet = 1, col_names = TRUE)
head(d)
library(curl)
f <- curl("https://raw.githubusercontent.com/difiore/ADA-datasets/master/CPDS-1960-2014-reduced.csv")
d <- read.csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)
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

