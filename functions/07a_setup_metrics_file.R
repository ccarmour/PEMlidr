setup_metrics_file <- function(data.path, res = c(5, 10, 20), cores = 6){
  
  init.lines <- str_c("set f_dir=", data.path) %>%
    str_replace(pattern = "/$", replace = "") %>%
    str_replace_all(pattern = "/", replace = "\\\\") %>%
    rbind(., str_c("set cores=", as.numeric(cores)), sep = "\n")
  
  ### Grab lines for creation of all metrics files for each tile as a 1m res .bil
  met.create.lines <- read.csv("LAStools_batch_files/base/07_metrics.bat",
                        header = FALSE,
                        blank.lines.skip = F)
  
  met.loop.lines <- read.csv("LAStools_batch_files/base/08_metrics_loop.bat",
                         header = FALSE,
                         blank.lines.skip = F)
  
  file.copy("LAStools_batch_files/metric_names.txt",
            str_c(data.path, "/LAStools_batch_files/metric_names.txt"),
            overwrite = TRUE)

  ### Merge the 1m .bil files into the desired resolution(s)
  met.merge.lines <- data.frame()
  
  for(i in 1:length(res)){
    ### Get template file
    met.merge.lines.new <- read.csv("LAStools_batch_files/base/09_metrics_merge.bat",
                                    header = FALSE,
                                    blank.lines.skip = F)
    
    ### Replace the "res" tag with desired resolution
    new.lines <- met.merge.lines.new %>%
      filter(str_detect(V1, "res")) %>%
      mutate(V1 = str_replace(V1, "res", as.character(res[i])))
    
    met.merge.lines.new[grepl("step", met.merge.lines.new$V1),] <- new.lines[grepl("step", new.lines$V1),]
    met.merge.lines.new[grepl("%met%_", met.merge.lines.new$V1),] <- new.lines[grepl("%met%_", new.lines$V1),]
    
    ### Append
    met.merge.lines = rbind(met.merge.lines, met.merge.lines.new)
    
  }
  
  lines <- rbind(init.lines, met.create.lines, "\n", met.loop.lines, "\n", met.merge.lines, "\npause")
  
  write.table(lines, str_c(data.path, "LAStools_batch_files/metrics.bat"),
              quote = F,
              col.names = F,
              row.names = F,
              append = F)
  
  print("Metrics batch file complete.")
  return(str_c(data.path, "LAStools_batch_files/metrics.bat"))
}
