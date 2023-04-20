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

## ---- include = FALSE---------------------------------------------------------
wp <- 0:4
sp <-  0:2
ssp <-  0:3
df <- data.frame(list(WHOLEPLOT =wp, SUBPLOT = c(sp, rep("", 2)), SUB_SUB_PLOT = c(ssp, rep("", 1))))

## ---- echo = FALSE, results='asis'--------------------------------------------
library(knitr)
kable(df)

## ---- echo = TRUE-------------------------------------------------------------
library(FielDHub)

## ---- echo=TRUE---------------------------------------------------------------
sspd <- split_split_plot(
  wp = 3, 
  sp = 2,  
  ssp = 4,  
  reps = 3,  
  type = 2,   
  l = 1, 
  plotNumber = 101,
  locationNames = "FARGO",
  seed = 123
)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  print(sspd)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
print(sspd)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  field_book <- sspd$fieldBook
#  head(field_book,10)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
field_book <- sspd$fieldBook
head(field_book,10)

## ---- fig.align='center', fig.width=7.2, fig.height=5.5-----------------------
plot(sspd)

