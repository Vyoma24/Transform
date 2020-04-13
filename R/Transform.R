library(BBmisc)
library(mltools)
library(dplyr)
library(tidyr)
library(onehot)
library(data.table)
#' @param path to data file
#' @export
Transform_Fin_Data <- function(path){
  Data <- read.csv(path, header=TRUE)
  Data$Age <- normalize(Data$Age, method = "standardize", range = c(18, 100))
  Data$Amount <- normalize(Data$Amount, method = "standardize", range = c(0, 500))

  Data$gender <- factor(Data$gender, levels = c("m", "f"), labels = c(0,1))

  Data <- one_hot(as.data.table(Data), naCols = TRUE)
  Data <- as.data.frame(Data)
  Data$v1 <- normalize(Data$v1, method = "standardize", range = c(-5, 5))
  Data$v2 <- normalize(Data$v2, method = "standardize", range = c(-5, 5))
  Data$v3 <- normalize(Data$v3, method = "standardize", range = c(-5, 5))
  Data$v4 <- normalize(Data$v4, method = "standardize", range = c(-5, 5))

  Data["v3*v4*Visa"] = Data$v3*Data$v4*Data$cardType_Visa
  Data["v1*v2*Master"] = Data$v1*Data$v2*Data$cardType_Master
}
# Transform_Fin_Data("C:/Users/vyoma/Desktop/Data.csv")


