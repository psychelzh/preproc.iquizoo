#' Symbolic Number Comparison
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), distance effect (dist_effect) and adjusted distance effect
#' (dist_effect_cor).
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{pc}{Percentage of correct responses.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{dist_eff}{Distance effect.}
#' @seealso [nsymncmp()] for non-symbolic number comparison.
#' @export
symncmp <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_big = "big",
    name_small = "small",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  fit_errproof <- purrr::possibly(
    ~ stats::coef(stats::lm(
      as.formula(
        stringr::str_glue("{.input$name_rt} ~ dist")
      ),
      .
    ))[["dist"]],
    otherwise = NA_real_
  )
  merge(
    calc_spd_acc(
      data,
      by = .by,
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    ) |>
      select(all_of(c(.by, "pc", "mrt"))),
    data |>
      mutate(
        dist = .data[[.input$name_big]] -
          .data[[.input$name_small]]
      ) |>
      filter(.data[[.input$name_acc]] == 1) |>
      nest(.by = all_of(.by)) |>
      mutate(
        dist_eff = purrr::map_dbl(
          .data$data,
          fit_errproof
        ),
        .keep = "unused"
      ),
    by = .by
  ) |>
    vctrs::vec_restore(data)
}
