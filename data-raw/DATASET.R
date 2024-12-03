## code to prepare `DATASET` dataset goes here

locations_example <- readRDS("C:/Users/tstephan/Documents/Lakehead/Goldshore data/Data/goldshore_bh_samples.rds")
locations_example$value <- runif(nrow(locations_example))
locations_example$empty <- (!sf::st_is_empty(locations_example))

locations_example <- locations_example |>
  dplyr::filter(empty) |>
  dplyr::select(value)

usethis::use_data(locations_example, overwrite = TRUE)
