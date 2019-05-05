copyDataFile = function(dataFilePath){
  tryCatch(
    
    {
      file.copy(dataFilePath, dataPath);
      print(paste0(dataFilePath, ' successfuly uploaded.'));
    },
    
    warning = function(cond){
      message(paste0('Error: Invalid file path ', dataFilePath))
    }
    
  )
}