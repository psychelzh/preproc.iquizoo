
<!-- README.md is generated from README.Rmd. Please edit that file -->

# preproc.iquizoo

<!-- badges: start -->

[![R-CMD-check](https://github.com/psychelzh/preproc.iquizoo/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/psychelzh/preproc.iquizoo/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/psychelzh/preproc.iquizoo/branch/main/graph/badge.svg)](https://app.codecov.io/gh/psychelzh/preproc.iquizoo?branch=main)
[![lint](https://github.com/psychelzh/preproc.iquizoo/workflows/lint/badge.svg)](https://github.com/psychelzh/preproc.iquizoo/actions)
<!-- badges: end -->

The goal of preproc.iquizoo is to provide pre-processing functions for
IQUIZOO original data.

## Background

IQUIZOO is now a developing company shipped with a bunch of games
assessing psychological constructs. The original data from these games
have various formats, and this package tries to provide data
preprocessing APIs for them.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("psychelzh/preproc.iquizoo@develop")
```

Or you can install the stable version from
[r-universe](https://psychelzh.r-universe.dev/) with:

``` r
install.packages("preproc.iquizoo", repos = c(getOption("repos"), "https://psychelzh.r-universe.dev"))
```

## Usage

This package is best used in company with
[tarflow.iquizoo](https://github.com/psychelzh/tarflow.iquizoo) package.
Read the [documentation](https://psychelzh.github.io/tarflow.iquizoo/)
there.

## Advanced

To deal with the various formats of datasets, each function accepts two
special input arguments:

- `.input`: the input variable names used in the `data.frame` typed
  data.
- `.extra`: some special values for certain variable. For example, the
  value used to indicate `"congruent"` type stimuli.
