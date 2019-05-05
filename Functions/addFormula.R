buildFormula = function(modelName, modelVersion = 1){
  if(any(is.na(modelVersion))){
    modelVersion = 1;
  }
  if(nrow(predictors[model == modelName]) == 0 || nrow(predictors[model == modelName & version == modelVersion]) == 0 || nrow(responses[model == modelName]) == 0){
    warning(paste0('Error: predictors and/or response variable not found for ', modelName, ' version: ', modelVersion));
  } else {
    predictorVector = predictors$predictor[predictors$model == modelName & predictors$version == modelVersion];
    responseVar = responses$response[responses$model == modelName];
    formulaString = paste0(responseVar, ' ~ ');
    for(i in 1:(length(predictorVector) - 1)){
      formulaString = paste0(formulaString, predictorVector[i], ' + ');
    }
    formulaString = as.character(paste0(formulaString, predictorVector[length(predictorVector)]));
    return(data.table(model = modelName, version = modelVersion, formula = formulaString));
  }
}

addFormula = function(formulaObject){
  formulas <<- formulas[!(model == formulaObject$model & version == formulaObject$version)];
  formulas <<- rbind2(formulas, formulaObject);
}