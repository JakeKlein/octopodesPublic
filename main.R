###Set Directory
setwd('~/octopodes');
path = getwd();
###Functions
functionsPath = file.path(path,'Functions');
for (i in 1:length(list.files(functionsPath)))source(file.path(functionsPath, list.files(functionsPath)[i]));


###Dependencies
dependenciesPath = file.path(path, 'Dependencies');
for (i in 1:length(list.files(dependenciesPath)))source(file.path(dependenciesPath, list.files(dependenciesPath)[i]));

###Data
dataPath = file.path(path, 'Data');
if(!exists('dataEnv')) dataEnv = new.env();
data = list.files(dataPath, pattern = '*.csv');
for (i in 1:length(data)) {
  fileName = data[i];
  fileNameClean = strsplit(fileName, split = '[.]')[[1]][1];
  dataFilePath = file.path(dataPath, data[i]);
  assign(fileNameClean, fread(dataFilePath), envir = dataEnv);
  rm(dataFilePath);
}
##MetaData
metaDataFields = c('predictors', 'responses', 'models', 'functions', 'data', 'commands', 'formulas');
if(!exists('predictors')) predictors = data.table(model = character(), version = integer(), predictor = character());
if(!exists('responses')) responses = data.table(model = character(), response = character());
if(!exists('formulas')) formulas = data.table(model = character(), version = integer(), formula = character());
if(!exists('models')) models = data.table(model = character(), version = integer(), data = character(), response = character(), predictors = character(), formula = character());
#if(!exists('commands')) commands =
functions = lsf.str();



###Models
modelPath = file.path(path, 'Models');
if(!exists('modelEnv')) modelEnv = new.env();



run = TRUE;



for (i in 1:length(list.files(functionsPath)))source(file.path(functionsPath, list.files(functionsPath)[i]));


{
  while(run == TRUE){
    input = readline(prompt = ' >> ');
    inputLower = tolower(input);
    inputSplitComma = strsplit(inputLower, ',')[[1]];
    inputSplitSpace = strsplit(inputLower, ' ')[[1]];
    inputLength = length(inputSplitSpace);
    command = inputSplitSpace[1];
    if (
      inputLower == 'quit' || inputLower == 'quit()' || inputLower == 'exit' || inputLower == 'exit()'
    ) {
      run = FALSE;
      break;
    }
    if(
      command == 'clear'
    ) {
      clearConsole();
      next;
    }
    if(
      command == 'list'
    ){
      collection = inputSplitSpace[2];
      modelName = inputSplitSpace[3];
      modelVersion = inputSplitSpace[4];
      if(!collection %in% metaDataFields){
        message(paste0(collection, " not valid option for 'list' method"));
        next;
      } else{
        listMetaData(collection, modelName, modelVersion);
        next;
      }
    }
    if(
      command == 'predictor'
    ) {
        if(inputLength > 3){
          message(paste0("Error: 'predictor' method expects 2 arguments but received ", inputLength - 1, ". Make sure predictors arg contains no spaces."));
          next;
        }
        model = inputSplitSpace[2];
        predictor = strsplit(inputSplitSpace[3], ',')[[1]];
        if(is.na(model) || is.na(predictor)){
          message("Error: Invalid option for 'predictor' method. Either 'model' or 'predictor' arg incorrect");
          next;
        } else {
          addPredictors(assignPredictors(model, predictor));
          next;
        }
    }
    if(
      command == 'response'
    ) {
      if(inputLength > 3){
        message(paste0("Error: 'response' method expects 2 arguments but received ", inputLength - 1, ". Make sure only one reponse argument is provided."));
        next;
      }
      model = inputSplitSpace[2];
      response = inputSplitSpace[3];
      if(is.na(model) || is.na(response)){
        message("Invalid option for 'response' method. Either 'model' or 'response' arg incorrect");
        next;
      } else {
        addResponse(assignResponse(model, response));
        next;
      }
    }
    if(
      command == 'copy'
    ) {
      if(inputLength > 2){
        message("Invalid option for 'copy' method.  Method can only copy one (1) file at a time.");
        next;
      } else {
        filePath = inputSplitSpace[2];
        copyDataFile(filePath);
        dataFiles = list.files(dataPath, pattern = '.csv');
        for(i in 1:length(dataFiles)){
          if(!dataFiles[i] %in% data) {
            data = append(data, dataFiles[i]);
            fileNameClean = strsplit(dataFiles[i], split = '[.]')[[1]][1];
            assign(dataFiles[i], fread(file.path(dataPath, fileNameClean)), envir = dataEnv);
          }
        }
        next;
      }
    }
    if(
      command == 'formula'
    ) {
      if(inputLength > 3){
        message(paste0("Error: 'formula' method expects 2 arguments but received ", inputLength - 1, ". Passable arguments are modelName (required) and modelVersion (optional)."));
        next;
      }
      model = inputSplitSpace[2];
      version = inputSplitSpace[3];
      if(is.na(model)){
        message("Invalid option for 'formula' method. modelName arg incorrect.");
        next;
      } else {
        addFormula(buildFormula(model, version));
        next;
      }
    }
    if(
      command == 'tree'
    ) {
      if(inputLength > 4) {
        message(paste0("Error: 'tree' method expects 3 arguments but received ", inputLength - 1, ". Passable arguments are modelName (required), modelData (required), and modelVersion (optional)."));
        next;
      }
      model = inputSplitSpace[2];
      trainData = inputSplitSpace[3];
      version = inputSplitSpace[4];
      if(is.na(model) || is.na(trainData)) {
        message("Invalid option for 'tree' method. modelName and/or modelData arg(s) incorrect.");
        next;
      } else {
        buildTree(model, trainData, version);
        addModel(assignModel(model, trainData, version));
      }
    }
    else exec(input);
  }
}
