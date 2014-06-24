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
install.packages("rglobi")
```


```r
library("rglobi")
```

Advanced users can also download and install the latest development copy from [GitHub](https://github.com/ropensci/rglobi).

#### Find interactions involving a certain species

Determining which species interact with each other (and how and where) is a major focus of ecology.  The Global Biotic Interactions Database offers data on multiple interaction types, and the rglobi library offers several ways to specify and access these interactions.  get_interactions is the primary function used if data on a specific interaction type is required.  A focus taxon is entered (may be specified as "Genus species" or higher level (e.g., Genus, Family, Class)).

```r
hsapiens=get_interactions(taxon = "Homo sapiens", interactionType = "preysOn")
head(hsapiens)
```

```
  source_taxon_name interaction_type   target_taxon_name
1      Homo sapiens          preysOn  Macropus bernardus
2      Homo sapiens          preysOn           Mysticeti
3      Homo sapiens          preysOn Dendrolagus scottae
4      Homo sapiens          preysOn Engraulis japonicus
5      Homo sapiens          preysOn       Sergia lucens
6      Homo sapiens          preysOn     Martes melampus
```

get_predators_of and get_prey_of are wrappers for get_interactions that remove the need to specify interaction type


```r
hsapiens=get_prey_of("Homo sapiens")
head(hsapiens)
```

```
  source_taxon_name interaction_type   target_taxon_name
1      Homo sapiens          preysOn  Macropus bernardus
2      Homo sapiens          preysOn           Mysticeti
3      Homo sapiens          preysOn Dendrolagus scottae
4      Homo sapiens          preysOn Engraulis japonicus
5      Homo sapiens          preysOn       Sergia lucens
6      Homo sapiens          preysOn     Martes melampus```

```

For a complete list of supported interaction types, 

```r
get_interaction_types()
```

```
   Interaction   Source   Target
1      preysOn predator     prey
2 preyedUponBy     prey predator
3   parasiteOf parasite     host
4       hostOf     host parasite
```

For data sources in which type of interactions was not specified, the interaction is labeled "interacts_with".

If you wish to view all interactions instead of specific types (e.g., parasitism and predation instead of just one of the two), the get_interactions_by_taxa allows this. In addition, the function provides options to search for interactions between two groups (source and target taxa, see above table) and only find interactions in a certain region.

```r
rattus=get_interactions_by_taxa(sourcetaxon = "Rattus")
head(rattus)
```
```
  source_taxon_external_id source_taxon_name
1               EOL:328447     Rattus rattus
2               EOL:328447     Rattus rattus
3               EOL:328447     Rattus rattus
4               EOL:328447     Rattus rattus
5               EOL:328447     Rattus rattus
6               EOL:328447     Rattus rattus
                                                             source_taxon_path interaction_type
1 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
2 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
3 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
4 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
5 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
6 Animalia | Chordata | Mammalia | Rodentia | Muridae | Rattus | Rattus rattus              ATE
  target_taxon_external_id               target_taxon_name
1               EOL:330973 Eleutherodactylus portoricensis
2               EOL:330977    Eleutherodactylus wightmanae
3              EOL:1019109       Eleutherodactylus eneidae
4              EOL:1019106      Eleutherodactylus hedricki
5               EOL:330433         Eleutherodactylus coqui
6               EOL:330945     Eleutherodactylus richmondi
                                                                                                   target_taxon_path
1 Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus portoricensis
2    Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus wightmanae
3       Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus eneidae
4      Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus hedricki
5         Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus coqui
6     Animalia | Chordata | Amphibia | Anura | Eleutherodactylidae | Eleutherodactylus | Eleutherodactylus richmondi
```

Only a source taxa need be identified, but you can also specify a target taxon and/or geographic boundary (Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  

```r
aves_crustacea_northern_hemisphere = get_interactions_by_taxa( sourcetaxon = "Aves", targettaxon = "Crustacea", bbox=c(-180, 0, 180, 90 ))
head(aves_crustacea_northern_hemisphere)
```
```
  source_taxon_external_id    source_taxon_name
1              EOL:1052686    Locustella naevia
2              EOL:1052686    Locustella naevia
3              EOL:1052686    Locustella naevia
4              EOL:1052686    Locustella naevia
5              EOL:1052686    Locustella naevia
6              EOL:1052775 Emberiza schoeniclus
                                                                           source_taxon_path interaction_type target_taxon_external_id
1    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia       PREYS_UPON              EOL:4285684
2    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia       PREYS_UPON              EOL:4285684
3    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia       PREYS_UPON              EOL:4285684
4    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia       PREYS_UPON              EOL:4285684
5    Animalia | Chordata | Aves | Passeriformes | Sylviidae | Locustella | Locustella naevia       PREYS_UPON              EOL:4285684
6 Animalia | Chordata | Aves | Passeriformes | Emberizidae | Emberiza | Emberiza schoeniclus       PREYS_UPON              EOL:4285684
  target_taxon_name
1 Ligidium hypnorum
2 Ligidium hypnorum
3 Ligidium hypnorum
4 Ligidium hypnorum
5 Ligidium hypnorum
6 Ligidium hypnorum
                                                                                                                                                                                                                                                                                          target_taxon_path
1 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
2 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
3 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
4 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
5 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
6 Cellular organisms | Eukaryota | Opisthokonta | Metazoa | Eumetazoa | Bilateria | Protostomia | Ecdysozoa | Panarthropoda | Arthropoda | Mandibulata | Pancrustacea | Crustacea | Malacostraca | Eumalacostraca | Peracarida | Isopoda | Oniscidea | Diplocheta | Ligiidae | Ligidium | Ligidium hypnorum
```


#### Find interactions in a geographic areas

Instead of a taxon-specific approach, users may also wish to gather information on all interactions occuring in a specific area.  For example, a group developing ecoystem models for the Gulf of Mexico may want to consider all the data from that region.  rglobi enables this type of search by allowing users to specify a rectangular bounding box. Coordinates must be in decimal degrees ([EPSG:4326](http://spatialreference.org/ref/epsg/wgs-84/)) and correspond to the west, south, east, and northern boundaries (i.e., min x, min y, max x, max y).  

```r
gulfinteractions <- get_interactions_in_area( bbox=c(-97.0, 17.5, -81, 31))
head(gulfinteractions)
```

```
                   source_taxon_external_id         source_taxon_name
1 urn:lsid:marinespecies.org:taxname:158827 Paralichthys squamilentus
2 urn:lsid:marinespecies.org:taxname:275839           Syacium gunteri
3 urn:lsid:marinespecies.org:taxname:159570          Prionotus alatus
4 urn:lsid:marinespecies.org:taxname:158758           Synodus foetens
5 urn:lsid:marinespecies.org:taxname:158758           Synodus foetens
6 urn:lsid:marinespecies.org:taxname:159217    Trichopsetta ventralis
                                                                                                                                                    source_taxon_path
1 Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Pleuronectiformes | Paralichthyidae | Paralichthys | Paralichthys squamilentus
2                Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Pleuronectiformes | Paralichthyidae | Syacium | Syacium gunteri
3                     Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Scorpaeniformes | Triglidae | Prionotus | Prionotus alatus
4         Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Aulopiformes | Synodontidae | Synodontinae | Synodus | Synodus foetens
5         Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Aulopiformes | Synodontidae | Synodontinae | Synodus | Synodus foetens
6           Biota | Animalia | Chordata | Vertebrata | Gnathostomata | Pisces | Actinopterygii | Pleuronectiformes | Bothidae | Trichopsetta | Trichopsetta ventralis
  interaction_type target_taxon_external_id target_taxon_name
1              ATE                    EOL:1          Animalia
2              ATE                    EOL:1          Animalia
3              ATE                    EOL:1          Animalia
4              ATE                    EOL:1          Animalia
5              ATE              EOL:2775808         Teleostei
6              ATE                    EOL:1          Animalia
                                                                                                                       target_taxon_path
1                                                                                                                               Animalia
2                                                                                                                               Animalia
3                                                                                                                               Animalia
4                                                                                                                               Animalia
5 Animalia | Bilateria | Deuterostomia | Chordata | Vertebrata | Gnathostomata | Osteichthyes | Actinopterygii | Neopterygii | Teleostei
6                                                                                                                               Animalia
>
```

To see all locations for which interactions have entered in GloBi, 

```r
areas=get_interaction_areas()
head(areas)
```

```
   Latitude  Longitude
1  36.92535 -118.68182
2  50.40000   -2.11000
3  53.40000   -0.59000
4  53.41667   -1.50000
5 -25.00000  135.00000
6  40.97780  -79.52529
```

You can also restrict this search to a certain area:

```r
areas=get_interaction_areas (bbox=c(-67.87,12.79,-57.08,23.32))
head(areas)
```

```
    Latitude Longitude
821 18.24829 -66.49989
826 18.33884 -65.82572
840 18.06667 -63.06667
914 13.16667 -59.53333
```


