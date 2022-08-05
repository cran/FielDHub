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
Hplots <- paste0("A", 0:4)
Vplots <- paste0("B", 0:4)
df <- data.frame(list(HPLOTS = Hplots, VPLOTS = Vplots)) 

## ---- echo = FALSE, results='asis'--------------------------------------------
library(knitr)
kable(df)

## ---- echo = TRUE-------------------------------------------------------------
library(FielDHub)

## ---- echo=TRUE---------------------------------------------------------------
strip <- strip_plot(
  Hplots = 6,
  Vplots = 4, 
  b = 3,
  l = 1,  
  plotNumber = 101, 
  planter = "serpentine",
  locationNames = "FARGO",
  seed = 1240
)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  print(strip)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
print(strip)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  field_book <- strip$fieldBook
#  head(strip$fieldBook, 10)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
field_book <- strip$fieldBook
head(strip$fieldBook, 10)

## ---- fig.align='center', fig.width=7.2, fig.height=5.5-----------------------
plot(strip)

