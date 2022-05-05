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
  b <- data[[name_bigset]]
  s <- data[[name_smallset]]
  acc <- data[[name_acc]]

  min_objective <- Inf
  best_fit <- NULL
  for (j in seq_len(n_fit)) {
    repeat {
      init <- c(w = stats::runif(1))
      if (ll_numerosity(init, b, s, acc) < 1e6) {
        break
      }
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
