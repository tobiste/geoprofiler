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
#> 1        0.0 [m] 0.4002115 0.4002115  0.5133848 0.6265580  0.7397312 0.8529044
#> 2   349377.3 [m] 0.4010476 0.1783056  0.3453621 0.5990991  0.8332517 0.9415551
#> 3   698754.6 [m] 0.4383210 0.3788548  0.4383210 0.5631618  0.6503813 0.6780313
#> 4  1048131.9 [m] 0.5272433 0.4090641  0.4955825 0.5272433  0.5423725 0.6267290
#> 5  1397509.2 [m] 0.4375479 0.4375479  0.4835537 0.5169764  0.5649958 0.6547918
#> 6  1746886.5 [m] 0.5886892 0.3062018  0.4384766 0.4851413  0.5129582 0.5886892
#> 7  2096263.8 [m] 0.4941441 0.3793129  0.4654363 0.6025754  0.7261146 0.7714384
#> 8  2445641.1 [m] 0.7161741 0.4429506  0.5659178 0.5851473  0.7094144 0.7161741
#> 9  2795018.4 [m] 0.3854873 0.3854873  0.4051313 0.4855534  0.5145653 0.7140257
#> 10 3144395.7 [m] 0.6050053 0.3114543  0.5999228 0.6042688  0.6050053 0.6198975
#> 11 3493773.0 [m] 0.7069721 0.3603955  0.3871127 0.6288912  0.6292604 0.7069721
#> 12 3843150.3 [m] 0.6857125 0.2199212  0.4762420 0.6048129  0.6205423 0.6857125
#> 13 4192527.6 [m] 0.8069916 0.3075961  0.4802689 0.5658303  0.6471234 0.8069916
#> 14 4541904.9 [m] 0.6992434 0.4192208  0.5146008 0.6099808  0.6546121 0.6992434
#> 15 4891282.2 [m] 0.4388141 0.4388141  0.4976373 0.5564605  0.6152837 0.6741068
#> 16 5240659.5 [m] 0.3471247 0.3471247  0.3471247 0.3471247  0.3471247 0.3471247
#>         mean         sd
#> 1  0.6265580 0.32010222
#> 2  0.5795147 0.35178491
#> 3  0.5417500 0.13044561
#> 4  0.5201983 0.07881446
#> 5  0.5315731 0.09147681
#> 6  0.4662934 0.11737943
#> 7  0.5889755 0.18360801
#> 8  0.6039208 0.11339950
#> 9  0.5009526 0.13070627
#> 10 0.5481098 0.13250927
#> 11 0.5425264 0.15759848
#> 12 0.5214462 0.18487442
#> 13 0.5615621 0.20521474
#> 14 0.5761483 0.14304419
#> 15 0.5564605 0.16637709
#> 16 0.3471247         NA
```
