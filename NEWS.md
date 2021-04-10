# dataproc.iquizoo 1.0.0

## New Features

* Add support for group-wise calculation, and this is implemented by using a new "entry-point" function `preproc_data()` with an input argument of `by` (#23, #25).

## Enhancement

* Use log-linear correction for extreme proportions in calculation of d' based on signal detection theory (#16).

# dataproc.iquizoo 0.2.8

* Add more games to `game_info` data.

# dataproc.iquizoo 0.2.7

* Completely removed `conflict()`, which is defunct for many versions.
* Used the 3rd version test framework of testthat package, especially takes advantage of the snapshot test (or goden test) to simplify all our tests.
* Unified the abnormal output by setting all of the `NA`s as `NA_real`.
* Unified the response metrics checking. Now many games need to have a minimal valid response rate of 80% and a minimal accuracy rate, too. Use `?tarflow.iquizoo:::check_resp_metric` to see details. Note this function is not exported for now.

# dataproc.iquizoo 0.2.6

* Add external data `game_info`, which stores games information of preprocessing functions. Run `?game_info` in R to read more details.

# dataproc.iquizoo 0.2.5

* Fixed a bug occured in function `london()` when user did not respond and the data still scored the user as correct.
* Added a response rate check for `london()`. Now the score is normal only when the response rate is no less than 80%.

# dataproc.iquizoo 0.2.4

* Just as `complexswitch()`, now `switchcost()` will also return abnormal result (all `NA`s) if at least one block has no responses.

# dataproc.iquizoo 0.2.3

* Fix a bug occured in function `multisense()` when users did not respond to sound trials.

# dataproc.iquizoo 0.2.2

* Fix a bug occured in function `wxpred()` after filling `NA` values to `name_block` (mostly is just `Block`) column.
* Fix a bug occured in function `driving()` when minus signs, which are confused with hyphens, are logged into data.

# dataproc.iquizoo 0.2.1

* Now `complexswitch()` will return abnormal result (all `NA`s) if at least one block has no responses.

# dataproc.iquizoo 0.2.0

* Rename package from "dataprocr2" to "dataproc.iquizoo". This is recommended because all the work is related to www.iquizoo.com.

# dataproc.iquizoo 0.1.4

* Added a utility function `calc_sdt()` to calculate signal detection theory related indices.
* Fixed an issue related to perfect accuracy in `drm()`.

# dataproc.iquizoo 0.1.3

* Added a `NEWS.md` file to track changes to the package.
* Added `pc_all` index, meaning overal percent of correct, to `wxpred` function.
