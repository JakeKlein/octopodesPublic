assignment = function(left, right, trimL = TRUE, trimR = TRUE) {
  var = if(trimL){ trimws(left) } else{ left };
  value = if(trimR){ trimws(right) } else { right };
  assign(var, safeCast(value), envir = parent.frame());
}
