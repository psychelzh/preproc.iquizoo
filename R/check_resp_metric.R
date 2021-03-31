#' Check whether basic data response metrics meet requirements
#'
#' This function is used to unify the check of response metrics for all the
#' data. Two basic metrics, i.e. valid response rate and total accuracy, are
#' checked (both can be opted out).
#'
#' @details
#'
#' Minimal valid response rate is required for all the games that need users'
#' response for all the trials. Minimal accuracy is required for all the games
#' that the chance accuracy level can be acquired for each trial.
#'
#' Minimal accuracy calculation is based on a statistical hypothesis testing
#' against the null hypothesis that the user responded at random. If so, the
#' number of trials a user scores correct will obey a Bernoulli distribution
#' \eqn{B(n,p)} with parameter \eqn{n} of the number of trials (set in `size`
#' argument) and \eqn{p} of the chance accuracy level (set in `chance`
#' argument). So the minimal accuracy can be calculated based on the 95% region
#' of rejection.
#'
#' @templateVar by low
#' @templateVar name_acc corrected
#' @template params-template
#' @param crit_resp_rate The required minimal valid response rate. Default to
#'   0.8.
#' @param crit_acc The required minimal accuracy. Default to `NULL`, a minimal
#'   accuracy was calculated based on `size` and `chance` argument (see
#'   "Details").
#' @param check_type "all": check all metrics. "resp_rate": check response rate
#'   only. "accuracy": check accuracy only. "none": skip all checking.
#' @param chance The chance level of score correct for each trial. Default to
#'   0.5, which is so for most games.
#' @return A `data.frame` with columns of grouping and a new column named
#'   `is_normal`, in which `TRUE` means that the response metrics of that group
#'   meet the requirements, and `FALSE` means not. If the `check_type` is set as
#'   "none", `NA` is returned.
#' @keywords internal
check_resp_metric <- function(data, by, name_acc,
                              crit_resp_rate = 0.8,
                              crit_acc = NULL,
                              check_type = c(
                                "all", "resp_rate",
                                "accuracy", "none"
                              ),
                              chance = 0.5) {
  check_type <- match.arg(check_type)
  stats <- data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      n_obs = dplyr::n(),
      pc = sum(.data[[name_acc]] == 1) / .data[["n_obs"]],
      crit_acc = ifelse(
        is.null(crit_acc),
        qbinom(0.95, n_obs, chance) / n_obs,
        crit_acc
      ),
      res_resp = mean(.data[[name_acc]] != -1) > crit_resp_rate,
      res_acc = pc > crit_acc,
      .groups = "keep"
    )
  stats %>%
    dplyr::transmute(
      is_normal = switch(
        check_type,
        all = .data[["res_resp"]] & .data[["res_acc"]],
        resp_rate = .data[["res_resp"]],
        accuracy = .data[["res_acc"]],
        NA
      )
    ) %>%
    dplyr::ungroup()
}
