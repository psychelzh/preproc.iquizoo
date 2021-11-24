#' Spatial Reference Frame
#'
#' Typically, two classes of spatial frames of reference: "egocentric" and
#' "allocentric". The spatial acuity for both classes are calculated.
#'
#' @templateVar .by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_dist_err_allo/mean_dist_err_ego}{Mean of the response distance
#'     errors for allocentric and egocentric conditions respectively.}
#'   \item{mean_log_err_allo/mean_log_err_ego}{Mean of the log-transformed (of
#'     base \eqn{e}) response distance errors for allocentric and egocentric
#'     conditions respectively.}
#' @export
refframe <- function(data, .by, vars_input) {
  bind_rows(
    each = data,
    both = data,
    .id = "set"
  ) |>
    mutate(
      type_cor = case_when(
        .data[["set"]] == "both" ~ "both",
        .data[[vars_input[["name_type"]]]] == "allocentric" ~ "allo",
        .data[[vars_input[["name_type"]]]] == "egocentric" ~ "ego"
      )
    ) |>
    group_by(across(all_of(c(.by, "type_cor")))) |>
    summarise(
      mean_dist_err = mean(.data[[vars_input[["name_dist"]]]]),
      mean_log_err = mean(log(.data[[vars_input[["name_dist"]]]] + 1)),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = .data[["type_cor"]],
      values_from = starts_with("mean")
    )
}
