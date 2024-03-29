#' Spatial Reference Frame
#'
#' Typically, two classes of spatial frames of reference: "egocentric" and
#' "allocentric". The spatial acuity for both classes are calculated.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
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
        .data$set == "both" ~ "both",
        .data[[.input$name_type]] == .extra$type_allo ~ "allo",
        .data[[.input$name_type]] == .extra$type_ego ~ "ego"
      )
    ) |>
    summarise(
      mean_dist_err = mean(.data[[.input$name_dist]]),
      mean_log_err = mean(log(.data[[.input$name_dist]] + 1)),
      .by = all_of(c(.by, "type_cor"))
    ) |>
    pivot_wider(
      id_cols = all_of(.by),
      names_from = "type_cor",
      values_from = starts_with("mean")
    ) |>
    vctrs::vec_restore(data)
}
