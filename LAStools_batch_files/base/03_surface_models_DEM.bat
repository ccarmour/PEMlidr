
:: make DEM
blast2dem -i %f_dir%\20_las\01_retiled\*.laz ^
	-use_tile_bb ^
	-keep_class 2 ^
	-step 1 ^
	-obil ^
	-nbits 32 ^
	-odir %f_dir%\30_dem\by_tile ^
	-kill 200 ^
	-cores %cores%
