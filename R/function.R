
# public ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' newDB
#' @description Function generates a new \link{R6} database handling interface with \link{DBI} backend.
#' For more information, see \link[rocker:rocker]{rocker} class description.
#' @param verbose TRUE or FALSE. Switch text output on / off.
#' @param id Optional object ID/name
#' @param ... Not used yet
#' @return New instance of rocker class
#' @examples
#' db <- rocker::newDB()
#' @export
newDB <- function(verbose = TRUE, id = NULL, ...)
  return(rocker$new(verbose, id, ...))

# encrypt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

generateKey <- function()
  return(as.raw(sample(0:255, 32, replace = TRUE)))

encrypt <- function(OBJECT, KEY)
  return(safer::encrypt_object(OBJECT, key = KEY))

decrypt <- function(OBJECT, KEY)
  return(safer::decrypt_object(OBJECT, key = KEY))

# comm ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

error <- function(TEXT, WARNING = FALSE) {
  if (WARNING) {
    warning(TEXT, call. = FALSE)
  } else {
    stop(TEXT, call. = FALSE)
  }
}

# test ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

testPackages <- function(PACKAGES) {
  INSTALLED <- list()
  for (i in PACKAGES)
    INSTALLED[[i]] <- requireNamespace(i, quietly = TRUE)
  return(INSTALLED)
}

testPackageFunctions <- function(PACKAGE, FUNCTIONS) {
  AVAIABLE <- list()
  for (i in FUNCTIONS) {
    AVAIABLE[[i]] <- tryCatch(
      {
        eval(parse(text = paste0(PACKAGE, "::", i)))
        TRUE
      },
      error = function(COND) return(FALSE),
      warning = function(COND) return(FALSE)
    )
  }
  return(AVAIABLE)
}

testParameter <- function(PAR, FORBIDDEN = NULL, OBLIGATORY = NULL) {
  if (!is.null(PAR)) {
    if (!is.null(FORBIDDEN))
      if (any(FORBIDDEN %in% names(PAR)))
        error(paste("Parameter forbidden:", paste(paste0("'", names(PAR)[names(PAR) %in% FORBIDDEN], "'"), collapse = ", ")))
    if (!is.null(OBLIGATORY))
      if (!all(OBLIGATORY %in% names(PAR)))
        error(paste("Parameter obligatory:", paste(paste0("'", OBLIGATORY[!(OBLIGATORY %in% names(PAR))], "'"), collapse = ", ")))
  }
}
