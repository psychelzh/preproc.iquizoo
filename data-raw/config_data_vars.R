config_data_vars <- jsonlite::read_json(
  "data-raw/config_data_vars.json",
  simplifyVector = TRUE
)
usethis::use_data(config_data_vars, internal = TRUE, overwrite = TRUE)
