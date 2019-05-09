trainTest = function(data, ratio = 0.5){
  if(any(is.na(ratio))){
    ratio = 0.5;
  }
  tryCatch(
    {
      dataSet = exec(paste0('dataEnv$', data));
      dataLength = nrow(dataSet);
      rows = sample(1:dataLength, size = round(ratio * dataLength, 0), replace = FALSE);
      trainSet = dataSet[rows];
      testSet = dataSet[-rows];
      assign(paste0(data, 'Train'), trainSet, envir = dataEnv);
      assign(paste0(data, 'Test'), testSet, envir = dataEnv);
    },
    warning = function(cond) {
      message(cond);
    },
    error = function(cond) {
      message(cond);
    }
  )
}
