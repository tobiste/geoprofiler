# Combine Points to a Line

Combine Points to a Line

## Usage

``` r
profile_line(x)
```

## Arguments

- x:

  `sf` point object

## Value

`sf` line object

## See also

[`profile_points()`](https://tobiste.github.io/geoprofiler/reference/profile_points.md)

## Examples

``` r
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
) |>
  profile_line()
#> Warning: Unit of profile.length not specified. Assuming unit is in meters.
#> Geometry set for 1 feature 
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 662193.2 ymin: 5378256 xmax: 669264.3 ymax: 5385328
#> Projected CRS: NAD83 / UTM zone 15N
#> LINESTRING (662193.2 5385328, 669264.3 5378256)
```
