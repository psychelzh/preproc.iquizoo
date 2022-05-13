#' Non-symbolic Number Comparison
#'
#' A classical test on subject's counting estimation skills.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{pc}{Percentage of correct responses.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{w}{Weber fraction.}
#' @seealso [symncmp()] for symbolic number comparison.
#' @export
nsymncmp <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_bigset = "bigsetcount",
    name_smallset = "smallsetcount",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  merge(
    calc_spd_acc(
      data,
      by = .by,
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    ),
    data |>
      group_by(across(all_of(.by))) |>
      group_modify(
        ~ calc_numerosity(
          .,
          name_bigset = .input$name_bigset,
          name_smallset = .input$name_smallset,
          name_acc = .input$name_acc
        )
      ) |>
      ungroup(),
    by = .by
  ) |>
    select(all_of(c(.by, "pc", "mrt", "w"))) |>
    vctrs::vec_restore(data)
}

calc_numerosity <- function(data, name_bigset, name_smallset, name_acc) {
  fit <- fit_numerosity(data, name_bigset, name_smallset, name_acc)
  pars <- fit$par
  if (fit$convergence != 0) {
    warn(
      "Cannot find fit after the max number of fitting.",
      "fit_not_converge"
    )
    pars <- replace(pars, TRUE, NA_real_)
  }
  tibble::as_tibble_row(pars)
}
