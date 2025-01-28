
:: Merge rasters
lasgrid -i %f_dir%\50_metrics\by_tile\*%met%.bil ^
	-merged ^
	-step res ^
	-epsg 3005 ^
	-otif ^
	-o %f_dir%\50_metrics\%met%_resm.tif