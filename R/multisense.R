#' Multiple Sensory Integration
#'
#' There will typically be some speed advantage if there are more than one
#' sensory inputs to be employed. This function calculates this advantage.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_image}{Mean reaction time of Image stimuli.}
#'   \item{mrt_sound}{Mean reaction time of Sound stimuli.}
#'   \item{mrt_mixed}{Mean reaction time of Mixed stimuli.}
#'   \item{mrt_mixadv}{Mean reaction decrease of Mixed stimuli compared to other
#'     two types of stimuli.}
#' @export
multisense <- function(data, by, vars_input) {
  data %>%
    group_by(across(
      all_of(c(by, vars_input[["name_type"]]))
    )) %>%
    mutate(
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      )
    ) %>%
    mutate(
      rt_cor = ifelse(
        .data[["rt_cor"]] %in%
          graphics::boxplot(.data[["rt_cor"]], plot = FALSE)$out,
        NA, .data[["rt_cor"]]
      )
    ) %>%
    summarise(
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    pivot_wider(
      names_from = vars_input[["name_type"]],
      names_prefix = "mrt_",
      values_from = "mrt"
    ) %>%
    mutate(
      mrt_mixadv = (.data[["mrt_image"]] + .data[["mrt_sound"]]) / 2 -
        .data[["mrt_mixed"]]
    )
}
