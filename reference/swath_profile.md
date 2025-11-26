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

  numeric. distance between lines

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
#> lyr.1       -2 0.4810259 0.4917692 0.1280879 0.1868466 0.6924040  0.4069518
#> lyr.1       -1 0.4889792 0.4924963 0.1245893 0.1868466 0.6924040  0.4109120
#> lyr.1        0 0.4610791 0.4717171 0.1190467 0.1868466 0.6219876  0.4042503
#> lyr.1        1 0.4563076 0.4524081 0.1166132 0.1868466 0.6219876  0.4195053
#> lyr.1        2 0.4572422 0.4524081 0.1128143 0.1868466 0.6219876  0.4348879
#>       quantile75
#> lyr.1  0.5741303
#> lyr.1  0.5741303
#> lyr.1  0.5481505
#> lyr.1  0.5210006
#> lyr.1  0.5210006
#> 
#> $data
#> $data$lyr.1
#>  [1] 0.3874607 0.4369957 0.3373393 0.3983100 0.4998237 0.4155935 0.4924963
#>  [8] 0.1868466 0.5821908 0.4910261 0.4917692 0.6150751 0.6219876 0.6924040
#> [15] 0.5660698
#> 
#> $data$lyr.1
#>  [1] 0.3874607 0.4369957 0.5421774 0.3983100 0.4998237 0.4155935 0.4924963
#>  [8] 0.1868466 0.5821908 0.4910261 0.4062304 0.6150751 0.6219876 0.6924040
#> [15] 0.5660698
#> 
#> $data$lyr.1
#>  [1] 0.4327801 0.3874607 0.4369957 0.5421774 0.3983100 0.4998237 0.4524081
#>  [8] 0.4924963 0.1868466 0.5821908 0.4910261 0.4062304 0.6150751 0.6219876
#> [15] 0.2653878 0.5660698
#> 
#> $data$lyr.1
#>  [1] 0.4327801 0.5562058 0.4369957 0.5421774 0.3983100 0.4998237 0.4524081
#>  [8] 0.4924963 0.1868466 0.4468624 0.4910261 0.4062304 0.6150751 0.6219876
#> [15] 0.2653878
#> 
#> $data$lyr.1
#>  [1] 0.4327801 0.5562058 0.4369957 0.5421774 0.5836794 0.4998237 0.4524081
#>  [8] 0.4924963 0.1868466 0.4468624 0.4910261 0.4062304 0.4437255 0.6219876
#> [15] 0.2653878
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
