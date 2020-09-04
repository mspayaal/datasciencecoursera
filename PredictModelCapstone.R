library(stringr)
library(stringi)
library(dplyr)
# reading the ngrams
bigram <-  readRDS( "C:/Users/mahendra.payaal/Documents/coursera/data/bigram.rds")
trigram <- readRDS("C:/Users/mahendra.payaal/Documents/coursera/data/trigram.rds")
quadgram <- readRDS("C:/Users/mahendra.payaal/Documents/coursera/data/quadgram.rds")

# function to take input and predict 
predictWord <- function(x){
phrase<- as.character()
  phrase <- x
  phrase <- tolower(x)
  # cleaning of input
  phrase <- phrase %>%
    str_remove_all(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)") %>%
    str_replace_all("&amp;", "and") %>%
    str_remove_all("^RT:? ") %>%
    str_remove_all("@[[:alnum:]]+") %>%
    str_remove_all("#[[:alnum:]]+") %>%
    str_replace_all("\\\n", " ")
  phrase <- unlist(strsplit(phrase," "))
  #print(phrase)
  num_words <- length(phrase)
  #print(num_words)

  if (num_words == 0){
    print("No input provided")
}

  if (num_words == 1){
    phrase <- paste0("^",phrase)
    predict_1_word(phrase)
    
        }
  else if (num_words == 2){
    phrase <- paste(phrase[1],phrase[2])
    phrase <- paste0("^",phrase)
    predict_2_word(phrase)
  } 
  
  else if (num_words == 3){
    phrase <- paste(phrase[1],phrase[2],phrase[3])
    phrase <- paste0("^",phrase)
    predict_3_word(phrase)
    
  } else {
    phrase <- paste(phrase[num_words-2],phrase[num_words -1],phrase[num_words])
    phrase <- paste0("^",phrase)
    predict_3_word(phrase)
  }
  
}

# predicting on bigrams
predict_1_word <- function(x){
    #print("In bigram now")
    match_list_2 <- bigram[grep(x,bigram[,1]),]
    #print(head(match_list_2))
    #print(nrow(match_list_2))
    #print(x)
    if (nrow(match_list_2) == 0){ 
      print("no match")
      } 
    
      else if(nrow(match_list_2) == 1) { 
        nextword_2 <- stri_extract_last_words(match_list_2[1,1])
        print(nextword_2)
          }
      else if(nrow(match_list_2) == 2) { 
           nextword_2_1 <- stri_extract_last_words(match_list_2[1,1])
           nextword_2_2 <- stri_extract_last_words(match_list_2[2,1])
           nextword_2 <- paste(nextword_2_1,nextword_2_2,sep=",")
           print(nextword_2)
      } else {
        nextword_2_1 <- stri_extract_last_words(match_list_2[1,1])
        nextword_2_2 <- stri_extract_last_words(match_list_2[2,1])
        nextword_2_3 <- stri_extract_last_words(match_list_2[3,1])
        nextword_2 <- paste(nextword_2_1,nextword_2_2,nextword_2_3,",")
        print(nextword_2)
          }
}

# prediction on trigrams
predict_2_word <- function(x){
  print("In trigram now")
  match_list_3 <- trigram[grep(x,trigram[,1]),]
  #print(head(match_list_3))
  #print(nrow(match_list_3))
  #print(x)
        if(nrow(match_list_3) == 0){
          phrase_temp_1  <- unlist(strsplit(x," ")) 
          phrase_1 <- paste0("^",phrase_temp_1[2])
          print(phrase_1)
          predict_1_word(phrase_1)
      
      } 
      
      else if(nrow(match_list_3) == 1) { 
        nextword_3 <- stri_extract_last_words(match_list_3[1,1])
        print(nextword_3)
      }
      else if(nrow(match_list_3) == 2) { 
    nextword_3_1 <- stri_extract_last_words(match_list_3[1,1])
    nextword_3_2 <- stri_extract_last_words(match_list_3[2,1])
    nextword_3 <- paste(nextword_3_1,nextword_3_2,sep=",")
    print(nextword_3)
  } else {
    nextword_3_1 <- stri_extract_last_words(match_list_3[1,1])
    nextword_3_2 <- stri_extract_last_words(match_list_3[2,1])
    nextword_3_3 <- stri_extract_last_words(match_list_3[3,1])
    nextword_3 <- paste(nextword_3_1,nextword_3_2,nextword_3_3,sep=",")
    print(nextword_3)
  }
    }
  # predicting on 4-grams      
predict_3_word <- function(x){
   #print("In quadgram now")
   match_list_4 <- quadgram[grep(x,quadgram[,1]),]
   #print(head(match_list_4))
   #print(nrow(match_list_4))
   #print(x)
   
    if(nrow(match_list_4) == 0){
      phrase_temp  <- unlist(strsplit(x," ")) 
      phrase_2 <- paste(phrase_temp[2],phrase_temp[3],sep=" ")
      phrase_2  <- paste0("^",phrase_2)
      #print(phrase_2)
      predict_2_word(phrase_2)
    
    } 
    
   else if(nrow(match_list_4) == 1) { 
      nextword_4 <- stri_extract_last_words(match_list_4[1,1])
      print(nextword_4)
    }
   else if(nrow(match_list_4) == 2) { 
     nextword_4_1 <- stri_extract_last_words(match_list_4[1,1])
     nextword_4_2 <- stri_extract_last_words(match_list_4[2,1])
     nextword_4 <- paste(nextword_4_1,nextword_4_2,sep=",")
     print(nextword_4)
   } else {
     nextword_4_1 <- stri_extract_last_words(match_list_4[1,1])
     nextword_4_2 <- stri_extract_last_words(match_list_4[2,1])
     nextword_4_3 <- stri_extract_last_words(match_list_4[3,1])
     nextword_4 <- paste(nextword_4_1,nextword_4_2,nextword_4_3,sep=",")
     print(nextword_4)
   }
}





