fun <- function(Cement_Ind, BlastFurnaceSlag_Ind, FlyAsh_Ind, Water_Ind, Superplasticizer_Ind, CoarseAggregate_Ind, FineAggregate_Ind, Age_Ind)
{
  require(AppliedPredictiveModeling)
  require(caret)
  data("concrete")
  
  if(Cement_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("Cement"))]
  if(BlastFurnaceSlag_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("BlastFurnaceSlag"))]
  if(FlyAsh_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("FlyAsh"))]
  if(Water_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("Water"))]
  if(Superplasticizer_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("Superplasticizer"))]
  if(CoarseAggregate_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("CoarseAggregate"))]
  if(FineAggregate_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("FineAggregate"))]
  if(Age_Ind == FALSE) concrete <- concrete[,-which(names(concrete) %in% c("Age"))]
  
  set.seed(414)
  inTrain = createDataPartition(concrete$CompressiveStrength, p = 0.7)[[1]]
  train <- concrete[inTrain,]
  test <- concrete[-inTrain,]
  
  glm1 <- glm(CompressiveStrength ~ ., data = train, family = Gamma(link = "log"))
  summary(glm1)
  test$prediction <- exp(predict(glm1, newdata = test))
  test$sqer <- (test$CompressiveStrength - test$prediction)^2
  RMSE <- round(sqrt(mean(test$sqer)),2)
  
  return(RMSE)
}


shinyServer(
  function(input, output) {
    calculator <- reactive({fun(input$Cement_Ind, input$BlastFurnaceSlag_Ind, input$FlyAsh_Ind, input$Water_Ind, input$Superplasticizer_Ind, input$CoarseAggregate_Ind, input$FineAggregate_Ind, input$Age_Ind)})
    output$text1 <- renderPrint({
      input$goButton
      isolate(calculator()[1])})
  }
)


