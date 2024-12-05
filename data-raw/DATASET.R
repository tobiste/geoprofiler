## code to prepare `DATASET` dataset goes here

set.seed(1234)
locations_example <- readRDS("C:/Users/tstephan/Documents/Lakehead/Goldshore data/Data/goldshore_bh_samples.rds") |>
  dplyr::slice_sample(n = 500)
locations_example$value <- runif(nrow(locations_example))
locations_example$empty <- (!sf::st_is_empty(locations_example))

locations_example <- locations_example |>
  dplyr::filter(empty) |>
  dplyr::select(value)

usethis::use_data(locations_example, overwrite = TRUE)


library(ncdf4)
library(dplyr)
library(ggplot2)

ncpath <- "E:/Global data/ETOPO/"
ncname1 <- "ETOPO_2022_v1_60s_N90W180_geoid"
ncname2 <- "ETOPO_2022_v1_60s_N90W180_bed"

ncfname1 <- paste0(ncpath, ncname1, ".nc")
ncfname2 <- paste0(ncpath, ncname2, ".nc")

geoid <- terra::rast(ncfname1)
bed <- terra::rast(ncfname2)

wgs84_z <- geoid + bed

raster_example_r <- terra::crop(wgs84_z, terra::vect(locations_example))
raster_example <- cbind(terra::crds(raster_example_r), terra::values(raster_example_r))
usethis::use_data(raster_example, overwrite = TRUE)
