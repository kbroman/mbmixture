context("boostrapNull")

test_that("bootstrapNull works", {

    data(mbmixdata)

    set.seed(20180906)
    expect_equal(bootstrapNull(mbmixdata, 5),  c(0, 0, 1.28785212337971, 0, 0))

    expect_equal(bootstrapNull(mbmixdata, 10, return_raw=FALSE),  0)

})
