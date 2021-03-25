#' Switch cost
#'
#' Utility function to calculate indices related to switch cost.
#'
#' @param data Required. A `data.frame` from which the indices are calculated.
#' @param config_block Required. A `data.frame` contains the configurations of
#'   each block. At least contains these variables:
#'   * Same name as `name_block` argument: The block identifier.
#'   * `type_block`: The type of each block: must contain "pure" and "mixed".
#'   * `dur`: The duration in minutes for each block.
#' @param name_block The name of the variable in `data` storing block number.
#' @param name_task The name of variable in `data` storing task info.
#' @param name_switch The name of the variable in `data` storing switch info.
#' @param name_rt The name of the variable in `data` storing reaction time data.
#' @param name_acc The name of the variable in `data` storing accuracy data.
#' @param values_mixed The values of the variable `name_switch` in mixed
#'   blocks, in which the first is about 'repeat', and the second about
#'   'switch'.
#' @keywords internal
calc_switch_cost <- function(data,
                             config_block,
                             name_block = "Block",
                             name_task = "Task",
                             name_switch = "Type",
                             name_rt = "rt_cor",
                             name_acc = "acc_cor",
                             values_mixed = c("Repeat", "Switch")) {
  switch_cost_count <- data %>%
    dplyr::group_by(.data[[name_block]]) %>%
    dplyr::summarise(nc = sum(.data[[name_acc]] == 1)) %>%
    dplyr::left_join(config_block, by = name_block) %>%
    dplyr::group_by(.data$type_block) %>%
    dplyr::summarise(
      nc = sum(.data$nc),
      dur = sum(.data$dur)
    ) %>%
    dplyr::transmute(
      .data$type_block,
      rc_all = sum(.data$nc) / sum(.data$dur),
      rc_each = .data$nc / .data$dur
    ) %>%
    tidyr::pivot_wider(
      names_from = "type_block",
      values_from = "rc_each",
      names_prefix = "rc_"
    ) %>%
    dplyr::mutate(
      switch_cost_rc_gen = .data$rc_pure - .data$rc_mixed
    )
  switch_cost_rt <- data %>%
    dplyr::left_join(config_block, by = name_block) %>%
    dplyr::mutate(
      type_rt = dplyr::if_else(
        .data$type_block == "pure",
        .data[[name_task]],
        .data[[name_switch]]
      )
    ) %>%
    dplyr::group_by(.data$type_block, .data$type_rt) %>%
    dplyr::summarise(
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    dplyr::summarise(
      mrt_pure = mean(.data$mrt[.data$type_block == "pure"]),
      mrt_repeat = .data$mrt[.data$type_rt == values_mixed[[1]]],
      mrt_switch = .data$mrt[.data$type_rt == values_mixed[[2]]],
      switch_cost_rt_gen = .data$mrt_repeat - .data$mrt_pure,
      switch_cost_rt_spe = .data$mrt_switch - .data$mrt_repeat
    )
  cbind(switch_cost_count, switch_cost_rt)
}
