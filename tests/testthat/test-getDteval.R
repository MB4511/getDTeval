<<<<<<< HEAD:tests/testthat/test-getDteval.R
context('getDteval')
# load package & data
library(data.table)
||||||| merged common ancestors
context('getDTeval')
# load package & data
library(data.table)
=======
context('getDteval')

>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R
library(formulaic)
library(dplyr)
<<<<<<< HEAD:tests/testthat/test-getDteval.R
library(getDTeval)
||||||| merged common ancestors
#library(getDTeval)
=======
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

## variables
<<<<<<< HEAD:tests/testthat/test-getDteval.R
age.name<-"Age"
awareness.name<-"Awareness"
region.name<-"Region"
gender.name<-"Gender"
persona.name<-"Persona"
satisfaction.name <-"Satisfaction"
income.group.name<-"Income Group"
product.name<-"Product"



#1 group by
mean.age.by.region.name = 'mean_age_by_region'

testthat::test_that('calculate mean by region dplyr',
                    {expect_equal(getDTeval(the.statement = 'dat %>%
                                            group_by(get(region.name)) %>%
                                            summarize(eval(mean.age.by.region.name) = mean(get(age.name)))
                                            ', return.as = 'result'),
                                  dat %>%
                                    group_by(Region) %>%
                                    summarize(mean_age_by_region = mean(get(age.name))))
                    })

testthat::test_that('calculate mean by region', {
  expect_equal(getDTeval(the.statement = 'dat[, .(eval(mean.age.by.region.name) =  mean(get(age.name))), keyby = region.name]
                         ', return.as = 'result'),
               dat[, .(mean_age_by_region = mean(get(age.name))), keyby = region.name])
})


#2 filter
mean.age.by.persona.name = 'mean_age_by_persona'
||||||| merged common ancestors
age.name<-"Age"
awareness.name<-"Awareness"
region.name<-"Region"
gender.name<-"Gender"
persona.name<-"Persona"
satisfaction.name <-"Satisfaction"
income.group.name<-"Income Group"
product.name<-"Product"



#1 group by
mean.age.by.region.name = 'mean_age_by_region'

test_that('calculate mean by region dplyr',
          {expect_equal(getDTeval(the.statement = 'dat %>%
                                  group_by(get(region.name)) %>%
                                  summarize(eval(mean.age.by.region.name) = mean(get(age.name)))
                                  ', return.as = 'result'),
                        dat %>%
                          group_by(Region) %>%
                          summarize(mean_age_by_region = mean(get(age.name))))
          })

test_that('calculate mean by region', {
  expect_equal(getDTeval(the.statement = 'dat[, .(eval(mean.age.by.region.name) =  mean(get(age.name))), keyby = region.name]
                         ', return.as = 'result'),
               dat[, .(mean_age_by_region = mean(get(age.name))), keyby = region.name])
})


#2 filter
mean.age.by.persona.name = 'mean_age_by_persona'
=======
age.name <- "Age"
awareness.name <- "Awareness"
region.name <- "Region"
gender.name <- "Gender"
persona.name <- "Persona"
satisfaction.name <- "Satisfaction"
income.group.name <- "Income Group"
product.name <- "Product"
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

<<<<<<< HEAD:tests/testthat/test-getDteval.R
testthat::test_that('calculate mean only for selected persona dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         group_by(Persona) %>%
                         summarise(eval(mean.age.by.persona.name) = mean(get(age.name))) %>%
                         filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))", return.as = 'result'),
||||||| merged common ancestors
test_that('calculate mean only for selected persona dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         group_by(Persona) %>%
                         summarise(eval(mean.age.by.persona.name) = mean(get(age.name))) %>%
                         filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))", return.as = 'result'),
=======
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

<<<<<<< HEAD:tests/testthat/test-getDteval.R
               dat %>%
                 group_by(Persona) %>%
                 summarize(mean_age_by_persona = mean(get(age.name))) %>%
                 filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))
  )
})

testthat::test_that('calculate mean only for selected perosna', {
  expect_equal(
    getDTeval(the.statement = "dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .(eval(mean.age.by.persona.name) = mean(get(age.name))), keyby = persona.name]", return.as = 'result'),
    dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .('mean_age_by_persona' = mean(get(age.name))), keyby = persona.name]
  )})
||||||| merged common ancestors
               dat %>%
                 group_by(Persona) %>%
                 summarize(mean_age_by_persona = mean(get(age.name))) %>%
                 filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))
  )
})

test_that('calculate mean only for selected perosna', {
  expect_equal(
    getDTeval(the.statement = "dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .(eval(mean.age.by.persona.name) = mean(get(age.name))), keyby = persona.name]", return.as = 'result'),
    dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .('mean_age_by_persona' = mean(get(age.name))), keyby = persona.name]
  )})
=======
#1 summarize
mean.age.name <- 'mean_age'
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

#avg age name
avg_age_dplyr <- formulaic::snack.dat %>%
  summarize(mean_age = mean(get(age.name)))

avg_age_getDTeval <- getDTeval(the.statement = 'formulaic::snack.dat %>%
                  summarize(mean_age = mean(Age))',
                               return.as = 'result')

<<<<<<< HEAD:tests/testthat/test-getDteval.R
testthat::test_that('create a new column dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         mutate(eval(age.decade.name) = floor(get(age.name)/10))", return.as ='result'),
               dat %>%
                 mutate(age_decades = floor(get(age.name)/10)))
})
||||||| merged common ancestors
test_that('create a new column dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         mutate(eval(age.decade.name) = floor(get(age.name)/10))", return.as ='result'),
               dat %>%
                 mutate(age_decades = floor(get(age.name)/10)))
})
=======
test_that('calculate mean age with dplyr', {
  expect_equal(avg_age_getDTeval, avg_age_dplyr)
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

<<<<<<< HEAD:tests/testthat/test-getDteval.R
testthat::test_that('create a new column', {
  expect_equal(
    getDTeval('dat[, eval(age.decade.name) := floor(get(age.name)/10)]', return.as = 'result'),
    dat[, age_decades := floor(get(age.name)/10)] )
||||||| merged common ancestors
test_that('create a new column', {
  expect_equal(
    getDTeval('dat[, eval(age.decade.name) := floor(get(age.name)/10)]', return.as = 'result'),
    dat[, age_decades := floor(get(age.name)/10)] )
=======
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R
})

<<<<<<< HEAD:tests/testthat/test-getDteval.R
#devtools::test()

||||||| merged common ancestors
devtools::test()
=======
>>>>>>> edcbc7e63401fcf16c4d8ed06c7f1a6789686537:tests/testthat/test_getDteval.R

# age region age
# mean_age_region_getDTeval <- getDTeval(
#   the.statement = 'formulaic::snack.dat %>%
#                                   group_by(get(region.name)) %>%
#                                   summarize(mean.age.by.region.name = mean(get(age.name)))',
#   return.as = 'result'
# )
#
# mean_age_region_dplyr <- formulaic::snack.dat %>%
#   group_by(Region) %>%
#   summarize(mean.age.by.region.name = mean(get(age.name)))
#
# test_that('calculate mean by region dplyr',
#           {
#             expect_equal(mean_age_region_dplyr$mean.age.by.region.name, mean_age_region_getDTeval$mean.age.by.region.name)
#           })


#2 group by
# mean.age.by.region.name = 'mean_age_by_region'
#
#
#
#
# formulaic::snack.dat %>%
#   group_by(region.name) %>%
#   summarize(mean.age.by.region.name) = mean(get(age.name))
#
#
#
#
# formulaic::snack.dat %>%
#   group_by(get(region.name)) %>%
#   summarise(mean.age.by.region.name = mean(get(age.name)))
#
# test_that('calculate mean by region', {
#   expect_equal(
#     getDTeval(the.statement = 'dat[, .(eval(mean.age.by.region.name) =  mean(get(age.name))), keyby = region.name]
#                          ', return.as = 'result'),
#     dat[, .(mean_age_by_region = mean(get(age.name))), keyby = region.name]
#   )
# })
#
#
# #3 filter
# mean.age.by.persona.name = 'mean_age_by_persona'
#
# test_that('calculate mean only for selected persona dplyr', {
#   expect_equal(
#     getDTeval(
#       the.statement = "dat %>%
#                          group_by(Persona) %>%
#                          summarise(eval(mean.age.by.persona.name) = mean(get(age.name))) %>%
#                          filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))",
#       return.as = 'result'
#     ),
#
#     dat %>%
#       group_by(Persona) %>%
#       summarize(mean_age_by_persona = mean(get(age.name))) %>%
#       filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))
#   )
# })
#
# test_that('calculate mean only for selected perosna', {
#   expect_equal(
#     getDTeval(the.statement = "dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .(eval(mean.age.by.persona.name) = mean(get(age.name))), keyby = persona.name]", return.as = 'result'),
#     dat[get(persona.name) %in% c('Millenial Muncher', 'Old School Oliver'), .('mean_age_by_persona' = mean(get(age.name))), keyby = persona.name]
#   )
# })
#
#
# #4 mutate
# age.decade.name = 'age_decades'
#
# test_that('create a new column dplyr', {
#   expect_equal(
#     getDTeval(
#       the.statement = "dat %>%
#                          mutate(eval(age.decade.name) = floor(get(age.name)/10))",
#       return.as = 'result'
#     ),
#     dat %>%
#       mutate(age_decades = floor(get(age.name) / 10))
#   )
# })
#
# test_that('create a new column', {
#   expect_equal(
#     getDTeval(
#       'dat[, eval(age.decade.name) := floor(get(age.name)/10)]',
#       return.as = 'result'
#     ),
#     dat[, age_decades := floor(get(age.name) / 10)]
#   )
# })
