context("mbmix_loglik")

test_that("mbmix_loglik works", {

    data(mbmixdata)

    expect_equal(mbmix_loglik(mbmixdata, 0.7448, 0.0028), -3005968.48026929)
    expect_equal(mbmix_loglik(mbmixdata, 0.25, 0.0028), -3886039.76783913)
    expect_equal(mbmix_loglik(mbmixdata, 0.9, 0.0028), -3148760.59650107)
    expect_equal(mbmix_loglik(mbmixdata, 0.7448, 0.001), -3010438.60524938)
    expect_equal(mbmix_loglik(mbmixdata, 0.7448, 0.01), -3020437.71988375)

})
