#' Utility function for level (or something similar) data preparation
.prepare_level <- function(outcome, init_level, max_level, min_level) {
  out <- numeric(length(outcome))
  for (i in seq_along(outcome)) {
    if (i == 1) {
      out[i] <- init_level
    } else {
      if (outcome[i - 1] == 1) {
        out[i] <- min(max_level, out[i - 1] + 1)
      } else {
        out[i] <- max(min_level, out[i - 1] - 1)
      }
    }
  }
  out
}
