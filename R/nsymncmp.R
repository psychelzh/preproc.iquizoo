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
nsymncmp <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_big = "bigsetcount",
    name_small = "smallsetcount",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  data_cor <- data |>
    rename(
      b = .data[[.input$name_big]],
      s = .data[[.input$name_small]]
    )
  basics <- calc_spd_acc(
    data_cor,
    .by,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    rt_rtn = "mean",
    acc_rtn = "percent"
  )
  ensure_fit <- function(data) {
    loglik <- function(b, s, acc, w, ...) {
      log(pnorm(0, b - s, w ^ 2 * (b ^ 2 + s ^ 2), lower.tail = !acc))
    }
    objctive_fun <- function(w, data) {
      sum(-purrr::pmap_dbl(data, loglik, w = w))
    }
    repeat {
      repeat {
        start <- c(w = runif(1))
        if (is.finite(objctive_fun(start, data))) {
          break
        }
      }
      tryCatch({
        fit <- stats::nlminb(start, objctive_fun, data = data, lower = 0)
        if (fit$convergence == 0) break
      }, error = function(e) {
        invisible()
      })
    }
    fit
  }
  weber <- data_cor |>
    group_by(across(all_of(.by))) |>
    group_modify(
      ~ ensure_fit(.x)$par |>
        tibble::as_tibble_row()
    ) |>
    ungroup()
  if (!is.null(.by)) {
    return(left_join(basics, weber, by = .by))
  } else {
    return(bind_cols(basics, weber))
  }
}
