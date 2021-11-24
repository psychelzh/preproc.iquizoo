
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
are supported. There will be two basic configurations used:

-   `game_info`: provides information of each game and its
    pre-processing function name, so that one can easily match the
    correct function to preprocess data for these games based on this
    dataset. Now lives in [data.iquizoo
    package](https://github.com/psychelzh/data.iquizoo).
-   `config_prep_fun`: provides configurations for each pre-processing
    functions, because each lower-level pre-processing functions will
    need pre-configured input and (optional) output variable names. Now
    also lives in [data.iquizoo
    package](https://github.com/psychelzh/data.iquizoo). But this
    configuration can be partly customized with a json file. An example
    is just as follows:

``` json
{
    "bart": {
        "input": {
            "name_nhit": "nhit",
            "name_feedback": "feedback"
        },
        "output": [
            "mean_pumps",
            "mean_pumps_raw"
        ]
    }
}
```
