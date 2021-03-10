rm(list = ls())

## Load Data Set
set.seed(27) # for reproduction
load('DataSet.RData')
clust.index.files = paste0('DCA.clustInd.', c(4, 13), '.txt')

for(i in seq_along(clust.index.files)) {
  clust.index = read.table(clust.index.files[i])
  clust.index = t(clust.index[1, ])
  ## Show
  sprintf('K = %d', length(unique(clust.index)))
  # chosen by http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
  color.set = c("antiquewhite4", "aquamarine2", "black", "blue3", 
                "brown1", "burlywood1", "chartreuse1", "chocolate2",
                "cyan2", "darkgoldenrod1", "darkgreen", "darkmagenta",
                "darkorange1", "darkslategray3", "deeppink1", "deepskyblue1",
                "firebrick1", "gold1", "gray0", "green1",
                "indianred1", "lightcoral", "lightgoldenrod2", "lightpink4",
                "lightslateblue", "maroon", "midnightblue", "olivedrab",
                "orange1", "orchid", "palegreen2", "palevioletred2",
                "peachpuff2", "purple3", "red", "rosybrown2",
                "saddlebrown", "seagreen2", "sienna4", "slateblue3",
                "springgreen2", "turquoise2", "violetred", "yellow1")
  windows()
  plot(train.X, 
       col = color.set[clust.index], 
       xlab = "Dim 1", 
       ylab = "Dim 2",
       main = paste0("DensityClust for the 't4.8k' Dataset [K = ", 
                     length(unique(clust.index)), "]"))
  unique(color.set[clust.index]) # used colors
  length(unique(color.set[clust.index])) # number of used colors  
}