# Sourcing user .Rprofile if it exists
home_profile <- file.path(
  Sys.getenv("HOME"),
  ".Rprofile"
)
if (file.exists(home_profile)){
  source(home_profile)
}

options(renv.config.pak.enabled = TRUE)

# Fix CRAN version
source("renv/activate.R")
lock_ <- renv:::lockfile(file = "renv.lock")
#
if (grepl("ubuntu 18.04|debian 8", tolower(utils::osVersion))) {
  repos <- c("RSPM" = "https://packagemanager.rstudio.com/all/__linux__/bionic/latest",
             "thinkropen" = "https://thinkr-open.r-universe.dev",
             "CRAN" = "https://cran.rstudio.com")
} else if (grepl("ubuntu 20.04|debian 9", tolower(utils::osVersion))) {
  repos <- c("RSPM" = "https://packagemanager.rstudio.com/all/__linux__/focal/latest",
             "thinkropen" = "https://thinkr-open.r-universe.dev",
             "CRAN" = "https://cran.rstudio.com")
} else if (grepl("centos", tolower(utils::osVersion))) {
  # Important for MacOS users in particular
  repos <- c("RSPM" = "https://packagemanager.rstudio.com/all/__linux__/centos7/latest",
             "thinkropen" = "https://thinkr-open.r-universe.dev",
             "CRAN" = "https://cran.rstudio.com")
} else {
  # Important for MacOS and Windows users in particular
  repos <- c("CRAN" = "https://cran.rstudio.com",
             "RSPM" = "https://cran.rstudio.com",
             "thinkropen" = "https://thinkr-open.r-universe.dev")
}


lock_$repos(.repos = repos)
options(repos = repos)


lock_$write(file = "renv.lock")
rm(lock_)
rm(repos)


renv::activate()

# cache ----
# usethis::edit_r_environ(scope = "project")

renv::settings$use.cache(TRUE)

# Setting shiny.autoload.r to FALSE
options(shiny.autoload.r = FALSE)
