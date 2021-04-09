#' Iowa Gambling Task (modified)
#'
#' A classical test on decision making. Read more details on
#' [wikipedia](https://en.wikipedia.org/wiki/Iowa_gambling_task). This modified
#' version uses pools to simulate cards, but the essential ideas are the same.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{sum_outcome}{The total outcome over all trials.}
#'   \item{perc_good}{The number of choices on "good" pools.}
#' @export
igt <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      sum_outcome = sum(.data[[vars_input[["name_outcome"]]]]),
      # good pools have label of "A" and "B"
      perc_good = mean(.data[[vars_input[["name_pool"]]]] %in% c("A", "B")),
      .groups = "drop"
    )
}
