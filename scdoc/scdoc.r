# Customizing markdown rendering ----
options(rstudio.markdownToHTML = 
			function(inputFile, outputFile) {
				if (!require(yaml)) {
					install.packages("yaml")
					library("yaml")
				}
				f <- readLines(inputFile, encoding="UTF-8")
				if (!is.na(b <- which(f == "---")[1]) & !is.na(e <- which(f == "...")[1]))
					opt <- yaml.load(paste(f[(b+1):(e-1)], collapse="\n"))
				else
					opt <- list()
        if (!is.null(opt$zotxt)) zotxt <- "--filter=pandoc-zotxt"
        else zotxt <- ""
				system(paste("pandoc", 
						shQuote(inputFile), 
						"-t html5 -s -o", 
						shQuote(outputFile),
						"--template=./scdoc/scdoc-template.html5",
						"--include-in-header=./scdoc/scdoc-head.html",
						"--self-contained",
						"--smart",
						"--number-sections",
            "--mathml",
            zotxt,
            "--filter=pandoc-citeproc",
						"-S"))
				if (!is.null(opt$pdf)) if (opt$pdf == 'prince')
					system(paste("prince",
						shQuote(outputFile),
						"--javascript"))
			}
)

#' Extract references from a Rmd/md file with Zotxt and create a JSON file
#' 
#' @param file file to parse
#' @param json name of the JSON file to produce (if NULL automatically determined)
#' @param return.file.name if TRUE, return the name of the JSON file
#' @note Zotero should be opened for this function to work.

zotxt2json <- function (file, json = NULL, return.file.name = FALSE) {
  if (is.null(json)) {
    base.file <- sub("\\.[a-zA-Z]*$","", file)
    json <- paste0(base.file,".json")  
  }
  json.code <- system(paste(
    "python ./scdoc/extractcites.py",
    shQuote(file)
  ), intern = TRUE)
  cat(json.code, file=json, sep="\n")
  if (return.file.name) return(json)
}

#' Extract references from a Rmd/md file with Zotxt and convert it to YAML
#' 
#' @param file file to parse
#' @param keep if TRUE, keep the json and YAML files produced
#' @param display if TRUE, display the result in the console
#' @note Zotero should be opened for this function to work.

zotxt2yaml <- function (file, keep = FALSE, display = TRUE) {
  base.file <- sub("\\.[a-zA-Z]*$","", file)
  json.file <- paste0(base.file,".json")
  yaml.file <- paste0(base.file,".yaml")
  zotxt2json(file, json.file)
  yaml <- system(paste(
    "biblio2yaml",
    shQuote(json.file)
    ), intern = TRUE)
  Encoding(yaml) <- "UTF-8"
  if (keep)
    cat(yaml, file=yaml.file, sep="\n")
  else
    file.remove (json.file)
  if (display)
    cat(yaml, sep="\n")
}