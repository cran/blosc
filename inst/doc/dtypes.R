## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----encoding-----------------------------------------------------------------
library(blosc)
r_to_dtype(c(TRUE, FALSE), "|b1")
r_to_dtype(1L:4L, "|u1")
r_to_dtype(c(1.4, 9.8e-6), "<f8")
r_to_dtype(1+1i, "<c16")
r_to_dtype(as.POSIXct("2023-06-23 15:32:19", tz = "UTC"), "<M8[ms]")
r_to_dtype(as.difftime(1, units = "weeks"), "<m8[D]")

## ----precision----------------------------------------------------------------
## Encoding numeric (64 bit) as a 16 bit float:
r_to_dtype(0.123, "<f2") |>
  dtype_to_r("<f2")

## Encoding a date-time object in whole hours
## as opposed to a floating point of seconds
r_to_dtype(as.POSIXct("2024-05-31 19:58:01", tz = "UTC"), "<M8[h]") |>
  dtype_to_r("<M8[h]")

## ----missing------------------------------------------------------------------
## As `na_value` is not specified for `dtype_to_r()`
## and the NA value is masked to 8 bit, the `NA`
## value is mistakenly interpreted as `TRUE`
r_to_dtype(c(TRUE, NA, FALSE, TRUE), "|b1") |>
  dtype_to_r("|b1", na_value = NA_integer_)

## This can be fixed by specifying `na_value`
r_to_dtype(c(TRUE, NA, FALSE, TRUE), "|b1", na_value = -1) |>
  dtype_to_r("|b1", na_value = -1)

## If the `na_value` is not specified for `dtype_to_r()`,
## it will be taken literally
r_to_dtype(c(1, NA, 4, 5), "<i4", na_value = -999) |>
  dtype_to_r("<i4")

## If the `na_value` is specified for `dtype_to_r()`,
## it will interpreted as NA
r_to_dtype(c(1, NA, 4, 5), "<i4", na_value = -999) |>
  dtype_to_r("<i4", na_value = -999)

