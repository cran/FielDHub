## ---- include = FALSE---------------------------------------------------------
  options(rmarkdown.html_vignette.check_title = FALSE)
  library(FielDHub)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## -----------------------------------------------------------------------------
experiment <- RCBD(
  t = 12,
  reps = 3,
  l = 2, 
  plotNumber = c(1001, 2001),
  locationNames = c("A", "B"),
  seed = 123
)

## -----------------------------------------------------------------------------
print(experiment)

## -----------------------------------------------------------------------------
summary(experiment)

## ---- fig.align='center', fig.width=7, fig.height=5---------------------------
plot(experiment, l = 2, layout = 2)

