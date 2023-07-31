library(shiny)

# Enter your grades from the Canvas averages, located at the bottom of your Grade page. If you're confused, there's a video at the bottom of this page that shows you where to find everything. 
# You should also input scores for the exams we have not yet taken, a good guess would be the average of previous exams or what you scored on the relevant pratice exam. 
# Remember this is just a tool to help you get a sense of where you stand in the class, your final grade may vary.
# Define UI
ui <- fluidPage(
  titlePanel("ECON 202 Grade Calculator"),
  sidebarLayout(
    sidebarPanel(
      h4(""),
      numericInput("quiz_grade", label = "Quiz grade", value = 0, min = 0, max = 100),
      numericInput("ps_grade", label = "Problem set grade", value = 0, min = 0, max = 100),
      numericInput("pb_grade", label = "Packback grade", value = 0, min = 0, max = 110),
      numericInput("ec_grade", label = "Achieve extra credit grade", value = 0, min = 0, max = 100),
      numericInput("exam1_grade", label = "Exam 1 grade", value = 0, min = 0, max = 100),
      numericInput("exam2_grade", label = "Exam 2 grade", value = 0, min = 0, max = 100),
      numericInput("exam3_grade", label = "Exam 3 grade", value = 0, min = 0, max = 100),
      actionButton("submit_button", label = "Calculate")
    ),
    mainPanel(
      h4("Current grade:"),
      verbatimTextOutput("current_grade"),
      h4("Current letter grade:"),
      verbatimTextOutput("final_letter")
    )
  )
)

# Define server
server <- function(input, output) {
  
  observeEvent(input$submit_button, {
    # Calculate current grade
    quiz_score <- input$quiz_grade * 0.2
    ps_score <- input$ps_grade * 0.15
    pb_score <- input$pb_grade * 0.1
    ec_score <- (input$ec_grade/100)*(90/100)
    exam_scores <- c(input$exam1_grade, input$exam2_grade, input$exam3_grade)
    highexam_score <- max(exam_scores) * 0.2
    medexam_score <- (sort(exam_scores)[2]) * 0.2
    lowexam_score <-  min(exam_scores) * 0.15
    current_grade <- sum(c(quiz_score, ps_score, pb_score, ec_score, 
                           highexam_score, medexam_score, lowexam_score))
    
    # Calculate final letter grade
    final_letter <- ifelse(current_grade > 89.5, "A", 
                           ifelse(current_grade > 79.5 & current_grade < 89.5, "B",
                                  ifelse(current_grade > 69.5 & current_grade < 79.5, "C",
                                         ifelse(current_grade > 59.5 & current_grade < 69.5, "D",
                                                "F"))))
    
    
    # Output results
    output$current_grade <- renderPrint(paste0(current_grade, "%"))
    output$final_letter <- renderPrint(final_letter)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
