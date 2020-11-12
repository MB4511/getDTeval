#' @title benchmark.getDTeval
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
#' #Benchmarking runtime performances in calculating mean age
#' dat<-formulaic::snack.dat
#' age.name<-'Age'
#' benchmark.getDTeval(the.statement = "dat[,.(mean_age=mean(get(age.name)))]", times = 5,  seed = 10)
#' @export


benchmark.getDTeval <- function(the.statement, times = 30, seed = 47, envir = .GlobalEnv, ...){

  set.seed(seed = seed)

  category.name <- "category"
  seconds.name <- "seconds"
  metric.name <- "metric"


  if(!is.character(the.statement) & !is.expression(x = the.statement)){
    return("Error:  the.statement must be a character or expression.")
  }

  translated.statement <- getDTeval(the.statement = the.statement, return.as = "code", envir = envir)

  times.translated <- as.data.table(microbenchmark(eval(parse(text = translated.statement)), times = times))
  times.translated[, eval(category.name) := "optimized coding statement"]


  times.dt <- as.data.table(microbenchmark(eval(parse(text = the.statement)), times = times))
  times.dt[, eval(category.name) := "original coding statement"]

  times.getDTeval <- as.data.table(microbenchmark(getDTeval(the.statement = the.statement, return.as = "result", envir = envir), times = times))
  times.getDTeval[, eval(category.name) := "getDTeval statement"]


  res <- rbindlist(l = list(times.translated, times.dt, times.getDTeval), fill = TRUE)
  res[, eval(seconds.name) := time / (10^9)]

  the.tab.names <- res[, names(summary(get(seconds.name))), keyby = category.name]
  setnames(x = the.tab.names, old = "V1", new = metric.name)
  the.tab.names$Index <- 1:nrow(the.tab.names)

  the.tab.seconds <- res[, summary(get(seconds.name)), keyby = category.name]
  setnames(x = the.tab.seconds, old = "V1", new = seconds.name)
  the.tab.seconds$Index <- 1:nrow(the.tab.names)

  the.tab <- merge(x = the.tab.names, y = the.tab.seconds, by = c("Index", category.name))

  the.tab$Index <- NULL

  the.summary <- dcast.data.table(data = the.tab, formula = category ~ metric, value.var = seconds.name)

  setcolorder(x = the.summary, neworder = c(category.name, "Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max."))

  setorderv(x = the.summary, cols = "Mean")

  return(the.summary)
}




