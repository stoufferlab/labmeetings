#!/usr/bin/env Rscript
library(magrittr)
library(optparse)

option_list <- list(
	make_option(c("-i", "--input"), type = "character", default = NULL, 
							help = "input csv file, must contain people names in first column & dates in first row. 0 for not available, 0.5 for available but not preferred, and 1 for preferred"),
	make_option(c("-s", "--seed"), type = "integer", default = 1,
							help = "random seed for computation")
)

opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

m <- read.csv(opt$input, row.names = 1)
m <- m[order(rowSums(m)), ]
m <- m[, order(colSums(m))]

choose_per <- function(x, fixture, seed = 1) {
	# print(x)
	set.seed(seed)
	chosen <- sample(rownames(x), 2, prob = x[, 1])
	fixture %<>% dplyr::bind_rows(
		dplyr::data_frame(person = chosen, 
											date = colnames(x)[1]))
	if(all(dim(x) > 1)){
		x <- x[!rownames(x) %in% chosen, , drop = F]
		x <- x[, -1, drop = F]
		choose_per(x, fixture, seed + 1)
	} else {
		return(fixture)
	}
}

fixture <- data.frame(person = NA, date = NA)
choose_per(m, fixture) %>% 
	# dplyr::mutate(date  = as.POSIXct(date, format = "X%Y.%m.%d")) %>%
	dplyr::filter(!is.na(date)) %>%
	dplyr::arrange(date)
