context('getDteval')

library(formulaic)
library(dplyr)

## variables
age.name <- "Age"
awareness.name <- "Awareness"
region.name <- "Region"
gender.name <- "Gender"
persona.name <- "Persona"
satisfaction.name <- "Satisfaction"
income.group.name <- "Income Group"
product.name <- "Product"


#1 summarize
mean.age.name <- 'mean_age'

#avg age name
avg_age_dplyr <- formulaic::snack.dat %>%
  summarize(mean_age = mean(get(age.name)))

avg_age_getDTeval <- getDTeval(the.statement = 'formulaic::snack.dat %>%
                  summarize(mean_age = mean(Age))',
                               return.as = 'result')

test_that('calculate mean age with dplyr', {
  expect_equal(avg_age_getDTeval, avg_age_dplyr)

})


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
