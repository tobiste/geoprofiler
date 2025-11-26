# Distance Between Points

This uses the **haversine** formula (by default) to calculate the
great-circle distance between two points, i.e., the shortest distance
over the earth's surface.

## Usage

``` r
point_distance(a, b, ...)
```

## Arguments

- a:

  lon, lat coordinate of point 1

- b:

  lon, lat coordinate of point 2

- ...:

  parameters passed to
  [`tectonicr::dist_greatcircle()`](https://tobiste.github.io/tectonicr/reference/dist_greatcircle.html)

## Value

units object giving the distance

## Examples

``` r
berlin <- c(13.4, 52.517) # lon, lat
tokyo <- c(139.767, 35.7) # lon, lat
point_distance(berlin, tokyo)
#> 247.4037 [km]
```
