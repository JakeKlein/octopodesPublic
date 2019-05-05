dependencies = c("data.table", "gbm", "devtools");

for(i in 1:length(dependencies)){
  loader(dependencies[i]);
}