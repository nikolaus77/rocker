% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rocker-package.R
\docType{package}
\name{rocker-package}
\alias{rocker-package}
\alias{_PACKAGE}
\title{rocker: Database Interface Class}
\description{
'R6' class interface for handling relational database connections using 'DBI' package as backend. The class allows handling of connections to e.g. PostgreSQL, MariaDB and SQLite. The purpose is having an intuitive object allowing straightforward handling of SQL databases.
}
\details{
\itemize{
  \item Description of 'rocker' R6 class: \link[rocker:rocker-R6-class]{rocker-R6-class}
  \item Description of S3 functions: \link[rocker:rocker-S3-functions]{rocker-S3-functions}
  \item How-to and examples: \link[rocker:rocker-README]{README}
  \item Additional information and vignettes: \href{https://cran.r-project.org/package=rocker}{CRAN}
}
}
\seealso{
Useful links:
\itemize{
  \item \url{https://github.com/nikolaus77/rocker}
  \item Report bugs at \url{https://github.com/nikolaus77/rocker/issues}
}


Other rocker: 
\code{\link{newDB}()},
\code{\link{rocker-R6-class}},
\code{\link{rocker-README}},
\code{\link{rocker-S3-functions}}

Other rocker-S3-functions: 
\code{\link{appendTable}()},
\code{\link{begin}()},
\code{\link{canConnect}()},
\code{\link{clearResult}()},
\code{\link{columnInfo}()},
\code{\link{commit}()},
\code{\link{connect}()},
\code{\link{createTable}()},
\code{\link{disconnect}()},
\code{\link{execute}()},
\code{\link{existsTable}()},
\code{\link{fetch}()},
\code{\link{getInfoCon}()},
\code{\link{getInfoDrv}()},
\code{\link{getInfoRes}()},
\code{\link{getQuery}()},
\code{\link{getRowCount}()},
\code{\link{getRowsAffected}()},
\code{\link{getStatement}()},
\code{\link{hasCompleted}()},
\code{\link{isValidCon}()},
\code{\link{isValidDrv}()},
\code{\link{isValidRes}()},
\code{\link{listFields}()},
\code{\link{listObjects}()},
\code{\link{listTables}()},
\code{\link{readTable}()},
\code{\link{removeTable}()},
\code{\link{rocker-README}},
\code{\link{rocker-S3-functions}},
\code{\link{rollback}()},
\code{\link{sendQuery}()},
\code{\link{sendStatement}()},
\code{\link{setupDriver}()},
\code{\link{setupMariaDB}()},
\code{\link{setupPostgreSQL}()},
\code{\link{setupSQLite}()},
\code{\link{unloadDriver}()},
\code{\link{validateCon}()},
\code{\link{writeTable}()}
}
\author{
\strong{Maintainer}: Nikolaus Pawlowski \email{niko@fr33.net} [copyright holder]

}
\concept{rocker}
\concept{rocker-S3-functions}
\keyword{internal}
