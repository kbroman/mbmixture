#' Bootstrap to assess significance
#'
#' Perform a parametric bootstrap to assess whether there is significant evidence that a sample is a mixture.
#'
#' @param tab Dataset of read counts as 3d array of size 3x3x2, genotype in first sample x genotype in second sample x allele in read.
#' @param n_rep Number of bootstrap replicates
#' @param interval Interval to which each parameter should be constrained
#' @param tol Tolerance for convergence
#' @param check_boundary If TRUE, explicitly check the boundaries of `interval`.
#' @param cores Number of CPU cores to use, for parallel calculations.
#' (If `0`, use [parallel::detectCores()].)
#' Alternatively, this can be links to a set of cluster sockets, as
#' produced by [parallel::makeCluster()].
#' @param return_raw If TRUE, return the raw results. If FALSE, just return the p-value.
#' Unlink [bootstrapSE()], here the default is TRUE.
#'
#' @return If `return_raw=FALSE`, a single numeric value (the p-value).If
#'     `return_raw=TRUE`, a vector of length `n_rep` with the LRT statistics from each
#'     bootstrap replicate.
#'
#' @examples
#' data(mbmixdata)
#' # just 100 bootstrap replicates, as an illustration
#' bootstrapNull(mbmixdata, n_rep=100)
#'
#' @export
#' @importFrom stats rbinom setNames
#' @seealso [bootstrapSE()]
bootstrapNull <-
    function(tab, n_rep=1000, interval=c(0,1), tol=1e-6, check_boundary=TRUE, cores=1,
             return_raw=TRUE)
{
    d <- dim(tab)
    stopifnot(length(d) == 3, all(d == c(3,3,2)))

    # fit alternative (allowing p > 0) and null (assuming p=0)
    if(!return_raw) out_alt <- mle_pe(tab, interval=interval, tol=tol, check_boundary=check_boundary)
    out_null <- mle_e(tab, p=0, interval=interval, tol=tol, check_boundary=check_boundary)

    # number of reads for each two-locus genotype
    n <- tab[,,1] + tab[,,2]

    # simulate under the null hypothesis of no mixture
    sims <- matrix(nrow=n_rep, ncol=length(n))
    k <- 1
    for(i in 1:3) {
        for(j in 1:3) {
            sims[,k] <- rbinom(n_rep, n[k], c(out_null, 0.5, 1-out_null)[j])

            k <- k + 1
        }
    }

    cores <- setup_cluster(cores)

    result <- cluster_lapply(cores, seq_len(n_rep), function(i) {
                         x <- array(c(n-sims[i,], sims[i,]), dim=d)
                         mle_pe(x, interval=interval, tol=tol, check_boundary=check_boundary, SE=FALSE)["lrt_p0"] })

    if(return_raw) {
        result <- setNames(unlist(result), NULL)
        result[result < 0] <- 0 # fix the round-off error cases
        return(result)
    }

    mean(result >= out_alt["lrt_p0"])
}
