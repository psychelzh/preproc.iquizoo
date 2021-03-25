#' Calculates index scores for Spatiotemporal Memory (so-called Camera) games.
#'
#' Mean distance and percentage of correct responses are returned. The only
#' difference with \code{\link{locmem}} is that this function takes order
#' accuracy (thus temporal) into consideration.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc_order}{Percent of correct in temporal order judgment.}
#'   \item{pc_loc}{Percent of correct (distance equals to 0) in location
#'     judgment.}
#'   \item{mean_dist}{Mean distance in location judgment.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
spattemp <- function(data, ...) {
  vars_output <- c("pc_order", "pc_loc", "mean_dist")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_obj_ori", "ObjectID",
    "name_loc_ori", "LocOrigin",
    "name_obj_resp", "RespObjectID",
    "name_loc_resp", "RespObjectLoc",
    "name_acc_order", "RespAccOrder",
    "name_dist_loc", "RespLocDist"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  pc_order <- data %>%
    dplyr::pull(vars_matched["name_acc_order"]) %>%
    stringr::str_split("-") %>%
    unlist() %>%
    as.numeric() %>%
    mean()
  loc_result <- data %>%
    dplyr::select(
      dplyr::all_of(
        vars_matched[
          c(
            "name_obj_ori", "name_loc_ori",
            "name_obj_resp", "name_loc_resp"
          )
        ]
      )
    ) %>%
    dplyr::mutate(trial = seq_len(dplyr::n())) %>%
    tidyr::pivot_longer(
      -.data[["trial"]],
      names_to = c(".value", "type"),
      names_pattern = "name_(.+)_(.+)"
    ) %>%
    dplyr::transmute(
      .data[["trial"]], .data[["type"]],
      data = purrr::map2(
        .data[["obj"]], .data[["loc"]],
        ~ tibble(
          id = unlist(stringr::str_split(.x, "-")),
          loc = unlist(stringr::str_split(.y, "-")) %>%
            stringr::str_split("_") %>%
            purrr::map(as.numeric)
        )
      )
    ) %>%
    tidyr::unnest(.data$data) %>%
    tidyr::pivot_wider(
      names_from = "type",
      values_from = "loc",
      values_fn = function(x) {
        if (length(x) != 1) list(x) else x
      }
    ) %>%
    dplyr::mutate(
      dist = purrr::map2_dbl(
        .data[["ori"]], .data[["resp"]],
        ~ if (!rlang::is_atomic(.x) || !rlang::is_atomic(.y)) {
          NA_real_
        } else {
          matrix(c(.x, .y), ncol = 2, byrow = TRUE) %>%
            stats::dist()
        }
      )
    ) %>%
    dplyr::summarise(
      pc_loc = mean(.data[["dist"]] %in% 0),
      mean_dist = mean(.data[["dist"]], na.rm = TRUE)
    )
  tibble(pc_order, loc_result, is_normal = TRUE)
}
