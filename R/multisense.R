#' Multiple Sensory Integration
#'
#' There will typically be some speed advantage if there are more than one
#' sensory inputs to be employed. This function calculates this advantage.
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_image}{Mean reaction time of Image stimuli.}
#'   \item{mrt_sound}{Mean reaction time of Sound stimuli.}
#'   \item{mrt_mixed}{Mean reaction time of Mixed stimuli.}
#'   \item{mrt_mixadv}{Mean reaction decrease of Mixed stimuli compared to other
#'     two types of stimuli.}
#' @export
multisense <- function(data, .by = NULL) {
  .input <- list(name_type = "type", name_rt = "rt") |>
    update_settings("preproc.input")
  .extra <- list(
    type_image = "image",
    type_sound = "sound",
    type_mixed = "mixed"
  ) |>
    update_settings("preproc.extra")
  data |>
    group_by(across(
      all_of(c(.by, .input[["name_type"]]))
    )) |>
    mutate(
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100,
        .data[[.input[["name_rt"]]]], NA
      )
    ) |>
    mutate(
      rt_cor = ifelse(
        .data[["rt_cor"]] %in%
          graphics::boxplot(.data[["rt_cor"]], plot = FALSE)$out,
        NA, .data[["rt_cor"]]
      )
    ) |>
    summarise(
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = .input[["name_type"]],
      names_prefix = "mrt_",
      values_from = "mrt"
    ) |>
    mutate(
      mrt_mixadv = (
        .data[[paste0("mrt_", .extra$type_image)]] +
          .data[[paste0("mrt_", .extra$type_sound)]]
      ) / 2 - .data[[paste0("mrt_", .extra$type_mixed)]]
    )
}
