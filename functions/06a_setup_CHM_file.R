setup_CHM_file <- function(data.path, res = c(1, 5, 10, 20), cores = 6){
  
  ### Initialize lines with the working directory and desired number of cores
  init.lines <- str_c("set f_dir=", data.path) %>%
    str_replace(pattern = "/$", replace = "") %>%
    str_replace_all(pattern = "/", replace = "\\\\") %>%
    rbind(., str_c("set cores=", as.numeric(cores)), sep = "\n")
  
  ### Grab lines for creation of CHM files for each tile as a 1m res .bil
  chm.create.lines <- read.csv("LAStools_batch_files/base/05_surface_models_CHM.bat",
                               header = FALSE,
                               blank.lines.skip = F)
  
  ### Merge the 1m .bil files into the desired resolution(s)
  chm.merge.lines <- data.frame()
  
  for(i in 1:length(res)){
    ### Get template file
    chm.merge.lines.new <- read.csv("LAStools_batch_files/base/06_surface_models_CHM_merge.bat", header = FALSE, blank.lines.skip = F)
    
    ### Replace the "res" tag with desired resolution
    new.lines <- chm.merge.lines.new %>%
      filter(str_detect(V1, "res")) %>%
      mutate(V1 = str_replace(V1, "res", as.character(res[i])))
    
    chm.merge.lines.new[grepl("step", chm.merge.lines.new$V1),] <- new.lines[grepl("step", new.lines$V1),]
    chm.merge.lines.new[grepl("CHM_", chm.merge.lines.new$V1),] <- new.lines[grepl("CHM_", new.lines$V1),]
    
    ### Append
    chm.merge.lines = rbind(chm.merge.lines, chm.merge.lines.new)
    
  }
  ### Bind all the lines together
  lines <- rbind(init.lines, chm.create.lines, "\n", chm.merge.lines, "\npause")
  
  write.table(lines, str_c(data.path, "LAStools_batch_files/surface_models_CHM.bat"),
              quote = F,
              col.names = F,
              row.names = F,
              append = F)
  
  print("CHM batch file complete. Executing in CMD.")
  return(str_c(data.path, "LAStools_batch_files/surface_models_CHM.bat"))
  
}
