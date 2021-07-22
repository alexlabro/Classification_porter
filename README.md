# Classification_Porter
---
Classification de types de porter à partir de données d'accéléromètre

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#Prérequis et installation">Prérequis et installation</a>
    <li><a href="#Utilisation de la pipeline">Utilisation de la pipeline</a></li>
    <li><a href="#Utilisation future des modèles">Utilisation future des modèles</a></li>
  </ol>
</details>

## A propos du projet

Ce projet a pour objectif d'amener une nouvelle solution de banc de test pour la chronométrie et le remontage automatique, de rendre ce banc de test le plus réaliste possible en termes de porter, et de baser la qualification de ce banc de test sur une analyse statistique de porter à partir de données d'accéléromètre. Ce répertoire décrit la partie analyse statistique qui cherche à assurer que les mouvements robotiques simulés sont fidèles à des porters réels. Pour cela des classifieurs sont mis en place afin de reconnaitre les types de porter à partir de données d'accéléromètre.

---

## Prérequis et installation

Les programmes requis pour utiliser les codes de ce répertoire sont :

- R et Rstudio
- GENEActiv PC Software
- Packages et scripts R de ce répertoire

### Installation

Installation de R et Rstudio sur https://www.rstudio.com/products/rstudio/download/

Installation de GENEActiv PC Software sur https://www.activinsights.com/expertise/geneactiv/downloads-software/

Les packages s'installent directement depuis R, les scripts nécessaires sont dans le dossier Scripts_R du répertoire.

## Utilisation de la pipeline

### Importation des données
- Brancher l'accéléromètre GENEActiv au PC, lancer l'acquisition des données avec Measurement frequency = 75 Hz.
- Faire l'acquisition des données puis rebrancher l'accéléromètre au PC et extraire le fichier .bin ;
- Lorsque tous les fichiers .bin sont extraits et placés dans le folder Fichiers_bin, lancer Run all sur le R-markdown Creating_Preprocessing_csv ;
- Les fichiers sont importés 1 à 1, il faut être présent pour labelliser les données (1 fichier = 1 label);
- 7 fichiers .csv sont alors créés : un fichier comprenant les labels de tous les segments, 3 fichiers avec les accélérations corporelles selon les trois axes, 3 fichiers avec les accélérations dues à la gravité selon les trois axes. 

Chaque segment de 10 secondes comprend donc 750 x 6 points d'accélérations.

### Création du dataset
- Les fichiers .csv doivent être dans le folder Fichiers_csv
- Lancer Run all sur le R-markdown Creating_dataset_csv 
- Un dataset est créé dans le folder Dataset_csv, avec les features associées à chaque segment et son label.

### Création des modèles machine learning classiques
- Lancer Run all sur le R-markdown Test_Classifieur
- Les modèles intéressants sont enregistrés au format .rds dans le folder Models ;
- Le notebook montre l'extraction des features avec PCA et les résultats du training et de la validation selo0n 3 types d'algorithmes.

### Création du modèle Deep Learning
- Lancer Run all sur le R-markdown Classifieur_LSTM
- Le modèle deep learning est entrainé puis sauvegardé sous format .rds dans le folder Models;

#### Problèmes potentiels

De nombreux packages et variables sont chargées dans l'environnement, il est possible que des erreurs surviennent.
Dans ce cas il faut relancer le markdown actif. Si l'erreur persiste, il faut relancer toute la pipeline.

---

## Utilisation future des modèles

Un exemple d'utilisation est présent dans le markdown Classification_bras, qui utilise les modèles enregistrés pour classifier certains mouvement effectués par le bras robotisé.

Le modèle LSTM apprend directement sur les données brutes labellisées (ie après Creation_preprocessed_csv_bras) tandis que les modèles machine learning classiques prennent en entrée le dataset claculé avec les features (ie après Creation_features_bras).


## Auteur

