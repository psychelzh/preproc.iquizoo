## code to prepare `gameinfo`(exported) and `gameconfig`(internal) datasets
game_info <- readr::read_csv(
  "data-raw/game_info.csv",
  show_col_types = FALSE,
  lazy = FALSE
)
usethis::use_data(game_info, overwrite = TRUE)
