all: move rmd2md

move:
	cp inst/vign/rglobi_vignette.md vignettes

rmd2md:
	cd vignettes;\
	mv rglobi_vignette.md rglobi_vignette.Rmd
