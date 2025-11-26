# Summary Statistics on Swath Elevation Profile

Statistics of the elevation data across a swath profile.

## Usage

``` r
swath_stats(x, profile.length = 1)
```

## Arguments

- x:

  list. The return object of
  [`swath_profile()`](https://tobiste.github.io/geoprofiler/reference/swath_profile.md)

- profile.length:

  numeric or `units` object. If `NULL` the fractional distance is
  returned, i.e. 0 at start and 1 at the end of the profile.

## Value

data.frame

## See also

[`swath_profile()`](https://tobiste.github.io/geoprofiler/reference/swath_profile.md)

## Examples

``` r
# Create a random raster
r <- terra::rast(ncol = 10, nrow = 10, xmin = -150, xmax = -80, ymin = 20, ymax = 60)
terra::values(r) <- runif(terra::ncell(r))

# Create a random profile
profile <- data.frame(lon = c(-140, -90), lat = c(55, 25)) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
swath <- swath_profile(profile, r, k = 5, dist = 10)
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: no non-missing arguments to min; returning Inf
#> Warning: no non-missing arguments to max; returning -Inf
#> Warning: no non-missing arguments to max; returning -Inf
#> Warning: no non-missing arguments to max; returning -Inf
#> Warning: no non-missing arguments to max; returning -Inf

swath_stats(swath, profile.length = profile_length(profile_line(profile)))
#>         distance elevation       min quantile25    median quantile75       max
#> 1        0.0 [m] 0.7932968 0.7475841  0.7590123 0.7704405  0.7818686 0.7932968
#> 2   349377.3 [m] 0.5488990 0.3262666  0.3947042 0.4384616  0.4817796 0.5488990
#> 3   698754.6 [m] 0.6254188 0.2624574  0.5805299 0.6196569  0.6254188 0.6764244
#> 4  1048131.9 [m] 0.5799470 0.3847243  0.4538514 0.4872710  0.5799470 0.6784282
#> 5  1397509.2 [m] 0.5408478 0.4617778  0.4890059 0.5194649  0.5809269 0.7011641
#> 6  1746886.5 [m] 0.4591882 0.4591882  0.5187569 0.5584295  0.5896470 0.6238500
#> 7  2096263.8 [m] 0.6003551 0.3115709  0.3188499 0.4122415  0.5274939 0.6003551
#> 8  2445641.1 [m] 0.6934987 0.2876855  0.4209505 0.4856788  0.5857769 0.6934987
#> 9  2795018.4 [m] 0.3885218 0.2405060  0.3885218 0.3977102  0.6094838 0.8578910
#> 10 3144395.7 [m] 0.4128698 0.4128698  0.4652195 0.5452935  0.6504364 0.6733673
#> 11 3493773.0 [m] 0.4847836 0.1653578  0.4847836 0.4937975  0.5407745 0.7625225
#> 12 3843150.3 [m] 0.5046545 0.4555524  0.5046545 0.5559582  0.6914817 0.7385666
#> 13 4192527.6 [m] 0.5483286 0.5483286  0.6382335 0.7019722  0.7739852 0.8887124
#> 14 4541904.9 [m] 0.7972042 0.6347607  0.7023803 0.7699999  0.7836020 0.7972042
#> 15 4891282.2 [m] 0.3617115 0.3617115  0.3765020 0.3912925  0.4060830 0.4208734
#> 16 5240659.5 [m] 0.3563060 0.3563060  0.3563060 0.3563060  0.3563060 0.3563060
#>         mean         sd
#> 1  0.7704405 0.03232377
#> 2  0.4380222 0.09248558
#> 3  0.5528975 0.16590212
#> 4  0.5168444 0.11444399
#> 5  0.5504679 0.10553376
#> 6  0.5499743 0.06982860
#> 7  0.4341023 0.14160875
#> 8  0.4947181 0.15507359
#> 9  0.4988226 0.23994451
#> 10 0.5494373 0.11326954
#> 11 0.4894472 0.21347088
#> 12 0.5892427 0.12133276
#> 13 0.7102464 0.14199213
#> 14 0.7339883 0.08700342
#> 15 0.3912925 0.04183380
#> 16 0.3563060         NA
```
