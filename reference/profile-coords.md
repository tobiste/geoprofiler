# Profile Coordinates

Project points on a cross section given by a starting point and the
direction

## Usage

``` r
geoprofiler(x, profile, azimuth = NULL, drop.units = TRUE)

profile_coords(x, profile, azimuth = NULL, drop.units = TRUE)
```

## Arguments

- x:

  `'sf'` object

- profile:

  `'sf'` object of the profile or the profile's starting point.

- azimuth:

  numeric. Direction (in degrees) emanating from starting point. Is
  ignored when `profile` contains two points or is a `LINESTRING`.

- drop.units:

  logical. Whether the return should show the units or not.

## Value

`tibble` where `X` is the distance along the profile line. `Y` is the
distance across the profile line. (units of `X` and `Y` depend on
coordinate reference system).

## Details

**\[superseded\]**

`profile_coords()` is superseded by `geoprofiler()` because the name of
the function is more intuitive.

## See also

Other profile:
[`profile_azimuth()`](https://tobiste.github.io/geoprofiler/reference/profile_azimuth.md),
[`profile_line()`](https://tobiste.github.io/geoprofiler/reference/profile_line.md),
[`profile_points()`](https://tobiste.github.io/geoprofiler/reference/profile_points.md)

## Author

Tobias Stephan

## Examples

``` r
data(locations_example)
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_crds <- geoprofiler(locations_example, profile = p1, azimuth = 135)
head(profile_crds)
#> # A tibble: 6 × 2
#>        X        Y
#>    <dbl>    <dbl>
#> 1 0.0778  0.116  
#> 2 0.0450  0.0123 
#> 3 0.0369 -0.00996
#> 4 0.0397 -0.00690
#> 5 0.0383 -0.00885
#> 6 0.0335  0.00333

# Plot the transformed coordinates
plot(profile_crds)
```
