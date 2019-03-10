#' log likelihood function for microbiome mixture
#'
#' Calculate log likelihood function for microbiome sample mixture model at particular values of `p` and `e`.
#'
#' @param tab Dataset of read counts as 3d array of size 3x3x2, genotype in first sample x genotype in second sample x allele in read.
#' @param p Contaminant probability (proportion of mixture coming from the second sample).
#' @param e Sequencing error rate.
#'
#' @examples
#' data(mbmixdata)
#' mbmix_loglik(mbmixdata, p=0.74, e=0.002)
#'
#' @return The log likelihood evaluated at `p` and `e`.
#'
#' @export
mbmix_loglik <-
    function(tab, p, e=0)
{
    stopifnot(length(dim(tab)) == 3,
              all(dim(tab) == c(3,3,2)))
    stopifnot(length(p)==1, !is.na(p), p>=0, p<=1)
    stopifnot(length(e)==1, !is.na(e), e>=0, e<=1)

    prA <- rbind(c(1, 1-p + p/2, 1-p),
                 c((1-p)/2+p, 1/2, (1-p)/2),
                 c(p, p/2, 0))

    prB <- 1 - prA

    p <- array(c(prA*(1-e)+prB*e,
                 prB*(1-e)+prA*e),
               dim=c(3,3,2))

    sum(log(p[tab > 0])*tab[tab > 0])
}


# one parameter version, taking e as fixed
mbmix_loglik_fixede <-
    function(p, tab, e=0.002)
{
    if(length(p) > 1) return(sapply(p, mbmix_loglik_fixede, tab=tab, e=e))
    mbmix_loglik(tab, p, e)
}

# one parameter version, taking p as fixed
mbmix_loglik_fixedp <-
    function(e, tab, p=1e-6)
{
    if(length(e) > 1) return(sapply(e, mbmix_loglik_fixedp, tab=tab, p=p))
    mbmix_loglik(tab, p, e)
}

# parameters as a leading vector
mbmix_loglik_pe <-
    function(theta, tab)
{
    mbmix_loglik(tab, theta[1], theta[2])
}
