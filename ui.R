library(shinydashboard)
library(shinythemes)
library(shiny)

### The shiny header

header = dashboardHeader(
  title = "Dashboard Demo",

  # Dropdown menu for messages
  dropdownMenu(type = "messages", badgeStatus = "success",
    messageItem("Support Team", "This is the content of a message.", time = "5 mins")
  ),
  
  # Dropdown menu for notifications
  dropdownMenu(type = "notifications", badgeStatus = "warning",
    notificationItem(icon = icon("users"), status = "info", "5 new members joined today")
  ),
  
  # Dropdown menu for tasks, with progress bar
  dropdownMenu(type = "tasks", badgeStatus = "danger",
    taskItem(value = 20, color = "aqua", "Refactor code")
  )
)

### The shiny sidebar

sidebar = dashboardSidebar(
  ## menu items - one for each tab
  sidebarMenu(
    menuItem("Data Input", tabName = "datainput"),    
    menuItem("Dashboard1", tabName = "dashboard1"),
    menuItem("Dashboard2", tabName = "dashboard2")
  ),
  ## data input and filters
  sliderInput(
    "rateThreshold"
    ,"Warn when rate exceeds"
    ,min  = 0
    ,max   = 50
    ,value = 3
    ,step  = 0.1
  )
)

### The shiny body

body = dashboardBody(
  tabItems(
    tabItem("dashboard1",
      fluidRow(
        valueBoxOutput("rate"),
        valueBoxOutput("count"),
        valueBoxOutput("users")
      )
      ,fluidRow(
        box(width = 8
        ,status = "info"
        ,solidHeader = TRUE
        ,title = "Popularity by package (last 5 min)"
        )
        ,box(
          width = 4, status = "info",
          title = "Top packages (last 5 min)",
          tableOutput("packageTable")
        )
      )
    ),
    tabItem("dashboard2",
      numericInput("maxrows", "Rows to show", 25),
      verbatimTextOutput("rawtable"),
      downloadButton("downloadCsv", "Download as CSV")
    )
    ,import_file_ui
  )
)


dashboardPage(
  header,
  sidebar,
  body
)



