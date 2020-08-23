#' benchmark.getDTeval
#'
#' @description Performs a benchmarking experiment for data.table coding statements that use get() or eval() for programmatic designs.  The a) original statement is compared to b) passing the original statement through getDTeval and also to c) an optimized coding statement.  The results can demonstrate the overall improvement of using the coding translations offered by getDTeval()
#'
#' @param the.statement refers to the original coding statement which needs to be translated to an optimized form.  This value may be entered as either a character value or as an expression.
#' @param times The number of iterations to run the benchmarking experiment
#' @param seed an integer value specifying the seed of the pseudorandom number generator.
#' @param envir The environment in which the calculation takes place, with the global environment .GlobalEnv set as the default.
#' @param ... provision for additonal arguments
#' @import microbenchmark
#' @import data.table
#' @import stats
#' @import utils
#' @examples
#' # Using benchmark.getDteval to compare runtime performance of original coding statement, optimized statement and getDteval statement while calculating the mean age
#' dat<-formulaic::snack.dat
#' benchmark.getDTeval(the.statement = 'dat[,.(mean_age=mean(Age))]', times = 50, seed = 282)
#' @export
#NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("category","seconds","."))


benchmark.getDTeval <- function(the.statement, times = 30, seed = 47, envir = .GlobalEnv, ...){

  set.seed(seed = seed)

  if(!is.character(the.statement) & !is.expression(x = the.statement)){
    return("Error:  the.statement must be a character or expression.")
  }

  translated.statement <- getDTeval(the.statement = the.statement, return.as = "code", envir = envir)

  times.translated <- as.data.table(microbenchmark(eval(parse(text = translated.statement)), times = times))
  times.translated[, category := "optimized coding statement"]


  times.dt <- as.data.table(microbenchmark(eval(parse(text = the.statement)), times = times))
  times.dt[, category := "original coding statement"]

  times.getDTeval <- as.data.table(microbenchmark(getDTeval(the.statement = the.statement, return.as = "result", envir = envir), times = times))
  times.getDTeval[, category := "getDTeval statement"]


  res <- rbindlist(l = list(times.translated, times.dt, times.getDTeval), fill = TRUE)
  res[, seconds := time / (10^9)]

  the.tab <- res[, .(metric = names(summary(seconds)), seconds = summary(seconds)), keyby = "category"]

  the.summary <- dcast.data.table(data = the.tab, formula = category ~ metric, value.var = "seconds")

  setcolorder(x = the.summary, neworder = c("category", "Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max."))

  setorderv(x = the.summary, cols = "Mean")

  return(the.summary)
}




