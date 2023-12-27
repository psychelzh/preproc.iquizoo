prep_fun <- function(data, .by = NULL) {
  data |>
    summarise(
      nhit = mean(.data$nhit[.data$feedback == 1]),
      .by = all_of(.by)
    )
}
