:: Tile 500m - flag buffered points as withheld for simple drop later
lastile -i %f_dir%\20_las\*.laz ^
	-buffer 30 ^
	-flag_as_withheld ^
	-tile_size 1000 ^
	-drop_z_below 0 ^
	-drop_class 7 ^
	-change_classification_from_to 17 1 ^
	-change_classification_from_to 5 1 ^
	-odir %f_dir%\20_las\01_retiled ^
	-olaz ^
	-cpu64 ^
	-cores %cores%

:: Index new .laz files
lasindex -i %f_dir%\20_las\01_retiled\*.laz ^
	-dont_reindex ^
	-cores %cores%
