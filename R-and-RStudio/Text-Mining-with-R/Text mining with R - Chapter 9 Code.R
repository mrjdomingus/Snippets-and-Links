library(dplyr)
library(tidyr)
library(purrr)
library(readr)

training_folder <- "data/20news-bydate/20news-bydate-train/"
# Define a function to read all files from a folder into a data frame
read_folder <-function(infolder) {
  data_frame(file = dir(infolder, full.names = TRUE)) %>%
    mutate(text = map(file, read_lines)) %>%
    transmute(id = basename(file), text) %>%
    unnest(text)
}

# Use unnest() and map() to apply read_folder to each subfolder
raw_text <-data_frame(folder = dir(training_folder, full.names = TRUE)) %>%
  unnest(map(folder, read_folder)) %>%
  transmute(newsgroup = basename(folder), id, text)

raw_text


library(ggplot2)
raw_text %>%
  group_by(newsgroup) %>%
  summarize(messages = n_distinct(id)) %>%
  ggplot(aes(newsgroup, messages)) +
  geom_col() +
  coord_flip()


library(stringr)
# must occur after the first occurrence of an empty line,
# and before the first occurrence of a line starting with --
cleaned_text <-raw_text %>%
  group_by(newsgroup, id) %>%
  filter(cumsum(text == "") >0,
         cumsum(str_detect(text, "^--")) ==0) %>%
  ungroup()


cleaned_text <-cleaned_text %>%
  filter(str_detect(text, "^[^>]+[A-Za-z\\d]") |text == "",
         !str_detect(text, "writes(:|\\.\\.\\.)$"),
         !str_detect(text, "^In article <"),
         !id %in%c(9704, 9985))


library(tidytext)
usenet_words <-cleaned_text %>%
  unnest_tokens(word, text) %>%
  filter(str_detect(word, "[a-z']$"),
         !word %in%stop_words$word)


usenet_words %>%
  count(word, sort = TRUE)


words_by_newsgroup <-usenet_words %>%
  count(newsgroup, word, sort = TRUE) %>%
  ungroup()
words_by_newsgroup


tf_idf <-words_by_newsgroup %>%
  bind_tf_idf(word, newsgroup, n) %>%
  arrange(desc(tf_idf))
tf_idf


tf_idf %>%
  filter(str_detect(newsgroup, "^sci\\.")) %>%
  group_by(newsgroup) %>%
  top_n(12, tf_idf) %>%
  ungroup() %>%
  mutate(word = reorder(word, tf_idf)) %>%
  ggplot(aes(word, tf_idf, fill = newsgroup)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~newsgroup, scales = "free") +
  ylab("tf-idf") +
  coord_flip()


library(widyr)
newsgroup_cors <-words_by_newsgroup %>%
  pairwise_cor(newsgroup, word, n, sort = TRUE)
newsgroup_cors


library(ggraph)
library(igraph)
set.seed(2017)
newsgroup_cors %>%
  filter(correlation >.4) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(alpha = correlation, width = correlation)) +
  geom_node_point(size = 6, color = "lightblue") +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()


# include only words that occur at least 50 times
word_sci_newsgroups <-usenet_words %>%
  filter(str_detect(newsgroup, "^sci")) %>%
  group_by(word) %>%
  mutate(word_total = n()) %>%
  ungroup() %>%
  filter(word_total >50)
# convert into a document-term matrix
# with document names such as sci.crypt_14147
sci_dtm <-word_sci_newsgroups %>%
  unite(document, newsgroup, id) %>%
  count(document, word) %>%
  cast_dtm(document, word, n)

library(topicmodels)
sci_lda <-LDA(sci_dtm, k = 4, control = list(seed = 2016))


sci_lda %>%
  tidy() %>%
  group_by(topic) %>%
  top_n(8, beta) %>%
  ungroup() %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free_y") +
  coord_flip()


sci_lda %>%
  tidy(matrix = "gamma") %>%
  separate(document, c("newsgroup", "id"), sep = "_") %>%
  mutate(newsgroup = reorder(newsgroup, gamma *topic)) %>%
  ggplot(aes(factor(topic), gamma)) +
  geom_boxplot() +
  facet_wrap(~newsgroup) +
  labs(x = "Topic",
       y = "# of messages where this was the highest % topic")



