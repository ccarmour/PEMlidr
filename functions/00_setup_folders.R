
setup_folders <- function(data.path){
  
  path <- c(str_c(data.path, "20_las/"),
            str_c(data.path, "20_las/", "00_converted/"),
            str_c(data.path, "20_las/", "01_retiled/"),
            str_c(data.path, "20_las/", "02_norm/"),
            str_c(data.path, "40_chm/"),
            str_c(data.path, "40_chm/", "by_tile/"),
            str_c(data.path, "30_dem/"),
            str_c(data.path, "30_dem/", "by_tile/"),
            str_c(data.path, "50_metrics/"),
            str_c(data.path, "50_metrics/", "by_tile/"),
            str_c(data.path, "LAStools_batch_files/"))
  
  for(i in 1:length(path)){
    if(!dir.exists(path[i])){
      dir.create(path[i])
    }
  }
  
  print("Setup of folders completed.")
}

