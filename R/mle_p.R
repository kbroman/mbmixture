#' MLE of p for fixed e
#'
#' Calculate the MLE of the contaminant probability p for a fixed value of the sequencing error rate e.
#'
#' @param tab Dataset of read counts as 3d array of size 3x3x2, genotype in first sample x genotype in second sample x allele in read.
#' @param e Assumed value for the sequencing error rate
#' @param interval Interval to which each parameter should be constrained
#' @param tol Tolerance for convergence
#' @param check_boundary If TRUE, explicitly check the boundaries of `interval`.
#'
#' @return A single numeric value, the MLE of `p`, with the log likelihood as an attribute.
#'
#' @examples
#' data(mbmixdata)
#' mle_p(mbmixdata, e=0.002)
#'
#' @export
#' @importFrom stats optimize
mle_p <-
    function(tab, e=0.002, interval=c(0,1), tol=1e-6, check_boundary=FALSE)
{
    out <- suppressWarnings(
        optimize(mbmix_loglik_fixede, interval, tab=tab, e=e, maximum=TRUE, tol=tol)
        )

    if(check_boundary) {
        out0 <- mbmix_loglik(tab, p=0, e)
        out1 <- mbmix_loglik(tab, p=1, e)

        if(is.finite(out0) && out0 >= out$objective) {
            out$objective <- out0
            out$maximum <- 0
        }

        if(is.finite(out1) && out1 >= out$objective) {
            out$objective <- out1
            out$maximum <- 1
        }
    }


    phat <- out$maximum
    attr(phat, "loglik") <- out$objective

    phat
}
