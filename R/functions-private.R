
# encrypt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

generateKey <- function()
  return(sodium::keygen())

encrypt <- function(OBJECT, KEY)
  return(sodium::data_encrypt(serialize(OBJECT, NULL), KEY))

decrypt <- function(OBJECT, KEY)
  return(unserialize(sodium::data_decrypt(OBJECT, KEY)))

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
    AVAIABLE[[i]] <- tryCatch({
      eval(parse(text = paste0(PACKAGE, "::", i)))
      TRUE
    }, error = function(COND) return(FALSE),
    warning = function(COND) return(FALSE))
  }
  return(AVAIABLE)
}

testParameterNames <- function(PAR, FORBIDDEN = NULL, OBLIGATORY = NULL) {
  if (!is.null(PAR)) {
    if (!is.null(FORBIDDEN))
      if (any(FORBIDDEN %in% names(PAR)))
        error(paste("Parameter forbidden:", paste(paste0("'", names(PAR)[names(PAR) %in% FORBIDDEN], "'"), collapse = ", ")))
    if (!is.null(OBLIGATORY))
      if (!all(OBLIGATORY %in% names(PAR)))
        error(paste("Parameter obligatory:", paste(paste0("'", OBLIGATORY[!(OBLIGATORY %in% names(PAR))], "'"), collapse = ", ")))
  }
}

testParameterString <- function(PAR, LENGTH = 1) {
  if (!is.na(LENGTH))
    if (length(PAR) != LENGTH)
      error("Parameter not correct")
  if (!is.character(PAR))
    error("Parameter not correct")
}

testParameterWholeNumber <- function(PAR, LENGTH = 1) {
  if (!is.na(LENGTH))
    if (length(PAR) != LENGTH)
      error("Parameter not correct")
  if (!is.numeric(PAR))
    error("Parameter not correct")
  if (any(PAR %% 1 != 0))
    error("Parameter not correct")
}

testParameterStringWholeNumber <- function(PAR, LENGTH = 1) {
  OUT1 <- tryCatch({
    testParameterString(PAR, LENGTH)
    TRUE
  }, error = function(COND) {
    FALSE
  })
  OUT2 <- tryCatch({
    testParameterWholeNumber(PAR, LENGTH)
    TRUE
  }, error = function(COND) {
    FALSE
  })
  if (!(OUT1 | OUT2))
    error("Parameter not correct")
}

testParameterBoolean <- function(PAR, LENGTH = 1) {
  if (!is.na(LENGTH))
    if (length(PAR) != LENGTH)
      error("Parameter not correct")
  if (!is.logical(PAR) | any(is.na(PAR)))
    error("Parameter not correct")
}

testParameterDataFrame <- function(PAR) {
  if (!is.data.frame(PAR))
    error("Parameter not correct")
}

testParameterObject <- function(PAR) {
  if (!is.object(PAR) | is.data.frame(PAR))
    error("Parameter not correct")
}

testDots <- function(DOTS) {
  if (!is.null(DOTS) & length(DOTS) > 0) {
    TEST <- TRUE
    if (is.null(names(DOTS))) {
      TEST <- FALSE
    } else if (any(names(DOTS) == "")) {
      TEST <- FALSE
    } else if (length(names(DOTS)) != length(DOTS)) {
      TEST <- FALSE
    }
    if (!TEST)
      error("All ... arguments must be named")
  }
}
