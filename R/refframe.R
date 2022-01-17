#' Spatial Reference Frame
#'
#' Typically, two classes of spatial frames of reference: "egocentric" and
#' "allocentric". The spatial acuity for both classes are calculated.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_dist_err_allo/mean_dist_err_ego}{Mean of the response distance
#'     errors for allocentric and egocentric conditions respectively.}
#'   \item{mean_log_err_allo/mean_log_err_ego}{Mean of the log-transformed (of
#'     base \eqn{e}) response distance errors for allocentric and egocentric
#'     conditions respectively.}
#' @export
refframe <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_type = "type", name_dist = "dist") |>
    update_settings(.input)
  .extra <- list(type_allo = "allocentric", type_ego = "egocentric") |>
    update_settings(.extra)
  bind_rows(
    each = data,
    both = data,
    .id = "set"
  ) |>
    mutate(
      type_cor = case_when(
        .data[["set"]] == "both" ~ "both",
        .data[[.input$name_type]] == .extra$type_allo ~ "allo",
        .data[[.input$name_type]] == .extra$type_ego ~ "ego"
      )
    ) |>
    group_by(across(all_of(c(.by, "type_cor")))) |>
    summarise(
      mean_dist_err = mean(.data[[.input$name_dist]]),
      mean_log_err = mean(log(.data[[.input$name_dist]] + 1)),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = .data[["type_cor"]],
      values_from = starts_with("mean")
    )
}
