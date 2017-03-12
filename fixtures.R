library(magrittr)

m <- read.csv("doodle_results_Feb2017.csv", row.names = 1)
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

set.seed(2017)
fixture <- data.frame(person = NA, date = NA)
choose_per(m, fixture) %>% 
	# dplyr::mutate(date  = as.POSIXct(date, format = "X%Y.%m.%d")) %>%
	dplyr::filter(!is.na(date)) %>%
	dplyr::arrange(date)
