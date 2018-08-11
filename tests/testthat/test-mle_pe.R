context("mle_pe, mle_p, and mle_e")

test_that("mle_pe, mle_p, and mle_e work", {

    data(mbmixdata)

    expected <- structure(c(p = 0.744841169389641, e = 0.00284299905444711, loglik = -3005967.16862983,
                            lrt_p0 = 3611308.87945943, lrt_p1 = 820483.428998603),
                          SE = c(p = 0.000349271095363225, e = 0.0000267534146778811))

    expect_equal(mle_pe(mbmixdata, SE=TRUE), expected)

    attr(expected, "SE") <- NULL
    expect_equal(mle_pe(mbmixdata), expected)

    expected_p <- setNames(expected["p"], NULL)
    expected_e <- setNames(expected["e"], NULL)
    attr(expected_p, "loglik") <- attr(expected_e, "loglik") <- setNames(expected["loglik"], NULL)

    expect_equal(mle_p(mbmixdata, e=expected_e), expected_p)
    expect_equal(mle_e(mbmixdata, p=expected_p), expected_e)

})
