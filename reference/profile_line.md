# Combine Points to a Line

Combine Points to a Line

## Usage

``` r
profile_line(x)
```

## Arguments

- x:

  `sf` point object. If `x` only contains 2 points, then the line will
  be the connection between these points. If there are more points, then
  a best-fit line will be determined using linear regression of all
  points.

## Value

`sf` line object

## See also

Other profile:
[`profile-coords`](https://tobiste.github.io/geoprofiler/reference/profile-coords.md),
[`profile_azimuth()`](https://tobiste.github.io/geoprofiler/reference/profile_azimuth.md),
[`profile_points()`](https://tobiste.github.io/geoprofiler/reference/profile_points.md)

## Examples

``` r
# Create a line from a point and a azimuth
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
pts1 <- profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
)
#> Warning: Unit of profile.length not specified. Assuming unit is in meters.
profile_line(pts1)
#> Geometry set for 1 feature 
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 662193.2 ymin: 5378256 xmax: 669264.3 ymax: 5385328
#> Projected CRS: NAD83 / UTM zone 15N
#> LINESTRING (662193.2 5385328, 669264.3 5378256)

# Create a line from fitting set of points
## Create 100 random points
set.seed(20250411)
x <- runif(100)
y <- 2*x + 10
noise <- rnorm(n = length(y), mean = 0, sd = 0.1)
noisy_y <- y + noise
pts2 <- data.frame(x = x, y = noisy_y) |>
  sf::st_as_sf(coords = c('x', 'y'))

## Extract line
profile_line(pts2)
#> Best-fit profile-line using linear regression
#> R-squared: 0.966991 
#> Geometry set for 1 feature 
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 0.005205289 ymin: 9.979017 xmax: 0.9936245 ymax: 11.99822
#> CRS:           NA
#> LINESTRING (0.005205289 9.979017, 0.9936245 11....
```
