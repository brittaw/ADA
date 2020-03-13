library(manipulate) 
manipulate(
  ggplot(data = data.frame(x = c(mu - 6 * sigma, mu + 6 * sigma)), aes(x)) +
    stat_function(
      fun = dnorm,
      args = list(mean = mu, sd = sigma),
      n = 1000
    ) +
    xlab("x") + ylab("f(x)") + labs(
      title = "Exploring the Normal Distribution",
      subtitle = paste0(
        "Probability ± ", n_sigma, " SD around Mean = ",
        round(
          pnorm(mu + n_sigma * sigma, mu, sigma) -
            pnorm(mu - n_sigma * sigma, mu, sigma),
          4
        )
      )
    ) +
    stat_function(
      fun = dnorm,
      xlim = c(mu - n_sigma * sigma, mu + n_sigma * sigma),
      args = list(mean = mu, sd = sigma),
      n = 1000,
      geom = "area",
      fill = "red",
      alpha = 0.5,
      color = "red"
    ),
  mu = slider(-100, 100, initial = 0, step = 10),
  sigma = slider(0, 30, initial = 5, step = 1),
  n_sigma = slider(0, 4, initial = 0, step = 0.25)
)
