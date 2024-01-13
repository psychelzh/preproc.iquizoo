#' Iowa Gambling Task (modified)
#'
#' A classical test on decision making. Read more details on
#' [wikipedia](https://en.wikipedia.org/wiki/Iowa_gambling_task). This modified
#' version uses pools to simulate cards, but the essential ideas are the same.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{sum_outcome}{The total outcome over all trials.}
#'
#'   \item{perc_good}{The number of choices on "good" pools.}
#' @export
igt <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_outcome = "outcome", name_pool = "poolid") |>
    update_settings(.input)
  .extra <- list(pools_advantage = c("a", "b")) |>
    update_settings(.extra)
  data |>
    summarise(
      sum_outcome = sum(.data[[.input$name_outcome]]),
      perc_good = mean(
        .data[[.input$name_pool]] %in% .extra$pools_advantage
      ),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}
