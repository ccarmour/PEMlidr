
:: Compute structural metrics
lascanopy -i %f_dir%\20_las\02_norm\*.laz ^
	-use_tile_bb ^
	-drop_class 2 7 ^
	-drop_z_above 100 ^
	-height_cutoff 2 ^
	-step 5 ^
	-p 10 25 50 75 90 99 ^
	-abv ^
	-all ^
	-avg ^
	-qav ^
	-std ^
	-cov ^
	-kur ^
	-ske ^
	-odir %f_dir%\50_metrics\by_tile ^
	-obil ^
	-cores %cores%