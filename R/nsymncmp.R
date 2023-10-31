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
      group_by(pick(all_of(.by))) |>
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
  }
  tibble::as_tibble_row(pars)
}

#' Fit a Simple Numerosity Model
#'
#' This model assumes the distribution of mental representation for a given
#' number/count k is N(k, (w * k) ^ 2).
#'
#' @template common
#' @param name_bigset,name_smallset Variable name in `data` indicates bigger and
#'   smaller set.
#' @param name_acc Variable name in `data` indicates user's response is correct
#'   or not.
#' @param n_fit Number of fits to try to find the best estimate.
#' @param seed Random seed. Default is 1 so that results can be reproduced.
#' @return A [list()] with structure the same as [optim()].
#' @export
fit_numerosity <- function(data, name_bigset, name_smallset, name_acc,
                           n_fit = 5, seed = 1) {
  set.seed(seed)
  b <- data[[name_bigset]]
  s <- data[[name_smallset]]
  acc <- data[[name_acc]]

  min_objective <- Inf
  best_fit <- NULL
  for (j in seq_len(n_fit)) {
    # try 10 times to find a good initial value
    for (i in seq_len(10)) {
      init <- c(w = stats::runif(1))
      init_objective <- ll_numerosity(init, b, s, acc)
      if (init_objective < 1e6) {
        break
      }
    }
    if (init_objective >= 1e6) {
      warn(
        "Cannot find a good initial value after 10 tries.",
        "no_good_init"
      )
      return(list(par = c(w = NA_real_), convergence = 1))
    }
    fit <- stats::optim(
      init, ll_numerosity,
      method = "L-BFGS-B",
      b = b, s = s, acc = acc,
      lower = 0
    )
    if (fit[["value"]] < min_objective) {
      best_fit <- fit
    }
  }
  best_fit
}

ll_numerosity <- function(pars, b, s, acc) {
  means <- b - s
  sds <- pars["w"]^2 * (b^2 + s^2)

  # incorrect means the mental representation is less than 0, so lower tail
  dens <- ifelse(
    !acc,
    stats::pnorm(0, means, sds, lower.tail = TRUE, log.p = TRUE),
    stats::pnorm(0, means, sds, lower.tail = FALSE, log.p = TRUE)
  )

  return(ifelse(any(!is.finite(dens)), 1e6, -sum(dens)))
}
