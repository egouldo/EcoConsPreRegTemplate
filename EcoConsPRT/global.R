library(shiny)
library(shinyWidgets)
library(shinyjs)
library(shinyBS)
library(shinyFeedback)
library(shinyanimate)
library(shinythemes)
library(shinycssloaders)
library(bsplus)
library(jsonlite)
library(RCurl) # for checking whether url.exists
library(digest)
library(knitr)
library(markdown)

source("R/helpers.R")
source("R/validation.R")
source("R/renderPDF.R")

# First, we load the .json, which defines the structure of the application
questions <- jsonlite::read_json(path = "data/questions.json")
headList <- questions$Head
sectionsList <- questions$Sections
answerList <- questions$Answers


# Name the questions (ind_1 ... ind_n) - this slightly reduces the tedious filling in of question numbers in .json
# and reduces the likelihood of a manual mistake.
ind <- 1
sectionsList <- lapply(sectionsList, function(Sec){
  Sec$Questions <- lapply(Sec$Questions, function(x) {

    if(is.null(x$Name)){ # create names for questions in format ind_number of question
      x <- c(x, Name = paste0("ind_", ind))

      # add the number of the question to the question label
      x$Label <- paste0("(", ind, ") ", x$Label)
      ind <<- ind + 1
    }

    x
  })

  Sec$Value <- digest::digest(Sec$Name)

  Sec
})


# write html code for sections prior opening the app
sectionsHTML <- lapply(sectionsList, renderSection)
names(sectionsHTML) <- NULL
sectionsHTML <- do.call(tabsetPanel, c(sectionsHTML, id = "sections"))

# write html code for heading
headHTML <- lapply(headList, switchButtons)