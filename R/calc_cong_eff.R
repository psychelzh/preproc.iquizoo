#' Congruence effect
#'
#' Utility function to calculate congruence effect sizes.
#'
#' @templateVar by low
#' @templateVar name_rt TRUE
#' @templateVar name_acc TRUE
#' @template params-template
#' @param name_cong The column name of the `data` input whose values are the
#'   congruence information, in which is a `character` vector with "incongruent
#'   condition" (label: `"incongruent"`) and "congruent condition" (label:
#'   `"congruent"`). It will be coerced as a `factor` vector with these two
#'   levels.
#' @return A [tibble][tibble::tibble-package] contains congruence effect results
#'   on accuracy and response time.
#' @keywords internal
calc_cong_eff <- function(data, by, name_cong, name_acc, name_rt) {
  data %>%
    dplyr::mutate(
      "{name_cong}" := factor(
        .data[[name_cong]],
        c("incongruent", "congruent"),
        c("inc", "con")
      )
    ) %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c(by, name_cong)))) %>%
    dplyr::mutate(
      # remove conditional reaction time outliers
      "{name_rt}" := ifelse(
        .data[[name_rt]] %in%
          graphics::boxplot(.data[[name_rt]], plot = FALSE)$out,
        NA, .data[[name_rt]]
      )
    ) %>%
    dplyr::summarise(
      pc = mean(.data[[name_acc]] == 1),
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    # make sure each type of condition exists
    tidyr::complete(!!sym(name_cong), tidyr::nesting(!!!syms(by))) %>%
    tidyr::pivot_wider(
      names_from = .data[[name_cong]],
      values_from = c("mrt", "pc")
    ) %>%
    dplyr::mutate(
      cong_eff_rt = .data[["mrt_inc"]] - .data[["mrt_con"]],
      cong_eff_pc = .data[["pc_con"]] - .data[["pc_inc"]]
    )
}
