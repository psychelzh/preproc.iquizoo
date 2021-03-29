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
#' @param x A `numeric` vector so coded that 1 means scoring correct, 0 means
#'   scoring incorrect, and that -1 means no response is made.
#' @param grp A [GRP][collapse::GRP] object.
#' @param crit_resp_rate The required minimal valid response rate. Default to
#'   0.8.
#' @param crit_acc The required minimal accuracy. Default to `NULL`, a minimal
#'   accuracy was calculated based on `size` and `chance` argument (see
#'   "Details").
#' @param check_type "all": check all metrics. "resp_rate": check response rate
#'   only. "accuracy": check accuracy only. "none": skip all checking.
#' @param size The number of trials. Default to `NULL`, then get it from input
#'   data.
#' @param chance The chance level of score correct for each trial. Default to
#'   0.5, which is so for most games.
#' @return A `data.frame` with columns of grouping and a new column named
#'   `is_normal`, in which `TRUE` means that the response metrics of that group
#'   meet the requirements, and `FALSE` means not. If the `check_type` is set as
#'   "none", `NA` is returned.
#' @keywords internal
check_resp_metric <- function(x, grp,
                              crit_resp_rate = 0.8,
                              crit_acc = NULL,
                              check_type = c(
                                "all", "resp_rate",
                                "accuracy", "none"
                              ),
                              size = NULL,
                              chance = 0.5) {
  check_type <- match.arg(check_type)
  if (check_type == "none") {
    return(collapse::ftransform(grp$groups, is_normal = NA))
  }
  stats <- collapse::add_vars(
    grp$groups,
    list(
      resp_rate = collapse::fmean(x != -1, grp, use.g.names = FALSE),
      accuracy = collapse::fmean(x == 1, grp, use.g.names = FALSE)
    )
  )
  chk_res <- collapse::ftransform(grp$groups, is_normal = TRUE)
  if (check_type %in% c("all", "resp_rate")) {
    collapse::get_vars(chk_res, "is_normal") <-
      .subset2(chk_res, "is_normal") &
      .subset2(stats, "resp_rate") > crit_resp_rate
  }
  if (check_type %in% c("all", "accuracy")) {
    if (is.null(crit_acc)) {
      if (is.null(size)) size <- collapse::fNobs(x, grp, use.g.names = FALSE)
      crit_acc <- qbinom(0.95, size, chance) / size
    }
    collapse::get_vars(chk_res, "is_normal") <-
      .subset2(chk_res, "is_normal") &
      .subset2(stats, "accuracy") > crit_acc
  }
  chk_res
}
