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
#>       distance      mean    median         sd       min       max quantile25
#> lyr.1       -2 0.5753769 0.5334707 0.13374968 0.3404439 0.8128922  0.5059782
#> lyr.1       -1 0.5858479 0.5944543 0.13195738 0.3404439 0.8128922  0.5128061
#> lyr.1        0 0.5635845 0.5479863 0.12693203 0.3404439 0.8128922  0.4932966
#> lyr.1        1 0.5587202 0.5628497 0.09400815 0.3942108 0.7455875  0.5008554
#> lyr.1        2 0.5808190 0.5881592 0.10697175 0.3942108 0.7455875  0.5008554
#>       quantile75
#> lyr.1  0.6835217
#> lyr.1  0.6835217
#> lyr.1  0.6149577
#> lyr.1  0.5994903
#> lyr.1  0.6493043
#> 
#> $data
#> $data$lyr.1
#>  [1] 0.3404439 0.3942108 0.5084438 0.5628497 0.7272036 0.4741889 0.5331228
#>  [8] 0.7455875 0.8128922 0.6055835 0.5334707 0.5220996 0.5035126 0.7239631
#> [15] 0.6430803
#> 
#> $data$lyr.1
#>  [1] 0.3404439 0.3942108 0.5944543 0.5628497 0.7272036 0.4741889 0.5331228
#>  [8] 0.7455875 0.8128922 0.6055835 0.6045263 0.5220996 0.5035126 0.7239631
#> [15] 0.6430803
#> 
#> $data$lyr.1
#>  [1] 0.4981982 0.3404439 0.3942108 0.5944543 0.5628497 0.7272036 0.4509949
#>  [8] 0.5331228 0.7455875 0.8128922 0.6055835 0.6045263 0.5220996 0.5035126
#> [15] 0.4785917 0.6430803
#> 
#> $data$lyr.1
#>  [1] 0.4981982 0.5717082 0.3942108 0.5944543 0.5628497 0.7272036 0.4509949
#>  [8] 0.5331228 0.7455875 0.5881592 0.6055835 0.6045263 0.5220996 0.5035126
#> [15] 0.4785917
#> 
#> $data$lyr.1
#>  [1] 0.4981982 0.5717082 0.3942108 0.5944543 0.6930251 0.7272036 0.4509949
#>  [8] 0.5331228 0.7455875 0.5881592 0.6055835 0.6045263 0.7234066 0.5035126
#> [15] 0.4785917
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
