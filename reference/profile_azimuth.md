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

Other profile:
[`profile-coords`](https://tobiste.github.io/geoprofiler/reference/profile-coords.md),
[`profile_line()`](https://tobiste.github.io/geoprofiler/reference/profile_line.md),
[`profile_points()`](https://tobiste.github.io/geoprofiler/reference/profile_points.md)

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

# Azimuth of a line-fit for a set of points
## Create 100 random points
set.seed(20250411)
x <- runif(100)
y <- 2*x + 10
noise <- rnorm(n = length(y), mean = 0, sd = 0.1)
noisy_y <- y + noise
pts2 <- data.frame(x = x, y = noisy_y) |>
  sf::st_as_sf(coords = c('x', 'y'))

## Extract line
profile_azimuth(pts2)
#> 63.91786 [°]
```
