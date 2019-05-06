context("Tidy dataframe for books")

suppressPackageStartupMessages(library(dplyr))

test_that("factor order is correct", {
  d <- thelordoftherings_books()
  expect_equal(levels(d$book)[1], "TheRingsetout")
  expect_equal(levels(d$book)[6], "TheEndoftheThirdAge")
})

test_that("tidy frame for Austen books is right", {
  d <- thelordoftherings_books() %>% 
    group_by(book) %>%
    summarise(total_lines = n())
  expect_equal(nrow(d), 6)
  expect_equal(ncol(d), 2)
  # the factor levels still in the right order?
  expect_equal(as.character(d$book[1]), "TheRingsetout")
  expect_equal(as.character(d$book[6]), "TheEndoftheThirdAge")
  
})
