complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  j<-1
  vector_completed <-c()
  matrix_completed <-matrix(0,ncol=2,nrow=length(id))
  matrix_completed[,1] <-id
  filenames <-sprintf("%03d.csv", id)
  filedir <-file.path(".", filenames)
  data.list <-lapply(filedir, read.csv)
  for(i in id){
    
    df=ldply(data.list[j])
    vector_completed<-c(vector_completed,min(
      sum(!is.na(df[,"sulfate"])),sum(!is.na(df[,"nitrate"]))
          )
      )
    j <-j+1
  }
  matrix_completed[,2] <- vector_completed
  
  colnames(matrix_completed, do.NULL = FALSE)
  colnames(matrix_completed) <- c("id","nobs")

  
  return(matrix_completed) 
  
}