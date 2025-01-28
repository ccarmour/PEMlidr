create_DEM <- function(data.path, res = c(5, 10, 20)){
  
  terra::terraOptions(overwrite = T, todisk = T, tempdir = "E:/temp")
  
  ctg.r <- list.files(stringr::str_c(data.path, "20_las/01_retiled"), pattern = ".las$", full.names = T) %>%
    lidR::readLAScatalog()
  
  # Specify output path for normalized files
  opt_output_files(ctg.r) <- stringr::str_c(data.path, "30_dem/by_tile/{XLEFT}_{YBOTTOM}")
  
  # Rasterize terrain using basic TIN algorithm
  lidR::rasterize_terrain(ctg.r, res = 1, algorithm = tin())
  
  # Pull 1m DEM together using virtual raster tile (vrt)
  dem_1m <- list.files(stringr::str_c(data.path, "30_dem/by_tile"),pattern = ".tif$", full.names = T) %>%
    terra::vrt()
  
  # Write the 1m DEM to file
  writeRaster(dem_1m, filename = stringr::str_c(data.path, "30_dem/DEM_1m.tif"), overwrite = TRUE)
  
  # Aggregate additional higher resolution DEMs from 1m
  for(i in 1:length(res)){
    ## Resample DEM to desired resolutions
    terra::aggregate(dem_1m, fact = res[i]) %>%
      writeRaster(x = .,
                  filename = stringr::str_c(data.path, "30_dem/DEM_", res[i], "m.tif"),
                  overwrite = TRUE)
  }
}

