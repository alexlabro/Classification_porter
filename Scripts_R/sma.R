#' @name Signal Magnitude Area
#' 

sma <- function(wave_x,wave_y,wave_z, sampling_rate=75){
  res <- (sum(sqrt(wave_x**2)) + sum(sqrt(wave_y**2)) +sum(sqrt(wave_z**2)))/sampling_rate
  return(res)
}