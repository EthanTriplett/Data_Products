shinyUI(pageWithSidebar(
  headerPanel("Compressive Strength Prediction"),
  sidebarPanel(
    checkboxInput(inputId="Cement_Ind", label = "Cement", value = TRUE),
    checkboxInput(inputId="BlastFurnaceSlag_Ind", label = "BlastFurnaceSlag", value = TRUE),
    checkboxInput(inputId="FlyAsh_Ind", label = "FlyAsh", value = TRUE),
    checkboxInput(inputId="Water_Ind", label = "Water", value = TRUE),
    checkboxInput(inputId="Superplasticizer_Ind", label = "Superplasticizer", value = TRUE),
    checkboxInput(inputId="CoarseAggregate_Ind", label = "CoarseAggregate", value = TRUE),
    checkboxInput(inputId="FineAggregate_Ind", label = "FineAggregate", value = TRUE),
    checkboxInput(inputId="Age_Ind", label = "Age", value = TRUE),
    actionButton("goButton", "Refresh Calculation")
  ),
  mainPanel(
    p('This application demonstrates predictive modeling. The goal is to determine the compressive strength of the concrete. Select the variables you want to use to predict compressive strength on the left.'),
    p("The estimate is the ", span("root mean squared error (RMSE).", style = "color:red"), " The smaller the number, the more accurate the prediction. Notice that as you add and subtract variables, the estimate changes."),
    p('Behind the scenes, Shiny is importing your selections and building a predictive model to predict the strength.  It then tests the model on unseen data and passes back the error.'),
    strong(p('RMSE of Prediction Based on Selected Variables')),
    strong(textOutput('text1'))
  )
  
))


