#' Attention Network Test
#'
#' The indices for ANT task are calculated.
#'
#' @name ant
#' @template common
#' @template options
#'
#' @return An object with the same class as `data` contains following values:
#'
#'   Executive function score (prefix `cong_eff`), endogenous orienting scores
#'   (prefix `orient_endo`), exogenous orienting scores (prefix `orient_exo`),
#'   audio alerting scores (prefix `alert_aud`) and visual alerting scores
#'   (prefix `alert_vis`) for the following performances:
#'
#'   \item{pc}{Percent of correct.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{ies}{Inverse efficiency score.}
#'
#'   \item{rcs}{Rate correct score.}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score.}
NULL

#' @rdname ant
#' @export
ant_orient <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_cuetype = "cuetype",
    name_cong = "stimtype",
    name_rt = "rt",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    stim_con = "congruent",
    stim_inc = "incongruent",
    cue_endo = "endogenous",
    cue_exo = "exogenous",
    cue_neu = "neutral"
  ) |>
    update_settings(.extra)
  scores_ef <- congeff(data, .by = .by, .input = .input, .extra = .extra) |>
    select(all_of(.by), starts_with("cong_eff"))
  scores_orient <- data |>
    calc_spd_acc(
      by = c(.by, .input$name_cuetype),
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    ) |>
    select(-c("nc", "pcsd", "mrt_all", "rtsd")) |>
    pivot_longer(
      -all_of(c(.by, .input$name_cuetype)),
      names_to = "index",
      values_to = "score"
    ) |>
    pivot_wider(
      id_cols = all_of(c(.by, "index")),
      names_from = all_of(.input$name_cuetype),
      values_from = "score"
    ) |>
    mutate(
      orient_endo = .data[[.extra$cue_neu]] - .data[[.extra$cue_endo]],
      orient_exo = .data[[.extra$cue_neu]] - .data[[.extra$cue_exo]],
      .keep = "unused"
    ) |>
    mutate(
      across(
        starts_with("orient"),
        ~ if_else(.data$index %in% c("pc", "rcs"), -., .)
      )
    ) |>
    pivot_wider(
      id_cols = all_of(.by),
      names_from = "index",
      values_from = starts_with("orient")
    )
  merge(scores_ef, scores_orient, by = .by) |>
    vctrs::vec_restore(data)
}

#' @rdname ant
#' @export
ant_alert <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_cuetype = "cue",
    name_cong = "stimtype",
    name_rt = "rt",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    stim_con = "congruent",
    stim_inc = "incongruent",
    cue_aud = "audio",
    cue_vis = "visual",
    cue_neu = "none"
  ) |>
    update_settings(.extra)
  scores_ef <- congeff(data, .by = .by, .input = .input, .extra = .extra) |>
    select(all_of(.by), starts_with("cong_eff"))
  scores_alert <- data |>
    calc_spd_acc(
      by = c(.by, .input$name_cuetype),
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    ) |>
    select(-c("nc", "pcsd", "mrt_all", "rtsd")) |>
    pivot_longer(
      -all_of(c(.by, .input$name_cuetype)),
      names_to = "index",
      values_to = "score"
    ) |>
    pivot_wider(
      id_cols = all_of(c(.by, "index")),
      names_from = all_of(.input$name_cuetype),
      values_from = "score"
    ) |>
    mutate(
      alert_aud = .data[[.extra$cue_neu]] - .data[[.extra$cue_aud]],
      alert_vis = .data[[.extra$cue_neu]] - .data[[.extra$cue_vis]],
      .keep = "unused"
    ) |>
    mutate(
      across(
        starts_with("alert"),
        ~ if_else(.data$index %in% c("pc", "rcs"), -., .)
      )
    ) |>
    pivot_wider(
      id_cols = all_of(.by),
      names_from = "index",
      values_from = starts_with("alert")
    )
  merge(scores_ef, scores_alert, by = .by) |>
    vctrs::vec_restore(data)
}
