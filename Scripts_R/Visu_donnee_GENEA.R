
#' @name Visu_donnee_GENEA
#' @import GENEAread

Visu_donnee_GENEA <- function(df2) {
  #Norme des accélérations
  hist(df2$r, freq=FALSE, col=3, main="Histogramme de la norme des accélérations", xlab="Accélération")
  plot(df2$timestamp,df2$r,type="l")
  print(paste0("Moyenne de la norme des accélérations: ", mean(df2$r)))
  print(paste0("Ecart type de la norme des accélérations: ", sd(df2$r)))
  
  #Light
  
  #Axe X
  print(paste0("Moyenne de l'accélération selon x: ", mean(df2$x)))
  print(paste0("Ecart type de l'accélération selon x: ", sd(df2$x)))
  plot(df2$timestamp,df2$x,type="l")
  
  #Axe Y
  print(paste0("Moyenne de l'accélération selon y: ", mean(df2$y)))
  print(paste0("Ecart type de l'accélération selon y: ", sd(df2$y)))
  plot(df2$timestamp,df2$y,type="l")
  
  #Axe Z
  print(paste0("Moyenne de l'accélération selon z: ", mean(df2$z)))
  print(paste0("Ecart type de l'accélération selon z: ", sd(df2$z)))
  plot(df2$timestamp,df2$z,type="l")
  
  #Colatitude et longitude
  hist(df2$theta, freq=FALSE, col=4, main="Histogramme de l'angle theta", xlab="rad")
  plot(df2$timestamp,df2$theta,col=4,type='l')
  
  hist(df2$phi, freq=FALSE, col=10, main="Histogramme de l'angle phi", xlab="rad")
  plot(df2$timestamp,df2$phi,col=10)
  
  #Tracer le graphique de densité
  ggplot(data=df2)+
    geom_density2d(mapping=aes(x = phi,y=theta))
  
}