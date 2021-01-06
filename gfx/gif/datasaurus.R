library(datasauRus)
library(tidyverse)
df <- filter(datasaurus_dozen, dataset == "dino")
df <- as.data.frame(df[,-1])

plot(df$x, df$y, pch=19)


# Animaiton
par(pty="s") 
plot(NA, xlim=c(0,100),ylim=c(0,100),xlab="", ylab="")
df.split <- sample(split(df, 1:nrow(df)))

for(idx in 1:length(df.split)){
  
  points(df.split[[idx]]$x, df.split[[idx]]$y,pch=19)
  Sys.sleep(0.1)
}

