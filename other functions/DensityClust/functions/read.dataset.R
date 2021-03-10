rm(list = ls())

## Load Data Set
#   the dataset is from the websit:
#   http://cs.uef.fi/sipu/datasets/t4.8k.txt
## Ref.
#   t4.8k: G. Karypis, E.H. Han, V. Kumar, 
#   CHAMELEON: A hierarchical 765 clustering algorithm using dynamic modeling,
#   IEEE Trans. on Computers, 32 (8), 68-75, 1999.

## Train Set
train.colClass = rep("numeric", 2)
train.set = read.table("t4.8k.txt",
                       colClasses = train.colClass, comment.char = "")
dim(train.set)
train.X = train.set
dim(train.X)

## Save Data Set
save(train.X, file = "DataSet.RData")