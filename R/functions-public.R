
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
