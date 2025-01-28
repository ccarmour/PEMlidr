normalize_las_files <- function(data.path){
  
  ## Create a new catalog with our retiled files.
  ctg.r <- list.files(stringr::str_c(data.path, "20_las/01_retiled"), pattern = ".las$", full.names = T) %>%
    lidR::readLAScatalog()
  
  # Specify output path for normalized files
  opt_output_files(ctg.r) <- stringr::str_c(data.path, "20_las/02_norm/{XLEFT}_{YBOTTOM}")
  
  # Normalize point cloud using TIN algorithm
  normalize_height(ctg.r, tin())
  
}