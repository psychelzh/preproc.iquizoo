#' Iowa Gambling Task (modified)
#'
#' A classical test on decision making. Read more details on
#' [wikipedia](https://en.wikipedia.org/wiki/Iowa_gambling_task). This modified
#' version uses pools to simulate cards, but the essential ideas are the same.
#'
#' @templateVar .by TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{sum_outcome}{The total outcome over all trials.}
#'   \item{perc_good}{The number of choices on "good" pools.}
#' @export
igt <- function(data, .by = NULL) {
  .input <- list(name_outcome = "outcome", name_pool = "poolid") |>
    update_settings("preproc.input")
  .extra <- list(pools_advantage = c("a", "b")) |>
    update_settings("preproc.extra")
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      sum_outcome = sum(.data[[.input[["name_outcome"]]]]),
      perc_good = mean(
        .data[[.input[["name_pool"]]]] %in% .extra$pools_advantage
      ),
      .groups = "drop"
    )
}
