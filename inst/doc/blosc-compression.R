## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  out.width = "50%",
  fig.width = 5,
  fig.height = 4
)

## ----compress-----------------------------------------------------------------
library(blosc)
data_input <- as.raw(c(1, 2, 3, 4, 1, 2, 3, 4))
blosc_compress(data_input, typesize = 2)

## ----compress-type------------------------------------------------------------
## The line below won't work as the default `typesize` (4) does
## not match with the dtype size (2)
## blosc_compress(iris$Petal.Length, dtype = "<f2")

## Explicitely set the `typesize` to 2
compressed_iris <-
  blosc_compress(iris$Petal.Length, typesize = 2, dtype = "<f2")

## ----blosc-info---------------------------------------------------------------
blosc_info( compressed_iris )

## ----decompress---------------------------------------------------------------
iris_length1 <- blosc_decompress(compressed_iris)
head(iris_length1)

## ----decompress-type----------------------------------------------------------
iris_length2 <- blosc_decompress(compressed_iris, dtype = "<f2")
hist(iris_length2)

