# datatoolboxexos 2021

Ce dépôt contient les données nécessaires à la réalisation des exercices de la formation « Bonnes pratiques pour une recherche reproductible en écologie numérique » - [:octocat:](https://github.com/FRBCesab/datatoolbox).


<br />

### Description des données

<br />

- **WWF Wildfinder** [:globe_with_meridians:](https://www.worldwildlife.org/pages/wildfinder-database)

La base de données WildFinder du WWF contient des données de présence/absence pour les amphibiens, reptiles, oiseaux et mammifères terrestres du monde entier au niveau des écorégions terrestres. Seul le sous-ensemble des mammifères est disponible dans ce dépôt avec 4936 espèces. Les données, préalablement nettoyées, sont structurées de la manière suivante dans le dossier `data/wwf-wildfinder/` :

  - `wildfinder-mammals_list.csv` : liste taxonomique des 4936 espèces de mammifères du monde entier
  - `wildfinder-ecoregions_list.csv` : liste des 798 écorégions terrestres définies par le WWF
  - `wildfinder-ecoregions_species.csv` : correspondances entre les espèces et les écorégions

A ces données s'ajoute la couche vectorielle permettant de cartographier ces écorégions terrestres (répertoire `data/wwf-ecoregions-layers/`).

<br />

- **PanTHERIA** [:globe_with_meridians:](https://esajournals.onlinelibrary.wiley.com/doi/10.1890/08-1494.1)

La base de données PanTHERIA recense un très grand nombre de traits d'histoire de vie, traits écologiques et géographiques pour les espèces de mammifères du monde entier.
Le fichier texte contenant cette base de données se trouve dans `data/pantheria-traits/PanTHERIA_1-0_WR05_Aug2008.txt`

**N.B.** De nombreuses données sont manquantes et sont notées `-999`.



### Ressources

:octocat: [Dépôt de la formation](https://github.com/FRBCesab/datatoolbox)
