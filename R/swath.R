#' Swath Profile
#'
#' Calculate swath-profile values perpendicular to a straight baseline.
#' The distance between samples and the number of samples can be
#' specified, see arguments \code{k} and \code{dist}. Values of the swath-profile are
#' extracted from a given raster file, see argument \code{raster}. CRS of raster
#' and points have to be the same.
#'
#' @param profile either a `sf` object or a matrix(ncol=2, nrow=2) with x and
#' y coordinates of beginning and end point of the baseline; each point in one row
#' \describe{
#'   \item{column 1}{x coordinates}
#'   \item{column 2}{y coordinates}
#' }
#' @param raster Raster file (loaded with [terra::rast()])
#' @param k integer. number of lines on each side of the baseline
#' @param dist numeric. distance between lines
#' @param crs character. coordinate reference system. Uses the CRS of `raster`
#' by default and transforms the profile into this coordinate system.
#' @param method character. method for extraction of raw data, see
#' [terra::extract()]: default value: "bilinear"
#'
#' @returns list.
#' \describe{
#'  \item{`swath`}{matrix. Statistics of the raster measured along the lines}
#'  \item{`data`}{list of numeric vector containing the data extracted from the raster along each line}
#'  \item{`lines`}{list of of the lines as SpatVectors}
#'  }
#'
#' @importFrom sf st_crs st_transform st_point st_set_crs st_linestring
#' @importFrom terra extract vect ymin xmin as.lines
#'
#' @source The algorithm is a modified version of "swathR"
#' by Vincent Haburaj (https://github.com/jjvhab/swathR).
#'
#' @export
#'
#' @seealso [swath_profile()]
#'
#' @examples
#' # Create a random raster
#' r <- terra::rast(ncol = 10, nrow = 10, xmin = -150, xmax = -80, ymin = 20, ymax = 60, crs = "WGS84")
#' values(r) <- runif(terra::ncell(r))
#'
#' # Create a random profile
#' profile <- data.frame(lon = c(-140, -90), lat = c(55, 25)) |>
#'   sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
#' swath_extract(profile, r, k = 2, dist = 1)
swath_extract <- function(profile, raster, k = 1, dist, crs = terra::crs(raster), method = c("bilinear", "simple")) {
  method <- match.arg(method)
  raster <- terra::project(raster, crs)

  if (inherits(profile, "sf") & all(sf::st_geometry_type(profile) == "LINESTRING")) {
    profile <- line_ends(profile)
  }

  # create SpatialPoints from coords:
  if (!inherits(profile, "sf") & is.matrix(profile)) {
    profile <- sf::st_point(profile) |> sf::st_set_crs(crs)
  }
  coords_mat <- sf::st_coordinates(profile)

  spt <- sf::st_transform(profile, crs = sf::st_crs(crs)) |> terra::vect()

  # get slope of baseline:
  m <- (terra::ymin(spt[1]) - terra::ymin(spt[2])) / (terra::xmin(spt[1]) - terra::xmin(spt[2]))
  # get slope of normal function:
  m1 <- -(1 / m)
  # get slope-angle from slope:
  alpha <- atan(m)
  alpha1 <- atan(m1)
  # get deltax and deltay from Pythagoras:
  if ((alpha * 180) / pi < 90 & (alpha * 180) / pi > 270) {
    deltax <- cos(alpha1) * dist
  } else {
    deltax <- cos(alpha1) * dist * -1
  }
  if ((alpha * 180) / pi > 0 & (alpha * 180) / pi < 180) {
    deltay <- sqrt(dist**2 - deltax**2)
  } else {
    deltay <- sqrt(dist**2 - deltax**2) * -1
  }
  # create empty matrix:
  swath <- matrix(nrow = k * 2 + 1, ncol = 8)
  colnames(swath) <- c(
    "distance", "mean", "median",
    "std.dev.", "min", "max", "quantile(25)", "quantile(75)"
  )
  # list for spatial lines:
  allLines <- list()
  # add baseline:
  allLines[[k + 1]] <- terra::vect(profile) |> terra::as.lines()
  # set distance for baseline:
  swath[k + 1, 1] <- 0
  # generate k lines parallel to baseline:
  for (n in 1:k) {
    # BELOW BASELINE:
    # new points
    cn <- matrix(nrow = 2, ncol = 2)
    cn[1, ] <- cbind(coords_mat[1, 1] - (deltax * n), coords_mat[1, 2] - (deltay * n))
    cn[2, ] <- cbind(coords_mat[2, 1] - (deltax * n), coords_mat[2, 2] - (deltay * n))
    # line between points:
    allLines[[k + 1 - n]] <- terra::vect(cn, crs = crs) |> terra::as.lines()

    # distance value:
    swath[k + 1 - n, 1] <- -1 * n * dist
    # ABOVE BASELINE:
    # new points
    cn <- matrix(nrow = 2, ncol = 2)
    cn[1, ] <- cbind(coords_mat[1, 1] + (deltax * n), coords_mat[1, 2] + (deltay * n))
    cn[2, ] <- cbind(coords_mat[2, 1] + (deltax * n), coords_mat[2, 2] + (deltay * n))
    # line between points:
    allLines[[k + n + 1]] <- terra::vect(cn, crs = crs) |> terra::as.lines()
    # distance value:
    swath[k + n + 1, 1] <- n * dist
  }

  # Expand raster to make sure all lines fall into the extent of the raster
  lines_extent <- terra::vect(allLines) |> terra::ext()
  raster_expanded <- terra::extend(raster, lines_extent)

  # get raw data:
  raw.data <- sapply(allLines, FUN = function(x) {
    terra::extract(raster_expanded, x, method = method, ID = FALSE)
  })

  # generalise data:
  swath[, 2] <- sapply(raw.data, function(x) {
    mean(x, na.rm = T)
  })
  swath[, 3] <- sapply(raw.data, function(x) {
    median(x, na.rm = T)
  })
  swath[, 4] <- sapply(raw.data, function(x) {
    sd(x, na.rm = T)
  })
  swath[, 5] <- sapply(raw.data, function(x) {
    min(x, na.rm = T)
  })
  swath[, 6] <- sapply(raw.data, function(x) {
    max(x, na.rm = T)
  })
  swath[, 7] <- sapply(raw.data, function(x) {
    quantile(x, na.rm = T)[2]
  })
  swath[, 8] <- sapply(raw.data, function(x) {
    quantile(x, na.rm = T)[4]
  })

  list(swath = swath, data = raw.data, lines = allLines)
}



#' Elevation profile
#'
#' Statistics of the elevation data across a swath profile.
#'
#' @param x list. The return object of [swath_extract()]
#' @param profile.length numeric or `units` object. If `NULL` the fractional
#' distance is returned, i.e. 0 at start and 1 at the end of the profile.
#' @return tibble
#' @importFrom dplyr c_across rowwise ungroup mutate tibble as_tibble everything matches select starts_with rename
#' @export
#' @examples
#' # Create a radnom raster
#' r <- terra::rast(ncol = 10, nrow = 10, xmin = -150, xmax = -80, ymin = 20, ymax = 60)
#' values(r) <- runif(terra::ncell(r))
#'
#' # Create a random profile
#' profile <- data.frame(lon = c(-140, -90), lat = c(55, 25)) |>
#'   sf::st_as_sf(coords = c("lon", "lat"), crs = "WGS84")
#' swath <- swath_extract(profile, r, k = 5, dist = 10)
#'
#' swath_profile(swath, profile.length = profile_length(profile_line(profile)))
swath_profile <- function(x, profile.length = NULL) {
  if (is.null(profile.length)) profile.length <- 1
  center <- paste0("X", as.character(median(seq_along(x$data))))

  max_length <- max(sapply(x$data, length))

  padded_vectors <- lapply(x$data, function(x) {
    length(x) <- max_length
    return(x)
  })

  # Combine the padded vectors into a matrix
  elevs <- do.call(cbind, padded_vectors)
  colnames(elevs) <- as.character(seq_along(x$data))

  data.frame(elevs) |>
    rowwise() |>
    mutate(
      min = min(c_across(everything()), na.rm = TRUE),
      mean = mean(c_across(everything()), na.rm = TRUE),
      sd = sd(c_across(everything()), na.rm = TRUE),
      quantile25 = quantile(c_across(everything()), na.rm = TRUE)[2],
      median = median(c_across(everything()), na.rm = TRUE),
      quantile75 = quantile(c_across(everything()), na.rm = TRUE)[4],
      max = max(c_across(everything()), na.rm = TRUE)
    ) |>
    ungroup() |>
    mutate(
      "distance" = ((seq_along(elevs[, 1]) - 1) / (length(elevs[, 1]) - 1)) * profile.length,
    ) |>
    rename("elevation" = matches(center)) |>
    select(distance, everything(), -starts_with("X"))
}
