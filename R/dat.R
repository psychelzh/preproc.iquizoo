#' Divergent Association Test
#'
#' Note you must input words distance matrix as a `dist` object for this
#' function to work.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'   \item{score}{Divergent Association Test score.}
#' @export
dat <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  if (!requireNamespace("proxy", quietly = TRUE)) {
    stop("Please install the `proxy` package to use this function.")
  }
  .input <- list(name_words = "words") |>
    update_settings(.input)
  .extra <- list(
    # only keep the first 7 words by default (Olson et al. 2021)
    minimum = 7,
    w2v = data.frame() # note this must be set by the user
  ) |>
    update_settings(.extra)
  data |>
    summarise(
      score = .data[[.input$name_words]] |>
        stringr::str_split_1("-") |>
        get_dat_score(.extra$minimum, .extra$w2v),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}

get_dat_score <- function(words, minimum, w2v) {
  w2v_matched <- w2v[match(words, rownames(w2v)), ]
  if (nrow(w2v_matched) < minimum) {
    return(NA_real_)
  }
  mean(proxy::dist(w2v_matched[seq_len(minimum), ], method = "cosine"))
}
