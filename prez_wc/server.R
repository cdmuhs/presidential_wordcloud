library(shiny)
library(wordcloud)
library(tm)

# Load data
trump_txt = readLines("./trump.txt")
obama_txt = readLines("./obama.txt")
bush_txt = readLines("./bush.txt")

# Define function to generate wordcloud objects for a text file
toCorpus <- function(txt_file) {
    myCorpus = Corpus(VectorSource(txt_file))
    myCorpus = tm_map(myCorpus, tolower)
    myCorpus = tm_map(myCorpus, removePunctuation)
    myCorpus = tm_map(myCorpus, removeNumbers)
    myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))
    myDTM = TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
    m = as.matrix(myDTM)
    v = sort(rowSums(m), decreasing = TRUE)
    return(v)    
}

# create wordcloud object for each president
trumpCorpus <- toCorpus(trump_txt)
obamaCorpus <- toCorpus(obama_txt)
bushCorpus <- toCorpus(bush_txt)

# Define server logic
shinyServer(function(input, output) {
   
  output$wordcloudT <- renderPlot({
      
      # accessing input$update here makes this reactive
      input$update
      
      # Use isolate() to avoid dependency on input$n
      isolate({
          
          # Logic based on drop down input
          if (input$var == "Donald Trump, 2017"){
              corpus <- trumpCorpus
          } else if (input$var == 'Barack Obama, 2009'){
              corpus <- obamaCorpus
          } else if (input$var == 'George W Bush, 2001'){
              corpus <- bushCorpus
          }
          
          # generate wordcloud
          wordcloud(names(corpus),
                    corpus,
                    max.words = input$word_count, 
                    random.order = FALSE,
                    scale=c(10,0.5), 
                    min.freq= input$min_freq, 
                    colors=brewer.pal(3, "Dark2"))
          
      })
    
      
    
  })
  
  
  
})
