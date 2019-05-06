#' Tidy data frame of The Lord of the Rings's 6 completed, published novels
#' 
#' @examples 
#' 
#' library(dplyr)
#
#' thelordoftherings_books() %>% group_by(book) %>%
#'      summarise(total_lines = n())
#'
#' @export
thelordoftherings_books <- function(){
  books <- list(
    "TheRingsetout" = TheLordoftheRings::Book1_TheRingsetsout,
    "TheRinggoessouth" = TheLordoftheRings::Book2_TheRinggoessouth,
    "TheTreasonofIsengard" = TheLordoftheRings::Book3_TheTreasonofIsengard,
    "TheRinggoesEast" = TheLordoftheRings::Book4_TheRinggoesEast,
    "TheWaroftheRing" = TheLordoftheRings::Book5_TheWaroftheRing,
    "TheEndoftheThirdAge" = TheLordoftheRings::Book6_TheEndoftheThirdAge
  )
  ret <- data.frame(text = unlist(books, use.names = FALSE), 
                    stringsAsFactors = FALSE)
  ret$book <- factor(rep(names(books), sapply(books, length)))
  ret$book <- factor(ret$book, levels = unique(ret$book))
  structure(ret, class = c("tbl_df", "tbl", "data.frame"))
}
