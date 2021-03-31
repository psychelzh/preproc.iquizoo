#' Congruence effect
#'
#' Utility function to calculate congruence effect sizes.
#'
#' @templateVar by low
#' @templateVar name_cong TRUE
#' @templateVar name_rt corrected
#' @templateVar name_acc corrected
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains congruence effect results
#'   on accuracy and response time.
#' @keywords internal
calc_cong_eff <- function(data, by, name_cong, name_acc, name_rt) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c(by, name_cong)))) %>%
    dplyr::mutate(
      # remove conditional reaction time outliers
      "{name_rt}" := ifelse(
        .data[[name_rt]] %in% boxplot(.data[[name_rt]], plot = FALSE)$out,
        NA, .data[[name_rt]]
      )
    ) %>%
    dplyr::summarise(
      pc = mean(.data[[name_acc]] == 1),
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    tidyr::pivot_wider(
      names_from = .data[[name_cong]],
      values_from = c("mrt", "pc")
    ) %>%
    dplyr::mutate(
      cong_eff_rt = .data[["mrt_inc"]] - .data[["mrt_con"]],
      cong_eff_pc = .data[["pc_con"]] - .data[["pc_inc"]]
    )
}
