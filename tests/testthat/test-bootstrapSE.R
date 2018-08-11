context("boostrapSE")

test_that("bootstrapSE works", {

    data(mbmixdata)

    set.seed(20180811)
    expected <- c(p = 0.000375210152625023, err = 0.0000269087827406382)

    expect_equal(bootstrapSE(mbmixdata, 100), expected)

})
