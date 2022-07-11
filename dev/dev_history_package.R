# Hide this file from build
usethis::use_build_ignore("dev")
usethis::use_build_ignore("ci/lib")
usethis::use_build_ignore("rsconnect")
usethis::use_git_ignore("docs/")
usethis::use_git_ignore("rsconnect/")
# usethis::create_package(".")

# Vaccinate for MacOS
usethis::git_vaccinate()
usethis::use_git_ignore(c(".DS_Store", ".Rproj.user", ".Rdata", ".Rhistory", ".httr-oauth"))

# description ----
library(desc)
unlink("DESCRIPTION")
# Utiliser `thinkridentity::get_author()` pour aider à remplir DESCRIPTION'
thinkridentity::get_author()

my_desc <- description$new("!new")
my_desc$set_version("0.0.0.9000")
my_desc$set(Package = "deeptools")
my_desc$set(Title = "Tools to analyze video images")
my_desc$set(Description = "Images were analyzed in a game. This package explores the results of the game.")
my_desc$set("Authors@R",
            'c(
  person("Sebastien", "Rochette", email = "sebastien@thinkr.fr", role = c("aut", "cre"), comment = c(ORCID = "0000-0002-1565-9313")),
  person("Colin", "Fay", email = "colin@thinkr.fr", role = c("aut"), comment = c(ORCID = "0000-0001-7343-1846")),
  person("Vincent", "Guyader", email = "vincent@thinkr.fr", role = c("aut"), comment = c(ORCID = "0000-0003-0671-9270")),
  person(given = "ThinkR", role = "cph")
)')
my_desc$set("VignetteBuilder", "knitr")
my_desc$del("Maintainer")
my_desc$del("URL")
my_desc$del("BugReports")
my_desc$write(file = "DESCRIPTION")

# Licence ----
usethis::use_proprietary_license("ThinkR")
# usethis::use_mit_license("ThinkR")

# Pipe ----
usethis::use_pipe()

# Data
dir.create("inst")
dir.create("inst/excel_files")

# Package quality ----

# _Tests ----
usethis::use_testthat()
usethis::use_test("app")

# _CI (cf {gitlabr} templates) ----
thinkridentity::use_gitlab_ci(image = "rocker/verse",
                              gitlab_url = "https://forge.thinkr.fr",
                              repo_name = "https://packagemanager.rstudio.com/all/__linux__/focal/latest",
                              type = "check-coverage-pkgdown") # "check-coverage-pkgdown-renv"
# GitLab MR and git commit templates
thinkridentity::add_gitlab_templates()

# Add kit package ----
thinkridentity::add_kit_package(type = c("package", "deliverables"))
thinkridentity::add_kit_project()

# GitHub Actions ----
# usethis::use_github_action_check_standard()
# usethis::use_github_action("pkgdown")
#  _Add remotes::install_github("ThinkR-open/thinkrtemplate") in this action
# usethis::use_github_action("test-coverage")


# _rhub
# rhub::check_for_cran()


# Documentation ----
# _Readme
# usethis::use_readme_rmd()
chameleon::generate_readme_rmd()
chameleon::generate_readme_rmd(parts = "description")
# CoC
usethis::use_code_of_conduct()
# Contributing
usethis::use_tidy_contributing()

# _Badges GitLab
usethis::use_badge(badge_name = "pipeline status",
                   href = "https://forge.thinkr.fr/<group>/<project>/-/commits/master",
                   src = "https://forge.thinkr.fr/<group>/<project>/badges/master/pipeline.svg")
usethis::use_badge(badge_name = "coverage report",
                   href = "http://<group>.pages.thinkr.fr/<project>/coverage.html",
                   src = "https://forge.thinkr.fr/<group>/<project>/badges/master/coverage.svg")

# _News
usethis::use_news_md()

# package-level documentation
usethis::use_package_doc()

# _Vignette
file.copy(system.file("templates/html/header_hide.html", package = "thinkridentity"),
          "vignettes")
thinkridentity::add_thinkr_css(path = "vignettes")

thinkridentity::create_vignette_thinkr("aa-data-exploration")
# usethis::use_vignette("ab-model")
devtools::build_vignettes()


# _Book
# remotes::install_github(repo = "ThinkR-open/chameleon")
chameleon::create_book("inst/report", clean = TRUE)
chameleon::open_guide_function()
devtools::document()
chameleon::build_book(clean_rmd = TRUE, clean = TRUE)
# pkg::open_guide()

# _Pkgdown - Pas besoin d'inclure le pkgdown pour un projet open-source avec un gh-pages
usethis::use_pkgdown()
# pkgdown::build_site() # pour tests en local
chameleon::build_pkgdown(
  # lazy = TRUE,
  yml = system.file("pkgdown/_pkgdown.yml", package = "thinkridentity"),
  favicon = system.file("pkgdown/favicon.ico", package = "thinkridentity"),
  move = TRUE, clean_before = TRUE, clean_after = TRUE
)

chameleon::open_pkgdown_function(path = "docs")
# pkg::open_pkgdown()

# Dependencies ----
## Ce qu'il faut avant d'envoyer sur le serveur
# devtools::install_github("ThinkR-open/attachment")
# attachment::att_amend_desc(extra.suggests = c("bookdown"))
# attachment::create_dependencies_file()
attachment::att_amend_desc()
# Cela est normal : "Error in eval(x, envir = envir) : object 'db_local' not found"
devtools:check()



# Description and Bibliography
chameleon::create_pkg_desc_file(out.dir = "inst", source = c("archive"), to = "html")
thinkridentity::create_pkg_biblio_file_thinkr()

# Utils for dev ----
# Get global variables
checkhelper::print_globals()
# Install
devtools::install(upgrade = "never")
# devtools::load_all()
devtools::check(vignettes = TRUE)
# ascii
stringi::stri_trans_general("é", "hex")


