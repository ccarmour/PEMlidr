retile_las_files <- function(data.path){
  
  
  ## Create LAS catalog with our downloaded or user-provided files
  ctg <- list.files(stringr::str_c(data.path, "20_las/"), pattern = ".laz$", full.names = T) %>%
    lidR::readLAScatalog()
  
  opt_chunk_buffer(ctg) <- 30 # Set chunk buffer for processing
  opt_chunk_size(ctg) <- 500 # Set chunk (tile) size to 500m
  opt_filter(ctg) <- "-drop_z_below 0" # Drop points below 0, if they exist
  # Specify output path for retiled files
  opt_output_files(ctg) <- stringr::str_c(data.path,
                                          "20_las/01_retiled/{XLEFT}_{YBOTTOM}")
  # Retile catalog to specs above
  lidR::catalog_retile(ctg)
  
}
