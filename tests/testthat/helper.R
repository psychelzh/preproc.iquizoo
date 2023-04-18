prepare_level <- function(outcome, n_up, n_down,
                          level_init = 2,
                          level_step = 1,
                          level_limits = NULL) {
  level_limits <- level_limits %||% c(0, 16)
  out <- numeric(length(outcome))
  win_streak <- 0
  lose_streak <- 0
  level_next <- level_init
  for (i in seq_along(outcome)) {
    level_cur <- level_next
    if (outcome[[i]] == 1) {
      win_streak <- win_streak + 1
      lose_streak <- 0
      if (win_streak == n_up) {
        level_next <- min(level_cur + level_step, level_limits[[2]])
        win_streak <- 0
      } else {
        level_next <- level_cur
      }
    } else {
      win_streak <- 0
      lose_streak <- lose_streak + 1
      if (lose_streak == n_down) {
        level_next <- max(level_cur - level_step, level_limits[[1]])
        lose_streak <- 0
      } else {
        level_next <- level_cur
      }
    }
    out[i] <- level_cur
  }
  out
}
