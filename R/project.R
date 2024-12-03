#' Project points on cross section
#'
#' Project points on a cross section given by a starting point and the direction
#'
#' @param x `'sf'` object
#' @param p1 `'sf'` object of profile starting point
#' @param azi direction emanating from starting point
#'
#' @returns `"tibble"`. `X` is the distance along the profile line.
#' `Y` is the distance from the profile line. (unit of `X` and `Y` depends on `crs(x)`).
#'
#' @importFrom sf st_transform st_coordinates st_crs st_as_sf
#' @importFrom dplyr mutate
#' @importFrom tectonicr deg2rad
#' @importFrom structr vrotate
#'
#' @export
#'
#' @examples
#' data(locations_example)
#' p1 <- data.frame(lon = -90.8, lat = 48.6, z = 1) |> sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
#' project_on_line(locations_example, p1, azi = 135)
project_on_line <- function(x, p1, azi) {
  x2 <- x |>
    st_transform(crs = "WGS84") |>
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

  p <- p1 |>
    st_transform(crs = "WGS84") |>
    st_coordinates() |>
    as_tibble()

  p1_coords <- p1 |>
    st_transform(crs = st_crs(x)) |>
    st_coordinates()

  rot <- matrix(nrow = 1, ncol = 3)
  p1r <- 1
  rot[, 1] <- p1r * tectonicr:::cosd(p$Y) * tectonicr:::cosd(p$X)
  rot[, 2] <- p1r * tectonicr:::cosd(p$Y) * tectonicr:::sind(p$X)
  rot[, 3] <- p1r * tectonicr:::sind(p$Y)


  n <- structr::vrotate(vec, rot, deg2rad(azi + 90 + 180))
  r <- sqrt(n[, 1]^2 + n[, 2]^2 + n[, 3]^2)
  lat2 <- tectonicr:::asind(n[, 3] / r) # lat
  lon2 <- tectonicr:::atan2d(n[, 2], n[, 1])

  res <- tibble(
    X = lon2, Y = lat2
  ) |>
    st_as_sf(coords = c("X", "Y"), crs = "WGS84", na.fail = FALSE, remove = FALSE) |>
    st_transform(crs = sf::st_crs(x)) |>
    st_coordinates() |>
    as_tibble()

  xmin <- min(res$X, na.rm = TRUE)

  res |> mutate(
    X = X - xmin,
    Y = Y - p1_coords[1, 2]
  )
}
