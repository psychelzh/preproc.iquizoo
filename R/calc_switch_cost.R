#' Switch cost
#'
#' Utility function to calculate general and specific switch cost.
#'
#' @templateVar by low
#' @templateVar name_rt TRUE
#' @templateVar name_acc TRUE
#' @template params-template
#' @param name_type_block The column name of the `data` input whose values are
#'   the block type, in which is a `character` vector with "pure block" (value:
#'   `"pure"`) and "mixed block" (value: `"mixed"`).
#' @param name_type_switch The column name of the `data` input whose values are
#'   the switch type, in which is a `character` vector with at least `"switch"`
#'   and `"repeat"` values. Other values if corresponding to `"pure"` block,
#'   will be used as task names.
#' @keywords internal
calc_switch_cost <- function(data,
                             by,
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
        c("repeat", "switch")
      )
    ) |>
    group_by(across(
      all_of(c(by, name_type_block, name_type_switch, "condition"))
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
    complete(.data[["condition"]], nesting(!!!syms(by))) |>
    mutate(
      condition = replace_na(
        as.character(.data[["condition"]]), "pure"
      )
    ) |>
    group_by(across(all_of(c(by, "condition")))) |>
    summarise(
      mrt = mean(.data[["mrt"]], na.rm = TRUE),
      pc = mean(.data[["pc"]], na.rm = TRUE),
      .groups = "drop"
    ) |>
    pivot_wider(
      all_of(by),
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
