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
library(FielDHub)
TREATMENT <- c(paste0("TRT_", LETTERS[1:10]))
df <- data.frame(TREATMENT)

## ---- echo = FALSE, results='asis'--------------------------------------------
library(knitr)
kable(df)

## ---- echo = TRUE-------------------------------------------------------------
crd <- CRD(
  t = 15,
  reps = 6,
  plotNumber = 101, 
  locationName = "FARGO",
  seed = 1236
)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  print(crd)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
print(crd)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  field_book <- crd$fieldBook
#  head(crd$fieldBook, 10)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
field_book <- crd$fieldBook
head(crd$fieldBook, 10)

## ---- fig.align='center', fig.width=7.2, fig.height=5.5-----------------------
plot(crd)

