#' Calculates index for Weather Prediction Paradigm game
#'
#' Percent of correct for each block is returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc_b1}{Percent of correct responses for block 1.}
#'   \item{pc_b2}{Percent of correct responses for block 2.}
#'   \item{pc_b3}{Percent of correct responses for block 3.}
#'   \item{pc_b4}{Percent of correct responses for block 4.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
wxpred <- function(data, ...) {
  vars_output <- c("pc_b1", "pc_b2", "pc_b3", "pc_b4")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_block", "Block",
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  if (max(data$Block) != 4) {
    warning("Number of blocks is not 4, will return NA values.")
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  data_adj <- data %>%
    dplyr::mutate(acc_adj = dplyr::if_else(.data$RT >= 100, .data$ACC, 0L))
  pc <- data_adj %>%
    dplyr::group_by(.data$Block) %>%
    dplyr::summarise(pc = mean(.data$acc_adj == 1)) %>%
    tidyr::pivot_wider(names_from = "Block", names_prefix = "pc_b", values_from = "pc")
  is_normal <- data_adj %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data$acc_adj == 1)) %>%
    dplyr::transmute(is_normal = .data$nc > stats::qbinom(0.95, .data$nt, 0.5))
  tibble(pc, is_normal)
}
