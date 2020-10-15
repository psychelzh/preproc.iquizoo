library(dataprocr2)
test_funs_reg <- c(
  "bart", "bps", "complexswitch", "congeff", "countcorrect", "cpt", "crt",
  "driving", "drm", "dualtask", "jlo", "locmem", "london", "multisense",
  "nback", "nle", "nsymncmp", "schulte", "span", "spattemp", "srt",
  "stopsignal", "switchcost", "symncmp", "wxpred"
)
for (test_fun_str in test_funs_reg) {
  context(stringr::str_glue("Testing on `{test_fun_str}()`"))
  test_batch(test_fun_str)
}
