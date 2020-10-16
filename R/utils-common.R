#' Congruency effect
#'
#' Utility function to calculate indices related to congruency effect.
#'
#' @param data A `data.frame` from which the indices are calculated.
#' @param name_cong The name of the variable in `data` storing the congruency
#'   info.
#' @param name_rt The name of the variable in `data` storing reaction time data.
#' @param name_acc The name of the variable in `data` storing accuracy data.
#' @param values_cong The values of the congruency info variable, in which the
#'   first is about 'congruent', and the second about 'incongruent'.
#' @keywords internal
calc_cong_eff <- function(data,
                          name_cong = "Type",
                          name_rt = "RT",
                          name_acc = "ACC",
                          values_cong = c("Congruent", "Incongruent")) {
  data %>%
    dplyr::group_by(.data[[name_cong]]) %>%
    dplyr::summarise(
      mrt = mean(.data[[name_rt]][.data[[name_acc]] == 1]),
      pc = mean(.data[[name_acc]] == 1)
    ) %>%
    tidyr::pivot_wider(
      names_from = dplyr::all_of(name_cong),
      values_from = c("mrt", "pc")
    ) %>%
    dplyr::transmute(
      mrt_con = .data[[paste("mrt", values_cong[[1]], sep = "_")]],
      mrt_inc = .data[[paste("mrt", values_cong[[2]], sep = "_")]],
      cong_eff_rt = .data$mrt_inc - .data$mrt_con,
      pc_con = .data[[paste("pc", values_cong[[1]], sep = "_")]],
      pc_inc = .data[[paste("pc", values_cong[[2]], sep = "_")]],
      cong_eff_pc = .data$pc_con - .data$pc_inc
    )
}
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
                             name_rt = "RT",
                             name_acc = "ACC",
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
      mrt = mean(.data[[name_rt]][.data[[name_acc]] == 1]),
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
#' Get the matched variables for input data
#'
#' Input data require several variables to be existed, and some variables can
#' have alternatives. Here we check if all the variables exist, and if only one
#' of the alternatives exists for each variable. If the check is passed, the
#' matched result (a character vector) will be returned, or else a `NULL` value
#' will be returned.
#'
#' @param data Required. Raw data, a `data.frame`.
#' @param vars_config Required. A `data.frame` containing the configuration of
#'   required variables. Possible variables are:
#'   * `field`: Required. Name references of all data variable names.
#'   * `name`: Required. Data variable names, in which lists all the possible
#'   names for current data variable.
#'   * `type`: Optional. Can be "required" (must exist) or "optional" (try to
#'     match, if not find, `NA` is returned and it must be handled in another
#'     place). If this variable is not specified, it will default to "required".
#' @keywords internal
match_data_vars <- function(data, vars_config) {
  # set default type to "required"
  if (!utils::hasName(vars_config, "type")) {
    vars_config$type <- "required"
  }
  vars_chk_result <- vars_config %>%
    dplyr::mutate(
      purrr::map_df(
        .data$name,
        ~ {
          match_result <- utils::hasName(data, .x)
          tibble(
            is_found = any(match_result),
            is_confused = sum(match_result) > 1,
            # the match can be of length 0, so use `if` instead of `if_else`
            matched = if (sum(match_result) == 1) .x[match_result] else NA
          )
        }
      )
    )
  if (!all(vars_chk_result$is_found[vars_chk_result$type == "required"])) {
    warning("At least one of the required variables are missing.")
    return(NULL)
  }
  if (any(vars_chk_result$is_confused)) {
    warning("At least one of the variables have more than one match.")
    return(NULL)
  }
  return(
    vars_chk_result %>%
      dplyr::select(.data$field, .data$matched) %>%
      tibble::deframe()
  )
}
