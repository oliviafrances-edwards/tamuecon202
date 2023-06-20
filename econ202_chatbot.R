library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  title = "Mini Browser",
  tags$iframe(src = "https://www.chatpdf.com/share/w8djTP1ejCLlxB4nPgfca", width = "100%", height = "600px")
)

server <- function(input, output) {
  
}

shinyApp(ui, server)
