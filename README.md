## [R/mbmixture](https://github.com/kbroman/mbmixture)

[![Build Status](https://travis-ci.org/kbroman/mbmixture.svg?branch=master)](https://travis-ci.org/kbroman/mbmixture)

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

You can install R/mbmixture from its
[GitHub repository](https://github.com/kbroman/mixture). You first need to
install the [devtools](https://github.com/hadley/devtools) package.

```r
install.packages("devtools")
```

Then install R/mbmixture using the `install_github` function in the
[devtools](https://github.com/hadley/devtools) package. (With
`build_vignettes=TRUE`, the vignettes will be built and installed.)

```r
library(devtools)
install_github("kbroman/mbmixture", build_vignettes=TRUE)
```

---

### Vignette

A vignette describing the use of the package is available from within
R. Load the package and then use the `vignette` function.

```r
library(mbmixture)
vignette("mbmixture", package="mbmixture")
```

---

### License

This package is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License, version 3, as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.  See the GNU
General Public License for more details.

A copy of the GNU General Public License, version 3, is available at
<https://www.r-project.org/Licenses/GPL-3>
