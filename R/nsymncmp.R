#' Non-symbolic Number Comparison
#'
#' A classical test on subject's counting estimation skills.
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{w}{Weber fraction.}
#' @seealso [symncmp()] for symbolic number comparison.
#' @export
nsymncmp <- function(data, .by) {
  .input <- list(
      name_big = "bigsetcount",
      name_small = "smallsetcount",
      name_acc = "acc",
      name_rt = "rt"
    ) |>
    update_settings("preproc.input")
  data_cor <- data |>
    mutate(
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100,
        .data[[.input[["name_rt"]]]], NA
      )
    ) |>
    rename(
      b = .data[[.input[["name_big"]]]],
      s = .data[[.input[["name_small"]]]]
    )
  basics <- calc_spd_acc(
    data_cor,
    .by,
    name_acc = .input[["name_acc"]],
    name_rt = "rt_cor",
    rt_rtn = "mean",
    acc_rtn = "percent"
  )
  fit_errproof <- purrr::possibly(
    ~ stats::coef(stats::nls(
      as.formula(
        stringr::str_glue(
          r"({.input[["name_acc"]]})",
          " ~ 1 - pnorm(0, b - s, w * sqrt(b^2 + s^2))"
        )
      ),
      .x,
      start = list(w = 1)
    )),
    otherwise = NA_real_
  )
  weber <- data_cor |>
    group_nest(across(all_of(.by))) |>
    mutate(
      w = purrr::map_dbl(
        .data[["data"]],
        fit_errproof
      ),
      .keep = "unused"
    )
  left_join(basics, weber, by = .by)
}
