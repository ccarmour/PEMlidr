
:: Merge rasters to DEM
lasgrid -i %f_dir%\30_dem\by_tile\*.bil ^
	-merged ^
	-highest ^
	-step res ^
	-otif ^
	-nbits 32 ^
	-epsg 3005 ^
	-o %f_dir%\30_dem\DEM_resm.tif ^
	-cores %cores%
