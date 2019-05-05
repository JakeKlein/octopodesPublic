###Create list metadata function
listMetaData = function(collection, modelName = NULL, modelVersion = NULL){
  if(any(is.na(modelName))){
    modelName <- NULL
  };
  if(any(is.na(modelVersion))){
    modelVersion <- NULL
  };
  if(is.null(modelName)){
    print(exec(collection));
  }
  else {
    subset = ifelse(
      is.null(modelVersion),
      paste0("model == '", modelName, "'"),
      paste0("model == '", modelName, "' & version == '", modelVersion, "'")
    )
    print(exec(collection)[eval(parse(text = subset))]);
  }
}
