library(scdoc)
scdoc("./vignettes/Mode_d_emploi.html")
file.copy("./vignettes/Mode_d_emploi.html","./inst/doc/Mode_d_emploi.html", overwrite = TRUE)
file.copy("./vignettes/Mode_d_emploi.pdf","./inst/doc/Mode_d_emploi.pdf", overwrite = TRUE)