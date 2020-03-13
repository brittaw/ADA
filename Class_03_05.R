library(manipulate)
library(tidyverse)
manipulate(
  ggplot(data = data.frame(x = c(0, 1)), aes(x)) + stat_function(fun = dbeta, args = list(shape1 = alpha, shape2 = beta), n = 1000) + xlab("x") + ylab("f(x)") + labs(title = "Exploring the Beta Distribution", subtitle = paste0("Cumulative Probability = ", round(pbeta(x, alpha, beta), 2))) + stat_function(fun = dbeta, xlim = c(0, x), args = list(shape1 = alpha, shape2 = beta), n = 1000, geom = "area"),
  alpha = slider(0, 10, initial = 2, step = 0.1), beta = slider(0, 10, initial = 1, step = 0.1), x = slider(0, 1, initial = 0.0, step = 0.01)
)

