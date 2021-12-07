# preproc.iquizoo 2.1.0

## Breaking Changes

* Now `options()` support is removed, but accept two additional arguments `.input` and `.extra`.

# preproc.iquizoo 2.0.1

## Internal

* Remove `where` from global variables.

# preproc.iquizoo 2.0.0

## Breaking Changes

* Removed support for custom-defined json configuration file.
* Added support to configure function behavior in `options()`, for now including input variable names in data and specific values for certain variables.
* Now `preproc()` is removed because it is believed there is no place for it after this refactoring.

# preproc.iquizoo 1.3.3

## Internal

* Remove several unused package from dependency.

# preproc.iquizoo 1.3.2

## Breaking Changes

* Changed argument names of `prep_fun` and `by` to `.fn` and `.by` respectively. See [here](https://adv-r.hadley.nz/functionals.html#argument-names) for the reasons.
* And `vars_input` is also renamed as `.input`.

# preproc.iquizoo 1.3.1

## Bug Fixes

* Remove "Datasets" section from pkgdown site.

# preproc.iquizoo 1.3.0

## Breaking Changes

* Now internal data moved to {data.iquizoo} package.
* Now `preproc()` accepts custom-defined functions and custom-defined configurations (input and output variable names) in a custom `.json` file.

# preproc.iquizoo 1.2.1

## Breaking Changes

* Now the package is named as "preproc.iquizoo".
* `game_info` data is moved to {data.iquizoo} package.

# preproc.iquizoo 1.2.0

## Breaking Changes

* For integrating "{dm}" package, we moved `wrangle_data()` back to {tarflow.iquizoo}, and then renamed `preproc_data()` to `preproc()`.

# preproc.iquizoo 1.1.1

## Miscellaneous

* Added more games into the `game_info` data.

# preproc.iquizoo 1.1.0

## New Features

* Added a new function `wrange_data()` (originally in {tarflow.iquizoo}). Now it removes duplicates from data.
* Added two more indices in `refframe()` of distance error aggregating both conditions.

# preproc.iquizoo 1.0.5

## New Features

* Support an edge case for `span()` when number of correct responses can be recovered from columns `"stim"` and `"resp"`. Use it with care, for it does take order into consideration!

# preproc.iquizoo 1.0.4

## New Features

* Support input of cancellation games data for `cpt()`.

## Misc

* Now cancellation games use `cpt()` preprocessing function.

# preproc.iquizoo 1.0.3

## New Features

* Changed the behavior of `preproc_data()` to make sure it restores all the attributes from input `data`.

## Misc

* Now pipe and rlang helpers are not re-exported from this package.

# preproc.iquizoo 1.0.2

## New Features

* Add a subtle new feature that now more keywords are supported in `nback()`. Specifically, you can now use `"filler"` and `"target"` keywords.
* Add another subtle new feature so that you can ignore the case of character vectors. For example, `"filler"` and `"Filler"` are both okay for now, but only `"Filler"` is errorproof for previous versions.

# preproc.iquizoo 1.0.1

## Bug Fixes

* Added more games in the data `game_info`, mostly are questionnaires (#27, thanks to @Blockhead-yj).
* Fixed case issues of data name. Now lowercase is used thoroughly for data names (note it is not snake_case, for readability is not for consideration).

# preproc.iquizoo 1.0.0

## New Features

* Add support for group-wise calculation, and this is implemented by using a new "entry-point" function `preproc_data()` with an input argument of `by` (#23, #25).

## Enhancement

* Use log-linear correction for extreme proportions in calculation of d' based on signal detection theory (#16).

# preproc.iquizoo 0.2.8

* Add more games to `game_info` data.

# preproc.iquizoo 0.2.7

* Completely removed `conflict()`, which is defunct for many versions.
* Used the 3rd version test framework of testthat package, especially takes advantage of the snapshot test (or goden test) to simplify all our tests.
* Unified the abnormal output by setting all of the `NA`s as `NA_real`.
* Unified the response metrics checking. Now many games need to have a minimal valid response rate of 80% and a minimal accuracy rate, too. Use `?tarflow.iquizoo:::check_resp_metric` to see details. Note this function is not exported for now.

# preproc.iquizoo 0.2.6

* Add external data `game_info`, which stores games information of preprocessing functions. Run `?game_info` in R to read more details.

# preproc.iquizoo 0.2.5

* Fixed a bug occured in function `london()` when user did not respond and the data still scored the user as correct.
* Added a response rate check for `london()`. Now the score is normal only when the response rate is no less than 80%.

# preproc.iquizoo 0.2.4

* Just as `complexswitch()`, now `switchcost()` will also return abnormal result (all `NA`s) if at least one block has no responses.

# preproc.iquizoo 0.2.3

* Fix a bug occured in function `multisense()` when users did not respond to sound trials.

# preproc.iquizoo 0.2.2

* Fix a bug occured in function `wxpred()` after filling `NA` values to `name_block` (mostly is just `Block`) column.
* Fix a bug occured in function `driving()` when minus signs, which are confused with hyphens, are logged into data.

# preproc.iquizoo 0.2.1

* Now `complexswitch()` will return abnormal result (all `NA`s) if at least one block has no responses.

# preproc.iquizoo 0.2.0

* Rename package from "preprocr2" to "preproc.iquizoo". This is recommended because all the work is related to www.iquizoo.com.

# preproc.iquizoo 0.1.4

* Added a utility function `calc_sdt()` to calculate signal detection theory related indices.
* Fixed an issue related to perfect accuracy in `drm()`.

# preproc.iquizoo 0.1.3

* Added a `NEWS.md` file to track changes to the package.
* Added `pc_all` index, meaning overal percent of correct, to `wxpred` function.
