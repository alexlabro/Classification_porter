#' @name Mean_Square
#' 

mean_square <- function(wave_x, wave_y, wave_z){
  res <- mean(wave_x**2) + mean(wave_y**2) + mean(wave_z**2)
}