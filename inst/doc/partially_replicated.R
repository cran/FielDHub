## ---- include = FALSE---------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)
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
ENTRY <- 1:12
NAME <- c(paste0("Genotype", LETTERS[1:12]))
REPS <- c(rep(2,4),rep(1,8))
df <- data.frame(ENTRY,NAME,REPS)

## ---- echo = FALSE, results='asis'--------------------------------------------
library(knitr)
kable(df)

## ---- echo = TRUE-------------------------------------------------------------
library(FielDHub)

## ---- echo = TRUE-------------------------------------------------------------
prep <- partially_replicated(
  nrows = 15,
  ncols = 20, 
  repGens = c(75,150),
  repUnits = c(2,1), 
  planter = "serpentine", 
  plotNumber = 101,
  l = 1, 
  exptName = "Expt1",
  locationNames = "PALMIRA",
  seed = 1245, 
)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  print(prep)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
print(prep)

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  field_book <- prep$fieldBook
#  head(field_book, 10)

## ---- echo=FALSE, eval=TRUE---------------------------------------------------
field_book <- prep$fieldBook
head(field_book, 10)

## ---- fig.align='center', fig.width=7.2, fig.height=5.5-----------------------
plot(prep)

