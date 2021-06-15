#' @name IQR_maison
#' @import spectrum
#' @import signal
#' 

IQR_maison <- function(wave){
  return(IQR(wave,na.rm = TRUE))
}