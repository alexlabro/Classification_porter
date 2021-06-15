
#' @name import_df_Genea
#' @import GENEAread

import_df_GENEA <- function(binfile) {
  acc_data <- read.bin(binfile)
  df <- data.frame(acc_data$data.out)
  df <- df[c("timestamp","x","y","z","light")]
  as_tibble(df)
}
