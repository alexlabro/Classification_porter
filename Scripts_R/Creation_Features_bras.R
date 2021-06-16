#' @name Creation_Features_bras
#' 
#Il faut avoir le dossier Fichiers_csv avec les 7 fichiers d'acceleration filtered


Creation_Features_bras <- function(){
  
  DataSet <- data.frame()
  
  #Importation des data
  Acc_total_x <- as_tibble(read.csv("Fichiers_csv_bras/Filtered_total_acc_x_bras.csv",header=FALSE))
  Acc_total_y <- as_tibble(read.csv("Fichiers_csv_bras/Filtered_total_acc_y_bras.csv",header=FALSE))
  Acc_total_z <- as_tibble(read.csv("Fichiers_csv_bras/Filtered_total_acc_z_bras.csv",header=FALSE))
  
  Acc_gravity_x <- as_tibble(read.csv("Fichiers_csv_bras/gravity_acc_x_bras.csv",header=FALSE))
  Acc_gravity_y <- as_tibble(read.csv("Fichiers_csv_bras/gravity_acc_y_bras.csv",header=FALSE))
  Acc_gravity_z <- as_tibble(read.csv("Fichiers_csv_bras/gravity_acc_z_bras.csv",header=FALSE))
  
  Labels <- as_tibble(read.csv("Fichiers_csv_bras/Labels_bras.csv",header=FALSE))
  
  Acc_Body_x <- Acc_total_x - Acc_gravity_x
  Acc_Body_y <- Acc_total_y - Acc_gravity_y
  Acc_Body_z <- Acc_total_z - Acc_gravity_z
  
  
  #Boucle pour chacun des segments
  N <- length(Acc_total_x$V1)
  
  print(paste0("---Creation d'un dataset avec ",N," entrées---"))
  
  for (k in 1:N){
    if(k%%260==0){
      prct <- 100*k/N
      print(paste0(prct," pourcents effectués..."))
    }
    #Extraction du segment
    t_Body_Acc_x <- as.numeric(as.vector(Acc_Body_x[k,]))
    t_Body_Acc_y <- as.numeric(as.vector(Acc_Body_y[k,]))
    t_Body_Acc_z <- as.numeric(as.vector(Acc_Body_z[k,]))
    
    t_Gravity_Acc_x <- as.numeric(as.vector(Acc_gravity_x[k,]))
    t_Gravity_Acc_y <- as.numeric(as.vector(Acc_gravity_y[k,]))
    t_Gravity_Acc_z <- as.numeric(as.vector(Acc_gravity_z[k,]))
    
    
    #First order approximation to get the Jerk from Acc
    sampling_rate <- 75 #75 Hz
    t_Body_Jerk_x <- c(0,diff(t_Body_Acc_x)*sampling_rate)
    t_Body_Jerk_y <- c(0,diff(t_Body_Acc_y)*sampling_rate)
    t_Body_Jerk_z <- c(0,diff(t_Body_Acc_x)*sampling_rate)
    
    
    #Magnitudes (Euclidian norm)
    t_Body_Acc_Mag <- sqrt(t_Body_Acc_x**2 + t_Body_Acc_y**2 +t_Body_Acc_y**2)
    t_Gravity_Acc_Mag <- sqrt(t_Gravity_Acc_x**2 + t_Gravity_Acc_y**2 + t_Gravity_Acc_y**2)
    t_Body_Jerk_Mag <- sqrt(t_Body_Jerk_x**2 + t_Body_Jerk_y**2 +t_Body_Jerk_y**2)
    
    
    #Fast Fourier Transforms
    duration <- 10 # durée du segment en s
    
    f_Body_Acc_x <- fft(t_Body_Acc_x)
    f_Body_Acc_x <- sqrt(Re(f_Body_Acc_x)**2 + Im(f_Body_Acc_x)**2)
    f_Body_Acc_x <- f_Body_Acc_x[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Acc_y <- fft(t_Body_Acc_y)
    f_Body_Acc_y <- sqrt(Re(f_Body_Acc_y)**2 + Im(f_Body_Acc_y)**2)
    f_Body_Acc_y <- f_Body_Acc_y[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Acc_z <- fft(t_Body_Acc_z)
    f_Body_Acc_z <- sqrt(Re(f_Body_Acc_z)**2 + Im(f_Body_Acc_z)**2)
    f_Body_Acc_z <- f_Body_Acc_z[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Jerk_x <- fft(t_Body_Jerk_x)
    f_Body_Jerk_x <- sqrt(Re(f_Body_Jerk_x)**2 + Im(f_Body_Jerk_x)**2)
    f_Body_Jerk_x <- f_Body_Jerk_x[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Jerk_y <- fft(t_Body_Jerk_y)
    f_Body_Jerk_y <- sqrt(Re(f_Body_Jerk_y)**2 + Im(f_Body_Jerk_y)**2)
    f_Body_Jerk_y <- f_Body_Jerk_y[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Jerk_z <- fft(t_Body_Jerk_z)
    f_Body_Jerk_z <- sqrt(Re(f_Body_Jerk_z)**2 + Im(f_Body_Jerk_z)**2)
    f_Body_Jerk_z <- f_Body_Jerk_z[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Acc_Mag <- fft(t_Body_Acc_Mag)
    f_Body_Acc_Mag <- sqrt(Re(f_Body_Acc_Mag)**2 + Im(f_Body_Acc_Mag)**2)
    f_Body_Acc_Mag <- f_Body_Acc_Mag[1:as.integer(sampling_rate*duration/2)]
    
    f_Body_Jerk_Mag <- fft(t_Body_Jerk_Mag)
    f_Body_Jerk_Mag <- sqrt(Re(f_Body_Jerk_Mag)**2 + Im(f_Body_Jerk_Mag)**2)
    f_Body_Jerk_Mag <- f_Body_Jerk_Mag[1:as.integer(sampling_rate*duration/2)]
    
    #Calcul des handcrafted features
    
    #Listes des signaux
    signaux_t <- list(t_Body_Acc_x,t_Body_Acc_y,t_Body_Acc_z,t_Gravity_Acc_x,t_Gravity_Acc_y,t_Gravity_Acc_z,t_Body_Jerk_x,t_Body_Jerk_y,t_Body_Jerk_z,t_Body_Acc_Mag,t_Gravity_Acc_Mag,t_Body_Jerk_Mag)
    signaux_f <- list(f_Body_Acc_x,f_Body_Acc_y,f_Body_Acc_z,f_Body_Jerk_x,f_Body_Jerk_y,f_Body_Jerk_z,f_Body_Acc_Mag,f_Body_Acc_Mag,f_Body_Jerk_Mag)
    signaux_tout <- list(t_Body_Acc_x,t_Body_Acc_y,t_Body_Acc_z,t_Gravity_Acc_x,t_Gravity_Acc_y,t_Gravity_Acc_z,t_Body_Jerk_x,t_Body_Jerk_y,t_Body_Jerk_z,t_Body_Acc_Mag,t_Gravity_Acc_Mag,t_Body_Jerk_Mag,f_Body_Acc_x,f_Body_Acc_y,f_Body_Acc_z,f_Body_Jerk_x,f_Body_Jerk_y,f_Body_Jerk_z,f_Body_Acc_Mag,f_Body_Acc_Mag,f_Body_Jerk_Mag)
    signaux_3D <- list(c(t_Body_Acc_x,t_Body_Acc_y,t_Body_Acc_z),c(t_Body_Jerk_x,t_Body_Jerk_y,t_Body_Jerk_z))
    
    
    #Dataframe des entries
    
    #List/dictionnaire des fonctions à évaluer
    
    prop_single_signal <- list(mean,sd,mad,max,min,IQR_maison,entropy) #ar.burg enlevé
    
    prop_freq_signal <- list(which.max,meanFreq,skewness,kurtosis)
    
    prop_signal_3D <- list(sma,mean_square)
    
    prop_2signaux <- list(cor)
    
    #### Dataframe des features : beaucoup de boucles for...
    
    #Deux fois la boucle pour pouvoir utiliser une liste
    
    #Determination du nombre de feature
    nb_features <- 0
    
    for (func in prop_single_signal){
      for (wave in signaux_tout){
        nb_features <- nb_features + 1
      }
    }
    for (func in prop_freq_signal){
      for (wave in signaux_f){
        nb_features <- nb_features + 1
      }
    }
    
    for (func in prop_signal_3D){
      for (sig_3D in signaux_3D){
        wave_x <- sig_3D[1]
        wave_y <- sig_3D[2]
        wave_z <- sig_3D[3]
        nb_features <- nb_features + 1
      }
    }
    
    for (func in prop_2signaux){
      for (wave in signaux_t){
        for (wave in signaux_t){
          nb_features <- nb_features + 1
        }
      }
      for (wave in signaux_f){
        for (wave in signaux_f){
          nb_features <- nb_features + 1
        }
      }
    }
    
    
    #Calcul du vecteur des entrées
    entries <- rep(0,nb_features)
    count <- 1
    
    
    for (func in prop_single_signal){
      for (wave in signaux_tout){
        res <- func(wave)
        if(length(res)==0){
          res <- 0
        }
        entries[count] <- res
        count <- count + 1
      }
    }
    for (func in prop_freq_signal){
      for (wave in signaux_f){
        res <- func(wave)
        if(length(res)==0){
          res <- 0
        }        
        entries[count] <- res
        count <- count + 1
      }
    }
    
    for (func in prop_signal_3D){
      for (sig_3D in signaux_3D){
        wave_x <- as.double(sig_3D[1])
        wave_y <- as.double(sig_3D[2])
        wave_z <- as.double(sig_3D[3])
        entries[count] <- func(wave_x,wave_y,wave_z)
        count <- count + 1
      }
    }
    
    for (func in prop_2signaux){
      for (wave1 in signaux_t){
        for (wave2 in signaux_t){
          entries[count] <- func(wave1,wave2)
          count <- count + 1
        }
      }
      for (wave in signaux_f){
        for (wave in signaux_f){
          entries[count] <- func(wave1,wave2)
          count <- count + 1
        }
      }
    }
    row_sup <- as.data.frame(c(Labels[k,1],t(entries)))
    names(row_sup) <- names(DataSet)
    DataSet <- rbind(DataSet,row_sup)
  }
  #Fin de la boucle sur les segments
  
  #Ecriture du csv Dataset
  write.table(DataSet, file="Fichiers_csv_bras/Dataset_total_features_bras.csv", row.names=FALSE, col.names=FALSE, sep=",")
  
  print("---Dataset_bras créé avec succès---")
}