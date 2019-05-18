trainTest = function(data, trainingRatio = 0.5){
  if(any(is.na(trainingRatio))){
    trainingRatio = 0.5;
  }
  tryCatch(
    {
      dataSet = exec(paste0('dataEnv$', data));
      dataLength = nrow(dataSet);
      rows = sample(1:dataLength, size = round(trainingRatio * dataLength, 0), replace = FALSE);
      trainSet = dataSet[rows];
      testSet = dataSet[-rows];
      assign(paste0(data, 'Train'), trainSet, envir = dataEnv);
      print(paste0("Assigning training set '", paste0(data, 'Train'), "' with ", nrow(dataSet[rows]), " rows."));
      assign(paste0(data, 'Test'), testSet, envir = dataEnv);
      print(paste0("Assigning test set '", paste0(data, 'Test'), "' with ", nrow(dataSet[-rows]), " rows."));
    },
    warning = function(cond) {
      message(cond);
    },
    error = function(cond) {
      message(cond);
    }
  )
}
