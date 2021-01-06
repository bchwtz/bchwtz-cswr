# How long should a line of code really be?
# Look at this long and complex line of code:

resultList <- lapply(seq(1,10,0.5), 
                     function(x, z, H){return( (sum(z) + log(x) * x)^H) }, 
                     z=3, H=7 ) # Wow this was really long!

# Never write code that exceeds this line ------------------------------------->



