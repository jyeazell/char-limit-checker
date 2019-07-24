library(shiny)    

ui <- fluidPage(title = "App Title",
                br(), br(),
                textAreaInput("mytext","Input text:",
                              width = '600px', height = '150px'),
                textOutput('helptext')
)

max_char = 50

server <- function(input, output, session) 
{
  output$helptext <- reactive({ paste0(max_char-nchar(input$mytext), ' characters remaining.' ) })
  
  observeEvent(input$mytext,{
    if(nchar(input$mytext)>max_char)
    {
      updateTextInput(session,'mytext',value=substr(input$mytext,1,max_char))
      showModal(modalDialog(
        title = "Error!",
        "Character limit exceeded!",
        easyClose = TRUE
      ))
    }
  }
  )
  
}
shinyApp(ui,server)