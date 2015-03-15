corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  

  
  j <- 1
  completed <- complete(directory, 1:332)
  positive_index <-c()
  for(i in completed[,2]){
    if(i >= threshold){
      positive_index <-c(positive_index, completed[j,1])
    }
    j <- j+1
  }
  
  filenames <-sprintf("%03d.csv", positive_index)
  filedir <-file.path(".", filenames)
  data.list <-lapply(filedir, read.csv)
  
  j <- 1
  correlation_vector <- c()
  
  for(i in positive_index){  
    df=ldply(data.list[j])
    correlation_vector <- c(correlation_vector,cor(df[,"sulfate"],df[,"nitrate"], use="pairwise.complete.obs"))
    j <-j+1
  }

  return(correlation_vector) 
}