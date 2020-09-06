context('getDteval')

#1

test_that('calculate mean age', {
  expect_equal(getDTeval(the.statement = 'dat[,.(mean_age=mean(get(age.name)))]',return.as = 'result'),dat[,.(mean_age=mean(get(age.name)))])
})

devtools::test()
