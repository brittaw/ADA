library(tidyverse)
library(skimr)
library(kableExtra)
library(curl)
f <- curl("https://raw.githubusercontent.com/difiore/ADA-datasets/master/KamilarAndCooperData.csv")
d <- read_csv(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)

s <- skim(d) # the main `skimr()` function
s %>%
  filter(skim_type == "numeric") %>%
  # select(skim_variable,n_missing, numeric.mean,numeric.sd,numeric.p0,numeric.p25,numeric.p50,numeric.p75, numeric.p100,numeric.hist) %>% # OR
  select(skim_variable, n_missing, starts_with("numeric")) %>%
  kable() %>%
  kable_styling(font_size = 10)
p <- ggplot(data = d, aes(x = Family, y = log(Body_mass_female_mean)))
p <- p + geom_boxplot(na.rm = TRUE)
p <- p + theme(axis.text.x = element_text(angle = 90))
p <- p + ylab("log(Female Body Mass)")
p


par(mfrow = c(1, 2))
plot(x = d$Body_mass_female_mean, y = d$Brain_Size_Female_Mean)
plot(x = log(d$Body_mass_female_mean), y = log(d$Brain_Size_Female_Mean))

p <- ggplot(data = d, aes(
  x = log(Body_mass_female_mean),
  y = log(Brain_Size_Female_Mean),
  color = factor(Family)
)) # first, we build a plot object and color points by Family
p <- p + xlab("log(Female Body Mass)") + ylab("log(Female Brain Size)") # then we modify the axis labels
p <- p + geom_point(na.rm = TRUE) # then we make a scatterplot
p <- p + theme(legend.position = "bottom", legend.title = element_blank()) # then we modify the legend
p # and, finally, we plot the object

p <- p + facet_wrap(~Family, ncol = 13) # wrap data "by" family into 4 columns
p <- p + theme(legend.position = "none")
p

p <- p + geom_smooth(method = "lm", fullrange = FALSE, na.rm = TRUE)
p
p <- ggplot(data = d, aes(
  x = log(Body_mass_female_mean),
  y = log(MaxLongevity_m)
))
p <- p + geom_point(na.rm = TRUE)
p <- p + geom_smooth(method = "lm", na.rm = TRUE)
p


p1 <- ggplot(data = d, aes(
  x = log(Body_mass_female_mean),
  y = log(MaxLongevity_m)
))
p1 <- p1 + geom_point(na.rm = TRUE)
p1 <- p1 + geom_smooth(method = "lm", na.rm = TRUE)
p1 <- p1 + xlab("log(Female Body Size)") + ylab("log(Lifespan)")

p2 <- ggplot(data = d, aes(
  x = log(Body_mass_male_mean),
  y = log(MaxLongevity_m)
))
p2 <- p2 + geom_point(na.rm = TRUE)
p2 <- p2 + geom_smooth(method = "lm", na.rm = TRUE)
p2 <- p2 + xlab("log(Male Body Size)") + ylab("log(Lifespan)")

p3 <- ggplot(data = d, aes(x = Family, y = log(Body_mass_female_mean)))
p3 <- p3 + geom_boxplot(na.rm = TRUE)
p3 <- p3 + theme(axis.text.x = element_text(angle = 90))
p3 <- p3 + xlab("Family") + ylab("log(Female Body Mass)")

library(patchwork)
(p1 | p2) / p3 + plot_annotation(tag_levels = "A")


library(cowplot)
plot_grid(plot_grid(p1, p2, labels = c("A", "B"), label_size = 12, nrow = 1), p3, labels = c("", "C"), label_size = 12, nrow = 2)

aggregate(x = d["Body_mass_female_mean"], by = d["Family"], FUN = "mean", na.rm = TRUE)
