## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = NA,
  warning = FALSE, 
  message = FALSE
)

## ---- eval=FALSE--------------------------------------------------------------
#  FielDHub::run_app()

## ---- eval=FALSE--------------------------------------------------------------
#  library(FielDHub)
#  run_app()

## ---- include=FALSE-----------------------------------------------------------
df <- data.frame(
  list(ROW = paste("Period", 1:5, sep = ""),
       COLUMN = paste("Cow", 1:5, sep = ""),
       TREATMENT = paste("Diet", 1:5, sep = ""))
)

## ---- echo = FALSE, results='asis'--------------------------------------------
library(knitr)
kable(df)

## ---- echo = TRUE-------------------------------------------------------------
library(FielDHub)

## ---- echo = TRUE-------------------------------------------------------------
lsd <- latin_square(
  t = 5,
  reps = 2,
  plotNumber = 101,
  planter = "serpentine",
  seed = 1238
)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  print(lsd)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
print(lsd)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  field_book <- lsd$fieldBook
#  head(lsd$fieldBook, 10)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
field_book <- lsd$fieldBook
head(lsd$fieldBook, 10)

## ---- fig.align='center', fig.width=7.2, fig.height=5.5-----------------------
plot(lsd)

