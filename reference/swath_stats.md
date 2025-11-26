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

tibble

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
#> # A tibble: 16 × 9
#>    distance elevation   min quantile25 median quantile75   max  mean      sd
#>         [m]     <dbl> <dbl>      <dbl>  <dbl>      <dbl> <dbl> <dbl>   <dbl>
#>  1       0      0.793 0.748      0.759  0.770      0.782 0.793 0.770  0.0323
#>  2  349377.     0.549 0.326      0.395  0.438      0.482 0.549 0.438  0.0925
#>  3  698755.     0.625 0.262      0.581  0.620      0.625 0.676 0.553  0.166 
#>  4 1048132.     0.580 0.385      0.454  0.487      0.580 0.678 0.517  0.114 
#>  5 1397509.     0.541 0.462      0.489  0.519      0.581 0.701 0.550  0.106 
#>  6 1746887.     0.459 0.459      0.519  0.558      0.590 0.624 0.550  0.0698
#>  7 2096264.     0.600 0.312      0.319  0.412      0.527 0.600 0.434  0.142 
#>  8 2445641.     0.693 0.288      0.421  0.486      0.586 0.693 0.495  0.155 
#>  9 2795018.     0.389 0.241      0.389  0.398      0.609 0.858 0.499  0.240 
#> 10 3144396.     0.413 0.413      0.465  0.545      0.650 0.673 0.549  0.113 
#> 11 3493773.     0.485 0.165      0.485  0.494      0.541 0.763 0.489  0.213 
#> 12 3843150.     0.505 0.456      0.505  0.556      0.691 0.739 0.589  0.121 
#> 13 4192528.     0.548 0.548      0.638  0.702      0.774 0.889 0.710  0.142 
#> 14 4541905.     0.797 0.635      0.702  0.770      0.784 0.797 0.734  0.0870
#> 15 4891282.     0.362 0.362      0.377  0.391      0.406 0.421 0.391  0.0418
#> 16 5240660.     0.356 0.356      0.356  0.356      0.356 0.356 0.356 NA     
```
