:: Merge rasters to CHM
lasgrid -i %f_dir%\40_las\by_tile\*.bil ^
	-merged ^
	-highest ^
	-step res ^
	-otif ^
	-nbits 32 ^
	-epsg 3005 ^
	-o %f_dir%\40_chm\CHM_resm.tif