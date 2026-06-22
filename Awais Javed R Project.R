library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)
library(dplyr)

#---------------------------------------------------
# Sample Health Dataset
#---------------------------------------------------

set.seed(123)

health <- data.frame(
  ID = 1:500,
  Age = sample(18:80,500,replace=TRUE),
  Gender = sample(c("Male","Female"),500,replace=TRUE),
  Disease = sample(c(
    "Diabetes",
    "Hypertension",
    "Heart Disease",
    "Healthy"
  ),500,replace=TRUE),
  BMI = round(rnorm(500,26,4),1),
  BloodPressure = round(rnorm(500,125,15)),
  Cholesterol = round(rnorm(500,195,35))
)

#---------------------------------------------------
# UI
#---------------------------------------------------

ui <- dashboardPage(
  
  dashboardHeader(title="Health Statistics Dashboard"),
  
  dashboardSidebar(
    
    sliderInput(
      "age",
      "Age Range",
      min=min(health$Age),
      max=max(health$Age),
      value=c(18,80)
    ),
    
    selectInput(
      "gender",
      "Gender",
      choices=c("All",unique(health$Gender)),
      selected="All"
    ),
    
    selectInput(
      "disease",
      "Disease",
      choices=c("All",unique(health$Disease)),
      selected="All"
    )
    
  ),
  
  dashboardBody(
    
    fluidRow(
      
      valueBoxOutput("patients"),
      
      valueBoxOutput("avgBMI"),
      
      valueBoxOutput("avgBP")
      
    ),
    
    fluidRow(
      
      box(
        width=6,
        title="Disease Distribution",
        status="primary",
        solidHeader=TRUE,
        plotOutput("barPlot")
      ),
      
      box(
        width=6,
        title="Gender Distribution",
        status="success",
        solidHeader=TRUE,
        plotOutput("piePlot")
      )
      
    ),
    
    fluidRow(
      
      box(
        width=12,
        title="Age Histogram",
        status="warning",
        solidHeader=TRUE,
        plotOutput("histPlot")
      )
      
    ),
    
    fluidRow(
      
      box(
        width=12,
        title="Health Data",
        status="info",
        solidHeader=TRUE,
        DTOutput("table")
      )
      
    )
    
  )
  
)

#---------------------------------------------------
# SERVER
#---------------------------------------------------

server <- function(input, output){
  
  filtered <- reactive({
    
    data <- health
    
    data <- data %>%
      filter(
        Age >= input$age[1],
        Age <= input$age[2]
      )
    
    if(input$gender!="All"){
      data <- data %>%
        filter(Gender==input$gender)
    }
    
    if(input$disease!="All"){
      data <- data %>%
        filter(Disease==input$disease)
    }
    
    data
    
  })
  
  #---------------- Value Boxes -----------------------
  
  output$patients <- renderValueBox({
    
    valueBox(
      
      nrow(filtered()),
      
      "Patients",
      
      icon=icon("users"),
      
      color="blue"
      
    )
    
  })
  
  output$avgBMI <- renderValueBox({
    
    valueBox(
      
      round(mean(filtered()$BMI),1),
      
      "Average BMI",
      
      icon=icon("heartbeat"),
      
      color="green"
      
    )
    
  })
  
  output$avgBP <- renderValueBox({
    
    valueBox(
      
      round(mean(filtered()$BloodPressure),0),
      
      "Average Blood Pressure",
      
      icon=icon("stethoscope"),
      
      color="red"
      
    )
    
  })
  
  #---------------- Bar Plot --------------------------
  
  output$barPlot <- renderPlot({
    
    ggplot(filtered(),
           
           aes(Disease,fill=Disease))+
      
      geom_bar()+
      
      theme_minimal()+
      
      labs(
        x="Disease",
        y="Count"
      )
    
  })
  
  #---------------- Pie Chart -------------------------
  
  output$piePlot <- renderPlot({
    
    df <- filtered() %>%
      count(Gender)
    
    ggplot(df,
           
           aes(
             "",
             n,
             fill=Gender
           ))+
      
      geom_col(width=1)+
      
      coord_polar("y")+
      
      theme_void()
    
  })
  
  #---------------- Histogram -------------------------
  
  output$histPlot <- renderPlot({
    
    ggplot(filtered(),
           
           aes(Age))+
      
      geom_histogram(
        bins=20,
        fill="steelblue",
        color="black"
      )+
      
      theme_minimal()
    
  })
  
  #---------------- Table -----------------------------
  
  output$table <- renderDT({
    
    datatable(
      
      filtered(),
      
      options=list(
        pageLength=10,
        scrollX=TRUE
      )
      
    )
    
  })
  
}

#---------------------------------------------------
# RUN APP
#---------------------------------------------------

shinyApp(ui,server)