modelSummary = function(modelName, modelVersion = 1){
  if(any(is.na(modelVersion))){
    modelVersion = 1;
  }
  exec(paste0('print(modelEnv$', modelName, '_V', modelVersion , ')'));
  exec(paste0('print(summary(modelEnv$', modelName, '_V', modelVersion , '))'));
}
