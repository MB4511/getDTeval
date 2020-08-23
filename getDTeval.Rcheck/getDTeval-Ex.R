pkgname <- "getDTeval"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "getDTeval-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('getDTeval')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("getDTeval")
### * getDTeval

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: getDTeval
### Title: getDTeval
### Aliases: getDTeval

### ** Examples

# Using getDTeval to calculate mean age
dat<-formulaic::snack.dat
age.name<-'Age'
getDTeval(the.statement = 'dat[,.(mean_age=mean(get(age.name)))]',return.as = 'result')



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("getDTeval", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
