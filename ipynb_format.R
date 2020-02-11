ipynb_document = function() {

    ipynb_pre_knit <- function (input=original_input) {
	    knitr::opts_chunk$set(results="hide",fig.show="hide",message=FALSE,warning=FALSE)
    }

    ipynb_pre_processor <- function (front_matter, utf8_input, runtime, knit_meta, files_dir, output_dir) {
	language <- front_matter$jupyter$kernelspec$language
	if(language == "R")  {
		pattern_text <- "```r" 
	} else if (language == "python") {
		pattern_text <- "```python" 
	}
	else {
		pattern_text <- "```python" 
	}

	# here we replace ```r or ```python with ```code since pandoc wants this.
	original_text  <- readLines(utf8_input)
	updated_text  <- gsub(pattern = pattern_text, replace = "```code", x = original_text)
	writeLines(updated_text, con=utf8_input)
    }

    rmarkdown::output_format(
	    knitr = rmarkdown::knitr_options(),
	    pandoc = rmarkdown::pandoc_options(to = "ipynb"),
	    clean_supporting = FALSE,
	    pre_knit = ipynb_pre_knit,
	    pre_processor = ipynb_pre_processor
  )
}
