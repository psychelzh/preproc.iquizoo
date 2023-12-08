# preproc.iquizoo (development version)

# preproc.iquizoo 2.6.1

## Bug Fixes

* Fixed observation order issue introduced by `calc_indices()`.

# preproc.iquizoo 2.6.0

## Breaking Changes

* Added `wrangle_data()` and `preproc_data()` functions, which were previously in tarflow.iquizoo package.

## Bug Fixes

* Fixed an edge case when `fit_numerosity()` will stuck in infinite loop.

# preproc.iquizoo 2.5.2

* Enhance code quality of internal functions.

# preproc.iquizoo 2.5.1

## Breaking Changes

* Ensure the number of reversals in `calc_staircase_wetherill()` to be even. Odd number of reversals will be automatically adjusted to even number by removing the first reversal from the condition with larger number of reversals ([#75](https://github.com/psychelzh/preproc.iquizoo/issues/75)).

# preproc.iquizoo 2.5.0

## New Features

* Added `condstairs()` to analyze data from self-adaptive filtering task.
* Added `capacity()` to analyze data from visual working memory capacity task.
* Added `fname()` to analyze data from face-name associative task.
* Added `ant_orient()` and `ant_alert()` to analyze data from split version of attention network tests (ANT).
* Added support for extra checking for valid rows to include in `countcorrect()`.
* Added support for restoring `"outcome"` column from `"acc"` column in `span()`. This might need further configuration of `"outcome_rule"` (default to 1, means no more error count of 1) in argument `.extra`.

## Bug Fixes

* Fixed the random seed in `fit_numerosity()`. Future work might be expanded to support setting this (rather easy but not so important now).

## Upkeep

* After {tidyselect} 1.2.0 and {dplyr} 1.1.0, many old usage of {tidyverse} functions will throw warnings. These warnings are now taken care of.

# preproc.iquizoo 2.4.2

* Fixed a bug in `span()` when correctness column has `NA` values not in all rows, in which case the function would not calculate partical credit scores for all cases.

# preproc.iquizoo 2.4.1

## Bug Fixes

* Reverted one index (`pc`) of `cpt()` to its original `nc`.

# preproc.iquizoo 2.4.0

## Breaking Changes

* Added `.by` argument back to all functions for speed improvement.

## Minor Improvements

* Ensured all the functions return data with the same `class` as input `data`. This is somewhat so-called class invariant.

# preproc.iquizoo 2.3.2

## New Features

* Added `rapm()` for Raven's Advanced Progressive Matrices test.
* Exported `fit_numerosity()`.
* Added basic support for indices combining speed and accuracy performances in `calc_spd_acc()`.
* Supported new version of Racer test in `racer()`.
* Added index of percent correct for learning phase for reinforcement test in `reinf()`.

## Bug Fixes

* Fixed bug of switch cost for percent correct (#68).
* Fixed docstring of `span()` (#65).

# preproc.iquizoo 2.3.1

* Correct spellings.

# preproc.iquizoo 2.3.0

## Breaking Changes

* Now the `.by` argument from all functions is removed. The decision to include that grouping argument is now considered a redundant feature.

## New Features

* Added new function `racer()` to support NeuroRacer tests.

# preproc.iquizoo 2.2.1

## New Features

* Added new function `reinf()` to support for reinforcement learning tests.
* Support threshold calculation in `staircase()` with inflection point.

## Bug Fixes

* Fixed issues for `synwin()` caused by a new design of the test.
* Now response times are corrected for no-response trials in stop signal test.

# preproc.iquizoo 2.2.0

## New Features

* Added new function `dualnback()` to support for dual n-back tests.
* Added new function `staircase()` to support for tests shipped with staircase method.
* Added new function `synwin()` to support modified SynWin test.
* Now `span()` can deal with location memory test.
* Supported new design of london tower test.

## Enhancement

* Added partical credit score for simple or complex span tests (#36).
* Changed algorithm to get stop signal reaction time for Stop Signal Paradigm based on the [recent eLife publication](https://doi.org/10.7554/eLife.46323) (#56).
* Added support for ncorrect and nerror input for `countcorrect()` and `countcorrect2()`.
* Enhanced reaction time outlier detection (#61).
* Enhanced fitting of weber fraction for numerosity task through trial-based maximum likelihood estimation.

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
* Used the 3rd version test framework of testthat package, especially takes advantage of the snapshot test (or golden test) to simplify all our tests.
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
