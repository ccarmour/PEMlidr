setup_preprocess_file <- function(data.path,
                                  cores = 6L){
  
  init.lines <- str_c("set f_dir=", data.path) %>%
    str_replace(pattern = "/$", replace = "") %>%
    str_replace_all(pattern = "/", replace = "\\\\") %>%
    rbind(., str_c("set cores=", as.numeric(cores)), sep = "\n")
  
  retile.lines <- read.csv("LAStools_batch_files/base/01_retile_index.bat",
                           header = FALSE,
                           blank.lines.skip = F)
  
  lines <- rbind(init.lines, retile.lines, "\npause")
  
  
  write.table(lines, str_c(data.path, "LAStools_batch_files/retile.bat"),
              quote = F,
              col.names = F,
              row.names = F,
              append = F)
  
  print("Retiling batch file complete. Executing in CMD.")
  return(str_c(data.path, "LAStools_batch_files/retile.bat"))
}
