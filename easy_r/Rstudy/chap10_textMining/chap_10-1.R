#text mining
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("installr")
check.for.updates.R()
useNIADic()

library(KoNLP)
useNIADic()
library(dplyr)
txt <- readLines("hiphop.txt")
head(txt)
install.packages("stringr")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >=2)

top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20
#텍스트가 힙합 가사이기 때문에 you, may, YAH 같은 영단어가 많이 사용되었다.

#word cloud
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
pal <- brewer.pal(8, "Dark2")
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)

pal <- brewer.pal(9, "Blues")[5:9]
set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)


