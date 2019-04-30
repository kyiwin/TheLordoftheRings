library(readr)
library(readxl)
library(dplyr)
#library(tidyverse)
library(rvest)
library(XML)
library(RCurl)
library(xml2)
library(stringr)

#setwd("~/Lordofthering/data-raw)

uurl <- "http://flyingmoose.org/tolksarc/book/book.htm"
pg <- read_html(uurl)
jj <- html_attr(html_nodes(pg, "a"), "href")
jj

#for all book
#to change for the specific book, change the prefix "book" in j = startsWith ()
#example .. for all chapters in book1, change it to book1 and for specific chapter book3, change it to book3_01 or book3_05 or so on ..

for (i in jj) {
  j = startsWith(i , "book")
  if (identical(j, TRUE))
  {
    jbook <- paste0("http://flyingmoose.org/tolksarc/book/", i)
    ikjurl <-c (jbook)

#print all the links
    #print(ikjurl)

    for(ikjurll in ikjurl){

#printing the title
      #ikjurlp <- read_html(ikjurll) %>%
        #html_nodes("title")
      #ikjurlq <- gsub("</?[^>]+>", "", ikjurlp) %>% gsub("[\r\n]+", "", .) %>% gsub('^""',"",.) %>% gsub('"$',"",.)
      #print(ikjurlq)

#printing the body
      ikjurli <- read_html(ikjurll) %>%
        html_nodes("pre")
      ikjurlk <- gsub("</?[^>]+>", "", ikjurli) %>% gsub("[\r\n]+", "", .) %>% gsub('^""',"",.) %>% gsub('"$',"",.)
      #print(ikjurlk)

    }
#write for all books
    for (ii in ikjurlk){
      lapply(ii, write, "book9999.txt", append = TRUE)
    }
  }
}


Book1_TheRingsetsout <- read_lines("~/Lordofthering/data-raw/book1.txt")
usethis::use_data(Book1_TheRingsetsout, overwrite = T, compress = "xz")
Book2_TheRinggoessouth <- read_lines("~/Lordofthering/data-raw/book2.txt")
usethis::use_data(Book2_TheRinggoessouth, overwrite = T)
Book3_TheTreasonofIsengard <- read_lines("~/Lordofthering/data-raw/book3.txt")
usethis::use_data(Book3_TheTreasonofIsengard, overwrite = T, compress = "xz")
Book4_TheRinggoesEast <- read_lines("~/Lordofthering/data-raw/book4.txt")
usethis::use_data(Book4_TheRinggoesEast, overwrite = T)
Book5_TheWaroftheRing <- read_lines("~/Lordofthering/data-raw/book5.txt")
usethis::use_data(Book5_TheWaroftheRing, overwrite = T, compress = "xz")
Book6_TheEndoftheThirdAge <- read_lines("~/Lordofthering/data-raw/book6.txt")
usethis::use_data(Book6_TheEndoftheThirdAge, overwrite = T, compress = "xz")

TheLordoftheRings <- read_lines("~/Lordofthering/data-raw/bookall.txt")
usethis::use_data(TheLordoftheRings, overwrite = T, compress = "xz")

#eachbook

A_Long_Expected_Parting <- read_lines("~/Lordofthering/data-raw/book1_01.htm")
The_Shadow_Of_The_Pest <- read_lines("~/Lordofthering/data-raw/book1_02.htm")
Three_Is_Company <- read_lines("~/Lordofthering/data-raw/book1_03.htm")
A_Short_Cut_To_Mushrooms <- read_lines("~/Lordofthering/data-raw/book1_04.htm")
A_Conspiracy_Undressed <- read_lines("~/Lordofthering/data-raw/book1_05.htm")
The_Old_Forest <- read_lines("~/Lordofthering/data-raw/book1_06.htm")
In_The_House_Of_Tom_Bombadil <- read_lines("~/Lordofthering/data-raw/book1_07.htm")
Fog_On_The_Barrow_Downs <- read_lines("~/Lordofthering/data-raw/book1_08.htm")
At_The_Sign_Of_The_Prancing_Pony <- read_lines("~/Lordofthering/data-raw/book1_09.htm")
Strider <- read_lines("~/Lordofthering/data-raw/book1_10.htm")
A_Stab_In_The_Back <- read_lines("~/Lordofthering/data-raw/book1_11.htm")
Flight_To_The_Ford <- read_lines("~/Lordofthering/data-raw/book1_12.htm")

usethis::use_data(A_Long_Expected_Parting, overwrite = T)
usethis::use_data(The_Shadow_Of_The_Pest, overwrite = T)
usethis::use_data(Three_Is_Company, overwrite = T)
usethis::use_data(A_Short_Cut_To_Mushrooms, overwrite = T)
usethis::use_data(A_Conspiracy_Undressed, overwrite = T)
usethis::use_data(The_Old_Forest, overwrite = T)
usethis::use_data(In_The_House_Of_Tom_Bombadil, overwrite = T)
usethis::use_data(Fog_On_The_Barrow_Downs, overwrite = T)
usethis::use_data(At_The_Sign_Of_The_Prancing_Pony, overwrite = T)
usethis::use_data(Strider, overwrite = T)
usethis::use_data(A_Stab_In_The_Back, overwrite = T)
usethis::use_data(Flight_To_The_Ford, overwrite = T)



