getDataPath <- function(fileName){
  if(fileName %in% list.files(dataPath)){
    return(file.path(dataPath, fileName));
  } else {
    message(paste0("Error: ", fileName, " not in Data folder.  Use the 'copy' command to upload data."));
  }
}