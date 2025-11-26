# Extract End Points of a Line

Extract End Points of a Line

## Usage

``` r
line_ends(x)
```

## Arguments

- x:

  `sf` line object

## Value

`sf` point object

## Examples

``` r
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
) |>
  profile_line() |>
  line_ends()
#> Warning: Unit of profile.length not specified. Assuming unit is in meters.
#> Geometry set for 2 features 
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 662193.2 ymin: 5378256 xmax: 669264.3 ymax: 5385328
#> Projected CRS: NAD83 / UTM zone 15N
#> POINT (662193.2 5385328)
#> POINT (669264.3 5378256)
```
