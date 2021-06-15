
#' @name Coord_spher_GENEA
#' @import GENEAread

Coord_spher_GENEA <- function(df) {
  df2 <- as_tibble(
    mutate(df,
           r=sqrt(x^2+y^2+z^2),
           phi = atan2(y,x),
           theta = acos(z/r),
    )
  )
  df2
}