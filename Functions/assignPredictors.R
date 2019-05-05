assignPredictors = function(modelName, predictorList){
  version = if(nrow(predictors[model == modelName]) == 0){ 1 }else{ max(predictors$version[predictors$model == modelName]) + 1};
  model = modelName;
  predictor = predictorList;
  return(data.table(model, version, predictor));
}

addPredictors = function(predictorObject){
  predictors <<- rbind2(predictors, predictorObject);
}