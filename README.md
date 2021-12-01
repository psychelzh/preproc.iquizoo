
<!-- README.md is generated from README.Rmd. Please edit that file -->

# preproc.iquizoo

<!-- badges: start -->

[![R-CMD-check](https://github.com/psychelzh/preproc.iquizoo/workflows/R-CMD-check/badge.svg)](https://github.com/psychelzh/preproc.iquizoo/actions)
[![Codecov test
coverage](https://codecov.io/gh/psychelzh/preproc.iquizoo/branch/main/graph/badge.svg)](https://codecov.io/gh/psychelzh/preproc.iquizoo?branch=main)
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
devtools::install_github("psychelzh/preproc.iquizoo")
```

## Usage

This package is best used in company with
[tarflow.iquizoo](https://github.com/psychelzh/tarflow.iquizoo) package.
Read the [documentation](https://psychelzh.github.io/tarflow.iquizoo)
there.

## Advanced

To deal with the various formats of datasets, some custom configurations
are supported. For now there are two most important `options()` used:

-   `"preproc.input"`: input variable names in data to be used in
    calculating the preformance indices.
-   `"preproc.extra"`: extra values to configure certain key values for
    variable names.
