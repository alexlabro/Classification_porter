#' @name Files_from_bin
#' @import GENEAread

#' @details This function needs to be in a project where there is a folder named "Fichiers_bin", and it extracts those files.


Files_from_bin <- function() {
  BinPattern <- "*\\.[bB][iI][nN]$"
  files <- list.files(path = paste0(getwd(), "/Fichiers_bin"), pattern = BinPattern, full.names = TRUE)
  files
}