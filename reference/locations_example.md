# Example `sf` data set

example dataset

## Usage

``` r
data('locations_example')
```

## Format

An object of class `sf`

## Examples

``` r
data("locations_example")
head(locations_example)
#> Simple feature collection with 6 features and 1 field
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -90.72175 ymin: 48.53417 xmax: -90.55858 ymax: 48.60387
#> Geodetic CRS:  NAD83
#>        value                   geometry
#> 1 0.28888987 POINT (-90.55858 48.60387)
#> 2 0.36566163 POINT (-90.69225 48.54615)
#> 3 0.70947389 POINT (-90.72175 48.53417)
#> 4 0.76371036 POINT (-90.71652 48.53504)
#> 5 0.05750697 POINT (-90.71959 48.53431)
#> 6 0.31801622 POINT (-90.70994 48.54514)
```
