scdoc
=====

Long scientific documents with R, R Studio, knitr, pandoc, prince XML and zotxt.

Documents longs (scientifiques) avec R, R Studio, knitr, pandoc, prince XML et zotxt.

## How to install /Installation

Read the manual (in particular the *Pre-requisite* section): https://github.com/larmarange/scdoc/blob/master/vignettes/How_to_use.pdf?raw=true

Lisez le mode d'emploi (en particulier la section *Pré-requis*): https://github.com/larmarange/scdoc/raw/master/vignettes/Mode_d_emploi.pdf


```{r}
if (!require(devtools)){
    install.packages('devtools')
    library(devtools)
}
install_github("scdoc","larmarange")
```
