query_lidarbc <- function(aoi,
                          index,
                          data.path,
                          keep.geometry = FALSE){
  
  if(!dir.exists(data.path)){
    print("The current data path is not valid. Check folder setup.")
  }
  
  # Does AOI CRS match LidarBC Index?
  if(sf::st_crs(aoi) != sf::st_crs(index)){
    aoi <- sf::st_transform(aoi, sf::st_crs(index))
    print('Transformed area of interest CRS')
  }
  
  # Extract intersecting polygons of aoi and LidarBC index
  if(keep.geometry == TRUE){
    aoi.index <- sf::st_intersection(index, aoi) %>% sf::st_cast("POLYGON")
    sf::st_write(aoi.index, dsn = stringr::str_c(data.path, "/aoi.index.gpkg"), append = FALSE)
  } else {
    aoi.index <- sf::st_intersection(index, aoi) %>% sf::st_drop_geometry()
  }
  
  # Add projection info
  aoi.index <- read.csv("projection_codes.csv", header = T) %>%
    select(!URL) %>%
    left_join(aoi.index, ., by = "projection", keep = F)
  
  # Define file destination
  aoi.index <- aoi.index %>%
    dplyr::rename(file.orig = s3Url) %>%
    dplyr::mutate(file.dest = file.path(stringr::str_c(data.path,  '20_las'), basename(file.orig))) %>%
    dplyr::relocate(file.dest , .after = file.orig)
  
  
  if(nrow(aoi.index) >= 1){
    print(stringr::str_c('There are ', nrow(aoi.index), ' lidar point cloud tiles that can be downloaded from LidarBC'))
  }

  if(nrow(aoi.index) < 1){
    print(stringr::str_c("There are no lidar point cloud tiles available on the LidarBC portal. User will need to provide lidar data. The raw tiles should be placed in the '", stringr::str_c(data.path,  '20_las'), "' folder in .laz or .las format."))
  }
  
  # Write to the data folder
  if(keep.geometry == TRUE){
    sf::st_write(aoi.index, stringr::str_c(data.path, "aoi_index.gpkg"), append = FALSE)
  } else {
    write.csv2(aoi.index, stringr::str_c(data.path, "aoi_index.csv"), append = FALSE)
  }

}






