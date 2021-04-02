#' Congruence effect
#'
#' The stimuli for these tasks contain *congruent* and *incongruent* conditions.
#' Typically, subjects score correct more easily and respond more quickly on
#' *congruent* ones, thus creating a congruence effect. This function calculates
#' scores of these effects.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{cong_eff_rt}{Congruence effect of reaction time (RT), i.e.,
#'     incongruent RT - congruent RT.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{cong_eff_pc}{Congruence effect of percent of correct (PC), i.e.,
#'     congruent PC - incongruent PC.}
#' @export
congeff <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      )
    )
  calc_cong_eff(
    data_cor, by = by,
    name_cong = vars_input[["name_cong"]],
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
}
