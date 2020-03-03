x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 50, 100, 200, 1000)
geometric_mean <- function(x) {
  prod(x)^(1 / length(x))
}
geometric_mean(x)
SS <- function(x) {
  sum((x - mean(x))^2)
}
SS(x)

pop_var <- function(x) {
  sum((x - mean(x))^2) / (length(x))
}
pop_var(x)



sample_var <- function(x) {
  sum((x - mean(x))^2) / (length(x) - 1)
}
sample_var(x)

var(x)

plot(c(0, 100), c(0, 15), type = "n", xlab = "Sample Size", ylab = "Variance")

mu <- 10
sigma <- 2
curve(dnorm(x, mean = mu, sd = sigma), from = mu - 3 * sigma, to = mu + 3 * sigma, ylab = "Frequency")
# plots the normal distribution for this curve
# we can also use...
library(mosaic)
plotDist("norm", mean = mu, sd = sigma, xlab = "x", ylab = "Frequency")
detach(package:mosaic)

plot(c(0, 100), c(0, 15), type = "n", xlab = "Sample Size", ylab = "Variance")
mu <- 10
sigma <- 2
for (n in seq(from = 5, to = 100, by = 5))
  # samples of 5, 10, 15...
{
  # set up a variable, reps, to hold set of variances calculated for each replicate
  reps <- vector("double", 50)
  for (i in 1:50) # 50 replicates
  {
    x <- rnorm(n, mean = mu, sd = sigma)
    points(n, var(x))
    reps[[i]] <- var(x)
  }
  points(n, mean(reps), bg = "red", pch = 23, cex = 2) # plots average
}

library(readr)
f <- "https://raw.githubusercontent.com/difiore/ADA-datasets/master/IMDB-movies.csv"
d <- read_csv(f, col_names = TRUE)

d <- filter(d, startYear %in% 1999:2019)
boxplot(averageRating ~ startYear, data = d, xlab = "Year", ylab = "Average Rating")

histogram(~averageRating, data = d, xlab = "Average Rating") # histogram from {mosaic}

set.seed(100)
n <- 100
s <- sample_n(d, size = n, replace = FALSE) # `sample_n()` is from {dplyr} and selects rows at random from a data frame
boxplot(averageRating ~ startYear, data = s, xlab = "Year", ylab = "Average Rating")

histogram(~averageRating, data = s, xlab = "Average Rating") # `histogram()` function from {mosaic}
(samp_stats <- favstats(~averageRating, data = s)) # variant of the 5-number summary from {mosiac}

