#' function.ending.point
#'
#' @description An Internal function to return the ending index
#'
#' @param all.chars all the characters of the statement
#' @param beginning.index specifies the index of the first character
#' @param ... provision for additional arguments
#' @export

function.ending.point <- function(all.chars, beginning.index, ...) {
  len <- length(all.chars)
  open.parens <- cumsum(x = all.chars[beginning.index:len] == "(")
  closed.parens <- cumsum(x = all.chars[beginning.index:len] == ")")

  ending.index <-
    beginning.index - 1 + min(which(open.parens > 0 &
                                      open.parens == closed.parens))
  return(ending.index)
}

#' translate.fn.calls
#'
#' @description Internal Function that translates programmatic designs into optimized coding statements for faster calculations
#'
#' @param the.statement original coding statement to perform the required calculation. Must be provided as a character value.
#' @param function.name Name of the function to be translated to an optimized form. Parameter values should be either 'get(' or 'eval('. 'get(' is set as default
#' @param envir Specify the environment for the required function. .GlobalEnv is set as default
#' @param ... provision for additional arguments
#' @export


translate.fn.calls <- function(the.statement, function.name = "get(", envir = .GlobalEnv, ...){

  fn.chars <- strsplit(x = function.name, split = "")[[1]]
  all.chars <- strsplit(x = the.statement, split = "")[[1]]

  first.chars <- which(all.chars == fn.chars[1])

  the.begin <- first.chars[as.logical(lapply(X = first.chars, FUN = function(x){return(paste(all.chars[x:(x+length(fn.chars)-1)], collapse = "") == function.name)}))]

  len <- length(the.begin)
  if(len > 0){
    for(i in 1:length(the.begin)){
      the.end <- function.ending.point(all.chars = all.chars, beginning.index = the.begin[i], ...)
      the.call <- paste(all.chars[the.begin[i]:the.end], collapse = "")
      arg <- trimws(x = gsub(pattern = function.name, replacement = "eval(", x = the.call, fixed = TRUE), which = "both")

      evaluated.arg <- eval(expr = parse(text = arg), envir = envir)

      if(function.name == "eval("){
        evaluated.arg <- sprintf("'%s'", evaluated.arg)
      }
      all.chars[the.begin[i]:the.end] <- ""
      all.chars[the.begin[i]] <- evaluated.arg
    }
  }
  the.statement <- paste(all.chars, collapse = "")
  return(the.statement)
}


#' @title getDTeval
#'
#' @description The getDTeval() function facilitates the translation of the original coding statement to an optimized form for improved runtime efficiency without compromising on the programmatic coding design.  The function can either provide a translation of the coding statement, directly evaluate the translation to return a coding result, or provide both of these outputs
#'
#' @param the.statement refers to the original coding statement which needs to be translated to an optimized form.  This value may be entered as either a character value or as an expression.
#' @param return.as refers to the mode of output. It could return the results as a coding statement (return.as = "code"), an evaluated coding result (return.as = "result", which is the default value), or a combination of both (return.as = "all").
#' @param coding.statements.as determines whether the coding statements provided as outputs are returned as expression objects (return.as = "expression") or as character values (return.as = "character", which is the default).
#' @param eval.type a character value stating whether the coding statement should be evaluated in its current form (eval.type = "as.is") or have its called to get() and eval() translated (eval.type = "optimized", the default setting).
#' @param envir Specify the environment for the required function. .GlobalEnv is set as default
#' @param ... provision for additional arguments
#' @examples
#' # Using getDTeval to calculate mean age
#' dat<-formulaic::snack.dat
#' age.name<-'Age'
#' getDTeval(the.statement = 'dat[,.(mean_age=mean(get(age.name)))]',return.as = 'result')
#' @export

getDTeval <- function(the.statement, return.as = "result", coding.statements.as = "character", eval.type = "optimized", envir = .GlobalEnv, ...){

  value.result <- "result"
  value.as.is <- "as.is"
  value.all <- "all"
  value.optimized <- "optimized"
  value.code <- "code"
  value.expression <- "expression"

  if(!is.character(the.statement) & !is.expression(x = the.statement)){
    stop("Error:  the.statement must be a character or expression.")
  }

  the.original.statement <- the.statement

  the.statement <- gsub(pattern = "\"", replacement = "'", x = the.statement, fixed = T)

  if(!is.character(return.as)){
    return.as <- value.result
  }
  if(!(return.as %in% c(value.result, value.code, value.all))){
    return.as <- value.result
  }
  if(!is.character(eval.type)){
    eval.type <- value.optimized
  }
  if(!(eval.type %in% c(value.optimized, value.as.is))){
    eval.type <- value.optimized
  }

  the.statement <- as.character(the.statement)

  if(eval.type != value.as.is){
    pattern.get <- "get("
    pattern.eval <- "eval("

    num.get.calls <- length(grep(pattern = pattern.get, x = the.statement, fixed = TRUE))
    num.eval.calls <- length(grep(pattern = pattern.eval, x = the.statement, fixed = TRUE))

    if(num.get.calls > 0 | num.eval.calls > 0){
      the.statement <- translate.fn.calls(the.statement = the.statement, function.name = pattern.get, envir = envir, ...)

      the.statement <- translate.fn.calls(the.statement = the.statement, function.name = pattern.eval, envir = envir, ...)
    }
  }

  if(return.as %in% c(value.code)){
    if(coding.statements.as == value.expression){
      return(str2expression(text = the.statement))
    }
    return(the.statement)
  }

  the.result <- eval(expr = parse(text = the.statement), envir = envir)

  names(the.result) <- gsub(pattern = "`", replacement = "", x = names(the.result))

  if(return.as == value.all){
    if(coding.statements.as == value.expression){

      the.statement <- str2expression(the.statement)
      if(!is.expression(the.original.statement)){
        the.original.statement <- str2expression(the.original.statement)
      }
      return(list(result = the.result, code = the.statement, original.statement = the.original.statement))
    }

    return(list(result = the.result, code = the.statement, original.statement = the.original.statement))
  }

  return(the.result)
}
