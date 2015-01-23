<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rglobi vignette}
-->

rglobi vignette - an R interface to the aggregated biotic interaction data of GloBI (http://globalbioticinteractions.org)
======

### About the package

`rglobi` allows easy access to the GLoBI database by wrapping the existing API.  

********************

### Quick start

#### First, install `rglobi`



```r
install.packages("devtools")
```

```
## Installing package into '/Volumes/Data/Users/unencrypted/jorrit/Library/R/3.0/library'
## (as 'lib' is unspecified)
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/v4/0_y78_xj1x7b72l89cwc2kq80000gp/T//RtmptgaLYk/downloaded_packages
```

```r
devtools::install_github("rglobi", "ropensci")
```

```
## Warning: Username parameter is deprecated. Please use ropensci/rglobi
```

```
## Downloading github repo ropensci/rglobi@master
## Installing rglobi
## '/Library/Frameworks/R.framework/Resources/bin/R' --vanilla CMD INSTALL  \
##   '/private/var/folders/v4/0_y78_xj1x7b72l89cwc2kq80000gp/T/RtmptgaLYk/devtools1fd744d4751b/ropensci-rglobi-7ec6694'  \
##   --library='/Volumes/Data/Users/unencrypted/jorrit/Library/R/3.0/library'  \
##   --install-tests 
## 
## Reloading installed rglobi
```


```r
library("rglobi")
```

Note that since rglobi is still pretty new, only the dev version of the library is available at this time. We hope to publish a version to CRAN once the library matures. For more information see [GitHub](https://github.com/ropensci/rglobi).

#### Find interactions involving a certain species

Determining which species interact with each other (and how and where) is a major focus of ecology.  The Global Biotic Interactions Database offers data on multiple interaction types, and the `rglobi` library offers several ways to specify and access these interactions. `get_interactions()` is the primary function used if data on a specific interaction type is required.  A focus taxon is entered (may be specified as "Genus species" or higher level (e.g., Genus, Family, Class)).


```r
hsapiens <- get_interactions(taxon = "Homo sapiens", interaction.type = "preysOn")
head(hsapiens)
```

```
##   source_taxon_external_id source_taxon_name
## 1               EOL:327955      Homo sapiens
## 2               EOL:327955      Homo sapiens
## 3               EOL:327955      Homo sapiens
## 4               EOL:327955      Homo sapiens
## 5               EOL:327955      Homo sapiens
## 6               EOL:327955      Homo sapiens
##                                                                                                                                                                                                           source_taxon_path
## 1 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 2 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 3 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 4 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 6 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
##   source_specimen_life_stage interaction_type target_taxon_external_id
## 1                         NA          preysOn               EOL:328048
## 2                         NA          preysOn               EOL:328716
## 3                         NA          preysOn                 EOL:1666
## 4                         NA          preysOn               EOL:326518
## 5                         NA          preysOn              EOL:4453589
## 6                         NA          preysOn              EOL:2815988
##                   target_taxon_name
## 1                 Nandinia binotata
## 2             Cephalophus monticola
## 3                           Manidae
## 4               Atherurus africanus
## 5 Cercopithecus nictitans nictitans
## 6                         Serpentes
##                                                                                                                                                                                                                                                                                                      target_taxon_path
## 1                                                                                                                                                                                                                              Animalia | Chordata | Mammalia | Carnivora | Nandiniidae | Nandinia | Nandinia binotata
## 2                                                                                                                                                                                                                        Animalia | Chordata | Mammalia | Artiodactyla | Bovidae | Cephalophus | Cephalophus monticola
## 3                                                                                                                                                                                                                                                                 Animalia | Chordata | Mammalia | Pholidota | Manidae
## 4                                                                                                                                                                                                                            Animalia | Chordata | Mammalia | Rodentia | Hystricidae | Atherurus | Atherurus africanus
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Cercopithecoidea | Cercopithecidae | Cercopithecinae | Cercopithecini | Cercopithecus | Cercopithecus nictitans | Cercopithecus nictitans nictitans
## 6                                                                                                                                                                                           Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Reptilia | Squamata | Serpentes
##   target_specimen_life_stage latitude longitude study_title
## 1                         NA       NA        NA          NA
## 2                         NA       NA        NA          NA
## 3                         NA       NA        NA          NA
## 4                         NA       NA        NA          NA
## 5                         NA       NA        NA          NA
## 6                         NA       NA        NA          NA
```

`get_predators_of()` and `get_prey_of()` are wrappers for `get_interactions()` that remove the need to specify interaction type


```r
hsapiens <- get_prey_of("Homo sapiens")
head(hsapiens)
```

```
##   source_taxon_external_id source_taxon_name
## 1               EOL:327955      Homo sapiens
## 2               EOL:327955      Homo sapiens
## 3               EOL:327955      Homo sapiens
## 4               EOL:327955      Homo sapiens
## 5               EOL:327955      Homo sapiens
## 6               EOL:327955      Homo sapiens
##                                                                                                                                                                                                           source_taxon_path
## 1 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 2 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 3 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 4 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
## 6 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Hominoidea | Hominidae | Homininae | Homo | Homo sapiens
##   source_specimen_life_stage interaction_type target_taxon_external_id
## 1                         NA          preysOn               EOL:328048
## 2                         NA          preysOn               EOL:328716
## 3                         NA          preysOn                 EOL:1666
## 4                         NA          preysOn               EOL:326518
## 5                         NA          preysOn              EOL:4453589
## 6                         NA          preysOn              EOL:2815988
##                   target_taxon_name
## 1                 Nandinia binotata
## 2             Cephalophus monticola
## 3                           Manidae
## 4               Atherurus africanus
## 5 Cercopithecus nictitans nictitans
## 6                         Serpentes
##                                                                                                                                                                                                                                                                                                      target_taxon_path
## 1                                                                                                                                                                                                                              Animalia | Chordata | Mammalia | Carnivora | Nandiniidae | Nandinia | Nandinia binotata
## 2                                                                                                                                                                                                                        Animalia | Chordata | Mammalia | Artiodactyla | Bovidae | Cephalophus | Cephalophus monticola
## 3                                                                                                                                                                                                                                                                 Animalia | Chordata | Mammalia | Pholidota | Manidae
## 4                                                                                                                                                                                                                            Animalia | Chordata | Mammalia | Rodentia | Hystricidae | Atherurus | Atherurus africanus
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Primates | Haplorrhini | Simiiformes | Cercopithecoidea | Cercopithecidae | Cercopithecinae | Cercopithecini | Cercopithecus | Cercopithecus nictitans | Cercopithecus nictitans nictitans
## 6                                                                                                                                                                                           Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Reptilia | Squamata | Serpentes
##   target_specimen_life_stage latitude longitude study_title
## 1                         NA       NA        NA          NA
## 2                         NA       NA        NA          NA
## 3                         NA       NA        NA          NA
## 4                         NA       NA        NA          NA
## 5                         NA       NA        NA          NA
## 6                         NA       NA        NA          NA
```

For a complete list of supported interaction types, 


```r
get_interaction_types()
```

```
##      interaction     source     target
## 1        preysOn   predator       prey
## 2   preyedUponBy       prey   predator
## 3     parasiteOf   parasite       host
## 4    hasParasite       host   parasite
## 5     pollinates pollinator      plant
## 6   pollinatedBy      plant pollinator
## 7     pathogenOf   pathogen       host
## 8    hasPathogen      plant pollinator
## 9     symbiontOf     source     target
## 10 interactsWith     source     target
```

For data sources in which type of interactions was not specified, the interaction is labeled "interacts_with".

If you wish to view all interactions instead of specific types (e.g., parasitism and predation instead of just one of the two), the `get_interactions_by_taxa()` function allows this. In addition, the function provides options to search for interactions between two groups (source and target taxa, see above table) and only find interactions in a certain region.


```r
rattus <- get_interactions_by_taxa(sourcetaxon = "Rattus")
head(rattus)
```

```
##   source_taxon_external_id source_taxon_name
## 1               EOL:328447     Rattus rattus
## 2               EOL:328447     Rattus rattus
## 3               EOL:328447     Rattus rattus
## 4               EOL:328447     Rattus rattus
## 5               EOL:328447     Rattus rattus
## 6               EOL:328447     Rattus rattus
##                                                                                                                                                                             source_taxon_path
## 1 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
## 2 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
## 3 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
## 4 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
## 6 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Tetrapoda | Mammalia | Theria | Eutheria | Rodentia | Myomorpha | Muridae | Murinae | Rattus | Rattus rattus
##   source_specimen_life_stage interaction_type target_taxon_external_id
## 1                         NA    interactsWith             EOL:13340393
## 2                         NA    interactsWith             EOL:10702710
## 3                         NA    interactsWith              EOL:5004474
## 4                         NA    interactsWith              EOL:4968671
## 5                         NA    interactsWith              EOL:4965412
## 6                         NA    interactsWith              EOL:4963889
##              target_taxon_name
## 1            Mastophorus muris
## 2           Trypanosoma lewisi
## 3           Calodium hepaticum
## 4                  Raillietina
## 5 Nippostrongylus brasiliensis
## 6                     Syphacia
##                                                                                                                  target_taxon_path
## 1                                     Animalia | Nematoda | Secernentea | Spirurida | Spiruridae | Mastophorus | Mastophorus muris
## 2 Cellular organisms | Eukaryota | Euglenozoa | Kinetoplastida | Trypanosomatidae | Trypanosoma | Herpetosoma | Trypanosoma lewisi
## 3                                                                                                               Calodium hepaticum
## 4                                                Animalia | Platyhelminthes | Cestoda | Cyclophyllidea | Davaineidae | Raillietina
## 5                 Animalia | Nematoda | Secernentea | Strongylida | Heligosomidae | Nippostrongylus | Nippostrongylus brasiliensis
## 6                                                            Animalia | Nematoda | Secernentea | Ascaridida | Oxyuridae | Syphacia
##   target_specimen_life_stage latitude longitude study_title
## 1                         NA       NA        NA          NA
## 2                         NA       NA        NA          NA
## 3                         NA       NA        NA          NA
## 4                         NA       NA        NA          NA
## 5                         NA       NA        NA          NA
## 6                         NA       NA        NA          NA
```

Only a source taxa need be identified, but you can also specify a target taxon and/or geographic boundary (Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  


```r
aves_crustacea_northern_hemisphere <- get_interactions_by_taxa( sourcetaxon = "Aves", targettaxon = "Crustacea", bbox=c(-180, 0, 180, 90 ))
head(aves_crustacea_northern_hemisphere)
```

```
##   source_taxon_external_id          source_taxon_name
## 1                EOL:18884                    Cepphus
## 2              EOL:1049577              Larus marinus
## 3              EOL:1049366       Pluvialis squatarola
## 4              EOL:1049366       Pluvialis squatarola
## 5              EOL:1049366       Pluvialis squatarola
## 6              EOL:1048643 Phalacrocorax penicillatus
##                                                                                          source_taxon_path
## 1                                         Animalia | Chordata | Aves | Charadriiformes | Alcidae | Cepphus
## 2                           Animalia | Chordata | Aves | Charadriiformes | Laridae | Larus | Larus marinus
## 3           Animalia | Chordata | Aves | Charadriiformes | Charadriidae | Pluvialis | Pluvialis squatarola
## 4           Animalia | Chordata | Aves | Charadriiformes | Charadriidae | Pluvialis | Pluvialis squatarola
## 5           Animalia | Chordata | Aves | Charadriiformes | Charadriidae | Pluvialis | Pluvialis squatarola
## 6 Animalia | Chordata | Aves | Suliformes | Phalacrocoracidae | Phalacrocorax | Phalacrocorax penicillatus
##   source_specimen_life_stage interaction_type target_taxon_external_id
## 1                         NA          preysOn              EOL:2625033
## 2                         NA          preysOn                EOL:35798
## 3                         NA    interactsWith              EOL:2625033
## 4                         NA          preysOn              EOL:2615930
## 5                         NA          preysOn              EOL:2620777
## 6                         NA    interactsWith              EOL:2625033
##   target_taxon_name
## 1          Copepoda
## 2           Balanus
## 3          Copepoda
## 4         Oniscidea
## 5        Gammaridea
## 6          Copepoda
##                                                                                                                                                         target_taxon_path
## 1                                                                        Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea | Maxillopoda | Copepoda
## 2 Biota | Animalia | Arthropoda | Crustacea | Maxillopoda | Thecostraca | Cirripedia | Thoracica | Sessilia | Balanomorpha | Balanoidea | Balanidae | Balaninae | Balanus
## 3                                                                        Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea | Maxillopoda | Copepoda
## 4                              Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea
## 5                           Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Amphipoda | Gammaridea
## 6                                                                        Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea | Maxillopoda | Copepoda
##   target_specimen_life_stage latitude longitude study_title
## 1                         NA       NA        NA          NA
## 2                         NA       NA        NA          NA
## 3                         NA       NA        NA          NA
## 4                         NA       NA        NA          NA
## 5                         NA       NA        NA          NA
## 6                         NA       NA        NA          NA
```

#### Find interactions in a geographic areas

Instead of a taxon-specific approach, users may also wish to gather information on all interactions occuring in a specific area.  For example, a group developing ecoystem models for the Gulf of Mexico may want to consider all the data from that region.  `rglobi` enables this type of search by allowing users to specify a rectangular bounding box. Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  


```r
gulfinteractions <- get_interactions_in_area( bbox=c(-97.0, 17.5, -81, 31))
head(gulfinteractions)
```

```
##   source_taxon_external_id        source_taxon_name
## 1                    EOL:1                 Animalia
## 2                 EOL:1905           Actinopterygii
## 3              EOL:2598871                Crustacea
## 4               EOL:208553 Chloroscombrus chrysurus
## 5               EOL:208553 Chloroscombrus chrysurus
## 6               EOL:208553 Chloroscombrus chrysurus
##                                                                                             source_taxon_path
## 1                                                                                                    Animalia
## 2                          Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii
## 3                                     Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea
## 4 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
## 5 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
## 6 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
##   source_specimen_life_stage interaction_type target_taxon_external_id
## 1                         NA     preyedUponBy               EOL:208553
## 2                         NA     preyedUponBy               EOL:208553
## 3                         NA     preyedUponBy               EOL:208553
## 4                         NA          preysOn                    EOL:1
## 5                         NA          preysOn                 EOL:1905
## 6                         NA          preysOn              EOL:2598871
##          target_taxon_name
## 1 Chloroscombrus chrysurus
## 2 Chloroscombrus chrysurus
## 3 Chloroscombrus chrysurus
## 4                 Animalia
## 5           Actinopterygii
## 6                Crustacea
##                                                                                             target_taxon_path
## 1 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
## 2 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
## 3 Animalia | Chordata | Actinopterygii | Perciformes | Carangidae | Chloroscombrus | Chloroscombrus chrysurus
## 4                                                                                                    Animalia
## 5                          Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii
## 6                                     Animalia | Bilateria | Protostomia | Ecdysozoa | Arthropoda | Crustacea
##   target_specimen_life_stage latitude longitude study_title
## 1                         NA       NA        NA          NA
## 2                         NA       NA        NA          NA
## 3                         NA       NA        NA          NA
## 4                         NA       NA        NA          NA
## 5                         NA       NA        NA          NA
## 6                         NA       NA        NA          NA
```

To see all locations for which interactions have entered in GloBi, 


```r
areas <- get_interaction_areas()
head(areas)
```

```
##   Latitude Longitude
## 1    29.35    -92.98
## 2    29.03    -92.29
## 3    28.04    -96.11
## 4    27.62    -95.77
## 5    26.33    -96.03
## 6    30.14    -86.17
```
You can also restrict this search to a certain area:


```r
areas <- get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
head(areas)
```

```
##      Latitude Longitude
## 1251    18.25    -66.50
## 1255    18.34    -65.83
## 1268    18.07    -63.07
## 1339    13.17    -59.53
```

#### Custom Queries using Cypher

Currently, GloBI is powered by [neo4j](http://neo4j.org), a graph database. Most results created by the R functions provided by `rglobi` are basically wrappers for commonly used cypher queries. This way, you can still use the library without having to learn Cypher, a graph query language. However, if you feel adventurous, you can execute queries using Cypher only using the function `query()`:


```r
result <- query("START taxon = node:taxons(name='Homo sapiens') MATCH taxon<-[:CLASSIFIED_AS]-predator-[:ATE|PREYS_ON]->prey-[:CLASSIFIED_AS]->preyTaxon RETURN distinct(preyTaxon.name) as `prey.taxon.name` LIMIT 10")
result
```

```
##         prey.taxon.name
## 1          Homo sapiens
## 2    Macropus bernardus
## 3             Mysticeti
## 4   Dendrolagus scottae
## 5   Engraulis japonicus
## 6         Sergia lucens
## 7       Martes melampus
## 8   Lophocebus albigena
## 9            Salmonidae
## 10 Moschus chrysogaster
```

This particular query returns the names of the first ten known prey or diet items of humans (_Homo sapiens_). More examples of GloBI specific Cypher queries can be found on the [GloBI Cypher Wiki](https://github.com/jhpoelen/eol-globi-data/wiki/cypher). 
