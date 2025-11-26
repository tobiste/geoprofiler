# Length of Profile

Length of Profile

## Usage

``` r
profile_length(x, ...)
```

## Arguments

- x:

  `sf` line object

- ...:

  (optional) passed on to
  [`s2::s2_distance()`](https://r-spatial.github.io/s2/reference/s2_is_collection.html)

## Value

`units` object when coordinate system is set.

## See also

[`profile_azimuth()`](https://tobiste.github.io/geoprofiler/reference/profile_azimuth.md)

## Examples

``` r
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
) |>
  profile_line() |>
  profile_length()
#> Warning: Unit of profile.length not specified. Assuming unit is in meters.
#> 10000 [m]
```
