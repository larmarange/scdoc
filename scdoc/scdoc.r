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
						"-S"))
				if (!is.null(opt$pdf)) if (opt$pdf == 'prince')
					system(paste("prince",
						shQuote(outputFile),
						"--javascript"))
			}
)
