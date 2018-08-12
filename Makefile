all: doc data vignette
.PHONY: doc data test vignette

# R_OPTS: --vanilla without --no-environ
R_OPTS=--no-save --no-restore --no-init-file --no-site-file

# build package documentation
doc:
	R -e 'devtools::document()'

# run tests
test:
	R -e 'devtools::test()'

data: data/mbmixdata.RData

data/mbmixdata.RData: inst/scripts/create_mbmixdata.R
	cd $(<D);R CMD BATCH $(R_OPTS) $(<F)

vignette: docs/mbmixture.html

docs/mbmixture.html: vignettes/mbmixture.Rmd
	[ -d docs ] || mkdir docs
	R $(R_OPTS) -e "rmarkdown::render('$<')"
	mv vignettes/mbmixture.html $@
