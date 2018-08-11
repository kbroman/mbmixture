# create mbmixdata object and save as .RData file

mbmixdata <- structure(c(3684249, 1293728, 219492, 977787, 545460, 146964,
49243, 36227, 1058, 10159, 185128, 72721, 554641, 519155, 231074,
134408, 232498, 202412), .Dim = c(3L, 3L, 2L), .Dimnames = list(
    c("AA", "AB", "BB"), c("AA", "AB", "BB"), c("A", "B")))

save(mbmixdata, file="../../data/mbmixdata.RData")
