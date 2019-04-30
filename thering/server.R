#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(shiny)
library(tidytext)
library("tm")
#library("SnowballC")
library("wordcloud")
#library("RColorBrewer")
library(ggplot2)
library(tidyr)
library(TheLordoftheRings)
library(wordcloud2)
library(text2vec)
library(stringr)
library(ngram)
library(stringi)
library(dplyr)
library(tidytext)
library(stringr)
library(tibble)
library(radarchart)
library(topicmodels)
library(quanteda)
library(reshape2)

create_wordcloud <- function(data, num_words = 100, background = "white") {

  # If text is provided, convert it to a dataframe of word frequencies
  if (is.character(data)) {
    corpus <- Corpus(VectorSource(data))
    corpus <- tm_map(corpus, tolower)
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
    tdm <- as.matrix(TermDocumentMatrix(corpus))
    data <- sort(rowSums(tdm), decreasing = TRUE)
    data <- data.frame(word = names(data), freq = as.numeric(data))
  }

  # Make sure a proper num_words is provided
  if (!is.numeric(num_words) || num_words < 3) {
    num_words <- 3
  }

  # Grab the top n most common words
  data <- head(data, n = num_words)
  if (nrow(data) == 0) {
    return(NULL)
  }
  wordcloud2(data, backgroundColor = "lightgray")
}


cleanfor_cosinesim <- function(data) {

  # If text is provided, convert it to a dataframe of word frequencies
  if (is.character(data)) {
    corpus <- Corpus(VectorSource(data))
    corpus <- tm_map(corpus, tolower)
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
  }
}

prep_fun <- function(x) {
  x %>%
    # make text lower case
    str_to_lower %>%
    # remove non-alphanumeric symbols
    str_replace_all("[^[:alnum:]]", " ") %>%
    # collapse multiple spaces
    str_replace_all("\\s+", " ")
}

Legolas <- function(string){
  temp <- tolower(string)
  temp <- stringr::str_replace_all(temp, "[^a-zA-Z\\s]", " ")
  temp <- stringr::str_replace_all(temp, "[\\s]+", " ")
  temp <- stringr::str_split(temp, " ")[[1]]
  index <- which(temp == "")
  if(length(index) > 0){
    temp <- temp[-index]
  }
  return(temp)
}

server <- function(input, output) {
  #wordcloud
  formulaText <- reactive({
    paste(input$selection)

  })
  output$cloud <- renderWordcloud2({
    # Use the values from the two inputs as
    # parameters to the word cloud

    create_wordcloud(formulaText(),
                     num_words = input$num
                     )
  })
  #cosine similarity
  datainput <- reactive({
    paste(input$selection_1, "Book1_TheRingsetsout" = Book1_TheRingsetsout, "Book2_TheRinggoessouth" = Book2_TheRinggoessouth,
         "Book3_TheTreasonofIsengard" = Book3_TheTreasonofIsengard, "Book4_TheRinggoesEast" = Book4_TheRinggoesEast,
          "Book5_TheWaroftheRing" = Book5_TheWaroftheRing,
          "Book6_TheEndoftheThirdAge" = Book6_TheEndoftheThirdAge)
  })
  datainput2 <- reactive({
    paste(input$selection_2, "Book1_TheRingsetsout" = Book1_TheRingsetsout, "Book2_TheRinggoessouth" = Book2_TheRinggoessouth,
          "Book3_TheTreasonofIsengard" = Book3_TheTreasonofIsengard, "Book4_TheRinggoesEast" = Book4_TheRinggoesEast,
          "Book5_TheWaroftheRing" = Book5_TheWaroftheRing,
          "Book6_TheEndoftheThirdAge" = Book6_TheEndoftheThirdAge)
  })
  datainput3 <- reactive({
    paste(input$selection_3, "Book1_TheRingsetsout" = Book1_TheRingsetsout, "Book2_TheRinggoessouth" = Book2_TheRinggoessouth,
          "Book3_TheTreasonofIsengard" = Book3_TheTreasonofIsengard, "Book4_TheRinggoesEast" = Book4_TheRinggoesEast,
          "Book5_TheWaroftheRing" = Book5_TheWaroftheRing,
          "Book6_TheEndoftheThirdAge" = Book6_TheEndoftheThirdAge)
  })
  datainput4 <- reactive({
    paste(input$selection_4, "Book1_TheRingsetsout" = Book1_TheRingsetsout, "Book2_TheRinggoessouth" = Book2_TheRinggoessouth,
          "Book3_TheTreasonofIsengard" = Book3_TheTreasonofIsengard, "Book4_TheRinggoesEast" = Book4_TheRinggoesEast,
          "Book5_TheWaroftheRing" = Book5_TheWaroftheRing,
          "Book6_TheEndoftheThirdAge" = Book6_TheEndoftheThirdAge)
  })
  output$cosine <- renderPrint(
    {
      dset1 <- datainput() %>% str_to_lower() %>% str_replace_all("[^[:alnum:]]", " ") %>% str_replace_all("\\s+", " ") %>%
        itoken()
      dset2 <- datainput2() %>% str_to_lower() %>% str_replace_all("[^[:alnum:]]", " ") %>% str_replace_all("\\s+", " ") %>%
        itoken()
      datall <- c(datainput(), datainput2())
      vectorizer1 <- datainput() %>% str_to_lower() %>% str_replace_all("[^[:alnum:]]", " ") %>% str_replace_all("\\s+", " ") %>%
        itoken() %>% create_vocabulary() %>% prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5) %>% vocab_vectorizer()
      vectorizer2 <- datainput2() %>% str_to_lower() %>% str_replace_all("[^[:alnum:]]", " ") %>% str_replace_all("\\s+", " ") %>%
        itoken() %>% create_vocabulary() %>% prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5) %>% vocab_vectorizer()
      vectorizer <- datall %>% str_to_lower() %>% str_replace_all("[^[:alnum:]]", " ") %>% str_replace_all("\\s+", " ") %>%
        itoken() %>% create_vocabulary() %>% prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5) %>% vocab_vectorizer()
        #dset1 <- tm_map(dset, removePunctuation)
        #dset1 <- tm_map(dset1, removeWords, stopwords("english"))
        #dset1 <- tm_map(dset1, stemDocument)
        #dset1
      dtm1 <- create_dtm(dset1, vectorizer)
      dtm2 <- create_dtm(dset2, vectorizer)
      #print(dset)
      #print(dset2)

      #totalword2 <-sapply(strsplit(dtm2, " "), length)

      #print(totalword2)
      #print(dtm1, dim(dtm1))
      #print(dtm2, dim(dtm2))
      d1_d2_jac_sim = sim2(dtm1, dtm2, method = "cosine", norm = c("l2"))

      print("Cosine Similarity")
      print(d1_d2_jac_sim)
      print(dim(d1_d2_jac_sim))
      d1_d2_jac_sim[1:13, 1:13]
    })
  output$sentiment <- renderChartJSRadar({
    alreadycleaned1 <- Legolas(datainput3())
    p1 <- get_sentiments("nrc")
    tablese <- tibble(alreadycleaned1)
    #print(table1)
    tablese %>% right_join(p1, c("alreadycleaned1" = "word")) %>%
      group_by(sentiment) %>% summarise(wordcount = n()) %>%
      ungroup() %>% mutate(sentiment = reorder(sentiment, wordcount))%>% chartJSRadar()
  }
    )
  output$topmol <- renderPlotly({
    titles <- c("The Ring sets out", "The War of the Ring", "The Ring goes East",
                "The Ring goes South", "The End of the Third Age", "The Treason of Isengard")


    books <- list(Book1_TheRingsetsout, Book2_TheRinggoessouth, Book3_TheTreasonofIsengard,
                  Book4_TheRinggoesEast, Book5_TheWaroftheRing, Book6_TheEndoftheThirdAge)

    series <- tibble()

    for(i in seq_along(titles)) {

      clean <- tibble(chapter = seq_along(books[[i]]),
                      text = books[[i]]) %>%
        unnest_tokens(word, text) %>%
        mutate(book = titles[i]) %>%
        select(book, everything())

      series <- rbind(series, clean)
    }

    series %>%
      group_by(book) %>%
      mutate(word_count = 1:n(),
             index = word_count %/% 500 + 1) %>%
      inner_join(get_sentiments("bing")) %>%
      count(book, index = index , sentiment) %>%
      ungroup() %>%
      spread(sentiment, n, fill = 0) %>%
      mutate(sentiment = positive - negative,
             book = factor(book, levels = titles)) %>%
      ggplot(aes(index, sentiment, fill = book)) +
      geom_bar(alpha = 0.5, stat = "identity", show.legend = FALSE) +
      facet_wrap(~ book, ncol = 2, scales = "free_y")
  }
  )
  output$topmol1 <- renderPlotly({
    titles <- c("The Ring sets out", "The War of the Ring", "The Ring goes East",
                "The Ring goes South", "The End of the Third Age", "The Treason of Isengard")


    books <- list(Book1_TheRingsetsout, Book2_TheRinggoessouth, Book3_TheTreasonofIsengard,
                  Book4_TheRinggoesEast, Book5_TheWaroftheRing, Book6_TheEndoftheThirdAge)

    series <- tibble()

    for(i in seq_along(titles)) {

      clean <- tibble(chapter = seq_along(books[[i]]),
                      text = books[[i]]) %>%
        unnest_tokens(word, text) %>%
        mutate(book = titles[i]) %>%
        select(book, everything())

      series <- rbind(series, clean)
    }

    afinn <- series %>%
      group_by(book) %>%
      mutate(word_count = 1:n(),
             index = word_count %/% 500 + 1) %>%
      inner_join(get_sentiments("afinn")) %>%
      group_by(book, index) %>%
      summarise(sentiment = sum(score)) %>%
      mutate(method = "AFINN")

    bing_and_nrc <- bind_rows(series %>%
                                group_by(book) %>%
                                mutate(word_count = 1:n(),
                                       index = word_count %/% 500 + 1) %>%
                                inner_join(get_sentiments("bing")) %>%
                                mutate(method = "Bing"),
                              series %>%
                                group_by(book) %>%
                                mutate(word_count = 1:n(),
                                       index = word_count %/% 500 + 1) %>%
                                inner_join(get_sentiments("nrc") %>%
                                             filter(sentiment %in% c("positive", "negative"))) %>%
                                mutate(method = "NRC")) %>%
      count(book, method, index = index , sentiment) %>%
      ungroup() %>%
      spread(sentiment, n, fill = 0) %>%
      mutate(sentiment = positive - negative) %>%
      select(book, index, method, sentiment)
    #We now have an estimate of the net sentiment (positive - negative) in each chunk of the novel text for each #sentiment lexicon. Let’s bind them together and plot them.

    bind_rows(afinn,
              bing_and_nrc) %>%
      ungroup() %>%
      mutate(book = factor(book, levels = titles)) %>%
      ggplot(aes(index, sentiment, fill = method)) +
      geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
      facet_grid(book ~ method)
  }
  )
  output$topmol2 <- renderPlotly({
    titles <- c("The Ring sets out", "The War of the Ring", "The Ring goes East",
                "The Ring goes South", "The End of the Third Age", "The Treason of Isengard")


    books <- list(Book1_TheRingsetsout, Book2_TheRinggoessouth, Book3_TheTreasonofIsengard,
                  Book4_TheRinggoesEast, Book5_TheWaroftheRing, Book6_TheEndoftheThirdAge)

    series <- tibble()

    for(i in seq_along(titles)) {

      clean <- tibble(chapter = seq_along(books[[i]]),
                      text = books[[i]]) %>%
        unnest_tokens(word, text) %>%
        mutate(book = titles[i]) %>%
        select(book, everything())

      series <- rbind(series, clean)
    }

    bing_word_counts <- series %>%
      inner_join(get_sentiments("bing")) %>%
      count(word, sentiment, sort = TRUE) %>%
      ungroup()

    bing_word_counts %>%
      group_by(sentiment) %>%
      top_n(10) %>%
      ggplot(aes(reorder(word, n), n, fill = sentiment)) +
      geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE, colour = "red") + scale_fill_grey() +
      facet_wrap(~sentiment, scales = "free_y") +
      labs(y = "Contribution to sentiment", x = NULL) +
      coord_flip() + theme(panel.border = element_blank(),
                           panel.grid.major = element_blank(),
                           panel.grid.minor = element_blank())
  }
  )
  output$topmol3 <- renderPlot({
    titles <- c("The Ring sets out", "The War of the Ring", "The Ring goes East",
                "The Ring goes South", "The End of the Third Age", "The Treason of Isengard")


    books <- list(Book1_TheRingsetsout, Book2_TheRinggoessouth, Book3_TheTreasonofIsengard,
                  Book4_TheRinggoesEast, Book5_TheWaroftheRing, Book6_TheEndoftheThirdAge)

    series <- tibble()

    for(i in seq_along(titles)) {

      clean <- tibble(chapter = seq_along(books[[i]]),
                      text = books[[i]]) %>%
        unnest_tokens(word, text) %>%
        mutate(book = titles[i]) %>%
        select(book, everything())

      series <- rbind(series, clean)
    }

    series %>%
      inner_join(get_sentiments("bing")) %>%
      count(word, sentiment, sort = TRUE) %>%
      acast(word ~ sentiment, value.var = "n", fill = 0) %>%
      comparison.cloud(colors = c("red", "gray80"),
                       max.words = 300)
  }
  )
  
}
