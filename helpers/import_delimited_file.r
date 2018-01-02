'''
  Roger C Gill, 2018-01-02
  Description : Reads a delimited text file
  Usage       : Place the following code snippets within the dashboard
    1 : import_file should be placed within a tabItem in a tab
	2 : import_file_server should be placed within the server.UI code
'''

# Sidebar panel for inputs
import_file = box(
  width = 4
  ,status = "info"
  # Input: Select a file
  ,fileInput(
    "infile"
    ,"Choose a delimited file"
    ,multiple = TRUE
    ,accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")
  )
  # Horizontal line
  ,tags$hr()

  # Input: Checkbox if file has header ----
  ,checkboxInput("header", "Header", TRUE)
  
  # Input: Select separator
  ,radioButtons(
    "sep"
    ,"Separator"
	,choices = c(Comma = ",", Semicolon = ";", Tab = "\t")
	,selected = ","
  )
  
  # Input: Select quotes
  ,radioButtons(
    "quote"
	,"Quote"
	,choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'")
	,selected = '"'
  ),
  
  # Horizontal line
  tags$hr(),
  
  # Input: Select number of rows to display
  radioButtons(
    "disp"
	,"Display"
	,choices = c(Head = "head", All = "all")
	,selected = "head"
  )
)

# Panel for displaying outputs
show_dataframe = box(
  width = 8
  ,status = "info"
  # Output: Data file
  ,tableOutput("data_contents")
)

# This should be placed within the tabitem
import_file_ui = tabItem(
  "datainput"
  ,fluidRow(
    import_file
    ,show_dataframe
  )
)

# Read the selected file
import_file_server = function(input, output) {

  output$data_contents <- renderTable({

    req(input$infile)
    df <- read.csv(input$infile$datapath, header = input$header, sep = input$sep, quote = input$quote)
    if(input$disp == "head") {
      return(head(df))
    } else { return(df) }

  })

}
