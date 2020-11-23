#' Make data for regular test
#'
#' Regular test data can be generated automatically.
make_test_data <- function(dir, ...) {
  test_fun <- utils::getFromNamespace(basename(dir), ns = "dataproc.iquizoo")
  sample_files <- list.files(dir, "sample", full.names = TRUE)
  for (sample_file in sample_files) {
    sample_label <- stringr::str_extract(sample_file, r"((?<=_)\w+(?=\.))")
    sample_data <- jsonlite::read_json(sample_file, simplifyVector = TRUE)
    jsonlite::write_json(
      test_fun(sample_data, ...),
      file.path(dir, stringr::str_c("result_", sample_label, ".json")),
      na = "null"
    )
  }
}
