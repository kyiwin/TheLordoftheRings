#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinydashboard)

# Define UI for application that draws a histogram
#library(shinydashboard)
library(shinythemes)
#library(TheLordoftheRings)
library(wordcloud2)
library(NLP)
library(RColorBrewer)
library(extrafont)
library(plotly)
library(radarchart)

dashboardPage(
  dashboardHeader(title = "The Lord of the Rings" , titleWidth = 350),
  dashboardSidebar(width = 350, sidebarMenu(
    
    menuItem("Frequent Word", icon = icon("eye"), tabName = "freqword",
             badgeLabel = "wordclouds", badgeColor = "fuchsia"),
    menuItem("Sentiment Analysis", icon = icon("eye"), tabName = "sentiment",
             badgeLabel = "", badgeColor = "fuchsia"),
    menuItem("Sentiment Analysis with index", icon = icon("eye"), tabName = "topmol",
             badgeLabel = "", badgeColor = "purple"),
    menuItem("Sentiment Analysis with different lexicons", icon = icon("eye"), tabName = "dflex",
             badgeLabel = "", badgeColor = "purple"),
    menuItem("Most common positive vs negative words", icon = icon("eye"), tabName = "commpn",
             badgeLabel = "", badgeColor = "purple"),
    menuItem("Document Similarity", icon = icon("eye"), tabName = "docsim",
             badgeLabel = "", badgeColor = "purple")
  )),
  skin = "red",
  dashboardBody(tabItems(
    tabItem(tabName = "dashboard",
            h2("Dashboard tab content")

    ),

    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    ),
    tabItem(tabName = "freqword",
            h2("Finding the most common word from each book"),
            fluidPage(
              h1("Word Cloud"),
              # Add a numeric input for the number of words
              numericInput(inputId = "num", label = "Maximum number of words",
                           value = 100, min = 5),
              # Add a colour input for the background colour
              selectInput("selection", "Choose a book:", choices = c("Book1_TheRingsetsout" = paste0(list(Book1_TheRingsetsout)),
                                                                     "Book2_TheRinggoessouth" = paste0(list(Book2_TheRinggoessouth)),
                                                                     "Book3_TheTreasonofIsengard" = paste0(list(Book3_TheTreasonofIsengard)),
                                                                     "Book4_TheRinggoesEast" = paste0(list(Book4_TheRinggoesEast)),
                                                                     "Book5_TheWaroftheRing" = paste0(list(Book5_TheWaroftheRing)),
                                                                     "Book6_TheEndoftheThirdAge" = paste0(list(Book6_TheEndoftheThirdAge)))
                          ),
              wordcloud2Output("cloud")
            )
    ),
    tabItem(tabName = "docsim",
            h2("Document Similarity"),
            fluidPage(
              selectInput("selection_1", "Choose first book to compare:", choices = c("Book1_TheRingsetsout" = paste0(list(Book1_TheRingsetsout)),
                                                                       "Book2_TheRinggoessouth" = paste0(list(Book2_TheRinggoessouth)),
                                                                       "Book3_TheTreasonofIsengard" = paste0(list(Book3_TheTreasonofIsengard)),
                                                                       "Book4_TheRinggoesEast" = paste0(list(Book4_TheRinggoesEast)),
                                                                       "Book5_TheWaroftheRing" = paste0(list(Book5_TheWaroftheRing)),
                                                                       "Book6_TheEndoftheThirdAge" = paste0(list(Book6_TheEndoftheThirdAge)))
              ),
              selectInput("selection_2", "Choose second book to compare:", choices = c("Book1_TheRingsetsout" = paste0(list(Book1_TheRingsetsout)),
                                                                       "Book2_TheRinggoessouth" = paste0(list(Book2_TheRinggoessouth)),
                                                                       "Book3_TheTreasonofIsengard" = paste0(list(Book3_TheTreasonofIsengard)),
                                                                       "Book4_TheRinggoesEast" = paste0(list(Book4_TheRinggoesEast)),
                                                                       "Book5_TheWaroftheRing" = paste0(list(Book5_TheWaroftheRing)),
                                                                       "Book6_TheEndoftheThirdAge" = paste0(list(Book6_TheEndoftheThirdAge)))
              ),
              verbatimTextOutput("cosine")
            )),
    tabItem(tabName = "sentiment",
            h2("Sentiment Analysis"),
            fluidPage(
              selectInput("selection_3", "Choose a book:", choices = c("Book1_TheRingsetsout" = paste0(list(Book1_TheRingsetsout)),
                                                                                      "Book2_TheRinggoessouth" = paste0(list(Book2_TheRinggoessouth)),
                                                                                      "Book3_TheTreasonofIsengard" = paste0(list(Book3_TheTreasonofIsengard)),
                                                                                      "Book4_TheRinggoesEast" = paste0(list(Book4_TheRinggoesEast)),
                                                                                      "Book5_TheWaroftheRing" = paste0(list(Book5_TheWaroftheRing)),
                                                                                      "Book6_TheEndoftheThirdAge" = paste0(list(Book6_TheEndoftheThirdAge)))
              ),
              chartJSRadarOutput("sentiment")

            )),
    tabItem(tabName = "topmol",
            h2("Sentiment analysis in the course of narrative"),
            h3("Positive vs Negative sentiments"),
            fluidPage(

              plotlyOutput("topmol", height = 700)

              ),
            h5("index keep track of where you are in narrative")
    ),
    tabItem(tabName = "dflex",
          h3("Sentiment analysis with different lexicon"),
          h4("Positive vs Negative sentiments"),
         # mainPanel(
          fluidPage(
            #tabsetPanel(
            plotlyOutput("topmol1", height = 700)
            #tabPanel("Lexicon", plotlyOutput("topmol1", height = 700)),
            #tabPanel("Narrative", plotlyOutput("topmol", height = 700))
         # )
          ),
          h5(" Index keep track of where you are in narrative "),
          h5(" AFINN represents Finn Arup Nielsen, gives the largest absolute values, with high positive values"),
          h5(" bing represents Bing Liu and collaborators, has lower absolute values and seems to label larger blocks of contiguous positive or negative text"),
          h5(" nrc represents Saif Mohammad and Peter Turney, esults are shifted higher relative to the other two, labeling the text more positively, but detects similar relative changes in the text")
  ),
    tabItem(tabName = "commpn",
          h2("Most common positive and negative words"),
          mainPanel(

            tabsetPanel(
              tabPanel("Bar",plotlyOutput("topmol2", height = 700, width = 1300)),
              tabPanel("Word cloud",plotOutput("topmol3", height = 760, width = 700))
    

          )
          )
 )
 
)
))
