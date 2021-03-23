# dataproc-iquizoo

[![tic](https://github.com/psychelzh/dataproc.iquizoo/workflows/tic/badge.svg?branch=master)](https://github.com/psychelzh/dataproc.iquizoo/actions)
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

This is an R package provides preprocessing functions for IQUIZOO original data.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [API](#api)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

IQUIZOO is now a developing company shipped with a bunch of games assessing psychological constructs. The original data from these games have various format, and this package tries to provide PIs for every game. The basic logic here is to use one dataset named `game_info`, which is exported to provide information of each game and its preprocessing function name, so that one can easily match the correct function to preprocess data for these games based on this dataset.

## Install

Install the develop version from github.

```r
# require("remotes")
remotes::install_github("psychelzh/dataproc.iquizoo")
```

## Usage

This package is best used in company with [`tarflow.iquizoo`](https://github.com/psychelzh/tarflow.iquizoo) package, which used this package in its `"indices"` and `"original"` (dataset only) schemas.

```r
# remotes::install_github("psychelzh/tarflow.iquizoo")
tarflow.iquizoo::use_targets("indices", separate = TRUE)
```

## Maintainers

[@psychelzh](https://github.com/psychelzh)

## Contributing

PRs accepted.

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

MIT © 2021 Liang Zhang
