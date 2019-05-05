assignModel = function(modelName, modelData, modelVersion = 1) {
  if(any(is.na(modelVersion))){
    modelVersion = 1;
  }
  predictorVector = paste0("[", paste(predictors$predictor[predictors$model == modelName & predictors$version == modelVersion], collapse = ', '), "]");
  responseVar = responses$response[responses$model == modelName];
  formulaVar = formulas$formula[formulas$model == modelName & formulas$version == modelVersion];
  return(data.table(model = modelName, version = modelVersion, data = modelData, response = responseVar, predictors = predictorVector, formula = formulaVar));
}

addModel = function(modelObject) {
  models <<- models[!(model == modelObject$model & version == modelObject$version)];
  models <<- rbind2(models, modelObject);
}