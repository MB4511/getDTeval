context('getDTeval')
# load package & data
library(data.table)
library(formulaic)
library(testthat)
#read snack data
dat<-formulaic::snack.dat
#dat<-setDT(copy(snack.dat))
library(dplyr)
#library(getDTeval)

## variables
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

test_that('calculate mean only for selected persona dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         group_by(Persona) %>%
                         summarise(eval(mean.age.by.persona.name) = mean(get(age.name))) %>%
                         filter(Persona %in% c('Millenial Muncher', 'Old School Oliver'))", return.as = 'result'),

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


#3 mutate
age.decade.name = 'age_decades'

test_that('create a new column dplyr', {
  expect_equal(getDTeval(the.statement = "dat %>%
                         mutate(eval(age.decade.name) = floor(get(age.name)/10))", return.as ='result'),
               dat %>%
                 mutate(age_decades = floor(get(age.name)/10)))
})

test_that('create a new column', {
  expect_equal(
    getDTeval('dat[, eval(age.decade.name) := floor(get(age.name)/10)]', return.as = 'result'),
    dat[, age_decades := floor(get(age.name)/10)] )
})

devtools::test()

