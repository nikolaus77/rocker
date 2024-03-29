% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rocker-S3-functions.R
\name{createTable}
\alias{createTable}
\title{Create empty formatted table.}
\usage{
createTable(db, name, fields, ...)
}
\arguments{
\item{db}{rocker object}

\item{name}{Table name}

\item{fields}{Template data.frame}

\item{...}{Optional, additional suitable parameters passed to \code{\link[DBI:dbCreateTable]{DBI::dbCreateTable()}}}
}
\value{
Invisible self
}
\description{
Create empty formatted table.
}
\examples{
db <- rocker::newDB()
rocker::setupSQLite(db)
rocker::connect(db)
rocker::createTable(db, "mtcars", mtcars)
rocker::disconnect(db)
rocker::unloadDriver(db)
}
\seealso{
Other rocker-S3-functions: 
\code{\link{appendTable}()},
\code{\link{begin}()},
\code{\link{canConnect}()},
\code{\link{clearResult}()},
\code{\link{columnInfo}()},
\code{\link{commit}()},
\code{\link{connect}()},
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
\code{\link{rocker-package}},
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
\concept{rocker-S3-functions}
