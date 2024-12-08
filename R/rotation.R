# Helper functions used from {structr} package

vlength <- function(x) {
  sqrt(x[, 1]^2 + x[, 2]^2 + x[, 3]^2)
}

vnorm <- function(x) {
  x / vlength(x)
}

vec2mat <- function(x) {
  if (is.null(dim(x))) {
    m <- as.matrix(t(x))
  } else {
    m <- as.matrix(x)
  }
  m
}

vcross <- function(x, y) {
  xxy <- cbind(
    x = x[, 2] * y[, 3] - x[, 3] * y[, 2],
    y = x[, 3] * y[, 1] - x[, 1] * y[, 3],
    z = x[, 1] * y[, 2] - x[, 2] * y[, 1]
  )
}

vrotate <- function(x, rotaxis, rotangle) {
  rotaxis <- vnorm(rotaxis)

  vax <- vcross(rotaxis, x)
  xrot <- x + vax * sin(rotangle) + vcross(rotaxis, vax) * 2 * (sin(rotangle / 2))^2 # Helmut

  colnames(xrot) <- c("x", "y", "z")
  xrot
}
