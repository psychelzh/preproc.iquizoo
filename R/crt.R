#' Calculates index scores for Choice Reaction Time game
#'
#' Now we majorly consider two indices: mean reaction time and count of correct
#' responses.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt}{Mean reaction time}
#'   \item{nc}{Count of correct responses}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
crt <- function(data, ...) {
  vars_output <- c("mrt", "nc")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  tibble(data) %>%
    correct_rt_acc() %>%
    dplyr::summarise(
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE),
      nc = sum(.data[["acc_cor"]] == 1),
      is_normal = check_resp_metric(.data[["acc_cor"]])
    )
}
