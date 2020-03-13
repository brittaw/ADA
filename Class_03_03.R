library(radiant)
library(mosaic)
library(tidyverse)

f <- "https://raw.githubusercontent.com/difiore/ADA-datasets/master/IMDB-movies.csv"
d <- read_csv(f, col_names = TRUE)
d <- filter(d, startYear %in% 1999:2019)


# using the mosaic package
reps <- 500
samp_dist_mean <- do(reps) * mean(~averageRating, data = sample_n(d, size = n, replace = FALSE)) # sampling distribution
mean_plot <- histogram(~mean, data = samp_dist_mean, xlab = "Sampling Distribution for the\nMean of Average Rating")
samp_dist_median <- do(reps) * median(~averageRating, data = sample_n(d, size = n, replace = FALSE)) # sampling distribution
median_plot <- histogram(~median, data = samp_dist_median, xlab = "Sampling Distribution for the\nMedian of Average Rating")
library(cowplot)
plot_grid(mean_plot, median_plot, ncol = 2)


detach(package:cowplot)
mean(~mean, data = samp_dist_mean) # mean based on mean of sampling distribution
pop_stats$mean # true population mean
mean(~median, data = samp_dist_median) # median based on mean of sampling distribution
pop_stats$median # true population median


se_mean <- favstats(~mean, data = samp_dist_mean)$sd
se_median <- favstats(~median, data = samp_dist_median)$sd
(paste0(
  "estimated population mean across all years = ",
  round(favstats(~mean, data = samp_dist_mean)$mean, 3),
  " ± ",
  round(se_mean, 3),
  " SE"
))

output <- tibble("n" = numeric(), "reps" = numeric(), "mean" = numeric(), "se" = numeric())
for (n in seq(from = 10, to = 200, by = 10)) {
  for (reps in c(10, 25, 50, 100, 250, 500, 1000, 2000)) {
    # the line below generates a sampling distribution...
    samp_dist_mean <- do(reps) * mean(~averageRating, data = sample_n(d, size = n, replace = FALSE))
    mean <- favstats(~mean, data = samp_dist_mean)$mean
    se <- favstats(~mean, data = samp_dist_mean)$sd
    output <- bind_rows(output, c(n = n, reps = reps, mean = mean, se = se))
  }
}
p1 <- ggplot(data = output, aes(x = n, y = mean)) + geom_line() + facet_grid(~reps)
p1 <- p1 + xlab("Sample Size") + ylab("Mean")
p2 <- ggplot(data = output, aes(x = n, y = se)) + geom_line() + facet_grid(~reps)
p2 <- p2 + xlab("Sample Size") + ylab("SE")
p3 <- ggplot(data = output, aes(x = n)) + geom_line(aes(y = mean + se), color = "blue") + geom_line(aes(y = mean)) + geom_line(aes(y = mean - se), color = "blue") + facet_grid(~reps)
p3 <- p3 + xlab("Sample Size") + ylab("Mean ± SE")
library(cowplot)
plot_grid(p1, p2, p3, nrow = 3)


###13
library(manipulate)
outcomes <- c(1, 2, 3, 4, 5, 6)
manipulate(
  histogram(sample(x = outcomes, size = n, replace = TRUE),
            breaks = c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5),
            type = "density",
            main = paste("Histogram of Outcomes of ", n, " Die Rolls", sep = ""),
            xlab = "Roll",
            ylab = "Probability"
  ),
  n = slider(0, 10000, initial = 100, step = 100)
)


roll <- function(nrolls = 1) {
  sample(1:6, nrolls, replace = TRUE)
} # function with default of 1 roll
nrolls <- 1000
two_dice <- roll(nrolls) + roll(nrolls)
library(mosaic)
histogram(two_dice,
          breaks = c(1.5:12.5),
          type = "density",
          main = "Rolling Two Dice",
          xlab = "Sum of Rolls",
          ylab = "Probability"
)

