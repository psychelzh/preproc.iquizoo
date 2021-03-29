#' Calculates index scores for BART game specifically
#'
#' The adjusted and unadjusted BART scores are both returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param by The column(s) variable names in `data` used to be grouped by. Note,
#'   the check of existence is in the higher level function, so here in this
#'   function does not check them.
#' @param vars_input This is done by other functions, storing the matched
#'   variable names for further processing.
#' @param keep.by A logical value. Should the grouping variable be kept in the
#'   output?
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bart <- function(data, by = "id", vars_input = NULL, keep.by = TRUE) {
  if (is.null(vars_input)) {
    name_nhit <- "NHit"
    name_feedback <- "Feedback"
  } else {
    name_nhit <- vars_input[["name_nhit"]]
    name_feedback <- vars_input[["name_feedback"]]
  }
  vars_output <- c(
    if (keep.by) by else NULL,
    .get_output_vars("bart")
  )
  collapse::add_vars(data) <- list(
    hit_cor = .subset2(data, name_nhit) * .subset2(data, name_feedback)
  )
  collapse::collapv(
    data, by,
    custom = list(
      fmean = "hit_cor",
      fmean = name_nhit,
      fsum = name_feedback
    ),
    keep.col.order = FALSE,
    keep.by = keep.by
  ) %>%
    setNames(vars_output) %>%
    collapse::ftransform(is_normal = TRUE)
}
