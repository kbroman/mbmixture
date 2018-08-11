all: doc data test
.PHONY: doc data test

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
	cd $(<D);R CMD BATCH ${R_OPTS} $(<F)
