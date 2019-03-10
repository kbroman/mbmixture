#' Find MLEs for microbiome mixture
#'
#' Find joint MLEs of p and e for microbiome mixture model
#'
#' @param tab Dataset of read counts as 3d array of size 3x3x2, genotype in first sample x genotype in second sample x allele in read.
#' @param interval Interval to which each parameter should be constrained
#' @param tol Tolerance for convergence
#' @param check_boundary If TRUE, explicitly check the boundaries of `interval`.
#' @param SE If TRUE, get estimated standard errors.
#'
#' @return A vector containing the estimates of `p` and `e` along with the evaluated log likelihood and likelihood ratio test statistics for the hypotheses p=0 and p=1.
#'
#' @examples
#' data(mbmixdata)
#' mle_pe(mbmixdata)
#'
#' @export
#' @importFrom stats optimize
#' @importFrom numDeriv hessian
#' @importFrom parallel detectCores makeCluster stopCluster parLapply mclapply
mle_pe <-
    function(tab, interval=c(0,1), tol=1e-6, check_boundary=FALSE, SE=FALSE)
{
    f <- function(e, tab) {
        attr(mle_p(tab, interval=interval, e=e, tol=tol, check_boundary=check_boundary), "loglik")
    }

    out <- suppressWarnings(
        optimize(f, interval, tab=tab, maximum=TRUE, tol=tol)
        )

    if(check_boundary) {
        out0 <- f(0, tab)
        out1 <- f(1, tab)

        if(is.finite(out0) && out0 >= out) out <- out0
        if(is.finite(out1) && out1 >= out) out <- out1
    }

    phat <- as.numeric(mle_p(tab, interval=interval, e=out$maximum, tol=tol, check_boundary=check_boundary))

    loglik_p0 <- attr(mle_e(tab, interval=interval, tol=tol, check_boundary=check_boundary, p=0), "loglik")
    loglik_p1 <- attr(mle_e(tab, interval=interval, tol=tol, check_boundary=check_boundary, p=1), "loglik")

    result <- c(p=phat,
                e=out$maximum,
                loglik=out$objective,
                lrt_p0=2*(out$objective - loglik_p0),
                lrt_p1=2*(out$objective - loglik_p1))

    if(SE) {
        d <- numDeriv::hessian(mbmix_loglik_pe, result[1:2], tab=tab)
        se <- sqrt(diag(solve(-d)))
        names(se) <- c("p", "e")
        attr(result, "SE") <- se
    }

    result
}
