% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/profile_points.R
\name{profile_line}
\alias{profile_line}
\title{Combine Points to a Line}
\usage{
profile_line(x)
}
\arguments{
\item{x}{\code{sf} point object}
}
\value{
\code{sf} line object
}
\description{
Combine Points to a Line
}
\examples{
p1 <- data.frame(lon = -90.8, lat = 48.6) |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
profile_points(p1,
  profile.azimuth = 135, profile.length = 10000,
  crs = sf::st_crs("EPSG:26915")
) |>
  profile_line()
}
\seealso{
\code{\link[=profile_points]{profile_points()}}
}
