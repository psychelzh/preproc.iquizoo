#' Switch cost
#'
#' Utility function to calculate general and specific switch cost.
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_switch The column name of the `data` input whose values are
#'   the switch type, in which is a `character` vector with at least `"switch"`
#'   and `"repeat"` values.
#' @keywords internal
calc_switch_cost <- function(data, by, name_switch, name_rt, name_acc) {
  data[[name_switch]] <- factor(data[[name_switch]], c("switch", "repeat"))
  calc_cond_diff(
    data,
    by,
    name_cond = name_switch,
    name_diff_prefix = "switch_cost_",
    name_acc = name_acc,
    name_rt = name_rt
  )
}

#' Congruence effect
#'
#' Utility function to calculate congruence effect sizes.
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
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
calc_cong_eff <- function(data, by, name_cong, name_acc, name_rt) {
  data[[name_cong]] <- factor(data[[name_cong]], c("inc", "con"))
  calc_cond_diff(
    data,
    by,
    name_cond = name_cong,
    name_diff_prefix = "cong_eff_",
    name_acc = name_acc,
    name_rt = name_rt
  )
}

calc_cond_diff <- function(data, by, name_acc, name_rt,
                           name_cond, name_diff_prefix) {
  conds <- levels(data[[name_cond]])
  index_each_cond <- data |>
    calc_spd_acc(
      by = c(by, name_cond),
      name_acc = name_acc,
      name_rt = name_rt
    ) |>
    complete(.data[[name_cond]]) |>
    select(all_of(c(by, name_cond, "pc", "mrt", "ies", "rcs", "lisas")))
  index_each_cond |>
    pivot_longer(
      cols = -any_of(c(by, name_cond)),
      names_to = "index_name",
      values_to = "score"
    ) |>
    pivot_wider(
      names_from = all_of(name_cond),
      values_from = "score"
    ) |>
    mutate(
      diff = .data[[conds[[1]]]] - .data[[conds[[2]]]],
      .keep = "unused"
    ) |>
    # make sure larger values correspond to larger switch cost
    mutate(
      diff = if_else(
        .data$index_name %in% c("pc", "rcs"),
        -diff, diff
      )
    ) |>
    pivot_wider(
      names_from = "index_name",
      values_from = "diff",
      names_prefix = name_diff_prefix
    ) |>
    merge(
      index_each_cond |>
        pivot_wider(
          names_from = all_of(name_cond),
          values_from = -any_of(c(by, name_cond))
        ),
      by = by
    )
}
