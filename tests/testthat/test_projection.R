data(locations_example)
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_crds <- profile_coords(locations_example, profile = p1, azimuth = 135)


test_that("type of object returned is as expected", {
  expect_s3_class(profile_coords(locations_example, profile = p1, azimuth = 135), "tbl")
})



# test_pt <-sf::st_sfc(
#   sf::st_point(c(0, 0)),
#   sf::st_point(c(0, 90)),
#   sf::st_point(c(-10, 0)),
#   crs = 'WGS84'
#   )
#
# profile2 <-
#   c(0, 0) |>
#   sf::st_point() |>
#   sf::st_sfc(crs = 'WGS84')
#
# profile_coords(test_pt, profile = profile2, azimuth = 90)
#
# exptd <- tibble::tribble(
#   ~X, ~Y,
#   0, 0,
#   0, 90,
#   -10, 0
# )
#
# test_that("type of object returned is as expected", {
#   expect_equal(profile_coords(test_pt, profile = p2, azimuth = 180), exptd)
# })
