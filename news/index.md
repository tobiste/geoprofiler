# Changelog

## geoprofiler (development version)

## geoprofiler 0.0.4 *2026-08-28*

CRAN release: 2026-08-28

- [`profile_line()`](https://tobiste.github.io/geoprofiler/reference/profile_line.md)
  returns LINESTRING for a set of points

- [`profile_line()`](https://tobiste.github.io/geoprofiler/reference/profile_line.md)
  now can interpolate a profile line when the input has more than 2
  points.

- [`geoprofiler()`](https://tobiste.github.io/geoprofiler/reference/profile-coords.md)
  supersedes
  [`profile_coords()`](https://tobiste.github.io/geoprofiler/reference/profile-coords.md)
  as it sounds more intuitive and is the main function of the package.

## geoprofiler 0.0.3 *2025-12-11*

CRAN release: 2025-12-11

- optimized
  [`swath_profile()`](https://tobiste.github.io/geoprofiler/reference/swath_profile.md)
  and
  [`swath_stats()`](https://tobiste.github.io/geoprofiler/reference/swath_stats.md).
  They are way faster now!
