#' Non-symbolic Number Comparison
#'
#' A classical test on subject's counting estimation skills.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{w}{Weber fraction.}
#' @seealso [symncmp()] for symbolic number comparison.
#' @export
nsymncmp <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(
    name_big = "bigsetcount",
    name_small = "smallsetcount",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(max_nfit = 10) |>
    update_settings(.extra)
  data_cor <- data |>
    rename(
      b = .data[[.input$name_big]],
      s = .data[[.input$name_small]]
    )
  bind_cols(
    calc_spd_acc(
      data_cor,
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      rt_rtn = "mean",
      acc_rtn = "percent",
      sat_rtn = "none"
    ),
    ensure_fit_numerosity(data_cor, max_nfit = .extra$max_nfit)$par |>
      tibble::as_tibble_row()
  )
}

ensure_fit_numerosity <- function(data, max_nfit = 10) {
  loglik <- function(b, s, acc, w, ...) {
    log(stats::pnorm(0, b - s, w^2 * (b^2 + s^2), lower.tail = !acc))
  }
  objctive_fun <- function(w, data) {
    sum(-purrr::pmap_dbl(data, loglik, w = w))
  }
  converged <- FALSE
  for (i_fit in seq_len(max_nfit)) {
    repeat {
      start <- c(w = stats::runif(1))
      if (is.finite(objctive_fun(start, data))) {
        break
      }
    }
    fit <- stats::nlminb(start, objctive_fun, data = data, lower = 0)
    if (fit$convergence == 0) {
      converged <- TRUE
      break
    }
  }
  if (!converged) {
    warn(
      "Cannot find fit after the max number of iterations.",
      "fit_not_converge"
    )
    # fall back with `NA` parameter
    list(par = c("w" = NA_real_))
  } else {
    fit
  }
}
