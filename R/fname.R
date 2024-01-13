#' Face Name Task
#'
#' This is used to do face name task indicator calculations. Current version
#' integrates a occupation memory task.
#'
#' Following Amariglio et al. (2012), we will calculate three scores: FN-N, FN-O
#' and FN-Total.
#'
#' @template common
#' @template options
#'
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{fnn}{The overall number of correct face name pairs.}
#'
#'   \item{fno}{The overall number of correct face occupation pairs.}
#'
#'   \item{fntotal}{The overall number of correct face name and occupation
#'   pairs.}
#'
#' @export
#' @references Amariglio, R. E., Frishe, K., Olson, L. E., Wadsworth, L. P.,
#'   Lorius, N., Sperling, R. A., & Rentz, D. M. (2012). Validation of the Face
#'   Name Associative Memory Exam in cognitively normal older individuals.
#'   Journal of Clinical and Experimental Neuropsychology, 34(6), 580–587.
#'   https://doi.org/10.1080/13803395.2012.666230
fname <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_phase = "phase",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    phase_name = 3,
    phase_occu = 5,
    phase_cmbn = 6
  ) |>
    update_settings(.extra)
  parse_combined <- function(acc) {
    cols <- c("crn", "cro")
    vctrs::vec_rbind(
      !!!stringr::str_split(acc, "-"),
      .name_repair = ~cols
    ) |>
      summarise(
        across(
          all_of(cols),
          ~ sum(as.numeric(.))
        )
      )
  }
  data |>
    summarise(
      iln = .data[[.input$name_acc]] |>
        .subset(.data[[.input$name_phase]] == .extra$phase_name) |>
        as.numeric() |>
        sum(),
      ilo = .data[[.input$name_acc]] |>
        .subset(.data[[.input$name_phase]] == .extra$phase_occu) |>
        as.numeric() |>
        sum(),
      .data[[.input$name_acc]] |>
        .subset(.data[[.input$name_phase]] == .extra$phase_cmbn) |>
        parse_combined(),
      .by = all_of(.by)
    ) |>
    mutate(
      fnn = .data$iln + .data$crn,
      fno = .data$ilo + .data$cro,
      fntotal = .data$fnn + .data$fno,
      .keep = "unused"
    ) |>
    vctrs::vec_restore(data)
}
