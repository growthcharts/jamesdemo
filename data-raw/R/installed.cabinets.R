#' Creates a cabinet from donor data
#'
#' This function copies child records from the \code{donorloader} package into an
#' S4 object of class \code{cabinet}. For all gestional ages, the
#' Dutch 1997 references are used to calculate Z-scores.
#' @param dnr Character vector with the name of the donor data
#' @param ids vector of unique (\code{integer}) id numbers for the individuals
#' @param names character vector with names of length \code{length(ids)}
#' @seealso \linkS4class{cabinet}
#' @author Stef van Buuren 2019
create.cabinet.donor <- function(dnr, ids, names = as.character(ids), ...) {
  n <- length(ids)

  # copy individuals
  ind <- vector("list", n)
  names(ind) <- names
  for (i in 1:n) {
    target <- minihealth::donordata_to_individual(dnr = dnr,
                                                  id = ids[i], ...)
    target@name <- names[i]

    # save child in list
    ind[[i]] <- target
  }

  # create the cabinet
  cab <- new("cabinet", ind, readonly = TRUE)

  # change id numbers
  for (i in 1:length(cab)) cab[[i]]@id <- ids[i]
  cab@ids <- sapply(cab, slot, "id")
  validObject(cab)

  return(cab)
}

#' Creates cabinet of 10 children from SMOCC
#'
#' @seealso \linkS4class{cabinet}, \code{\link{create.cabinet.donor}}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2016
create.cabinet.smocc <- function() {
  dnr <- "smocc"
  ids <- as.integer(c(34071, 34072, 34073, 34075, 34076, 34077, 34078, 34079, 34080, 34081))
  names <- c("Laura S", "Thomas S", "Anne S", "Jeroen S",
             "Mark S", "Kevin S", "Linda S", "Iris S",
             "Tim S", "Rick S")
  cab <- create.cabinet.donor(dnr, ids, names)
  return(cab)
}

#' Creates cabinet of children from lollypop
#'
#' @seealso \linkS4class{cabinet}, \code{\link{create.cabinet.donor}}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2020
create.cabinet.preterm <- function() {
  dnr <- "lollypop"
  ids <- as.integer(c(53696, 53675, 53676, 53684, 53519, 53520, 53531, 53582, 53583, 53584))
  names <- c("Jurre P", "Sanne P",  "Milan P", "Roos P",  "Bram P",
             "Freek P", "Anouk P",  "Sharon P", "Nick P", "Simon P")
  cab <- create.cabinet.donor(dnr, ids, names)

  return(cab)
}

#' Creates cabinet of children from POPS survivors at 19 (n = 959)
#'
#' @seealso \linkS4class{cabinet}, \code{\link{create.cabinet.donor}}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2020
create.cabinet.pops <- function() {
  dnr <- "pops"
  ids <- as.integer(c(1, 4, 176, 234, 235, 290, 291, 548, 549, 625))
  names <- c("Angela", "Boris", "Chantalle", "Bonny", "Clyde",
             "Agnetha", "Anni-Frid", "Stan", "Laurel", "Randy")
  cab <- create.cabinet.donor(dnr, ids, names, models = "pops_bs")
  return(cab)
}

#' Creates cabinet of children from terneuzen
#'
#' @seealso \linkS4class{cabinet}, \code{\link{create.cabinet.donor}}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2017
create.cabinet.terneuzen <- function() {
  terneuzen <- load_data(dnr = "terneuzen")
  dnr <- "terneuzen"
  ids <- as.integer(terneuzen$child$id[seq(100, 1000, by = 100)])
  names <- c("T 163", "T 1017",  "T 1413", "T 2035",  "T 2602",
             "T 3254", "T 4207",  "T 5002", "T 5270", "T 6021")
  create.cabinet.donor(dnr, ids, names)
}


#' Creates a cabinet of data from Patricia Graham
#'
#' @seealso \linkS4class{cabinet}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2019
create.cabinet.graham <- function() {
  graham <- load_data(dnr = "graham")
  dnr <- "graham"
  ids <- 1:9
  names <- c("Lotte G", "Tim G", "Hasna G", "Naomi G", "Sven G",
             "Nikki G", "Nienke G", "Femke G", "Bas")
  cab <- create.cabinet.donor(dnr, ids, names)
  return(cab)
}


#' Creates an empty cabinet for 10 children
#'
#' @seealso \linkS4class{cabinet}
#' @return An S4 object of class \code{cabinet}
#' @author Stef van Buuren 2016
create.cabinet.mykids <- function() {
  ids <- as.integer(8001:8010)
  names <- paste("Kind", 1:10)

  n <- length(ids)
  cab <- new("cabinet", n = n)

  # change id numbers and names
  for (i in 1:length(cab)) {
    cab[[i]]@id <- ids[i]
    cab[[i]]@name <- names[i]
    cab[[i]]@src <- "Gebruiker"
  }

  cab@ids <- sapply(cab, slot, "id")
  validObject(cab)

  return(cab)
}


#' Initialize user cabinets
#'
#'This function constructs five user cabinets in a specified environment
#' @param envir environment in which cabinets should be stored
#' @seealso \linkS4class{cabinet}
#' @author Stef van Buuren 2017
init.cabinets <- function(envir) {
  assign("none", new("cabinet", readonly = TRUE), envir = envir)
  assign("smocc", create.cabinet.smocc(), envir = envir)
  assign("preterm", create.cabinet.preterm(), envir = envir)
  assign("pops", create.cabinet.pops(), envir = envir)
  assign("terneuzen", create.cabinet.preterm(), envir = envir)
  assign("graham", create.cabinet.graham(), envir = envir)
  assign("mykids", create.cabinet.mykids(), envir = envir)
  invisible()
}

library(minihealth)
# NOTE: IF YOU WANT TO SAVE DDI, MAKE TEMPORARY FAT VERSION OF donorloader
library(donorloader)
con <- NULL

none <- new("cabinet", readonly = TRUE)
smocc <- create.cabinet.smocc()
preterm <- create.cabinet.preterm()
pops <- create.cabinet.pops()
terneuzen <- create.cabinet.terneuzen()
graham <- create.cabinet.graham()
mykids <- create.cabinet.mykids()

installed.cabinets <- list(none = none,
                           smocc = smocc,
                           preterm = preterm,
                           pops = pops,
                           terneuzen = terneuzen,
                           graham = graham,
                           mykids = mykids)

usethis::use_data(installed.cabinets, overwrite = TRUE)

# now run make_json.R