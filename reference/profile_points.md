# Profile End Point

Create a end point along a profile line starting at a point with a
defined direction and length.

## Usage

``` r
profile_points(
  start,
  profile.azimuth,
  profile.length,
  crs = st_crs(start),
  return.sf = TRUE
)
```

## Arguments

- start:

  `sf` point object.

- profile.azimuth:

  numeric or `units` object. Direction of profile in degrees if numeric.

- profile.length:

  numeric or `units` object.

- crs:

  Coordinate reference system. Should be parsed by
  [`sf::st_crs()`](https://r-spatial.github.io/sf/reference/st_crs.html).

- return.sf:

  logical. Should the profile points be returned as a `sf` object
  (`TRUE`, the default) object or as a data.frame.

## Value

class depends on `return.sf`.

## Note

Use metric values (meters, kilometers, etc) in case of a projected
coordinate reference frame, and degree when geographical coordinate
reference frame.

## Examples

``` r
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_points(p1,
  profile.azimuth = 135, profile.length = units::set_units(10, "km"),
  crs = sf::st_crs("EPSG:26915")
)
#> Simple feature collection with 2 features and 0 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 662193.2 ymin: 5378256 xmax: 669264.3 ymax: 5385328
#> Projected CRS: NAD83 / UTM zone 15N
#>                   geometry
#> 1 POINT (662193.2 5385328)
#> 2 POINT (669264.3 5378256)
```
