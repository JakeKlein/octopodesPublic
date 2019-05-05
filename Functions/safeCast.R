safeCast <- function(object, Class = 'numeric') {
  suppressWarnings(
    if(is.na(as(object, Class))){
      #print(paste('Could not coerce ', object, ' to type ', Class));
      return(object);
    } else {
      return(as(object, Class));
    }
  )
}