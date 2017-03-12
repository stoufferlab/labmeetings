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
if(ncol(m) * 2 < nrow(m)) warning("Not enough meeting dates to accomodate all the people")
if(ncol(m) * 2 > nrow(m)) warning("Not enough people to fill all the meetings")

modulus <- nrow(m) %% ncol(m)
last_date <- NULL
if(modulus != 0) last_date <- colnames(m)[ncol(m)]
if(!is.null(last_date)) warning("Only one person in last meeting")

m <- m[order(rowSums(m)), ]
m <- m[, order(colSums(m))]

choose_per <- function(x, fixture, seed = 1, last_date = NULL) {
	set.seed(seed)
	if(!is.null(last_date)){
		if(colnames(x)[1] == last_date) {
			n <- 1
		} else {
			n <- 2
		}
	} else {
		n <- 2
	}
	chosen <- sample(rownames(x), n, prob = x[, 1])
	fixture %<>% dplyr::bind_rows(
		dplyr::data_frame(person = chosen, 
											date = colnames(x)[1]))
	if(all(dim(x) > 1)){
		x <- x[!rownames(x) %in% chosen, , drop = F]
		x <- x[, -1, drop = F]
		choose_per(x, fixture, seed + 1, last_date)
	} else {
		return(fixture)
	}
}

fixture <- data.frame(person = NA, date = NA)
choose_per(m, fixture, seed = opt$seed, last_date) %>% 
	# dplyr::mutate(date  = as.POSIXct(date, format = "X%Y.%m.%d")) %>%
	dplyr::filter(!is.na(date)) %>%
	dplyr::arrange(date)
