library(tidyverse)
library(readr)
library(tm)
library(tidytext)


final <- read_csv("d:/Usuarios/jmtoral/Documents/felicidad/final_le_sk_rbmex19.csv", 
                  locale = locale(encoding = "WINDOWS-1252"))

numpal <- sapply(strsplit(final$contenido, " "), length)

final$num_palabras <- numpal

es_stopword <- tibble(word=tm::stopwords("es"))

#final %>% 
 # group_by(mc) %>% 
 # summarise(suma = sum(num_palabras))

final %>% 
  unnest_tokens(word, contenido) %>% 
  group_by(mc) %>% 
  summarise(total = n()) -> x1

final %>% 
  unnest_tokens(word, contenido) %>% 
  anti_join(es_stopword) %>% 
  group_by(mc) %>% 
  unique() %>% 
  summarise(total_unicas = n()) -> x2


cuenta <- inner_join(x1, x2) %>% 
  mutate(diversidad_ling = total_unicas/total)

cuenta 

