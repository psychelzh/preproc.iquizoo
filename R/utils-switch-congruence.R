#' Switch cost
#'
#' Utility function to calculate general and specific switch cost.
#'
#' @template common
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_type_block The column name of the `data` input whose values are
#'   the block type, in which is a `character` vector with "pure block" (value:
#'   `"pure"`) and "mixed block" (value: `"mixed"`).
#' @param name_type_switch The column name of the `data` input whose values are
#'   the switch type, in which is a `character` vector with at least `"switch"`
#'   and `"repeat"` values. Other values if corresponding to `"pure"` block,
#'   will be used as task names.
#' @keywords internal
calc_switch_cost <- function(data,
                             .by,
                             name_type_block,
                             name_type_switch,
                             name_rt,
                             name_acc) {
  data |>
    # remove all filler trials
    filter(.data[[name_type_switch]] != "filler") |>
    mutate(
      condition = factor(
        .data[[name_type_switch]],
        c("pure", "repeat", "switch")
      )
    ) |>
    group_by(across(
      all_of(c(.by, name_type_block, name_type_switch, "condition"))
    )) |>
    mutate(
      # remove conditional reaction time outliers
      "{name_rt}" := ifelse(
        .data[[name_rt]] %in%
          graphics::boxplot(.data[[name_rt]], plot = FALSE)$out,
        NA, .data[[name_rt]]
      )
    ) |>
    summarise(
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      pc = mean(.data[[name_acc]] == 1),
      .groups = "drop"
    ) |>
    complete(.data[["condition"]], nesting(!!!syms(.by))) |>
    group_by(across(all_of(c(.by, "condition")))) |>
    summarise(
      mrt = mean(.data[["mrt"]], na.rm = TRUE),
      pc = mean(.data[["pc"]], na.rm = TRUE),
      .groups = "drop"
    ) |>
    pivot_wider(
      all_of(.by),
      names_from = .data[["condition"]],
      values_from = c("mrt", "pc")
    ) |>
    mutate(
      switch_cost_rt_gen = .data[["mrt_repeat"]] - .data[["mrt_pure"]],
      switch_cost_rt_spe = .data[["mrt_switch"]] - .data[["mrt_repeat"]],
      switch_cost_pc_gen = .data[["pc_repeat"]] - .data[["pc_pure"]],
      switch_cost_pc_spe = .data[["pc_switch"]] - .data[["pc_repeat"]]
    )
}

#' Congruence effect
#'
#' Utility function to calculate congruence effect sizes.
#'
#' @template common
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_cong The column name of the `data` input whose values are the
#'   congruence information, in which is a `character` vector with "incongruent
#'   condition" (label: `"inc"`) and "congruent condition" (label: `"con"`). It
#'   will be coerced as a `factor` vector with these two levels.
#' @return A [tibble][tibble::tibble-package] contains congruence effect results
#'   on accuracy and response time.
#' @keywords internal
calc_cong_eff <- function(data, .by, name_cong, name_acc, name_rt) {
  data |>
    mutate(
      "{name_cong}" := factor(
        .data[[name_cong]],
        c("inc", "con")
      )
    ) |>
    group_by(across(all_of(c(.by, name_cong)))) |>
    mutate(
      # remove conditional reaction time outliers
      "{name_rt}" := ifelse(
        .data[[name_rt]] %in%
          graphics::boxplot(.data[[name_rt]], plot = FALSE)$out,
        NA, .data[[name_rt]]
      )
    ) |>
    summarise(
      pc = mean(.data[[name_acc]] == 1),
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      .groups = "drop"
    ) |>
    # make sure each type of condition exists
    complete(!!sym(name_cong), nesting(!!!syms(.by))) |>
    pivot_wider(
      names_from = .data[[name_cong]],
      values_from = c("mrt", "pc")
    ) |>
    mutate(
      cong_eff_rt = .data[["mrt_inc"]] - .data[["mrt_con"]],
      cong_eff_pc = .data[["pc_con"]] - .data[["pc_inc"]]
    )
}
