#' Multiple Sensory Integration
#'
#' There will typically be some speed advantage if there are more than one
#' sensory inputs to be employed. This function calculates this advantage.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{mrt_image}{Mean reaction time of Image stimuli.}
#'
#'   \item{mrt_sound}{Mean reaction time of Sound stimuli.}
#'
#'   \item{mrt_mixed}{Mean reaction time of Mixed stimuli.}
#'
#'   \item{mrt_mixadv}{Mean reaction decrease of Mixed stimuli compared to other
#'     two types of stimuli.}
#' @export
multisense <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_type = "type", name_rt = "rt") |>
    update_settings(.input)
  .extra <- list(
    type_image = "image",
    type_sound = "sound",
    type_mixed = "mixed"
  ) |>
    update_settings(.extra)
  data |>
    mutate(acc_dummy = 1) |>
    calc_spd_acc(
      by = c(.by, .input$name_type),
      name_acc = "acc_dummy",
      name_rt = .input$name_rt
    ) |>
    pivot_wider(
      id_cols = all_of(.by),
      names_from = .input$name_type,
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
