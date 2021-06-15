#' @name Creation_Preprocessed_csv
#' Apply on fft magnitude signal

meanFreq <- function(fft_wave,sampling_rate=75,duration=10){
  N <- sampling_rate*duration
  res <- 0
  q <- as.integer(N/2)-1
  for (i in 1:q){
    res <- res + i*(N/2)*sampling_rate*fft_wave[i]
  }
  res <- res/sum(fft_wave)
  
  return(res)
}