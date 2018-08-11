context("mle_pe, mle_p, and mle_e")

test_that("mle_pe works", {

    data(mbmixdata)

    expected <- structure(c(p = 0.744841169389641, e = 0.00284299905444711, loglik = -3005967.16862983,
                            lrt_p0 = 3611308.87945943, lrt_p1 = 820483.428998603),
                          SE = c(p = 0.000349271095363225, e = 0.0000267534146778811))

    expect_equal(mle_pe(mbmixdata, SE=TRUE), expected)

    attr(expected, "SE") <- NULL
    expect_equal(mle_pe(mbmixdata), expected)

})
