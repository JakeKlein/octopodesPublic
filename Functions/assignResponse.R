assignResponse = function(modelName, response){
  model = modelName;
  return(data.table(model, response));
}

addResponse = function(responseObject){
  responses <<- responses[model != responseObject$model];
  responses <<- rbind2(responses, responseObject);
}