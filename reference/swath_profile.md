# Swath Elevation Profile Statistics

Calculate swath-profile values perpendicular to a straight baseline. The
distance between samples and the number of samples can be specified, see
arguments `k` and `dist`. Values of the swath-profile are extracted from
a given raster file, see argument `raster`. CRS of raster and points
have to be the same.

## Usage

``` r
swath_profile(
  profile,
  raster,
  k = 1,
  dist,
  crs = terra::crs(raster),
  method = c("bilinear", "simple")
)
```

## Source

The algorithm is a modified version of "swathR" by Vincent Haburaj
(https://github.com/jjvhab/swathR).

## Arguments

- profile:

  either a `sf` object or a matrix(ncol=2, nrow=2) with x and y
  coordinates of beginning and end point of the baseline; each point in
  one row

  column 1

  :   x coordinates (or longitudes)

  column 2

  :   y coordinates (latitudes)

- raster:

  Raster file (`"SpatRaster"` object as loaded by
  [`terra::rast()`](https://rspatial.github.io/terra/reference/rast.html))

- k:

  integer. number of lines on each side of the baseline

- dist:

  numeric. distance between lines. Unit depends on reference system
  specified by `crs` (see note).

- crs:

  character. coordinate reference system. Both the `raster` and the
  `profile` are transformed into this CRS. Uses the CRS of `raster` by
  default.

- method:

  character. method for extraction of raw data, see
  [`terra::extract()`](https://rspatial.github.io/terra/reference/extract.html):
  default value: `"bilinear"`

## Value

list.

- `swath`:

  matrix. Statistics of the raster measured along the lines

- `data`:

  list of numeric vector containing the data extracted from the raster
  along each line

- `lines`:

  swath lines as `"sf"` objects

## Details

The final width of the swath is: \\2k \times \text{dist}\\.

## Note

The unit of `dist` depends on the coordinate reference system specified
in `crs` (which uses the coordinate system of `raster` by default). This
means, a geographic coordinates system (e.g. WGS84) assumes units in
degrees, while a projected coordinate system (e.g. UTM) assumes meters.

## See also

[`swath_stats()`](https://tobiste.github.io/geoprofiler/reference/swath_stats.md)

## Examples

``` r
# Create a random raster
r <- terra::rast(ncol = 10, nrow = 10, xmin = -150, xmax = -80, ymin = 20, ymax = 60, crs = "WGS84")
terra::values(r) <- runif(terra::ncell(r))

# Create a random profile
profile <- data.frame(lon = c(-140, -90), lat = c(55, 25)) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
swath_profile(profile, r, k = 2, dist = 1)
#> $swath
#>       distance      mean    median        sd       min       max quantile25
#> lyr.1       -2 0.4590701 0.4745807 0.1073198 0.2613481 0.6733179  0.4035579
#> lyr.1       -1 0.4729833 0.4900782 0.1175709 0.2613481 0.6733179  0.3944666
#> lyr.1        0 0.4861382 0.4843019 0.1315223 0.2613481 0.7434251  0.4053778
#> lyr.1        1 0.5193847 0.5047430 0.1157125 0.2986234 0.7434251  0.4610370
#> lyr.1        2 0.5188714 0.5354328 0.1226090 0.2986234 0.7434251  0.4610370
#>       quantile75
#> lyr.1  0.5320362
#> lyr.1  0.5409959
#> lyr.1  0.5411026
#> lyr.1  0.5776294
#> lyr.1  0.5807059
#> 
#> $data
#> $data$lyr.1
#>  [1] 0.4745807 0.4435484 0.4067186 0.4900782 0.5542827 0.5465590 0.2986234
#>  [8] 0.6733179 0.3514926 0.5354328 0.4003972 0.4162889 0.5047430 0.5286397
#> [15] 0.2613481
#> 
#> $data$lyr.1
#>  [1] 0.4745807 0.4435484 0.3726443 0.4900782 0.5542827 0.5465590 0.2986234
#>  [8] 0.6733179 0.3514926 0.5354328 0.6431701 0.4162889 0.5047430 0.5286397
#> [15] 0.2613481
#> 
#> $data$lyr.1
#>  [1] 0.5367092 0.4745807 0.4435484 0.3726443 0.4900782 0.5542827 0.4785257
#>  [8] 0.2986234 0.6733179 0.3514926 0.5354328 0.6431701 0.4162889 0.5047430
#> [15] 0.7434251 0.2613481
#> 
#> $data$lyr.1
#>  [1] 0.5367092 0.4990050 0.4435484 0.3726443 0.4900782 0.5542827 0.4785257
#>  [8] 0.2986234 0.6733179 0.6009761 0.5354328 0.6431701 0.4162889 0.5047430
#> [15] 0.7434251
#> 
#> $data$lyr.1
#>  [1] 0.5367092 0.4990050 0.4435484 0.3726443 0.3382311 0.5542827 0.4785257
#>  [8] 0.2986234 0.6733179 0.6009761 0.5354328 0.6431701 0.5604357 0.5047430
#> [15] 0.7434251
#> 
#> 
#> $lines
#> Simple feature collection with 5 features and 0 fields
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: -141.029 ymin: 23.28501 xmax: -88.97101 ymax: 56.71499
#> Geodetic CRS:  WGS 84
#>                         geometry
#> 1 LINESTRING (-141.029 53.285...
#> 2 LINESTRING (-140.5145 54.14...
#> 3   LINESTRING (-140 55, -90 25)
#> 4 LINESTRING (-139.4855 55.85...
#> 5 LINESTRING (-138.971 56.714...
#> 
```
