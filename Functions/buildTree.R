buildTree = function(modelName, modelData, modelVersion = 1){
  if(any(is.na(modelVersion))){
    modelVersion = 1;
  }
  if(
    nrow(predictors[model == modelName]) == 0 ||
    nrow(predictors[model == modelName & version == modelVersion]) == 0 ||
    nrow(responses[model == modelName]) == 0 ||
    nrow(formulas[model == modelName]) == 0 ||
    nrow(formulas[model == modelName & version == modelVersion]) == 0
  ){
    warning(paste0('Error: predictors and/or response and/or formula variable not found for ', modelName, ' version: ', modelVersion));
  } else {
    predictorVector = predictors$predictor[predictors$model == modelName & predictors$version == modelVersion];
    responseVar = responses$response[responses$model == modelName];
    formulaVar = as.formula(formulas$formula[formulas$model == modelName & formulas$version == modelVersion]);
    DT = get(modelData, envir = dataEnv);
    responseVector = DT[[responseVar]];
    responseFamily = {
      if(is.numeric(responseVector)) {
        if(countUnique(responseVector) > 2) {
          'gaussian';
        } else {
          'bernoulli';
        }
      } else {
        if(is.character(responseVector)) {
          if(countUnique(responseVector) > 2) {
            'multinomial';
          } else {
            'bernoulli';
          }
        } else {
          message('Cannnot determine type of response variable.  Please ensure response is numeric, binomial, or multinomial.');
          NA;
        }
      }
    }
    if(is.na(responseFamily)) {
      return(message('Cannnot determine type of response variable.  Please ensure response is numeric, binomial, or multinomial.'));
    }
    else{
      depth = length(predictorVector) - 1;
      nTrees = round(length(responseVector) / 100, 0) + 1;
      name = paste0(modelName, '_V', modelVersion)
      print(paste0("Writing a ", responseFamily, "boosted tree model with ", nTrees, " trees."));
      assign(name, gbm(formulaVar, data = DT, interaction.depth = depth, n.trees = nTrees, distribution = responseFamily), envir = modelEnv);
      print(paste0(name, ' successfully created.'));
      exec(paste0('print(modelEnv$', name, '$train.error)'));
    }
  }
}
