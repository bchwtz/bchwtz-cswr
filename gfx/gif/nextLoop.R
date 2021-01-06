for( idx in 1:10 ){
  if( idx %% 2 == 0 ){ next }
  print(idx)
  Sys.sleep(1) # Pause for 1s
}