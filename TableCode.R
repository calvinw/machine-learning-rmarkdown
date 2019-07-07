

library(knitr)

colTitles <- c(" .00"," .01"," .02"," .03"," .04"," .05"," .06"," .07"," .08"," .09")
zStartOfLastRow <- 3.4
numRows <- zStartOfLastRow*10+1

# Pos z-table rows go like this:  0.0, 0.1,... , 2.9, 3.0
# Matrix of positive z-values
posZValues <- matrix(nrow=numRows, ncol=10)

for(i in 1:numRows) {
  for(j in 1:10) {
    posZValues[i, j] = (i-1)*.1 + (j-1)*(.01)
  }
}

# left tail areas like '0.9324' 
posZAreas <- format(round(pnorm(posZValues),4),nsmall=4)

# remove the leading 0, so now '.9324' 
posZAreas <- substring(posZAreas, 2)

# eg this is .1, .2, .3, ..., 3.0 
posRowNames <- seq(.1, zStartOfLastRow, by=.1)
rownames(posZAreas) <- c("0.0",posRowNames)
colnames(posZAreas) <- colTitles

# Neg z-table rows go like this: -3.0,-2.9,... ,-0.1, 0.0 
# Matrix of negative z-values
negZValues <- matrix(nrow=numRows, ncol=10)
for(i in 1:numRows) {
  for(j in 1:10) {
    negZValues[i, j] = (numRows-i)*(-.1) - (j-1)*(.01)
  }
}
negZAreas <- format(round(pnorm(negZValues),4),nsmall=4)
negZAreas <- substring(negZAreas, 2)

# eg this is -3.0, -2.9, ... , -.1
negRowNames <- seq(-zStartOfLastRow,-.1,by=.1)
rownames(negZAreas) <- c(negRowNames, "0.0")
colnames(negZAreas) <- colTitles

## Standard Normal Table 

kable(negZAreas)
kable(posZAreas)

# This returns the row and col of the enty 2.13
which(posZValues == "2.13", arr.ind=TRUE)

# This returns the row and col of the enty -2.13
whichIndex = which(negZValues == "-2.13", arr.ind=TRUE)
#this gives the row
whichIndex[1]
#this gives the column
whichIndex[2]

