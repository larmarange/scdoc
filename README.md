scdoc
=====

Long scientific documents with R, R Studio, knitr, pandoc, prince XML and zotxt.

Documents longs (scientifiques) avec R, R Studio, knitr, pandoc, prince XML et zotxt.

## Before installing / Pré-requis

Lisez le mode d'emploi (en particiculier la section *Pré-requis*): https://github.com/larmarange/scdoc/raw/master/vignettes/Mode_d_emploi.pdf

## Installation

Execute the following code in R Studio.

Exécutez le code suivant dans R Studio.

```{r}
if (!require(devtools)){
    install.packages('devtools')
    library(devtools)
}
install_github("scdoc","larmarange")
```
