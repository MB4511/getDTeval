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


#1 summarize dplyr check
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


#2 group by dplyr check
mean.age.by.region.name = 'mean_age_by_region'

#avg age by region
avg_age_by_region_dplyr<-formulaic::snack.dat %>% group_by(Region) %>% summarize(mean_age_by_region = mean(get(age.name)))

avg_age_by_region_getDTeval<- getDTeval(the.statement = 'formulaic::snack.dat %>% group_by(Region) %>% summarize(mean_age_by_region = mean(Age))',return.as='result')


test_that('calculate mean age by region', {
  expect_equal(avg_age_by_region_dplyr, avg_age_by_region_getDTeval)
})

#
#3 mean age by persona
mean.age.by.persona.name = 'mean_age_by_persona'

getdteval_meanagebypersona<-getDTeval(the.statement = "formulaic::snack.dat %>% group_by(Persona) %>% summarize(mean_age_by_persona = mean(Age))", return.as = 'result')

dplyr_meanagebypersona<-formulaic::snack.dat %>% group_by(Persona) %>% summarize(mean_age_by_persona = mean(get(age.name)))

test_that('calculate mean age by persona', {
 expect_equal(getdteval_meanagebypersona,dplyr_meanagebypersona)
})

#4 mutate dplyr check
age.decade.name = 'age_decades'

test_that('create a new column dplyr', {
 expect_equal(getDTeval(the.statement = "formulaic::snack.dat%>% mutate(age_decades = floor(Age/10))",return.as = 'result'), formulaic::snack.dat %>% mutate(age_decades = floor(get(age.name) / 10)))
})

#5 mutate data.table check
test_that('create a new column', {
 expect_equal(getDTeval('formulaic::snack.dat[, age_decades := floor(Age/10)]', return.as = 'result'), formulaic::snack.dat[, age_decades := floor(get(age.name) / 10)])
})
