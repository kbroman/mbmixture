## [R/mbmixture](https://github.com/kbroman/mbmixture)

[![Build Status](https://travis-ci.org/kbroman/mbmixture.svg?branch=master)](https://travis-ci.org/kbroman/mbmixture)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/mbmixture)](https://cran.r-project.org/package=mbmixture)

[Karl W Broman](https://kbroman.org)

---

R/mbmixture is an [R](https://www.r-project.org) package for
evaluating whether a microbiome sample is the mixture of two source
samples. We are thinking of shotgun sequencing data on the microbiome
sample plus dense SNP genotype data on the two potential source
samples. We assume that the data has been reduced to a
three-dimensional array of read counts: the 3 possible SNP genotypes
for the first sample &times; the 3 possible SNP genotypes of the
second sample &times; the 2 possible SNP alleles on the reads.

We fit a model with contaminant probability _p_ = proportion of the
microbiome sample coming from the second sample and _e_ = rate of sequencing
errors.


---

### Installation

You can install R/mbmixture from [CRAN](https://cran.r-project.org):

```r
install.packages("mbmixture")
```

---

### Vignette

A vignette describing the use of the package is available
[on the web](https://kbroman.org/mbmixture/mbmixture.html).
Or view it from within R by load the package and then using the
`vignette()` function.

```r
library(mbmixture)
vignette("mbmixture", package="mbmixture")
```

### Citation

To cite R/mbmixture in publications use:

- Lobo AK, Traeger LL, Keller MP, Attie AD, Rey FE, Broman KW (2019)
  Identification of sample mix-ups and mixtures in microbiome data in
  Diversity Outbred mice. bioRxiv
  [doi:10.1101/529040](https://doi.org/10.1101/529040)

---

### License

Licensed under the [MIT license](https://cran.r-project.org/web/licenses/MIT).
([More information here](https://en.wikipedia.org/wiki/MIT_License).)
