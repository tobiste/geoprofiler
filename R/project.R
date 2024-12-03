#' Project points on cross section
#'
#' Project points on a cross section given by a starting point and the direction
#'
#' @param x `'sf'` object
#' @param start `'sf'` object of profile starting point
#' @param azi numeric. Direction (in degrees) emanating from starting point.
#' @param drop.units logical. Whether the return should show the units or not.
#'
#' @returns `"tibble"`. `X` is the distance along the profile line.
#' `Y` is the distance from the profile line. (units of `X` and `Y` depend on
#' coordinate reference system).
#'
#' @importFrom sf st_transform st_coordinates st_crs st_as_sf st_is_longlat
#' @importFrom dplyr mutate mutate_all as_tibble tibble
#' @importFrom tectonicr deg2rad rad2deg
#' @importFrom structr vrotate
#' @importFrom units set_units drop_units
#'
#' @export
#'
#' @examples
#' data(locations_example)
#' p1 <- data.frame(lon = -90.8, lat = 48.6, z = 1) |> sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
#' projected <- project_on_line(locations_example, start = p1, azimuth = 135)
#' plot(projected)
project_on_line <- function(x, start, azimuth, drop.units = TRUE) {
  x2 <- st_transform(x, crs = "WGS84") |>
    st_coordinates() |>
    as_tibble() |>
    mutate(
      lon_rad = deg2rad(X),
      lat_rad = deg2rad(Y),
      R = 1
    )

  vec <- matrix(nrow = length(x2$X), ncol = 3)
  vec[, 1] <- x2$R * cos(x2$lat_rad) * cos(x2$lon_rad)
  vec[, 2] <- x2$R * cos(x2$lat_rad) * sin(x2$lon_rad)
  vec[, 3] <- x2$R * sin(x2$lat_rad)

  p <- start |>
    st_transform(crs = "WGS84") |>
    st_coordinates() |>
    as_tibble() |>
    mutate_all(deg2rad)

  p1_coords <- start |>
    st_transform(crs = st_crs(x)) |>
    st_coordinates()

  rot <- matrix(nrow = 1, ncol = 3)
  p1r <- 1
  rot[, 1] <- p1r * cos(p$Y) * cos(p$X)
  rot[, 2] <- p1r * cos(p$Y) * sin(p$X)
  rot[, 3] <- p1r * sin(p$Y)

  if (inherits(azimuth, "units")) {
    azimuth <- set_units(azimuth, "degree") |>
      drop_units()
  }

  n <- structr::vrotate(vec, rotaxis = rot, rotangle = deg2rad(azimuth + 90 + 180))
  r <- sqrt(n[, 1]^2 + n[, 2]^2 + n[, 3]^2)
  lat2 <- asin(n[, 3] / r) # lat
  lon2 <- atan2(n[, 2], n[, 1])

  res <- tibble(
    X = lon2, Y = lat2
  ) |>
    mutate_all(rad2deg) |>
    st_as_sf(coords = c("X", "Y"), crs = "WGS84", na.fail = FALSE, remove = FALSE) |>
    st_transform(crs = st_crs(x)) |>
    st_coordinates() |>
    as_tibble()

  xmin <- min(res$X, na.rm = TRUE)

  res2 <- mutate(res,
    X = X - xmin,
    Y = Y - p1_coords[1, 2]
  )
  if (st_is_longlat(x)) {
    res3 <- mutate(res2, X = ifelse(X > 180, 360 - X, X)) |>
      mutate_all(set_units, value = "degree")
  } else {
    res3 <- mutate_all(res2, set_units, value = "m")
  }
  if(drop.units){
    mutate_all(res3, drop_units)
  } else {
    res3
  }
}
