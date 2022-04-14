#' Fit a Drift Diffusion Model
#'
#' Gain drift diffusion model for different conditions (if specified).
#'
#' @template common
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_truth The condition which is depended upon to calculate different
#'   drifting rates. Default is `NULL`. Must be a [factor()].
#' @param rt_unit The unit of response time in `data`.
#' @param n_fit Number of fits to try to find the best estimate.
#' @param seed Random seed. Default is 1 so that results can be reproduced.
#' @return A [list()] with structure the same as [optim()].
#' @export
fit_ddm <- function(data,
                    name_rt = "rt", name_acc = "acc", name_truth = NULL,
                    rt_unit = c("ms", "s"),
                    n_fit = 5, seed = 1) {
  # `dfddm` requires rt in seconds
  rt_unit <- match.arg(rt_unit)
  if (rt_unit == "ms") data[[name_rt]] <- data[[name_rt]] / 1000

  # drift paramter for each level in truth will be estimated
  if (!is.null(name_truth)) {
    names_drift <- paste0("v_", levels(data[[name_truth]]))
  } else {
    names_drift <- "v"
  }

  # remove rts faster than 0.1 seconds which is deemed impossible
  data <- data[data[[name_rt]] > 0.1, ]

  rt <- data[[name_rt]]
  resp <- data[[name_acc]] == 1 # logical values are acceptable
  truth <- if (!is.null(name_truth)) data[[name_truth]]

  # starting value for t0 must be smaller than the smallest rt
  min_rt <- min(data[[name_rt]])

  set.seed(seed)
  on.exit(set.seed(NULL))

  min_objective <- Inf
  best_fit <- NULL
  for (j in seq_len(n_fit)) {
    repeat {
      v <- stats::rnorm(length(names_drift), 2, 2) |> set_names(names_drift)
      init <- c(
        v,
        a = stats::runif(1, min = 0.5, max = 5),
        t0 = stats::runif(1, min = 0, max = min_rt),
        w = stats::runif(1, min = 0, max = 1),
        sv = stats::runif(1, min = 0, max = 5)
      )
      if (ll_fun(init, rt, resp, truth) < 1e6) {
        break
      }
    }
    fit <- stats::optim(
      init, ll_fun,
      method = "L-BFGS-B",
      rt = rt, resp = resp, truth = truth,
      lower = c(rep(-Inf, length(names_drift)), .01, 0, 0, 0),
      upper = c(rep(Inf, length(names_drift)), Inf, Inf, 1, Inf)
    )
    if (fit[["value"]] < min_objective) {
      best_fit <- fit
    }
  }
  # check truth to exclude unused parameters
  for (lvl in levels(truth)) {
    if (!any(truth == lvl)) {
      best_fit$par[paste0("v_", lvl)] <- NA_real_
    }
  }
  best_fit
}

ll_fun <- function(pars, rt, resp, truth = NULL) {
  if (is.null(truth)) {
    v <- pars["v"]
  } else {
    v <- numeric(length(rt))
    for (i in 1:2) {
      v[truth == levels(truth)[i]] <- pars[i]
    }
  }

  dens <- fddm::dfddm(
    rt = rt,
    response = resp,
    a = pars["a"],
    v = v,
    t0 = pars["t0"],
    w = pars["w"],
    sv = pars["sv"],
    log = TRUE
  )

  return(ifelse(any(!is.finite(dens)), 1e6, -sum(dens)))
}
