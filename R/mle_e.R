#' MLE of e for fixed p
#'
#' Calculate the MLE of the sequencing error rate e for a fixed value of the contaminant probability p.
#'
#' @param tab Dataset of read counts as 3d array of size 3x3x2, genotype in first sample x genotype in second sample x allele in read.
#' @param p Assumed value for the contaminant probability
#' @param interval Interval to which each parameter should be constrained
#' @param tol Tolerance for convergence
#' @param check_boundary If TRUE, explicitly check the boundaries of `interval`.
#'
#' @return A single numeric value, the MLE of `e`, with the log likelihood as an attribute.
#'
#' @examples
#' data(mbmixdata)
#' mle_e(mbmixdata, p=0.74)
#'
#' @export
#' @importFrom stats optimize
mle_e <-
    function(tab, p=0.05, interval=c(0,1), tol=1e-6, check_boundary=FALSE)
{
    out <- suppressWarnings(
        optimize(mbmix_loglik_fixedp, interval, tab=tab, p=p, maximum=TRUE, tol=tol)
        )

    if(check_boundary) {
        out0 <- mbmix_loglik(tab, p, e=0)
        out1 <- mbmix_loglik(tab, p, e=1)

        if(is.finite(out1) && out1 >= out$objective) {
            out$objective <- out1
            out$maximum <- 1
        }

        if(is.finite(out0) && out0 >= out$objective) {
            out$objective <- out0
            out$maximum <- 0
        }

    }

    ehat <- out$maximum
    attr(ehat, "loglik") <- out$objective

    ehat
}
