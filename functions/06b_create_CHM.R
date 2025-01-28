create_CHM <- function(data.path, res = c(5, 10, 20)){
  
  terra::terraOptions(overwrite = T, todisk = T, tempdir = "E:/temp")
  
  # Get catalog of height-normalized tiles. Filter for outliers.
  ctg.n <- list.files(stringr::str_c(data.path, "20_las/02_norm"),pattern = ".las$", full.names = T) %>%
    lidR::readLAScatalog(filter = "-drop_z_below 0 -drop_z_above 100")
  
  # Specify output path for normalized files
  opt_output_files(ctg.n) <- stringr::str_c(data.path, "40_chm/by_tile/{XLEFT}_{YBOTTOM}")
  
  # Rasterize canopy using pit-free algorithm
  lidR::rasterize_canopy(ctg.n, res = 1, algorithm = pitfree())
  
  # Pull 1m CHM together using virtual raster tile (vrt)
  chm_1m <- list.files(stringr::str_c(data.path, "40_chm/by_tile"), pattern = ".tif$", full.names = T) %>%
    terra::vrt()
  
  # Write 1m CHM to file
  writeRaster(chm_1m, filename = stringr::str_c(data.path, "40_chm/CHM_1m.tif"), overwrite = TRUE)
  
  # Aggregate additional resolutions
  for(i in 1:length(res)){
    ## Resample CHM to desired resolutions
    terra::aggregate(chm_1m, fact = res[i]) %>%
      writeRaster(x = .,
                  filename = stringr::str_c(data.path, "40_chm/CHM_", res[i], "m.tif"),
                  overwrite = TRUE)
  }
}

