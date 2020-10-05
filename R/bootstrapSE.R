#' Bootstrap to get standard errors
#'
#' Perform a parametric bootstrap to get estimated standard errors.
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
#' @param return_raw If TRUE, return the raw results. If FALSE, just return the estimated standard errors.
#'
#' @return If `return_raw=FALSE`, a vector of two standard errors. If
#'     `return_raw=TRUE`, an matrix of size `n_rep` x 2 with the detailed
#'     bootstrap results.
#'
#' @examples
#' data(mbmixdata)
#' # just 100 bootstrap replicates, as an illustration
#' bootstrapSE(mbmixdata, n_rep=100)
#'
#' @export
#' @importFrom stats rmultinom setNames sd
#' @seealso [bootstrapNull()]
bootstrapSE <-
    function(tab, n_rep=1000, interval=c(0,1), tol=1e-6, check_boundary=FALSE, cores=1,
             return_raw=FALSE)
{
    d <- dim(tab)
    n <- sum(tab)
    p <- as.numeric(tab/n)

    sims <- rmultinom(n_rep, n, p)

    cores <- setup_cluster(cores)

    result <- cluster_lapply(cores, seq_len(n_rep), function(i) {
                         x <- array(sims[,i], dim=d)
                         mle_pe(x, interval=interval, tol=tol, check_boundary=check_boundary, SE=FALSE)[1:2] })

    result <- matrix(unlist(result), ncol=2, byrow=TRUE)

    if(return_raw) {
        colnames(result) <- c("p", "err")
        return(result)
    }

    setNames(apply(result, 2, sd), c("p", "err"))
}
