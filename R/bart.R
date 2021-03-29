#' Calculates index scores for BART game specifically
#'
#' The adjusted and unadjusted BART scores are both returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param vars_input This is done by other functions, storing the matched
#'   variable names for further processing.
#' @param by The column(s) variable names in `data` used to be grouped by. Note,
#'   the check of existence is in the higher level function, so here in this
#'   function does not check them.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bart <- function(data, vars_input, by) {
  if (is.null(vars_input)) {
    name_nhit <- "NHit"
    name_feedback <- "Feedback"
  } else {
    name_nhit <- vars_input[["name_nhit"]]
    name_feedback <- vars_input[["name_feedback"]]
  }
  collapse::add_vars(data) <- list(
    hit_cor = .subset2(data, vars_input[["name_nhit"]]) *
      .subset2(data, vars_input[["name_feedback"]])
  )
  grps_out <- collapse::GRP(data, by)
  collapse::add_vars(
    grps_out$groups,
    list(
      mean_pumps = collapse::fmean(
        .subset2(data, "hit_cor"),
        grps_out,
        use.g.names = FALSE
      ),
      mean_pumps_raw = collapse::fmean(
        .subset2(data, vars_input[["name_nhit"]]),
        grps_out,
        use.g.names = FALSE
      ),
      num_explosion = collapse::fsum(
        .subset2(data, vars_input[["name_feedback"]]),
        grps_out,
        use.g.names = FALSE
      )
    )
  ) %>%
    collapse::ftransform(is_normal = TRUE)
}
