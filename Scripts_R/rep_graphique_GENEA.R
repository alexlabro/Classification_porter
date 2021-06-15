
#' @name rep_graphique_GENEA
#' @import GENEAread
#' @import rgl

rep_graphique_GENEA <- function(df2) {
  a <- sin(df2$theta)*cos(df2$phi)
  b <-sin(df2$theta)*sin(df2$phi)
  c <- cos(df2$theta)
  
  #On crée la "carte" en superposant deux sphères l'une au dessus de l'autre.
  spheres3d(0,0,0,lit=FALSE,color="white")
  spheres3d(0,0,0,radius=1.01,lit=FALSE,color="black",front="lines")
  spheres3d(0,0,1,radius=0.05,col="blue")
  spheres3d(0,0,-1,radius=0.05,col="red")
  spheres3d(0,1,0,radius=0.05,col="yellow")
  spheres3d(0,-1,0,radius=0.05,col="orange")
  
  
  
  #On crée un sphère pour chaque qccélération
  rgl.spheres(a,b,c,col="green",radius=0.02)
}