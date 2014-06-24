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
## 
## The downloaded binary packages are in
## 	/var/folders/v4/0_y78_xj1x7b72l89cwc2kq80000gp/T//RtmpB87w6g/downloaded_packages
```

```r
devtools::install_github("rglobi", "ropensci")
```

```
## Installing github repo rglobi/master from ropensci
## Downloading master.zip from https://github.com/ropensci/rglobi/archive/master.zip
## Installing package from /var/folders/v4/0_y78_xj1x7b72l89cwc2kq80000gp/T//RtmpB87w6g/master.zip
## arguments 'minimized' and 'invisible' are for Windows only
## Installing rglobi
## '/Library/Frameworks/R.framework/Resources/bin/R' --vanilla CMD build  \
##   '/private/var/folders/v4/0_y78_xj1x7b72l89cwc2kq80000gp/T/RtmpB87w6g/devtoolsb9483e2c827c/rglobi-master'  \
##   --no-manual --no-resave-data
```

```
## Error: Command failed (1)
```


```r
library("rglobi")
```

Note that since rglobi is still pretty new, only the dev version of the library is available at this time. We hope to publish a version to CRAN once the library matures. For more information see [GitHub](https://github.com/ropensci/rglobi).

#### Find interactions involving a certain species

Determining which species interact with each other (and how and where) is a major focus of ecology.  The Global Biotic Interactions Database offers data on multiple interaction types, and the rglobi library offers several ways to specify and access these interactions.  get_interactions is the primary function used if data on a specific interaction type is required.  A focus taxon is entered (may be specified as "Genus species" or higher level (e.g., Genus, Family, Class)).


```r
hsapiens <- get_interactions(taxon = "Homo sapiens", interaction.type = "preysOn")
head(hsapiens)
```

```
##   source_taxon_name interaction_type   target_taxon_name
## 1      Homo sapiens          preysOn        Homo sapiens
## 2      Homo sapiens          preysOn  Macropus bernardus
## 3      Homo sapiens          preysOn           Mysticeti
## 4      Homo sapiens          preysOn Dendrolagus scottae
## 5      Homo sapiens          preysOn Engraulis japonicus
## 6      Homo sapiens          preysOn       Sergia lucens
```

get_predators_of and get_prey_of are wrappers for get_interactions that remove the need to specify interaction type



```r
hsapiens <- get_prey_of("Homo sapiens")
head(hsapiens)
```

```
##   source_taxon_name interaction_type   target_taxon_name
## 1      Homo sapiens          preysOn        Homo sapiens
## 2      Homo sapiens          preysOn  Macropus bernardus
## 3      Homo sapiens          preysOn           Mysticeti
## 4      Homo sapiens          preysOn Dendrolagus scottae
## 5      Homo sapiens          preysOn Engraulis japonicus
## 6      Homo sapiens          preysOn       Sergia lucens
```

For a complete list of supported interaction types, 


```r
get_interaction_types()
```

```
## Warning: incomplete final line found by readTableHeader on
## 'http://api.globalbioticinteractions.org:80/interactionTypes'
```

```
##    Interaction   Source   Target
## 1      preysOn predator     prey
## 2 preyedUponBy     prey predator
## 3   parasiteOf parasite     host
## 4       hostOf     host parasite
```

For data sources in which type of interactions was not specified, the interaction is labeled "interacts_with".

If you wish to view all interactions instead of specific types (e.g., parasitism and predation instead of just one of the two), the get_interactions_by_taxa allows this. In addition, the function provides options to search for interactions between two groups (source and target taxa, see above table) and only find interactions in a certain region.


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
##                                                              source_taxon_path
## 1 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
## 2 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
## 3 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
## 4 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
## 5 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
## 6 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus
##   interaction_type target_taxon_external_id
## 1              ATE               EOL:330973
## 2              ATE               EOL:330977
## 3              ATE              EOL:1019109
## 4              ATE              EOL:1019106
## 5              ATE               EOL:330433
## 6              ATE               EOL:330945
##                 target_taxon_name
## 1 Eleutherodactylus portoricensis
## 2    Eleutherodactylus wightmanae
## 3       Eleutherodactylus eneidae
## 4      Eleutherodactylus hedricki
## 5         Eleutherodactylus coqui
## 6     Eleutherodactylus richmondi
##                                                                                                    target_taxon_path
## 1 Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus portoricensis
## 2    Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus wightmanae
## 3       Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus eneidae
## 4      Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus hedricki
## 5         Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus coqui
## 6     Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus richmondi
```

Only a source taxa need be identified, but you can also specify a target taxon and/or geographic boundary (Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  


```r
aves_crustacea_northern_hemisphere <- get_interactions_by_taxa( sourcetaxon = "Aves", targettaxon = "Crustacea", bbox=c(-180, 0, 180, 90 ))
head(aves_crustacea_northern_hemisphere)
```

```
##   source_taxon_external_id    source_taxon_name
## 1              EOL:1052686    Locustella naevia
## 2              EOL:1052686    Locustella naevia
## 3              EOL:1052686    Locustella naevia
## 4              EOL:1052686    Locustella naevia
## 5              EOL:1052686    Locustella naevia
## 6              EOL:1052775 Emberiza schoeniclus
##                                                                            source_taxon_path
## 1    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia
## 2    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia
## 3    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia
## 4    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia
## 5    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia
## 6 Animalia | Chordata | Aves | Passeriformes | Emberizidae | Emberiza | Emberiza schoeniclus
##   interaction_type target_taxon_external_id target_taxon_name
## 1       PREYS_UPON              EOL:4285684 Ligidium hypnorum
## 2       PREYS_UPON              EOL:4285684 Ligidium hypnorum
## 3       PREYS_UPON              EOL:4285684 Ligidium hypnorum
## 4       PREYS_UPON              EOL:4285684 Ligidium hypnorum
## 5       PREYS_UPON              EOL:4285684 Ligidium hypnorum
## 6       PREYS_UPON              EOL:4285684 Ligidium hypnorum
##                                                                                                                                                                                                                                                                                           target_taxon_path
## 1 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
## 2 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
## 3 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
## 4 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
## 5 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
## 6 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
```

#### Find interactions in a geographic areas

Instead of a taxon-specific approach, users may also wish to gather information on all interactions occuring in a specific area.  For example, a group developing ecoystem models for the Gulf of Mexico may want to consider all the data from that region.  rglobi enables this type of search by allowing users to specify a rectangular bounding box. Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  


```r
gulfinteractions <- get_interactions_in_area( bbox=c(-97.0, 17.5, -81, 31))
head(gulfinteractions)
```

```
##   source_taxon_external_id         source_taxon_name
## 1               EOL:210932 Paralichthys squamilentus
## 2               EOL:210806           Syacium gunteri
## 3               EOL:225997          Prionotus alatus
## 4               EOL:225007           Synodus foetens
## 5               EOL:225007           Synodus foetens
## 6               EOL:338581    Trichopsetta ventralis
##                                                                                                       source_taxon_path
## 1 Animalia | Chordata | Actinopterygii | Pleuronectiformes | Paralichthyidae | Paralichthys | Paralichthys squamilentus
## 2                Animalia | Chordata | Actinopterygii | Pleuronectiformes | Paralichthyidae | Syacium | Syacium gunteri
## 3                     Animalia | Chordata | Actinopterygii | Scorpaeniformes | Triglidae | Prionotus | Prionotus alatus
## 4                        Animalia | Chordata | Actinopterygii | Aulopiformes | Synodontidae | Synodus | Synodus foetens
## 5                        Animalia | Chordata | Actinopterygii | Aulopiformes | Synodontidae | Synodus | Synodus foetens
## 6           Animalia | Chordata | Actinopterygii | Pleuronectiformes | Bothidae | Trichopsetta | Trichopsetta ventralis
##   interaction_type target_taxon_external_id target_taxon_name
## 1              ATE                    EOL:1          Animalia
## 2              ATE                    EOL:1          Animalia
## 3              ATE                    EOL:1          Animalia
## 4              ATE                    EOL:1          Animalia
## 5              ATE              EOL:2775808         Teleostei
## 6              ATE                    EOL:1          Animalia
##                                                                                                                        target_taxon_path
## 1                                                                                                                               Animalia
## 2                                                                                                                               Animalia
## 3                                                                                                                               Animalia
## 4                                                                                                                               Animalia
## 5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Osteichthyes | Actinopterygii | Neopterygii | Teleostei
## 6                                                                                                                               Animalia
```

To see all locations for which interactions have entered in GloBi, 


```r
areas <- get_interaction_areas()
head(areas)
```

```
##   Latitude Longitude
## 1    36.93   -118.68
## 2    50.40     -2.11
## 3    53.40     -0.59
## 4    53.42     -1.50
## 5   -25.00    135.00
## 6    40.98    -79.53
```
You can also restrict this search to a certain area:


```r
areas <- get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
head(areas)
```

```
##     Latitude Longitude
## 821    18.25    -66.50
## 826    18.34    -65.83
## 840    18.07    -63.07
## 914    13.17    -59.53
```

#### Custom Queries using Cypher

Currently, GloBI is powered by [neo4j](http://neo4j.org), a graph database. Most results created by the R functions provided by rglobi are basically wrappers for commonly used cypher queries. This way, you can still use the library without having to learn Cypher, a graph query language. However, if you feel adventurious, you can execute queries using Cypher only using the function query():


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
