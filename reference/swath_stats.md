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
#> 1        0.0 [m] 0.8173854 0.2574638  0.3974442 0.5374246  0.6774050 0.8173854
#> 2   349377.3 [m] 0.7181259 0.3812662  0.5393279 0.6550705  0.7364850 0.7915622
#> 3   698754.6 [m] 0.4161699 0.3319564  0.4161699 0.5487574  0.8497091 0.8925887
#> 4  1048131.9 [m] 0.4303673 0.4077772  0.4303673 0.4770515  0.6432893 0.6736628
#> 5  1397509.2 [m] 0.7230899 0.3675345  0.4690219 0.5584744  0.6413457 0.7230899
#> 6  1746886.5 [m] 0.7463372 0.2985906  0.5720309 0.7047574  0.7872478 0.9099796
#> 7  2096263.8 [m] 0.6843084 0.4523731  0.4699486 0.5218479  0.5969937 0.6843084
#> 8  2445641.1 [m] 0.6755226 0.3819319  0.5168844 0.5592101  0.6451789 0.6755226
#> 9  2795018.4 [m] 0.2869238 0.2869238  0.5355189 0.5592542  0.6160086 0.6373706
#> 10 3144395.7 [m] 0.7704198 0.4971106  0.5299680 0.5464206  0.7704198 0.8319334
#> 11 3493773.0 [m] 0.7224972 0.2541760  0.4388941 0.5486077  0.6488137 0.7224972
#> 12 3843150.3 [m] 0.4945914 0.3130119  0.3495539 0.4945914  0.4996581 0.7352921
#> 13 4192527.6 [m] 0.4870340 0.2739995  0.4337754 0.5852368  0.6868747 0.6971801
#> 14 4541904.9 [m] 0.3702759 0.3632354  0.3667556 0.3702759  0.5362028 0.7021297
#> 15 4891282.2 [m] 0.4823776 0.4823776  0.5399075 0.5974373  0.6549671 0.7124969
#> 16 5240659.5 [m] 0.5024581 0.5024581  0.5024581 0.5024581  0.5024581 0.5024581
#>         mean        sd
#> 1  0.5374246 0.3959244
#> 2  0.6207424 0.1796636
#> 3  0.6078363 0.2529439
#> 4  0.5264296 0.1235702
#> 5  0.5518933 0.1522837
#> 6  0.6545213 0.2584896
#> 7  0.5450944 0.1053535
#> 8  0.5557456 0.1162736
#> 9  0.5270152 0.1404045
#> 10 0.6351705 0.1541206
#> 11 0.5225977 0.1841354
#> 12 0.4784215 0.1663296
#> 13 0.5354133 0.1989623
#> 14 0.4785470 0.1936603
#> 15 0.5974373 0.1627189
#> 16 0.5024581        NA
```
