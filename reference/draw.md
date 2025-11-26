# Draw a profile line or a point to retrieve coordinates

Opens a plot window showing the the map with the data, where the user
can click profile coordinates.

## Usage

``` r
get_coordinates(x, n = 1, type = "o", col = "#B63679FF", ...)

draw_profile(x, n = 10, ...)
```

## Arguments

- x:

  `sf` object

- n:

  the maximum number of points to locate. Valid values start at 1.

- type:

  One of `"n"`, `"p"`, `"l"` or `"o"`. If `"p"` or `"o"` the points are
  plotted; if `"l"` or `"o"` they are joined by lines.

- col:

  color of line or point

- ...:

  additional graphics parameters used if `type != "n"` for plotting the
  locations.

## Value

`sf` object of the profile.
