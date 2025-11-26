# Azimuth Between Profile Points

Azimuth Between Profile Points

## Usage

``` r
profile_azimuth(x)
```

## Arguments

- x:

  `sf` point object. First point marks the start point.

## Value

Azimuth as `units` object

## Details

If only two points are given, the azimuth is calculated using
triangulation from the `tectonicr` package. If more than two points are
given, the azimuth is calculated using linear interpolation in the
coordinate reference frame given by `profile`.

## See also

[`profile_length()`](https://tobiste.github.io/geoprofiler/reference/profile_length.md)

## Examples

``` r
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")

profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
) |>
  profile_azimuth()
#> Warning: Unit of profile.length not specified. Assuming unit is in meters.
#> 136.7341 [°]
```
